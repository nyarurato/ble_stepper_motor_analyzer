#include "misc/util.h"

// #include <bluetooth/buf.h>
// #include <bluetooth/gatt.h>
#include <device.h>
// #include <host/conn_internal.h>

// Hooks to the zephyr device list.
extern const struct device __device_start[];
extern const struct device __device_end[];

namespace util {

char text_bfr[100] = {0};

 void my_trap() {
  for (;;) {
    k_msleep(1000);
    printk("My Trap");
  }
}

// TODO: Move to ble_util.h
// Based on example in zephyr's kernel/device.c.
void dump_zephyr_devices() {
  int i = 0;
  printk("Zephyr devices:\n");
  for (const struct device *dev = __device_start; dev < __device_end; dev++) {
    printk("* [%d]: [%s]\n", i++, dev->name);
  }
}

}  // namespace util
