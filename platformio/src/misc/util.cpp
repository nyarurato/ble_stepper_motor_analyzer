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

// // TODO: Move to ble_util.h
// // Iterator for dumping connections.
// static void conn_iterator(struct bt_conn *conn, void *data) {
//   // uint8_t *adr = conn->le.dst.a.val;
//   uint8_t *adr = conn->le.init_addr.a.val;
//   //uint8_t *adr = conn->le.resp_addr.a.val;
//   printk(
//       "*** Conn MTU %hu, Internal %hu (%hu, %hu) "
//       "%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX\n",
//       bt_gatt_get_mtu(conn), conn->le.interval, conn->le.interval_min,
//       conn->le.interval_max, adr[0], adr[1], adr[2], adr[3], adr[4], adr[5]);
// }

// // TODO: Move to ble_util.h
// void dump_connections() {
//   bt_conn_foreach(BT_CONN_TYPE_ALL, conn_iterator, NULL);
// }

}  // namespace util
