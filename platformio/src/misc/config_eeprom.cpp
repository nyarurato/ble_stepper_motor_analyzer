// Examples:
// https://github.com/zephyrproject-rtos/zephyr/blob/main/samples/drivers/i2c_fujitsu_fram/src/main.c
// https://github.com/zapta/legacy_stepper_motor_analyzer/blob/master/platformio/src/misc/config_eeprom.cpp

#include "config_eeprom.h"

#include <device.h>
#include <drivers/i2c.h>
#include <memory.h>
#include <sys/crc.h>
#include <zephyr.h>

namespace config_eeprom {

static constexpr uint16_t kSettingsCrcAddress = 0x10;
static constexpr uint16_t kSettingsAddress = kSettingsCrcAddress + 4;

// i2c device address.
constexpr uint8_t kEepromDeviceAddress = 0x50;

struct ConfigPayload {
  // Acquisition channels offsets.
  int16_t offset1 = 0;
  int16_t offset2 = 0;
  // Acquisition direction flag.
  bool is_reverse_direction = false;
  // Reserve. Always write as 0.
  uint8_t reserved[32] = {};
};

// sizeof() = 40 as of Jan 2021.
struct ConfigPacket {
  uint32_t crc;
  ConfigPayload payload;
};

// Use this as default package value.
static const ConfigPayload kDefaultConfigPayload = {
    .offset1 = 2970,
    .offset2 = 2070,
    .is_reverse_direction = false,
};

static void clear_reserved(ConfigPayload* payload) {
  memset(&payload->reserved, 0x0, sizeof(payload->reserved));
}

// 'packet.reserved should be pre cleared.
static inline uint32_t compute_crc(const ConfigPayload& payload) {
  // Using an arbitrary seed.
  return crc32_ieee_update(0x1234, reinterpret_cast<const uint8_t*>(&payload),
                           sizeof(payload));
}

bool read_bytes(uint8_t byte_address, uint8_t* bfr, uint8_t size) {
  const struct device* i2c_dev = DEVICE_DT_GET(DT_NODELABEL(i2c0));

  if (!device_is_ready(i2c_dev)) {
    printk("I2c device not ready\n");
    return false;
  }
  int status = i2c_write_read(i2c_dev, kEepromDeviceAddress, &byte_address, 1,
                              bfr, size);

  printk("i2c read: status: %d\n", status);

  return status == 0;
}

bool write_bytes(uint8_t byte_address, const uint8_t* bfr, uint8_t size) {
  const struct device* i2c_dev = DEVICE_DT_GET(DT_NODELABEL(i2c0));

  if (!device_is_ready(i2c_dev)) {
    printk("read_bytes: I2c device not ready\n");
    return false;
  }

  uint8_t bytes_written = 0;

  while (bytes_written < size) {
    // Writes must be in a single 8 bytes page. Determine how many
    // bytes we have to write in the next page.
    const uint8_t next_byte_address = byte_address + bytes_written;
    const uint8_t bytes_left = size - bytes_written;
    uint8_t bytes_in_page = 8 - (next_byte_address & 0x7);
    if (bytes_in_page > bytes_left) {
      bytes_in_page = bytes_left;
    }

    // Preper send buffer. Start address + one to eight bytes to write.
    // bytes_in_page is in the range [1, 8].
    uint8_t packet[1 + 8];
    packet[0] = next_byte_address;
    for (uint8_t i = 0; i < bytes_in_page; i++) {
      packet[i + 1] = bfr[bytes_written++];
    }

    int status =
        i2c_write(i2c_dev, packet, bytes_in_page + 1, kEepromDeviceAddress);

    printk("i2c page write: status: %d\n", status);

    if (status) {
      // last_status = "WRITE_ERROR";
      return false;
    }

    // Let the eeprom finish pending writes, if any. See Twr in the datasheet.
    k_msleep(10);
  }

  return true;
}

static void copy_settings(const ConfigPayload& payload,
                          analyzer::Settings* settings) {
  settings->offset1 = payload.offset1;
  settings->offset2 = payload.offset2;
  settings->is_reverse_direction = payload.is_reverse_direction;
}

// const char* last_status = "NONE";

// Returns true if read ok. Otherwise default settings are returned.
bool read_acquisition_settings(analyzer::Settings* settings) {
  ConfigPacket packet;

  const bool read_ok = read_bytes(0, (uint8_t*)&packet, sizeof(packet));
  if (!read_ok) {
    copy_settings(kDefaultConfigPayload, settings);
    // last_status = "READ-ERROR";
    return false;
  }

  const uint32_t crc = compute_crc(packet.payload);

  printk("Config eeprom CRC: expected %08x, found %08x\n", crc, packet.crc);

  if (crc != packet.crc) {
    printk("Config eeprom: corrupted config, using defaults.\n");
    copy_settings(kDefaultConfigPayload, settings);
    // last_status = "CRC_ERROR";
    return false;
  }

  copy_settings(packet.payload, settings);
  // last_status = "OK";
  return true;
}

// Returns true if written ok.
bool write_acquisition_settings(const analyzer::Settings& settings) {
  ConfigPacket packet;
  // Populate payload.
  packet.payload.offset1 = settings.offset1;
  packet.payload.offset2 = settings.offset2;
  packet.payload.is_reverse_direction = settings.is_reverse_direction;
  clear_reserved(&packet.payload);

  // Compute checkscum.
  packet.crc = compute_crc(packet.payload);

  return write_bytes(0, (uint8_t*)&packet, sizeof(packet));
}

}  // namespace config_eeprom