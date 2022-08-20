
#include "io.h"

namespace io {

// Digital outputs.
OutputPin LED1;
OutputPin LED2;
OutputPin TIMER_OUT_PIN;
OutputPin ISR_OUT_PIN;

// Digital inputs.
InputPin  SWITCH1;  // Used for BUTTON1

InputPin HARDWARE_CFG1;
InputPin HARDWARE_CFG2;

void setup() {
  // Outpupts
  LED1.init(25, 0);
  LED2.init(28, 0);
  TIMER_OUT_PIN.init(11, 0);
  ISR_OUT_PIN.init(12, 0);

  // Inputs
  SWITCH1.init(13, NRF_GPIO_PIN_PULLUP);

  HARDWARE_CFG1.init(9, NRF_GPIO_PIN_PULLUP);
  HARDWARE_CFG2.init(10, NRF_GPIO_PIN_PULLUP);
}

uint8_t read_hardware_config() {
  return (HARDWARE_CFG1.is_low() ? 1 : 0) |
         (HARDWARE_CFG2.is_low() ? 2 : 0);
}

}  // namespace io