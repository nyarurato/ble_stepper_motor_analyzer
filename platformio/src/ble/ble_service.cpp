#include "ble/ble_service.h"

#include <bluetooth/bluetooth.h>
#include <bluetooth/buf.h>
#include <bluetooth/conn.h>
#include <bluetooth/gatt.h>
#include <bluetooth/hci.h>
#include <bluetooth/uuid.h>
#include <errno.h>
#include <host/conn_internal.h>
#include <settings/settings.h>
#include <stddef.h>
#include <stdio.h>
#include <string.h>
#include <sys/byteorder.h>
#include <sys/printk.h>
#include <zephyr.h>

#include "acquisition/acq_consts.h"
#include "acquisition/analyzer.h"
#include "misc/controls.h"
#include "misc/elapsed.h"
#include "misc/io.h"
#include "misc/util.h"

namespace ble_service {

// Temp buffer to sample the analyzer's histogram.
static analyzer::Histogram histogram_snapshot;

// For reading the adc signal capture buffer in pages.
//
// Each capture point take 4 bytes so we limit the page
// size to fit in a BLE packet.
// constexpr int kMaxCapturePointPerPacket = 50;

// Number of capture points already read from the current
// snapshot. Reset each time a new snapshot is taken.
// Sould be in [0, adc_capture_snapshot.items.size()].
static uint16_t adc_capture_items_read_so_far = 0;

// User reads capture pagees from this snapshot.
static analyzer::AdcCaptureBuffer adc_capture_snapshot;

// Histogram value format
// * Format. [1 byte]
// * Data point count [ 1 byte]
// * Data point value  [2 bytes each, big endian]
constexpr size_t HISTOGRAM_VALUE_SIZE =
    2 + (acq_consts::kNumHistogramBuckets * 2);

// ----- Prober service
#define PROBE_SERVICE_UUID \
  BT_UUID_128_ENCODE(0x68e1a034, 0x8125, 0x4525, 0x8a30, 0x8799018c4bd0)

static struct bt_uuid_128 probe_service_uuid =
    BT_UUID_INIT_128(PROBE_SERVICE_UUID);

// ----- Info characteristic

static struct bt_uuid_128 info_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f2));

// Offset in info_value below of the adc_ticks_per_amp field.
static constexpr int ADC_TICKS_PER_AMP_OFFSET = 1;

static uint8_t info_value[] = {
    // One byte for format version.
    0x1,

    // Two bytes for adc_ticks_per_amp. The actual value of
    // these two bytes are set by setup() using the
    // offset const ADC_TICKS_PER_AMP_OFFSET.
    0x00,  // adc_ticks_per_amp >> 8  MSB
    0x00,  // adc_ticks_per_amp >> 0  LSB

    // Three bytes for TIME_TICKS_PER_SEC.
    (uint8_t)(acq_consts::TIME_TICKS_PER_SEC >> 16),
    (uint8_t)(acq_consts::TIME_TICKS_PER_SEC >> 8),
    (uint8_t)(acq_consts::TIME_TICKS_PER_SEC >> 0),

    // Two bytes for histogram bucket width in steps/sec.
    // Histogram buckets start at zero steps/sec.
    (uint8_t)(acq_consts::kBucketStepsPerSecond >> 8),
    (uint8_t)(acq_consts::kBucketStepsPerSecond >> 0),

};

constexpr size_t INFO_VALUE_SIZE = sizeof(info_value) / sizeof(*info_value);

static ssize_t on_probe_info_read(struct bt_conn *conn,
                                  const struct bt_gatt_attr *attr, void *buf,
                                  uint16_t len, uint16_t offset) {
  if (offset != 0) {
    // io::LED2.set();
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  if (len < INFO_VALUE_SIZE) {
    return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
  }

  memcpy(buf, info_value, INFO_VALUE_SIZE);
  return INFO_VALUE_SIZE;
}

// ----- State characteristic

static struct bt_uuid_128 state_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f1));

// As of Aug 2022 we use only 19 bytes.
#define STATE_VALUE_MAX_LEN 30

static uint8_t state_value[STATE_VALUE_MAX_LEN] = {0};

