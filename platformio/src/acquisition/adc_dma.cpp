// Implementation of the acquisition module. It uses the ADC/DMA
// interrupts to process the ADC sampling.

#include "adc_dma.h"

//#include <stdio.h>
#include <hal/nrf_gpio.h>
#include <hal/nrf_gpiote.h>
#include <hal/nrf_ppi.h>
#include <hal/nrf_saadc.h>
#include <hal/nrf_timer.h>
#include <stdint.h>
#include <zephyr.h>
#include <spinlock.h>

#include "acquisition/analyzer.h"
#include "misc/io.h"
#include "nrfx_gpiote.h"
#include "nrfx_ppi.h"

// Analyzer provides this callback.
namespace analyzer {
void isr_handle_one_sample(const uint16_t raw_v1, const uint16_t raw_v2);
void isr_snapshot_state();
}  // namespace analyzer

namespace adc_dma {

static k_spinlock zephyr_lock; 
static k_spinlock_key_t zephyr_lock_key;

// This also prevents preemption of the calling thread
// by other zephyr threads while interrupts are disabled.
//
// Nesting of disable interrupts are not allowed.
void disable_irq() { 
  //NVIC_DisableIRQ(SAADC_IRQn); 
  zephyr_lock_key = k_spin_lock(&zephyr_lock);
}

void enable_irq() { 
  //NVIC_EnableIRQ(SAADC_IRQn); 
  k_spin_unlock(&zephyr_lock, zephyr_lock_key);
}

#define MY_NRFX_CHECK(x, reason)              \
  {                                           \
    if ((x) != NRFX_SUCCESS) my_trap(reason); \
  }

#define ADC_TIMER NRF_TIMER2

//#define PAIRS_PER_BUFFER 800
#define SAMPLES_PER_BUFFER (2 * 800)  // TODO: final value 800

static nrf_saadc_value_t adc_buffers[2][SAMPLES_PER_BUFFER] = {0};

static volatile uint32_t isr_counter = 0;

// Current saadc buffer index. Contains 0 or 1.
static volatile int current_buffer = 0;

// TODO: Find a better way to stop the CPU.
void my_trap(int reason) {
  static volatile int x;
  for (;;) {
    x += reason;
  }
}

nrf_ppi_channel_t FreshPpiChan() {
  nrf_ppi_channel_t ppi_chan = NRF_PPI_CHANNEL19;  // Be deterministic.
  if (nrfx_ppi_channel_alloc(&ppi_chan) != NRFX_SUCCESS) {
    my_trap(100);
  }
  return ppi_chan;
}

// Takes <2ms, 50Hz per 800 sample pairs per buffer.
void my_saadc_isr(void* arg) {
  isr_counter += 1;

  io::ISR_OUT_PIN.set();

  nrf_saadc_event_clear(NRF_SAADC, NRF_SAADC_EVENT_END);

  nrf_saadc_value_t* p = adc_buffers[current_buffer];
  nrf_saadc_value_t* p_end = p + SAMPLES_PER_BUFFER;

  while (p < p_end) {
    // TODO: clip both values to 12 bits.
    const int16_t v1_raw = *(p++);
    const int16_t v2_raw = *(p++);

    const uint16_t v1 = v1_raw < 0 ? 0 : v1_raw & 0xfff;
    const uint16_t v2 = v2_raw < 0 ? 0 : v2_raw & 0xfff;

    analyzer::isr_handle_one_sample(v1, v2);
  }

  // Submit the current buffer back to the saadc for next sampling.
  // nrf_saadc_buffer_pointer_set(NRF_SAADC, adc_buffer_ptrs[current_buffer]);
  nrf_saadc_buffer_pointer_set(NRF_SAADC, adc_buffers[current_buffer]);

  current_buffer = (current_buffer + 1) & 0x1;

  analyzer::isr_snapshot_state();

  io::ISR_OUT_PIN.clear();
}

void InitTimer() {
  nrf_timer_mode_set(ADC_TIMER, NRF_TIMER_MODE_TIMER);
  nrf_timer_bit_width_set(ADC_TIMER, NRF_TIMER_BIT_WIDTH_16);
  nrf_timer_frequency_set(ADC_TIMER, NRF_TIMER_FREQ_1MHz);

  // Set cycle and pulse width.  40Khz for 40Khz sampling on each
  // of the two analog inputs. This should match the value of
  // TIME_TICKS_PER_SEC.
  //
  // NOTE: The CC indexes are tied to the PPI code below.
  nrf_timer_cc_set(ADC_TIMER, NRF_TIMER_CC_CHANNEL0, 5);
  nrf_timer_cc_set(ADC_TIMER, NRF_TIMER_CC_CHANNEL1, 25);

  // Auto timer reset at CC 1 event.
  nrf_timer_shorts_set(ADC_TIMER, NRF_TIMER_SHORT_COMPARE1_CLEAR_MASK);

  // Start the timer.
  nrf_timer_task_trigger(ADC_TIMER, NRF_TIMER_TASK_START);
}

static const nrf_saadc_channel_config_t ch_config = {
    .resistor_p = NRF_SAADC_RESISTOR_PULLDOWN,
    .resistor_n = NRF_SAADC_RESISTOR_PULLDOWN,
    // Gain = 1/4, to match the reference.
    .gain = NRF_SAADC_GAIN1_4,
    // Reference = 3.3V / 4.
    .reference = NRF_SAADC_REFERENCE_VDD4,
    // Per errata, can't be less than 10us which results in per
    // channel sampling time of 12usec.
    .acq_time = NRF_SAADC_ACQTIME_10US,
    .mode = NRF_SAADC_MODE_SINGLE_ENDED,
    .burst = NRF_SAADC_BURST_DISABLED};

void InitAdc() {
  nrf_saadc_resolution_set(NRF_SAADC, NRF_SAADC_RESOLUTION_12BIT);
  nrf_saadc_oversample_set(NRF_SAADC, NRF_SAADC_OVERSAMPLE_DISABLED);

  // Write the first buffer. The second buffer is written  below
  // after we start the adc to sample the first buffer.
  nrf_saadc_buffer_init(NRF_SAADC, adc_buffers[0], SAMPLES_PER_BUFFER);
  nrf_saadc_buffer_pointer_set(NRF_SAADC, adc_buffers[1]);

  nrf_saadc_channel_init(NRF_SAADC, 0, &ch_config);

  // Select the two analog input pins.
  nrf_saadc_channel_pos_input_set(NRF_SAADC, 0, NRF_SAADC_INPUT_AIN0);
  nrf_saadc_channel_pos_input_set(NRF_SAADC, 1, NRF_SAADC_INPUT_AIN1);

  nrf_saadc_enable(NRF_SAADC);

  // Calibrate.
  nrf_saadc_event_clear(NRF_SAADC, NRF_SAADC_EVENT_CALIBRATEDONE);
  nrf_saadc_task_trigger(NRF_SAADC, NRF_SAADC_TASK_CALIBRATEOFFSET);
  for (;;) {
    if (nrf_saadc_event_check(NRF_SAADC, NRF_SAADC_EVENT_CALIBRATEDONE)) {
      nrf_saadc_event_clear(NRF_SAADC, NRF_SAADC_EVENT_CALIBRATEDONE);
      break;
    }
    k_msleep(100);
  }

  // Enable interrupt on the END event to signal that the ADC completed
  // filling the current buffer.
  IRQ_CONNECT(SAADC_IRQn, 4, my_saadc_isr, "MY_ISR_ARG", 0);
  nrf_saadc_int_enable(NRF_SAADC, NRF_SAADC_INT_END);
  NVIC_EnableIRQ(SAADC_IRQn);

  // Start the SAADC. The actual sampling will happen on each timer trigger
  // SAMPLE task.
  nrf_saadc_event_clear(NRF_SAADC, NRF_SAADC_EVENT_STARTED);
  nrf_saadc_task_trigger(NRF_SAADC, NRF_SAADC_TASK_START);

  // Wait for the SAADC to start before submiting the next buffe.r
  while (!nrf_saadc_event_check(NRF_SAADC, NRF_SAADC_EVENT_STARTED)) {
    k_msleep(1);
  }
  nrf_saadc_channel_init(NRF_SAADC, 1, &ch_config);
}

void InitPpi() {
  nrfx_err_t nrfx_status;
  if (!nrfx_gpiote_is_init()) {
    nrfx_status = nrfx_gpiote_init(4);  // Arbitrary irq level. Not used.
    MY_NRFX_CHECK(nrfx_status, 106);
  }

  // Make the timer out pin controlled by GPIOTE.
  {
    const nrfx_gpiote_out_config_t pin_config =
        NRFX_GPIOTE_CONFIG_OUT_TASK_TOGGLE(true);

    nrfx_status =
        // nrfx_gpiote_out_prealloc_init(LED2_PIN, &config, gpiote_chan);
        // nrfx_gpiote_out_init(TIMER_OUT_PIN, &pin_config);
        nrfx_gpiote_out_init(io::TIMER_OUT_PIN.pin_num, &pin_config);
    MY_NRFX_CHECK(nrfx_status, 102);

    // ;;nrfx_gpiote_set_task_trigger

    // Define a GPIO task on the timer out pin (for diagnostics). This
    // also enables the built in SET/CLEAR tasks for that pin, which is
    // what we actually use below.
    // nrf_gpiote_task_configure(NRF_GPIOTE,
    //                          5,                           // Config index
    //                          idx, TIMER_OUT_PIN,                    // Pin,
    //                          NRF_GPIOTE_POLARITY_TOGGLE,  // Polarity,
    //                          NRF_GPIOTE_INITIAL_VALUE_HIGH);  // Init_val;
    nrfx_gpiote_out_task_enable(io::TIMER_OUT_PIN.pin_num);
    // nrf_gpiote_task_enable(NRF_GPIOTE, 5);
  }

  // Tie the GPIO's reset task to the ADC timer's fiirst compare event. Used
  // for diagnostics only.
  {
    nrfx_err_t nrfx_status;

    // Alloc a PPI channel.
    const nrf_ppi_channel_t ppi_chan = FreshPpiChan();

    // Task is clearing LED2 pin.
    const uint32_t gpio_clr_task_addr =
        nrfx_gpiote_clr_task_addr_get(io::TIMER_OUT_PIN.pin_num);

    // Event is ADC timer middle of cycle.
    const uint32_t timer_clr_event_addr =
        nrf_timer_event_address_get(ADC_TIMER, NRF_TIMER_EVENT_COMPARE0);

    // Associate the event and task.
    nrfx_status = nrfx_ppi_channel_assign(ppi_chan, timer_clr_event_addr,
                                          gpio_clr_task_addr);
    MY_NRFX_CHECK(nrfx_status, 104);

    nrfx_ppi_channel_enable(ppi_chan);
  }

  // Do the same for the second timer compare event and the GPIO set
  // task.
  {
    nrfx_err_t nrfx_status;

    const nrf_ppi_channel_t ppi_chan = FreshPpiChan();

    // Task is clearing LED2 pin.
    const uint32_t gpio_set_task_addr =
        nrfx_gpiote_set_task_addr_get(io::TIMER_OUT_PIN.pin_num);

    // Event is ADC timer end of cycle.
    const uint32_t timer_set_event_addr =
        nrf_timer_event_address_get(ADC_TIMER, NRF_TIMER_EVENT_COMPARE1);

    // Associate the event and task.
    nrfx_status = nrfx_ppi_channel_assign(ppi_chan, timer_set_event_addr,
                                          gpio_set_task_addr);
    MY_NRFX_CHECK(nrfx_status, 104);

    nrfx_ppi_channel_enable(ppi_chan);
  }

  // --------- adc auto start next buffer.  END -> Start

  // PER https://www.taterli.com/nrf5/nrf5/hardware_driver_saadc.html
  {
    const nrf_ppi_channel_t ppi_chan = FreshPpiChan();
    uint32_t saadc_end_event_addr =
        nrf_saadc_event_address_get(NRF_SAADC, NRF_SAADC_EVENT_END);

    uint32_t saadc_start_task_addr =
        nrf_saadc_task_address_get(NRF_SAADC, NRF_SAADC_TASK_START);

    nrf_ppi_channel_endpoint_setup(NRF_PPI, ppi_chan, saadc_end_event_addr,
                                   saadc_start_task_addr);

    nrf_ppi_channel_enable(NRF_PPI, ppi_chan);
  }

  //----------adc trigger from timer
  {
    const nrf_ppi_channel_t ppi_chan = FreshPpiChan();
    uint32_t timer_event_addr =
        nrf_timer_event_address_get(ADC_TIMER, NRF_TIMER_EVENT_COMPARE1);
    uint32_t adc_sample_task_addr =
        nrf_saadc_task_address_get(NRF_SAADC, NRF_SAADC_TASK_SAMPLE);
    nrf_ppi_channel_endpoint_setup(NRF_PPI, ppi_chan, timer_event_addr,
                                   adc_sample_task_addr);
    nrf_ppi_channel_enable(NRF_PPI, ppi_chan);
  }
}

// Assuming io: is already setup.
void setup() {
  InitAdc();
  InitPpi();
  InitTimer();
}

// TODO: Move to a common place and share with other temp state
// buffers.
static analyzer::State temp_state;

void dump_state() {
  analyzer::sample_state(&temp_state);

  printk("Acq: %u, %hd, %hd, %d, %.2f\n", isr_counter, temp_state.v1,
         temp_state.v2, temp_state.full_steps,
         analyzer::state_steps(temp_state));
}

}  // namespace adc_dma
