
#include <bluetooth/gatt.h>
#include <stdio.h>
#include <zephyr.h>

#include "acquisition/adc_dma.h"
#include "acquisition/analyzer.h"
#include "ble/ble_util.h"
#include "misc/config_eeprom.h"

// NOTE: BLE Peripheral example is from
// .platformio/packages/framework-zephyr/samples/bluetooth/peripheral/src
// https://docs.zephyrproject.org/latest/samples/bluetooth/bluetooth.html

// NOTE: UUID are version 4 (random) UUID, generated
// at https://www.uuidgenerator.net.

#include <errno.h>
#include <string.h>
#include <sys/printk.h>
#include <zephyr.h>
#include <zephyr/types.h>

#include "ble/ble_service.h"
#include "misc/elapsed.h"
#include "misc/io.h"
#include "misc/util.h"

static void aqc_setup() {
  analyzer::Settings analyzer_settings = {.offset1 = 2048 - 239 + 270,
                                          .offset2 = 2048 - 205 + 220,
                                          .reverse_direction = false};
  // NOTE that we call the analyzer settings before starting
  // the ADC interrupts.
  analyzer::setup(analyzer_settings);

  adc_dma::setup();
}

//-----------------------------------

static Elapsed blink_timer;

static Elapsed test_timer;


// TODO: share with other temp state buffers
static analyzer::State notification_state;

// static analyzer::AdcCaptureBuffer capture_buffer;
// static Elapsed dump_timer;


void main(void) {
  io::setup();

  // k_msleep(5000);

  util::dump_zephyr_devices();

  ble_service::setup();

  aqc_setup();

  static bool is_connected = false;
  for (;;) {
    const uint32_t blink_ms = is_connected ? 50 : 300;

    if (blink_timer.elapsed_millis() >= blink_ms) {
      blink_timer.reset();
      io::LED1.toggle();
      is_connected = ble_service::is_connected();
    }

    // if (dump_timer.elapsed_millis() >= 5000) {
    //   dump_timer.reset();
    //   analyzer::get_last_capture_snapshot(&capture_buffer);
    //   analyzer::dump_adc_capture_buffer(capture_buffer);
    // }

    // Blocking call.
    analyzer::pop_next_state(&notification_state, true);

    // Send state notification if enabled.
    ble_service::maybe_notify_state(notification_state);

    if (test_timer.elapsed_millis() > 2000) {
      test_timer.reset();
      config_eeprom::temp_test();
    }
  }
}
