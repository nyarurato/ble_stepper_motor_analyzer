
#include "io.h"

namespace io {

// Digital outputs.
// OutputPin LED1(25);
// OutputPin LED2(28);
// OutputPin TIMER_OUT_PIN(11);
// OutputPin ISR_OUT_PIN(12);
OutputPin LED1;
OutputPin LED2;
OutputPin TIMER_OUT_PIN;
OutputPin ISR_OUT_PIN;

// Digital inputs.
InputPin  SWITCH1;  // Used for BUTTON1

void setup() {
  // Outpupts
  LED1.init(25, 1);
  LED2.init(28, 1);
  TIMER_OUT_PIN.init(11, 0);
  ISR_OUT_PIN.init(12, 0);

  // Inputs
  SWITCH1.init(13, NRF_GPIO_PIN_PULLUP);
}

}  // namespace io