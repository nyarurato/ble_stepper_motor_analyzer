
#pragma once

#include "debounced_input.h"
#include "io.h"

class Button {
 public:
  enum ButtonEvent {
    EVENT_NONE,
    EVENT_SHORT_CLICK,
    EVENT_LONG_PRESS,
    EVENT_LONG_RELEASE,
  };

  // Note: Constructor is not called. Seems to be related to the
  // fact we use this as a global var.
  explicit Button() {}

  void init(io::InputPin* in_pin) {
    state_ = STATE_RELEASED;
    debounced_in_.init(in_pin);
    time_start_millis_ = 0;
  }

  // Returns the applicable button event for this update.
  ButtonEvent update(uint32_t millis_now);

  // Active low. Could check state_ instead.
  inline bool is_pressed() { return !debounced_in_.is_on(); }

  inline bool is_long_pressed() { return state_ == STATE_PRESSED_LONG; }

 private:
  enum State { STATE_RELEASED, STATE_PRESSED_IDLE, STATE_PRESSED_LONG };
  State state_;

  DebouncedInput debounced_in_;

  // Measure time in PRESSED_IDLE state.
  uint32_t time_start_millis_;
};

namespace button {

extern Button BUTTON1;

extern void setup();

}  // namespace button