
from __future__ import annotations

# import asyncio
# import math
import logging

# from typing import Awaitable
# from typing import Callable
# from typing import Dict
# from typing import List
# from typing import Optional
# from typing import Tuple

# from bleak import BleakScanner
# from bleak import BleakClient
# from numpy import full


logger = logging.getLogger(__name__)


class ProbeInfo:
    def __init__(self, model: str, manufacturer: str, hardware_config: int,
                 current_ticks_per_amp: int, time_ticks_per_sec: int,
                 histogram_bucket_steps_per_sec: int):
        self.__model = model
        self.__manufacturer = manufacturer
        self.__hardware_config = hardware_config
        self.__current_ticks_per_amp = current_ticks_per_amp
        self.__time_ticks_per_sec = time_ticks_per_sec
        self.__histogram_bucket_steps_per_sec = histogram_bucket_steps_per_sec

    @classmethod
    def decode(cls, data: bytearray,  model: str, manufacturer: str) -> (ProbeInfo | None):
        if len(data) != 9:
            logger.error(f"Invalid probe info data length {len(data)}.")
            return None
        # Uint8
        format = data[0]
        if format != 0x01:
            logger.error(f"Unexpected probe info format {format}.")
            return None
        # Uint8
        hardware_config = data[1]
        # Uint16
        current_ticks_per_amp = int.from_bytes(
            data[2:4],  byteorder='big', signed=False)
        # Uint24
        time_ticks_per_sec = int.from_bytes(
            data[4:7],  byteorder='big', signed=False)
        # Uint16
        histogram_bucket_steps_per_sec = int.from_bytes(
            data[7:9],  byteorder='big', signed=False)

        return ProbeInfo(model, manufacturer, hardware_config, current_ticks_per_amp, time_ticks_per_sec, histogram_bucket_steps_per_sec)

    def model(self) -> str:
        return self.__model

    def manufacturer(self) -> str:
        return self.__manufacturer

    def hardware_config(self) -> int:
        return self.__hardware_config

    def current_ticks_per_amp(self) -> int:
        return self.__current_ticks_per_amp

    def time_ticks_per_sec(self) -> int:
        return self.__time_ticks_per_sec

    def histogram_bucket_steps_per_sec(self) -> int:
        return self.__histogram_bucket_steps_per_sec
