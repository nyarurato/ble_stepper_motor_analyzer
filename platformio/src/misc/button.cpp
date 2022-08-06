#include "misc/button.h"

#include <zephyr.h>

#include "misc/io.h"

namespace button {
Button BUTTON1;

void setup() { BUTTON1.init(&io::SWITCH1); }

}  // namespace button

Button::ButtonEvent Button::update(uint32_t millis_now) {
  const bool debouncer_val = debounced_in_.update(millis_now);

  // Switch is active low.
  const bool is_on = !debouncer_val;

  ButtonEvent result = EVENT_NONE;
  switch (state_) {
    case STATE_RELEASED: {
      if (is_on) {
        state_ = STATE_PRESSED_IDLE;
        time_start_millis_ = millis_now;
      }
    } break;

    case STATE_PRESSED_IDLE: {
      const uint32_t millis_in_state = millis_now - time_start_millis_;
      if (is_on) {
        if (millis_in_state > 3000) {
          state_ = STATE_PRESSED_LONG;
          result = EVENT_LONG_PRESS;
        }
      } else {
        if (millis_in_state < 1000) {
          result = EVENT_SHORT_CLICK;
        }
        state_ = STATE_RELEASED;
      }
    } break;

    case STATE_PRESSED_LONG: {
      if (!is_on) {
        state_ = STATE_RELEASED;
        result = EVENT_LONG_RELEASE;
      }
    } break;

    default: {
      printk("UNKNOWN BUTTON STATE: %d\n", state_);
      state_ = STATE_RELEASED;
    }
  }

  return result;
}
