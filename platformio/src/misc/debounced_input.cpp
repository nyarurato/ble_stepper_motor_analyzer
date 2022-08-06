
#include "debounced_input.h"

#include <zephyr.h>

#include "io.h"

bool DebouncedInput::update(uint32_t millis_now) {
  last_in_value_ = in_pin_->read();
  // Case 1: pin is same as stable state.
  if (stable_state_ == last_in_value_) {
    changing_ = false;
  }

  // Case 2: pin just starting a transition from a stable state.
  else if (!changing_) {
    changing_ = true;
    change_start_millis_ = millis_now;
  }

  // Case 3: Transition became stable.
  else if ((millis_now - change_start_millis_) >= 100) {
    stable_state_ = !stable_state_;
    changing_ = false;
  }

  return stable_state_;
}

void DebouncedInput::dump_state() {
  // uint32_t a;
  printk("%u, %d, %d, %d, %u\n", in_pin_->pin_num(), last_in_value_,
         stable_state_, changing_, change_start_millis_);
}
