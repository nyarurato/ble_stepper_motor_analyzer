#pragma once

#include <stdint.h>

namespace acq_consts {

// This number of report times ticks corresponds to 1 amp
// of current. Used to convert raw current ticks to 
// actual amps.
constexpr uint16_t CURRENT_TICKS_PER_AMP = 496;

// How many time the pair of channels is sampled per second.
// This time ticks are used as the data time base.
constexpr uint32_t TIME_TICKS_PER_SEC = 40000;

// Number of histogram buckets, each bucket represents
// a band of step speeds.
constexpr int kNumHistogramBuckets = 25;

// Each histogram bucket represents a speed range of 100
// steps/sec, starting from zero. Overflow speeds are
// aggregated in the last bucket.
const int kBucketStepsPerSecond = 200;

}  // namespace acq_consts