static int encode_state(const analyzer::State &state, uint8_t *buf,
                        uint16_t len) {
  // At the moment we use 15 of the 20 bytes.
  if (len < STATE_VALUE_MAX_LEN) {
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
  }

  uint8_t *p = buf;

  // We encode this as a unit_48 bit MSB value.
  uint64_t val64 = state.tick_count;
  *p++ = val64 >> 40;
  *p++ = val64 >> 32;
  *p++ = val64 >> 24;
  *p++ = val64 >> 16;
  *p++ = val64 >> 8;
  *p++ = val64 >> 0;

  uint32_t val32 = (uint32_t)state.full_steps;
  *p++ = val32 >> 24;
  *p++ = val32 >> 16;
  *p++ = val32 >> 8;
  *p++ = val32 >> 0;

  // Flags.
  // * bit5 : true IFF energized.
  // * bit4 : true IFF reversed direction.
  // * bit1 : quadrant MSB.
  // * bit0 : quadrant LSB.
  //
  // Quarant is in the range [0, 3].
  // All other bits are reserved and readers should treat them
  // as undefined.
  const uint8_t flags = (state.is_energized ? 0x20 : 0) |
                        (state.is_reverse_direction ? 0x10 : 0) |
                        (state.quadrant & 0x03);
  *p++ = flags;

  // Current ticks for coil 1.
  uint16_t val16 = (uint16_t)state.v1;
  *p++ = val16 >> 8;
  *p++ = val16 >> 0;

  // Current ticks for coil 2.
  val16 = (uint16_t)state.v2;
  *p++ = val16 >> 8;
  *p++ = val16 >> 0;

  // Number of times was not energized.
  val32 = state.non_energized_count;
  *p++ = val32 >> 24;
  *p++ = val32 >> 16;
  *p++ = val32 >> 8;
  *p++ = val32 >> 0;

  printk("state len: %d, e=%d\n", p - buf, state.is_energized ? 1 : 0);
  return (p - buf);
}

// TODO: Share with other temp state buffer to save RAM.
static analyzer::State read_state;

static ssize_t on_probe_state_read(struct bt_conn *conn,
                                   const struct bt_gatt_attr *attr, void *buf,
                                   uint16_t len, uint16_t offset) {
  // io::LED2.clear();
  //  printk("on_state_read(%hd, %d) called.\n", len, offset);

  if (offset != 0) {
    // io::LED2.set();

    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  analyzer::sample_state(&read_state);

  const int result =
      encode_state(read_state, reinterpret_cast<uint8_t *>(buf), len);

  // io::LED2.set();
  return result;
}

// ----- Current histogram characteristic

static struct bt_uuid_128 current_histogram_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f3));

static ssize_t on_current_histogram_read(struct bt_conn *conn,
                                         const struct bt_gatt_attr *attr,
                                         void *buf, uint16_t len,
                                         uint16_t offset) {
  if (offset != 0) {
    // io::LED2.set();
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  if (len < HISTOGRAM_VALUE_SIZE) {
    return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
  }

  // Sample the histogram.
  analyzer::sample_histogram(&histogram_snapshot);

  // Encode the result value.
  uint8_t *const p0 = static_cast<uint8_t *>(buf);
  uint8_t *p = p0;

  // Format id (1 byte)
  *p++ = 0x10;  // Format id.

  // Num points: (1 byte)
  *p++ = acq_consts::kNumHistogramBuckets;

  // Format bucket values, (2 bytes each)
  for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
    const analyzer::HistogramBucket &bucket = histogram_snapshot.buckets[i];
    uint16_t value;
    if (bucket.total_steps == 0) {
      value = 0;
    } else {
      value = bucket.total_step_peak_currents / bucket.total_steps;
      if (value == 0) {
        // We use 0 to indicate zero steps.
        value = 1;
      }
    }
    *p++ = value >> 8;  // MSB
    *p++ = value;       // LSB
  }

  // Here we expact n == HISTOGRAM_VALUE_SIZE <= len.
  const uint16_t n = p - p0;
  // printk("Current histogram read ok (%hu == %hu <= %hu)\n", n,
  // HISTOGRAM_VALUE_SIZE, len );
  return n;
}

