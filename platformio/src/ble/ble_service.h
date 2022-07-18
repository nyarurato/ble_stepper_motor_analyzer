
#pragma once

#include "acquisition/analyzer.h"


namespace ble_service { 

    void setup();

    // If state notification is enabled then send a notification
    // with this state.
    void maybe_notify_state(const analyzer::State& state);

    // Returns true if a host is connected.
    bool is_connected();
     
}  // namespace ble_service