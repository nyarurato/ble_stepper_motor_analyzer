
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
    def __init__(self, client: BleakClient):
        self.__client = client
        self.__probe_info = None
        self.__stepper_state_chrc = None
        self.__stepper_current_histogram_chrc = None
        self.__stepper_time_histogram_chrc = None
        self.__stepper_distance_histogram_chrc = None
        self.__stepper_command_chrc = None
        self.__capture_signal_chrc = None

    def __str__(self) -> str:
        return self.__client.address

    def address(self) -> str:
        return self.__client.address

    def probe_info(self) -> (ProbeInfo | None):
        return self.__probe_info

    async def __find_service_or_disconnect(self, name: str, uuid: str) -> (BleakGATTService | None):
        if not self.__client.is_connected:
            logger.error(f"Not connected (__find_service_or_disconnect).")
            return None
        service = self.__client.services.get_service(uuid)
        if not service:
            logger.error(
                f"Failed to find service {name} at device {self.address()}.")
            await self.disconnect()
            return None
        logger.info(f"Found {name} info service {service}.")
        return service

    async def __find_chrc_or_disconnect(self, service: BleakGATTService, name: str, uuid: str) -> (BleakGATTCharacteristic | None):
        if not self.__client.is_connected:
            logger.error(f"Not connected (__find_chrc_or_disconnect).")
            return None
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
            return None
        chrc = await self.__find_chrc_or_disconnect(service, name, uuid)
        if not chrc:
            return None
        val_bytes = await self.__client.read_gatt_char(chrc)
        return val_bytes

    @classmethod
    async def find_by_address(cls, dev_addr: str, timeout: float = 30.0) -> Optional[Probe]:
        device = await BleakScanner.find_device_by_address(dev_addr, timeout=timeout)
        if not device:
            logger.error(f"Device with address {dev_addr} not found.")
            return None
        logger.info(f"Found device: {device.address}.")
        client = BleakClient(device)
        return Probe(client)

    def is_connected(self) -> bool:
        return self.__client.is_connected

    async def connect(self, timeout: float = 20.0) -> bool:
        if self.is_connected():
            return True

        await self.__client.connect(timeout=timeout)
        if not self.is_connected():
            logger.error(f"Failed to connect to {self.address()}.")
            return False

        for s in self.__client.services.services.values():
            logger.info(f"* Service: {s}")

        device_info_service = await self.__find_service_or_disconnect("Device Info", "180a")
        if not device_info_service:
            return False

        stepper_service = await self.__find_service_or_disconnect("Stepper", "68e1a034-8125-4525-8a30-8799018c4bd0")
        if not stepper_service:
            return False

        model_number_bytes = await self.__read_chrc_or_disconnect(device_info_service, "Model Number", "2A24")
        if not model_number_bytes:
            return False

        manufacturer_bytes = await self.__read_chrc_or_disconnect(device_info_service, "Manufacturer", "2A29")
        if not manufacturer_bytes:
            return False

        probe_info_bytes = await self.__read_chrc_or_disconnect(stepper_service, "Probe Info", "37e75add-a610-448d-9fd3-3e3130e2c7f2")
        if not probe_info_bytes:
            return False

        # Get stepper state characteristic.
        stepper_state_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Stepper State", "37e75add-a610-448d-9fd3-3e3130e2c7f1")
        if not stepper_state_chrc:
            return False

        # Get current histogram characteristic.
        stepper_current_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Current Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f3")
        if not stepper_current_histogram_chrc:
            return False

        # Get time histogram characteristic.
        stepper_time_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Time Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f4")
        if not stepper_time_histogram_chrc:
            return False

        # Get distance histogram characteristic.
        stepper_distance_histogram_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Distance Histogram", "37e75add-a610-448d-9fd3-3e3130e2c7f5")
        if not stepper_distance_histogram_chrc:
            return False

        # Get stepper command characteristic.
        stepper_command_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Command", "37e75add-a610-448d-9fd3-3e3130e2c7f6")
        if not stepper_command_chrc:
            return False

        # Get capture signal characteristic.
        capture_signal_chrc = await self.__find_chrc_or_disconnect(stepper_service, "Command", "37e75add-a610-448d-9fd3-3e3130e2c7f7")
        if not capture_signal_chrc:
            return False

        # Set this object.
        self.__probe_info = ProbeInfo.decode(
            probe_info_bytes, model_number_bytes.decode(), manufacturer_bytes.decode())
        self.__stepper_state_chrc = stepper_state_chrc
        self.__stepper_current_histogram_chrc = stepper_current_histogram_chrc
        self.__stepper_time_histogram_chrc = stepper_time_histogram_chrc
        self.__stepper_distance_histogram_chrc = stepper_distance_histogram_chrc
        self.__stepper_command_chrc = stepper_command_chrc
        self.__capture_signal_chrc = capture_signal_chrc

        logger.info(f"Connected to {self.address()}.")
        return True

    def info(self) -> (ProbeInfo | None):
        return self.__probe_info

    async def read_state(self) -> Optional[ProbeState]:
        if not self.is_connected():
            logger.error(f"Not connected (read_state)")
            return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_state_chrc)
        return ProbeState.decode(val_bytes, self.__probe_info)

    async def read_current_histogram(self) -> Optional[CurrentHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_current_histogram).")
            return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_current_histogram_chrc)
        return CurrentHistogram.decode(val_bytes, self.__probe_info)

    async def read_time_histogram(self) -> Optional[TimeHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_time_histogram).")
            #return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_time_histogram_chrc)
        return TimeHistogram.decode(val_bytes, self.__probe_info)

    async def read_distance_histogram(self) -> Optional[DistanceHistogram]:
        if not self.is_connected():
            logger.error(f"Not connected (read_distance_histogram).")
            return None
        val_bytes = await self.__client.read_gatt_char(self.__stepper_distance_histogram_chrc)
        return DistanceHistogram.decode(val_bytes, self.__probe_info)

    async def write_command_reset_data(self):
        if not self.is_connected():
            logger.error(f"Not connected (write_command_reset_data).")
            return
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x01]))

    async def write_command_capture_signal_snapshot(self):
        if not self.is_connected():
            logger.error(f"Not connected (write_command_capture_signal_snapshot).")
            return
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x02]))

    async def write_command_set_capture_divider(self, divider):
        if not self.is_connected():
            logger.error(f"Not connected (write_command_set_capture_divider).")
            return
        arg = max(0, min(255, int(divider)))
        await self.__client.write_gatt_char(self.__stepper_command_chrc, bytearray([0x03, arg]))

    async def read_capture_signal_packet(self) -> Optional[bytearray]:
        if not self.is_connected():
            logger.error(f"Not connected (read_capture_signal_packet).")
            return None
        return await self.__client.read_gatt_char(self.__capture_signal_chrc)

    async def tickle(self):
        await self.__client.get_services()
        return None

    async def state_notifications(self,
                                  handler: Callable[[ProbeState], None]):

        # Adapter handler.
        async def callback_handler(sender, data):
            ##print(f"Notification handler called data:{len(data)}, self:{self.info().current_ticks_per_amp()}, handler:{callback}", flush=True)
            probe_state = ProbeState.decode(data, self.__probe_info)
            if handler:
                handler(probe_state)

        if not self.is_connected():
            logger.error(f"Not connected (callback_handler).")
            return None
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
