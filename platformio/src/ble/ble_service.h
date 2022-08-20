
#pragma once

#include "acquisition/analyzer.h"


namespace ble_service { 

    void setup(uint16_t adc_ticks_per_amp);


    // If state notification is enabled then send a notification
    // with this state.
    void maybe_notify_state(const analyzer::State& state);

    // Returns true if a host is connected.
    bool is_connected();
     
}  // namespace ble_service