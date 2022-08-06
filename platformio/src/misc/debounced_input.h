#pragma once

// #include "common.h"
#include "misc/io.h"

class DebouncedInput {
 public:
  // Note: Constructor is not called. Seems to be related to the 
  // fact we use this as a global var.
  explicit DebouncedInput() {}

  void init(io::InputPin* in_pin) {
    in_pin_ = in_pin;
    last_in_value_ = in_pin->read();
    stable_state_ = last_in_value_;
    changing_ = false;
    change_start_millis_ = 0;
  }

  // Returns the is_on() state.
  bool update(uint32_t millis_now);

  inline bool is_on() { return stable_state_; }

  void dump_state();

 private:
  io::InputPin* in_pin_;
  bool last_in_value_;
  bool stable_state_;
  bool changing_;
  uint32_t change_start_millis_;
};