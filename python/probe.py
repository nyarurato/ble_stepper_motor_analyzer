
from __future__ import annotations

import asyncio
import logging

# from typing import Awaitable
from typing import Callable
# from typing import Dict
# from typing import List
from typing import Optional
# from typing import Tuple

from bleak import BleakScanner
from bleak import BleakClient
from bleak.backends.service import BleakGATTService
from bleak.backends.service import BleakGATTCharacteristic
from numpy import byte
# from capture_signal import CaptureSignal
from current_histogram import CurrentHistogram

from probe_state import ProbeState
from probe_info import ProbeInfo
from time_histogram import TimeHistogram
from distance_histogram import DistanceHistogram


logger = logging.getLogger(__name__)


class Probe:
    def __init__(self, client: BleakClient, steps_per_unit: float):
        print("** Debug marker 30.1", flush=True)
        self.__client = client
        self.__probe_info = None
        self.__stepper_state_chrc = None
        self.__stepper_current_histogram_chrc = None
        self.__stepper_time_histogram_chrc = None
        self.__stepper_distance_histogram_chrc = None
        self.__stepper_command_chrc = None
        self.__capture_signal_chrc = None
        self.__steps_per_unit = steps_per_unit
        print("** Debug marker 30.2", flush=True)


    def __str__(self) -> str:
        return self.__client.address

    def address(self) -> str:
        return self.__client.address

    def probe_info(self) -> (ProbeInfo | None):
        return self.__probe_info

    async def __find_service_or_disconnect(self, name: str, uuid: str) -> (BleakGATTService | None):
        print("** Debug marker __find_service_or_disconnect.01", flush=True)
        if not self.__client.is_connected:
            print("** Debug marker __find_service_or_disconnect.02", flush=True)
            logger.error(f"Not connected (__find_service_or_disconnect).")
            # return None
        print("** Debug marker __find_service_or_disconnect.03", flush=True)
        service = self.__client.services.get_service(uuid)
        print("** Debug marker __find_service_or_disconnect.04", flush=True)
        if not service:
            print("** Debug marker __find_service_or_disconnect.05", flush=True)
            logger.error(
                f"Failed to find service {name} at device {self.address()}.")
            await self.disconnect()
            print("** Debug marker __find_service_or_disconnect.06", flush=True)
            return None
        logger.info(f"Found {name} info service {service}.")
        return service

    async def __find_chrc_or_disconnect(self, service: BleakGATTService, name: str, uuid: str) -> (BleakGATTCharacteristic | None):
        if not self.__client.is_connected:
            logger.error(f"Not connected (__find_chrc_or_disconnect).")
            # return None
        chrc = service.get_characteristic(uuid)
        if not chrc:
            logger.error(
                f"Failed to find characteristic {name} of device {self.address()}.")
            await self.disconnect()
            return None
        logger.info(f"Found {name} characteristic {chrc}.")
        return chrc

    async def __read_chrc_or_disconnect(self, service: BleakGATTService, name: str, uuid: str) -> (bytearray | None):
        if not self.__client.is_connected:
            logger.error(f"Not connected (__read_chrc_or_disconnect).")
            # return None
        chrc = await self.__find_chrc_or_disconnect(service, name, uuid)
        if not chrc:
            return None
        val_bytes = await self.__client.read_gatt_char(chrc)
        return val_bytes

    @classmethod
    async def find_by_address(cls, dev_addr: str, steps_per_unit: float, timeout: float = 30.0) -> Optional[Probe]:
        print(f"** Debug marker 20.1, dev_addr={dev_addr} ", flush=True)
        device = await BleakScanner.find_device_by_address(dev_addr, timeout=timeout)
        if not device:
            print(f"** Debug marker 20.1a, dev_addr={dev_addr} ", flush=True)
            logger.error(f"Device with address {dev_addr} not found.")
            return None
        logger.info(f"Found device: {device.address}.")
        print("** Debug marker 20.2 ", flush=True)
        client = BleakClient(device)
        print("** Debug marker 20.3", flush=True)
        probe = Probe(client, steps_per_unit)
        print("** Debug marker 20.4", flush=True)
        return probe

    def is_connected(self) -> bool:
        return self.__client.is_connected

    async def connect(self, timeout: float = 20.0) -> bool:
        print("** Debug marker 10.1.100", flush=True)
        if self.is_connected():
            print("** Debug marker 10.1.101", flush=True)
            return True

        print("** Debug marker 10.1.100a", flush=True)
        await self.__client.connect(timeout=timeout)
        print("** Debug marker 10.1.102", flush=True)
        if not self.is_connected():
            print("** Debug marker 10.1.103", flush=True)
            logger.error(f"Failed to connect to {self.address()}.")
            return False

        for s in self.__client.services.services.values():
            logger.info(f"* Service: {s}")

        print("** Debug marker 10.1.104", flush=True)
        device_info_service = await self.__find_service_or_disconnect("Device Info", "180a")
        if not device_info_service:
            print("** Debug marker 10.1.105", flush=True)
            return False

        print("** Debug marker 10.1.106", flush=True)
        stepper_service = await self.__find_service_or_disconnect("Stepper", "68e1a034-8125-4525-8a30-8799018c4bd0")
        if not stepper_service:
            print("** Debug marker 10.1.107", flush=True)
            return False

        print("** Debug marker 10.1.108", flush=True)
        model_number_bytes = await self.__read_chrc_or_disconnect(device_info_service, "Model Number", "2A24")
        if not model_number_bytes:
            print("** Debug marker 10.1.109", flush=True)
            return False

        manufacturer_bytes = await self.__read_chrc_or_disconnect(device_info_service, "Manufacturer", "2A29")
        if not manufacturer_bytes:
            return False

        print("** Debug marker 10.1.110", flush=True)
        probe_info_bytes = await self.__read_chrc_or_disconnect(stepper_service, "Probe Info", "37e75add-a610-448d-9fd3-3e3130e2c7f2")
        if not probe_info_bytes:
            print("** Debug marker 10.1.111", flush=True)
            return False

        # Get stepper state characteristic.
        print("** Debug marker 10.1.112", flush=True)
        stepper_state_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Stepper State", "37e75add-a610-448d-9fd3-3e3130e2c7f1")
        if not stepper_state_chrc:
            print("** Debug marker 10.1.113", flush=True)
            return False

        # Get current histogram characteristic.
        print("** Debug marker 10.1.114", flush=True)
        stepper_current_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Current Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f3")
        if not stepper_current_histogram_chrc:
            print("** Debug marker 10.1.115", flush=True)
            return False

        # Get time histogram characteristic.
        print("** Debug marker 10.1.116", flush=True)
        stepper_time_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Time Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f4")
        if not stepper_time_histogram_chrc:
            print("** Debug marker 10.1.117", flush=True)
            return False

        # Get distance histogram characteristic.
        print("** Debug marker 10.1.118", flush=True)
        stepper_distance_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Distance Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f5")
        if not stepper_distance_histogram_chrc:
            print("** Debug marker 10.1.119", flush=True)
            return False

        # Get stepper command characteristic.
        print("** Debug marker 10.1.120", flush=True)
        stepper_command_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Command", "37e75add-a610-448d-9fd3-3e3130e2c7f6")
        if not stepper_command_chrc:
            print("** Debug marker 10.1.121", flush=True)
            return False

        # Get capture signal characteristic.
        print("** Debug marker 10.1.122", flush=True)
        capture_signal_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Command", "37e75add-a610-448d-9fd3-3e3130e2c7f7")
        if not capture_signal_chrc:
            print("** Debug marker 10.1.123", flush=True)
            return False

        # Set this object.
        print("** Debug marker 10.1.124", flush=True)
        self.__probe_info = ProbeInfo.decode(
            probe_info_bytes, model_number_bytes.decode(), manufacturer_bytes.decode())
        print("** Debug marker 10.1.125", flush=True)
        self.__stepper_state_chrc = stepper_state_chrc
        self.__stepper_current_histogram_chrc = stepper_current_histogram_chrc
        self.__stepper_time_histogram_chrc = stepper_time_histogram_chrc
        self.__stepper_distance_histogram_chrc = stepper_distance_histogram_chrc
        self.__stepper_command_chrc = stepper_command_chrc
        self.__capture_signal_chrc = capture_signal_chrc

        print("** Debug marker 10.1.116", flush=True)
        logger.info(f"Connected to {self.address()}.")
        print("** Debug marker 10.1.127", flush=True)
        return True

    def info(self) -> (ProbeInfo | None):
        return self.__probe_info

    async def read_state(self) -> Optional[ProbeState]:
        if not self.is_connected():
            logger.error(f"Not connected (read_state)")
            # return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_state_chrc)
        return ProbeState.decode(val_bytes, self.__probe_info)

    async def read_current_histogram(self) -> Optional[CurrentHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_current_histogram).")
            # return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_current_histogram_chrc)
        return CurrentHistogram.decode(val_bytes, self.__probe_info, self.__steps_per_unit)

    async def read_time_histogram(self) -> Optional[TimeHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_time_histogram).")
            # return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_time_histogram_chrc)
        return TimeHistogram.decode(val_bytes, self.__probe_info,  self.__steps_per_unit)

    async def read_distance_histogram(self) -> Optional[DistanceHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_distance_histogram).")
            # return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_distance_histogram_chrc)
        return DistanceHistogram.decode(val_bytes, self.__probe_info,  self.__steps_per_unit)

    async def write_command_reset_data(self):
        if not self.is_connected():
            logger.error(f"Not connected (write_command_reset_data).")
            # return
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x01]))

    # async def write_toggle_direction_command(self):
    #     if not self.is_connected():
    #         logger.error(f"Not connected (write_toggle_direction_command).")
    #         return
    #     await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x04]))

    async def write_command_capture_signal_snapshot(self):
        if not self.is_connected():
            logger.error(
                f"Not connected (write_command_capture_signal_snapshot).")
            return
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x02]))

    async def write_command_set_capture_divider(self, divider):
        if not self.is_connected():
            logger.error(f"Not connected (write_command_set_capture_divider).")
            # return
        arg = max(0, min(255, int(divider)))
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x03, arg]))

    # Changes forward/backward direction interpretation. The new direction
    # is persisted on the device.
    async def write_toggle_direction_command(self):
        if not self.is_connected():
            logger.error(f"Not connected (write_toggle_direction_command).")
            # return
        print("Toggle direction command", flush=True)
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x04]))

    # Should be done with steppers disconnected or turned off. New zero calibration
    # is persisted on the device.
    async def write_zero_calibration_command(self):
        if not self.is_connected():
            logger.error(f"Not connected (write_zero_calibration_command).")
            # return
        print("Zero calibration command", flush=True)
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x05]))

    async def read_capture_signal_packet(self) -> Optional[bytearray]:
        if not self.is_connected():
            logger.error(f"Not connected (read_capture_signal_packet).")
            # return None
        return await self.__client.read_gatt_char(self.__capture_signal_chrc)

    async def tickle(self):
        await self.__client.get_services()
        return None

    async def state_notifications(self,
                                  handler: Callable[[ProbeState], None]):
        # Adapter handler.
        async def callback_handler(sender, data):
            # print("*** in callback adapter", flush=True)
            probe_state = ProbeState.decode(data, self.__probe_info)
            if handler:
                handler(probe_state)

        if not self.is_connected():
            logger.error(f"Not connected (callback_handler).")
            # return None
        await self.__client.start_notify(self.__stepper_state_chrc, callback_handler)
        logger.info(f"Started probe state notifications.")

    async def disconnect(self):
        logger.info(f"Disconnecting.")
        if not self.is_connected():
            self.__client.disconnect()
        self.__probe_info = None
        self.__stepper_state_chrc = None
        self.__stepper_current_histogram_chrc = None
        self.__stepper_time_histogram_chrc = None
        self.__stepper_distance_histogram_chrc = None
        self.____stepper_distance_histogram_chrc = None
        return