// ----- Time histogram characteristic

static struct bt_uuid_128 time_histogram_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f4));

static ssize_t on_time_histogram_read(struct bt_conn *conn,
                                      const struct bt_gatt_attr *attr,
                                      void *buf, uint16_t len,
                                      uint16_t offset) {
  if (offset != 0) {
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  if (len < HISTOGRAM_VALUE_SIZE) {
    return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
  }

  // Sample the histogram.
  analyzer::sample_histogram(&histogram_snapshot);

  // Encode the result value.
  uint8_t *const p0 = static_cast<uint8_t *>(buf);
  uint8_t *p = p0;

  // Format id (1 byte)
  *p++ = 0x20;  // Format id.

  // Num points: (1 byte)
  *p++ = acq_consts::kNumHistogramBuckets;

  // Find max time value
  uint64_t max_value = 0;
  for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
    if (histogram_snapshot.buckets[i].total_ticks_in_steps > max_value) {
      max_value = histogram_snapshot.buckets[i].total_ticks_in_steps;
    }
  }

  // Special case: all buckets are zero.
  if (max_value == 0) {
    for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
      *p++ = 0;
      *p++ = 0;
    }
  } else {
    // Normal case: encide relative values as mils (1/thousand) of the
    // top value.
    for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
      uint16_t normalized_val =
          (histogram_snapshot.buckets[i].total_ticks_in_steps * 1000) /
          max_value;
      *p++ = normalized_val >> 8;
      *p++ = normalized_val;
    }
  }

  // Here we expact n == HISTOGRAM_VALUE_SIZE <= len.
  const uint16_t n = p - p0;
  // printk("Time histogram read ok (%hu == %hu <= %hu)\n", n,
  //        HISTOGRAM_VALUE_SIZE, len);
  return n;
}

// ----- Distance histogram characteristic

static struct bt_uuid_128 distance_histogram_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f5));

static ssize_t on_distance_histogram_read(struct bt_conn *conn,
                                          const struct bt_gatt_attr *attr,
                                          void *buf, uint16_t len,
                                          uint16_t offset) {
  if (offset != 0) {
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  if (len < HISTOGRAM_VALUE_SIZE) {
    return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
  }

  // Sample the histogram.
  analyzer::sample_histogram(&histogram_snapshot);

  // Encode the result value.
  uint8_t *const p0 = static_cast<uint8_t *>(buf);
  uint8_t *p = p0;

  // Format id (1 byte)
  *p++ = 0x30;  // Format id.

  // Num points: (1 byte)
  *p++ = acq_consts::kNumHistogramBuckets;

  // Find max distance value
  uint64_t max_value = 0;
  for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
    if (histogram_snapshot.buckets[i].total_steps > max_value) {
      max_value = histogram_snapshot.buckets[i].total_steps;
    }
  }

  // Special case: all buckets are zero.
  if (max_value == 0) {
    for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
      *p++ = 0;
      *p++ = 0;
    }
  } else {
    // Normal case: encide relative values as mils (1/thousand) of the
    // top value.
    for (int i = 0; i < acq_consts::kNumHistogramBuckets; i++) {
      uint16_t normalized_val =
          (histogram_snapshot.buckets[i].total_steps * 1000) / max_value;
      *p++ = normalized_val >> 8;
      *p++ = normalized_val;
      // printk("%d: %llu\n", i, histogram_sample.buckets[i].total_steps);
    }
  }

  // Here we expact n == HISTOGRAM_VALUE_SIZE <= len.
  const uint16_t n = p - p0;
  // printk("Distance histogram read ok (%hu == %hu <= %hu)\n", n,
  //        HISTOGRAM_VALUE_SIZE, len);
  return n;
}

// ----- Command characteristic

static struct bt_uuid_128 command_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f6));

