// Examples:
// https://github.com/zephyrproject-rtos/zephyr/blob/main/samples/drivers/i2c_fujitsu_fram/src/main.c
// https://github.com/zapta/legacy_stepper_motor_analyzer/blob/master/platformio/src/misc/config_eeprom.cpp

#include "config_eeprom.h"

#include <errno.h>
#include <zephyr.h>
// #include <zephyr/sys/printk.h>
#include <device.h>
#include <drivers/i2c.h>

namespace config_eeprom {

// i2c device address.
constexpr uint8_t kEepromDeviceAddress = 0x50;

// static const struct device *i2c_dev = nullptr;

static struct i2c_msg msgs[2];

bool read_bytes(const struct device *i2c_dev, uint8_t byte_address,
                uint8_t *bfr, uint8_t size) {
  // Command 1: Set eeprom internal address register using a dummy write.
  //   HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(
  //       &i2c::hi2c1, kEepromDeviceAddress << 1 | 0, &byte_address, 1, 100);
  //   if (status != HAL_OK) {
  //     return false;
  //   }

  //   HAL_StatusTypeDef status = HAL_I2C_Master_Transmit(
  //       &i2c::hi2c1, kEepromDeviceAddress << 1 | 0, &byte_address, 1, 100);
  //   if (status != HAL_OK) {
  //     return false;
  //   }

  // Select starting read address.

  // uint8_t rd_addr;
  // rd_addr = byte_address;

  msgs[0].buf = &byte_address;
  msgs[0].len = 1;
  msgs[0].flags = I2C_MSG_WRITE;

  // Read N bytes

  //  status = HAL_I2C_Master_Receive(&i2c::hi2c1, kEepromDeviceAddress << 1 |
  //  1,
  //                               bfr, size, 100);

  msgs[1].buf = bfr;
  msgs[1].len = size;
  msgs[1].flags = I2C_MSG_READ | I2C_MSG_STOP;

  // Execute.
  int status = i2c_transfer(i2c_dev, &msgs[0], 2, kEepromDeviceAddress);
  printk("read_bytes(): i2c status: %d\n", status);
  return status == 0;

  // Command 2: Read N bytes.
  //   status = HAL_I2C_Master_Receive(&i2c::hi2c1, kEepromDeviceAddress << 1 |
  //   1,
  //                                   bfr, size, 100);
  //   if (status != HAL_OK) {
  //     return false;
  //   }
  //   return true;
}

void temp_test() {
  const struct device *i2c_dev = DEVICE_DT_GET(DT_NODELABEL(i2c0));
  //   uint8_t cmp_data[16];
  //   uint8_t data[16];
  //   int i, ret;

  if (!device_is_ready(i2c_dev)) {
    printk("I2C: Device is not ready.\n");
    return;
  }

  printk("I2C: Device is ready.\n");

  uint8_t bfr[4];
  read_bytes(i2c_dev, 16, bfr, sizeof(bfr));
}

}  // namespace config_eeprom