
#include <bluetooth/gatt.h>
#include <errno.h>
#include <stdio.h>
#include <string.h>
#include <sys/printk.h>
#include <zephyr.h>
#include <zephyr/types.h>

#include "acquisition/adc_dma.h"
#include "acquisition/analyzer.h"
#include "ble/ble_service.h"
#include "ble/ble_util.h"
#include "misc/button.h"
#include "misc/config_eeprom.h"
#include "misc/controls.h"
#include "misc/elapsed.h"
#include "misc/io.h"
#include "misc/util.h"

// NOTE: UUID are version 4 (random) UUID, generated
// at https://www.uuidgenerator.net.

//-----------------------------------

static Elapsed periodic_timer;

// TODO: share with other temp state buffers
static analyzer::State notification_state;

// When true, blinking LED is solid to provide feedback.
// static bool zero_setting = false;

// Used to have solid LED for a short time after reset to
// indicate a reset, in case of an unstable power supply.
// static bool reset_flag = true;

// Used to blink N times LED 2.
static Elapsed led2_timer;
// Down counter. If value > 0, then led2 blinks and bit 0 controls
// the led state.
static uint16_t led2_counter;

static void start_led2_blinks(uint16_t n) {
  led2_timer.reset();
  led2_counter = n * 2;
  io::LED2.write(led2_counter > 0);
}

// Determine hardware configuration based on configuration
// resistors.
static uint16_t get_adc_ticks_per_amp(uint8_t hardware_config) {
  switch (hardware_config) {
    case 3:
      // R12, R11 not installed.
      return acq_consts::CC6920BSO5A_MV_PER_AMP;
      break;
    case 2:
      // Only R11 is installed.
      return acq_consts::TMCS1108A4B_MV_PER_AMP;
      break;
    // Configurations 0, 1 are reserved.
    default:
      printk("ERROR: Unknoen hardware config %hhu\n", hardware_config);
      return 0;
  }
}

static void aqc_setup() {
  analyzer::Settings settings;
  config_eeprom::read_acquisition_settings(&settings);

  // NOTE that we call the analyzer settings before starting
  // the ADC interrupts.
  analyzer::setup(settings);

  adc_dma::setup();
}

// Used to generate blink to indicates that
// acquisition is working.
static uint32_t analyzer_counter = 0;

void main(void) {
  io::setup();
  button::setup();
  util::dump_zephyr_devices();

  // We assume that the pullup inputs got settled by now.
  const uint8_t hardware_config = io::read_hardware_config();
  printk("Hardware config: %hhu\n", hardware_config);
  const uint16_t adc_ticks_per_amp = get_adc_ticks_per_amp(hardware_config);
  printk("ADC ticks per amp: %hu\n", adc_ticks_per_amp);

  ble_service::setup(hardware_config, adc_ticks_per_amp);
  aqc_setup();

  static bool is_connected = false;
  for (;;) {
    // Update is_connected periodically.
    if (periodic_timer.elapsed_millis() >= 500) {
      periodic_timer.reset();
      is_connected = ble_service::is_connected();
    }

    // Update LED blinks.  Blinking indicates analyzer works
    // and provides states. High speed blink indicates connection
    // status.
    const int blink_shift = is_connected ? 0 : 3;
    const bool blink_state = ((analyzer_counter >> blink_shift) & 0x7) == 0x0;
    // Supress LED1 while blinking LED2. We should move them appart on the
    // board such that they don't interfere visually.
    io::LED1.write(blink_state && !led2_counter);

    if (led2_counter > 0 && led2_timer.elapsed_millis() >= 500) {
      led2_timer.reset();
      led2_counter--;
      io::LED2.write(led2_counter > 0 && !(led2_counter & 0x1));
    }

    // if  (reset_flag) {
    //   io::LED2.set();
    // }

    // Check button.
    const uint32_t millis_now = k_uptime_get_32();
    // if (millis_now >= 3000) {
    //   reset_flag = false;
    // }
    Button::ButtonEvent button_event = button::BUTTON1.update(millis_now);
    // if (!button::BUTTON1.is_pressed()) {
    //   // Button is not pressed. Can stop the zero calibration action
    //   feedback. zero_setting = false;
    // }

    if (button_event != Button::EVENT_NONE) {
      printk("Button event: %d\n", button_event);

      // Handle single click. Reverse direction.
      if (button_event == Button::EVENT_SHORT_CLICK) {
        bool new_is_reversed_direcction;
        const bool ok = controls::toggle_direction(&new_is_reversed_direcction);
        const uint16_t num_blinks = !ok                          ? 10
                                    : new_is_reversed_direcction ? 2
                                                                 : 1;
        start_led2_blinks(num_blinks);
      }

      // Handle long press. Zero calibration.
      else if (button_event == Button::EVENT_LONG_PRESS) {
        // zero_setting = true;
        const bool ok = controls::zero_calibration();
        start_led2_blinks(ok ? 3 : 10);
      }
    }

    // This call is blocked until next notification state is available.
    // The rate is fast enough to non interfere with other activities in
    // this loop such as LED blinkin.
    analyzer::pop_next_state(&notification_state, true);

    analyzer_counter++;

    // Send state notification if enabled.
    ble_service::maybe_notify_state(notification_state);

    // printk("Config: %hhu\n",   io::read_hardware_config());

  }
}
