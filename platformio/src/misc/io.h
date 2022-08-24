
#pragma once

#include <hal/nrf_gpio.h>
#include <stdint.h>
#include <zephyr.h>
// #include <misc/button.h>

namespace io {

// --- Output pins

class OutputPin {
 public:
  // Note: Constructor is not called. Seems to be related to the
  // fact we use this as a global var.
  OutputPin() {}

  void init(uint32_t pin_num, uint32_t initial_state) {
    // printk("** OutputPin.init(%u), prior=%u\n", pin_num, pin_num_);
    pin_num_ = pin_num;
    nrf_gpio_cfg_output(pin_num_);
    write(initial_state);
  }
  inline void set() { nrf_gpio_pin_set(pin_num_); }
  inline void clear() { nrf_gpio_pin_clear(pin_num_); }
  inline void toggle() { nrf_gpio_pin_toggle(pin_num_); }
  inline void write(uint32_t val) { nrf_gpio_pin_write(pin_num_, val); }
  inline uint32_t pin_num() { return pin_num_; }

 private:
  // Initialized by init().
  uint32_t pin_num_ = 0;
};

// Active low.
extern OutputPin LED1;
extern OutputPin LED2;

// Output pulses for diagnostics.
extern OutputPin TIMER_OUT_PIN;
extern OutputPin ISR_OUT_PIN;

// Enables power on 0 value.
// extern OutputPin<9> SENSOR_POWER_PIN;

// --- Output pins

class InputPin {
 public:
  InputPin() {}
  void init(uint32_t pin_num, nrf_gpio_pin_pull_t pull) {
    pin_num_ = pin_num;
    nrf_gpio_cfg_input(pin_num_, pull);
  }
  inline bool read() { return nrf_gpio_pin_read(pin_num_); }
  inline bool is_high() { return read(); }
  inline bool is_low() { return !read(); }
  inline uint32_t pin_num() { return pin_num_; }

 private:
  // Initialized by init()
  uint32_t pin_num_ = 0;
};

// Active low. This pin is also the default DFU switch pin
// of MCUboot.
extern InputPin SWITCH1;

// Used to select hardware configuration based on population
// of resistors R11, R12. An installed resistor results in
// '0' at the respective input.
extern InputPin HARDWARE_CFG1;
extern InputPin HARDWARE_CFG2;


void setup();

// Read hardware configuration.
// Returns:
// 3 - R11, R12, not installed.
// 2 - Only R11 installed.
// 1 - Only R12 installed.
// 0 - Both R11, R12 installed.
extern uint8_t read_hardware_config();

}  // namespace io