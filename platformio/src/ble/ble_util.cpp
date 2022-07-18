#include "ble/ble_util.h"

#include <bluetooth/buf.h>
#include <bluetooth/gatt.h>
#include <device.h>
#include <host/conn_internal.h>


namespace ble_util { 

    // void setup();

    // void loop();

// Iterator for dumping connections.
static void conn_iterator(struct bt_conn *conn, void *data) {
  // uint8_t *adr = conn->le.dst.a.val;
  uint8_t *adr = conn->le.init_addr.a.val;
  //uint8_t *adr = conn->le.resp_addr.a.val;
  printk(
      "*** Conn State %u, MTU %hu, Interval %hu (%hu, %hu) "
      "%02hhX:%02hhX:%02hhX:%02hhX:%02hhX:%02hhX\n",
      conn->state,
      bt_gatt_get_mtu(conn), conn->le.interval, conn->le.interval_min,
      conn->le.interval_max, adr[0], adr[1], adr[2], adr[3], adr[4], adr[5]);
}

// TODO: Move to ble_util.h
void dump_connections() {
  bt_conn_foreach(BT_CONN_TYPE_ALL, conn_iterator, NULL);
}
}  // namespace util