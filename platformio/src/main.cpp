
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
#include "misc/button.h"
#include "misc/elapsed.h"
#include "misc/io.h"
#include "misc/util.h"

static void aqc_setup() {
  analyzer::Settings settings;
  config_eeprom::read_acquisition_settings(&settings);

  // NOTE that we call the analyzer settings before starting
  // the ADC interrupts.
  analyzer::setup(settings);

  adc_dma::setup();
}

//-----------------------------------

static Elapsed periodic_timer;

// TODO: share with other temp state buffers
static analyzer::State notification_state;

// When true, blinking LED is solid to provide feedback.
static bool zero_setting = false;

static void is_reverse_direction() {
  const bool new_reversed_direction = !analyzer::get_is_reversed_direction();
  analyzer::set_is_reversed_direction(new_reversed_direction);
  // We also reset the steps counter and such.
  analyzer::reset_data();
  analyzer::Settings settings;
  analyzer::get_settings(&settings);
  const bool write_ok = config_eeprom::write_acquisition_settings(settings);
  printk("%s direction. Write %s\n",
         new_reversed_direction ? "REVERSED" : "NORMAL",
         write_ok ? "OK" : "FAILED");
}

// Current through sensors must be zero when calling
// this.
static void zero_calibration() {
  analyzer::calibrate_zeros();
  analyzer::Settings settings;
  analyzer::get_settings(&settings);
  const bool write_ok = config_eeprom::write_acquisition_settings(settings);
  printk("Zero calibration (%hd, %hd). Write %s\n", settings.offset1,
         settings.offset2, write_ok ? "OK" : "FAILED");
}

void main(void) {
  io::setup();
  button::setup();
  util::dump_zephyr_devices();
  ble_service::setup();
  aqc_setup();

  static bool is_connected = false;
  for (;;) {
    // Update is_connected periodically.
    if (periodic_timer.elapsed_millis() >= 500) {
      periodic_timer.reset();
      is_connected = ble_service::is_connected();
    }

    // Update LED blinks.
    const uint32_t millis_now = k_uptime_get_32();
    const uint32_t blink_mask = is_connected ? 0x1 << 6 : 0x1 << 10;
    io::LED1.write((millis_now & blink_mask) || zero_setting);

    // Check button.
    Button::ButtonEvent button_event = button::BUTTON1.update(millis_now);
    if (!button::BUTTON1.is_pressed()) {
      // Button is not pressed. Can stop the zero calibration action feedback.
      zero_setting = false;
    }
    
    if (button_event != Button::EVENT_NONE) {
      printk("Button event: %d\n", button_event);

      // Handle single click. Reverse direction.
      if (button_event == Button::EVENT_SHORT_CLICK) {
        is_reverse_direction();
      }

      // Handle long press. Zero calibration.
      else if (button_event == Button::EVENT_LONG_PRESS) {
        zero_setting = true;
        zero_calibration();
      }
    }

    // This call is blocked until next notification state is available.
    // The rate is fast enough to non interfere with other activities in
    // this loop such as LED blinkin.
    analyzer::pop_next_state(&notification_state, true);

    // Send state notification if enabled.
    ble_service::maybe_notify_state(notification_state);
  }
}
