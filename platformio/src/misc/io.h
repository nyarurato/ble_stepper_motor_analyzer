
#pragma once

#include <hal/nrf_gpio.h>
#include <stdint.h>

namespace io {

// --- Output pins

template <uint32_t PIN_NUM>
class OutputPin {
 public:
  OutputPin()  {}
  void setup(uint32_t initial_value) {
    nrf_gpio_cfg_output(PIN_NUM);
    write(initial_value);
  }
  inline void set() { nrf_gpio_pin_set(PIN_NUM); }
  inline void clear() { nrf_gpio_pin_clear(PIN_NUM); }
  inline void toggle() { nrf_gpio_pin_toggle(PIN_NUM); }
  inline void write(uint32_t val) { nrf_gpio_pin_write(PIN_NUM, val); }
  static constexpr uint32_t pin_num = PIN_NUM;
};

// Active low.
extern OutputPin<25> LED1;
extern OutputPin<28> LED2;

// Output pulses for diagnostics.
extern OutputPin<11> TIMER_OUT_PIN;
extern OutputPin<12> ISR_OUT_PIN;

// Enables power on 0 value.
// extern OutputPin<9> SENSOR_POWER_PIN;

// --- Output pins

// template <uint32_t PIN_NUM>
// class InputPin {
//  public:
//   InputPin()  {}
//   void setup() {
//     nrf_gpio_cfg_input(PIN_NUM, NRF_GPIO_PIN_PULLUP);
//   }
//   inline bool read() { return nrf_gpio_pin_read(PIN_NUM); }
//   inline bool is_high() { return read(); }
//   inline bool is_low() { return !read(); }
  
//   static constexpr uint32_t pin_num = PIN_NUM;
// };

// // Active low. This pin is also the default DFU switch pin
// // of MCUboot.
// extern InputPin<13> SWITCH1;

void setup();

}  // namespace io