static ssize_t on_command_write(struct bt_conn *conn,
                                const struct bt_gatt_attr *attr,
                                const void *buf, uint16_t len, uint16_t offset,
                                uint8_t flags) {
  // Expecting this exact flag for write-without-response.
  if (flags != BT_GATT_WRITE_FLAG_CMD) {
    printk("on_command_write: unexpected flags: %02x\n", flags);
    return 0;
  }

  if (offset != 0) {
    printk("on_command_write: unexpected offset: %02x\n", offset);
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  // We need at least one byte for the opcode.
  if (len < 1) {
    printk("on_command_write: empty command\n");
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
  }

  const uint8_t *data = (uint8_t *)buf;
  const uint32_t opcode = data[0];

  switch (opcode) {
    // command = Reset data.
    case 0x01:
      // printk("on_command_write: resetting state and histogram\n");
      if (len != 1) {
        printk("on_command_write: reset command too long: %hu\n", len);
        return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
      }
      analyzer::reset_data();
      return len;

    // Command = Snapshot ADC signal capture.
    case 0x02:
      // printk("on_command_write: snapshot adc capture signal\n");
      if (len != 1) {
        printk("on_command_write: signal capture command too long: %hu\n", len);
        return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
      }
      analyzer::get_last_capture_snapshot(&adc_capture_snapshot);
      adc_capture_items_read_so_far = 0;
      return len;

    // Command = Set ADC capture divider. Note that until the new capture
    // will be ready, the last capture is still with the old divider.
    case 0x03:
      // printk("on_command_write: snapshot adc capture signal\n");
      if (len != 2) {
        printk("on_command_write: set divider command wrong length : %hu\n",
               len);
        return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
      }
      analyzer::set_signal_capture_divider(data[1]);
      return len;

      // Command = toggle direction. This doesn't reverses the motors
      // buy just the direction of the step counting. New value is
      // persisted on the eeprom.
    case 0x04:
      if (len != 1) {
        printk(
            "on_command_write: toggle direction command wrong length : %hu\n",
            len);
        return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
      }
      if (controls::toggle_direction(NULL)) {
        return len;  // ok
      } else {
        return BT_GATT_ERR(BT_ATT_ERR_WRITE_NOT_PERMITTED);
      }

      // Command = zero calibrate the sensors. Should we called with
      // zero sensor curent, preferably disconnected. New value
      // is persisted on the eeprom.
    case 0x05:
      if (len != 1) {
        printk(
            "on_command_write: zero calibration command wrong length : %hu\n",
            len);
        return BT_GATT_ERR(BT_ATT_ERR_INVALID_ATTRIBUTE_LEN);
      }
      if (controls::zero_calibration()) {
        return len;  // ok
      } else {
        return BT_GATT_ERR(BT_ATT_ERR_WRITE_NOT_PERMITTED);
      }

    default:
      printk("on_command_write: unknown opcode: %02x\n", opcode);
      return BT_GATT_ERR(BT_ATT_ERR_NOT_SUPPORTED);
  }
}

// ----- Distance histogram characteristic

static struct bt_uuid_128 capture_signal_uuid = BT_UUID_INIT_128(
    BT_UUID_128_ENCODE(0x37e75add, 0xa610, 0x448d, 0x9fd3, 0x3e3130e2c7f7));

// Prefix takes up to 9 bytes (sometimes just 2).
constexpr uint16_t CAPTURE_SIGNAL_VALUE_PREFIX_MAX_SIZE = 9;
// Expecting room for at least 25 data points per packet.
constexpr uint16_t MIN_CAPTURE_SIGNAL_VALUE_SIZE =
    CAPTURE_SIGNAL_VALUE_PREFIX_MAX_SIZE + (4 * 25);

static ssize_t on_capture_signal_read(struct bt_conn *conn,
                                      const struct bt_gatt_attr *attr,
                                      void *buf, uint16_t len,
                                      uint16_t offset) {
  if (offset != 0) {
    return BT_GATT_ERR(BT_ATT_ERR_INVALID_OFFSET);
  }

  // We reject even if currently we don't have sufficient pending
  // data to fill it.
  if (len < MIN_CAPTURE_SIGNAL_VALUE_SIZE) {
    return BT_GATT_ERR(BT_ATT_ERR_VALUE_NOT_ALLOWED);
  }

  // Index of first item to transfer.
  const int start_item_index = adc_capture_items_read_so_far;
  // How many left to transfer.
  const int desired_item_count =
      adc_capture_snapshot.items.size() - adc_capture_items_read_so_far;
  // How many can we transfer now.
  const int available_item_count =
      (len - CAPTURE_SIGNAL_VALUE_PREFIX_MAX_SIZE) / 4;
  // How many we are going to transfer now.
  const int actual_item_count = (desired_item_count <= available_item_count)
                                    ? desired_item_count
                                    : available_item_count;

  uint8_t *const p0 = static_cast<uint8_t *>(buf);
  uint8_t *p = p0;

  // --- Packet header: CAPTURE_SIGNAL_VALUE_PREFIX_SIZE bytes.

  // packet format id (uint8)
  *p++ = 0x40;  // Format id.

  // Flags (uint8)
  uint8_t flags = 0x00;
  if (actual_item_count) {
    flags = flags | 0x80;  // Snapshot available.
    if (actual_item_count < desired_item_count) {
      flags = flags | 0x01;  // Needs at least one more read.
    }
    // if (adc_capture_snapshot.trigger_found) {
    //   flags = flags | 0x02;  // Trigger found in this snapshot.
    // }
  }

  *p++ = flags;

  if (actual_item_count) {
    // Capture sequence number: (uint16). For sanity check.
    *p++ = adc_capture_snapshot.seq_number >> 8;
    *p++ = adc_capture_snapshot.seq_number;

    // Divider value (uint8_t).
    *p++ = adc_capture_snapshot.divider;

    // Reserved for future flags
    // *p++ = adc_capture_snapshot.divider;

    // Number of points in this read: (uint16)
    *p++ = (uint16_t)actual_item_count >> 8;
    *p++ = (uint16_t)actual_item_count;

    // First point offset: (uint16)
    *p++ = (uint16_t)start_item_index >> 8;
    *p++ = (uint16_t)start_item_index;

    // Here we expect: (p - p0) == CAPTURE_SIGNAL_VALUE_PREFIX_SIZE.

    // ----- N points data : 4 x N bytes.
    // Encode data points as pairs of int16_t.
    for (int i = start_item_index; i < start_item_index + actual_item_count;
         i++) {
      const analyzer::AdcCaptureItem *item = adc_capture_snapshot.items.get(i);
      *p++ = item->v1 >> 8;
      *p++ = item->v1;
      *p++ = item->v2 >> 8;
      *p++ = item->v2;
    }

    // Update for next chunk read.
    adc_capture_items_read_so_far += actual_item_count;
  }

  // Here we expact n  <= len.
  const uint16_t n = p - p0;

  // printk(
  //     "Capture signal read ok: start: %d, count: %d, bytes: %hu, buffer:
  //     %hu\n", start, actual_count, n, len);

  return n;
}

// ------

// Service Declaration
BT_GATT_SERVICE_DEFINE(
    probe_svc, BT_GATT_PRIMARY_SERVICE(&probe_service_uuid),

    // Info characteristic. Ready only.
    BT_GATT_CHARACTERISTIC(&info_uuid.uuid, BT_GATT_CHRC_READ,
                           BT_GATT_PERM_READ, on_probe_info_read, NULL, NULL),

    // Command. Write only.
    BT_GATT_CHARACTERISTIC(&command_uuid.uuid, BT_GATT_CHRC_WRITE_WITHOUT_RESP,
                           BT_GATT_PERM_WRITE, NULL, on_command_write, NULL),

    // State characteristic. Ready only. Supports notification.
    BT_GATT_CHARACTERISTIC(&state_uuid.uuid,
                           BT_GATT_CHRC_READ | BT_GATT_CHRC_NOTIFY,
                           BT_GATT_PERM_READ, on_probe_state_read, NULL, NULL),

    // Extension for state_uuid above that define an notification control for
    // the state charateristic above.
    BT_GATT_CCC(NULL, BT_GATT_PERM_READ | BT_GATT_PERM_WRITE),

    // Current histogram characteristics. Read only.
    BT_GATT_CHARACTERISTIC(&current_histogram_uuid.uuid, BT_GATT_CHRC_READ,
                           BT_GATT_PERM_READ, on_current_histogram_read, NULL,
                           NULL),

    // Time histogram characteristics. Read only.
    BT_GATT_CHARACTERISTIC(&time_histogram_uuid.uuid, BT_GATT_CHRC_READ,
                           BT_GATT_PERM_READ, on_time_histogram_read, NULL,
                           NULL),

    // Distance histogram characteristics. Read only.
    BT_GATT_CHARACTERISTIC(&distance_histogram_uuid.uuid, BT_GATT_CHRC_READ,
                           BT_GATT_PERM_READ, on_distance_histogram_read, NULL,
                           NULL),

    // Signal capture data characteristics. Read only. Entire capture is read
    // in chunks due to MTU limitation.
    BT_GATT_CHARACTERISTIC(&capture_signal_uuid.uuid, BT_GATT_CHRC_READ,
                           BT_GATT_PERM_READ, on_capture_signal_read, NULL,
                           NULL));

// Advertisement info.
static const struct bt_data advertisement_data[] = {
    BT_DATA_BYTES(BT_DATA_FLAGS, (BT_LE_AD_GENERAL | BT_LE_AD_NO_BREDR)),
    BT_DATA_BYTES(BT_DATA_UUID128_ALL, PROBE_SERVICE_UUID),
};

const static struct bt_data scan_resp_data[] = {
    // Empty response.
};

void mtu_updated_cb(struct bt_conn *conn, uint16_t tx, uint16_t rx) {
  printk("Updated MTU: TX: %d RX: %d bytes\n", tx, rx);
}

static struct bt_gatt_cb gatt_callbacks = {
    .att_mtu_updated = mtu_updated_cb,
};

static void mtu_exchange_cb(struct bt_conn *conn, uint8_t err,
                            struct bt_gatt_exchange_params *params) {
  printk("MTU exchange %u %s (%u)\n", bt_conn_index(conn),
         err == 0U ? "successful" : "failed", bt_gatt_get_mtu(conn));
}

static struct bt_gatt_exchange_params mtu_exchange_params {
  .func = mtu_exchange_cb,
};

static int mtu_exchange(struct bt_conn *conn) {
  // uint8_t conn_index;
  // int err;

  // conn_index = bt_conn_index(conn);

  printk("MTU (%u)\n", bt_gatt_get_mtu(conn));

  // mtu_exchange_params[conn_index].func = mtu_exchange_cb;

  const int err = bt_gatt_exchange_mtu(conn, &mtu_exchange_params);
  if (err) {
    printk("MTU exchange failed (err %d)\n", err);
  } else {
    printk("Exchange pending...\n");
  }

  return err;
}

static void on_conn_connected(struct bt_conn *conn, uint8_t err) {
  if (err) {
    printk("on_connected failed (err 0x%02x)\n", err);
    return;
  }
  printk("on_connected OK.\n");

  // BT_LE_CONN_PARAM_INIT

  mtu_exchange(conn);
}

// See reason codes here
// https://docs.zephyrproject.org/apidoc/latest/hci__err_8h_source.html
static void on_conn_disconnected(struct bt_conn *conn, uint8_t reason) {
  // state_notifications_enabled = false;
  printk("on_disconnected (reason 0x%02x)\n", reason);
}

// See
void on_conn_param_updated(struct bt_conn *conn, uint16_t interval,
                           uint16_t latency, uint16_t timeout) {
  printk("*** on_conn_param_updated, %hu, %hu, %hu\n", interval, latency,
         timeout);
}

// Defines the connection call back. See bt_conn_cb in conn.h.
// Self registered.
BT_CONN_CB_DEFINE(conn_callbacks) = {
    .connected = on_conn_connected,
    .disconnected = on_conn_disconnected,
    .le_param_updated = on_conn_param_updated,
};

static const struct bt_le_adv_param *kAdvParams =
    // BT_LE_ADV_OPT_USE_IDENTITY stablizes the address across sessions.
    BT_LE_ADV_PARAM(BT_LE_ADV_OPT_CONNECTABLE | BT_LE_ADV_OPT_USE_NAME |
                        BT_LE_ADV_OPT_USE_IDENTITY,
                    BT_GAP_ADV_FAST_INT_MIN_2, BT_GAP_ADV_FAST_INT_MAX_2, NULL);

static struct bt_gatt_attr *state_notify_attr = NULL;

void setup(uint16_t adc_ticks_per_amp) {
  // Initialize the adc_ticks_per_amp in the info value.
  info_value[ADC_TICKS_PER_AMP_OFFSET + 0] =
      (uint8_t)(adc_ticks_per_amp >> 8);  // MSB
  info_value[ADC_TICKS_PER_AMP_OFFSET + 1] =
      (uint8_t)(adc_ticks_per_amp >> 0);  // LSB

  int err = bt_enable(NULL);
  if (err) {
    printk("Bluetooth init failed (err %d)\n", err);
    return;
  }

  printk("Bluetooth initialized\n");

  if (IS_ENABLED(CONFIG_SETTINGS)) {
    settings_load();
  }

  {
    // Assuming CONFIG_BT_ID_MAX = 1, and that a single
    // address is  returned here.
    //
    // Note: as of June 2022, bt_addr_le_t is about 8 bytes in size.
    static bt_addr_le_t addr[CONFIG_BT_ID_MAX] = {0};
    size_t addr_count;
    bt_id_get(addr, &addr_count);
    // Should be exactly 1.
    printk("Found %d local addresses\n", addr_count);
    uint8_t *const p = addr[0].a.val;

    // for(;;);

    printk("Device address: %02X:%02X:%02X:%02X:%02X:%02X\n", p[5], p[4], p[3],
           p[2], p[1], p[0]);

    // Construct device name
    sprintf(util::text_bfr, "STP-%02X%02X%02X%02X%02X%02X", p[5], p[4], p[3],
            p[2], p[1], p[0]);
  }

  printk("Device name: [%s]\n", util::text_bfr);
  bt_set_name(util::text_bfr);

  err = bt_le_adv_start(kAdvParams, advertisement_data,
                        ARRAY_SIZE(advertisement_data), scan_resp_data,
                        ARRAY_SIZE(scan_resp_data));

  if (err) {
    printk("Advertising failed to start (err %d)\n", err);
    return;
  }

  printk("Advertising successfully started\n");

  bt_gatt_cb_register(&gatt_callbacks);

  state_notify_attr = bt_gatt_find_by_uuid(
      probe_svc.attrs, probe_svc.attr_count, &state_uuid.uuid);
  if (err) {
    printk("status attribute not found");
    util::my_trap();
  }
}

// TODO: Share with other temp analyzer state buffers.
static analyzer::State notifications_state;

void maybe_notify_state(const analyzer::State &state) {
  const int state_size = encode_state(state, state_value, sizeof(state_value));

  int status = bt_gatt_notify(NULL, state_notify_attr, state_value, state_size);
  if (status == -ENOTCONN) {
    // No connection is subscribed to this notification.
    // printk(" %d\n", state.full_steps);
  } else if (status == 0) {
    // printk("Notif sent ok\n");
    // printk("#%d\n", state.full_steps);
  } else {
    printk("%05d Notification error %d. (%hu bytes)\n", 0, status, state_size);
  }
}

struct ConnectionIteratorData {
  int conn_counter = 0;
};

// Iterator for counting connections.  Data is a pointer to an int counter.
static void conn_counter_iterator(struct bt_conn *conn, void *data) {
  ConnectionIteratorData *iter_data = (ConnectionIteratorData *)data;

  if (conn->state == BT_CONN_CONNECTED) {
    iter_data->conn_counter += 1;
  }
}

// TODO: Merge the implementation of the iterator here with that
// in ble_util.h
bool is_connected() {
  ConnectionIteratorData iter_data;
  bt_conn_foreach(BT_CONN_TYPE_ALL, conn_counter_iterator, &iter_data);
  return iter_data.conn_counter != 0;
}

}  // namespace ble_service