
#include "io.h"

namespace io {

// Digital outputs.
OutputPin<26> LED1;
OutputPin<25> LED2;
OutputPin<11> TIMER_OUT_PIN;
OutputPin<12> ISR_OUT_PIN;
OutputPin<9> SENSOR_POWER_PIN;

// Digital inputs.
// InputPin<13> SWITCH1;

void setup() {
  // Outpupts
  LED1.setup(1);
  LED2.setup(1);
  SENSOR_POWER_PIN.setup(0);
  TIMER_OUT_PIN.setup(0);
  ISR_OUT_PIN.setup(0);

  // Inputs
  // SWITCH1.setup();
}

}  // namespace io