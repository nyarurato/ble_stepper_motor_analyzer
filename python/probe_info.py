
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
    def __init__(self, model: str, manufacturer: str, current_ticks_per_amp: int, time_ticks_per_sec: int, histogram_bucket_steps_per_sec: int):
        self.__model = model
        self.__manufacturer = manufacturer
        self.__current_ticks_per_amp = current_ticks_per_amp
        self.__time_ticks_per_sec = time_ticks_per_sec
        self.__histogram_bucket_steps_per_sec = histogram_bucket_steps_per_sec

    @classmethod
    def decode(cls, data: bytearray,  model: str, manufacturer: str) -> (ProbeInfo | None):
        if len(data) != 8:
            logger.error(f"Invalid probe info data length {len(data)}.")
            return None

        format = data[0]
        if format != 0x01:
            logger.error(f"Unexpected probe info format {format}.")
            return None

        current_ticks_per_amp = int.from_bytes(
            data[1:3],  byteorder='big', signed=False)

        time_ticks_per_sec = int.from_bytes(
            data[3:6],  byteorder='big', signed=False)

        histogram_bucket_steps_per_sec = int.from_bytes(
            data[6:8],  byteorder='big', signed=False)

        return ProbeInfo(model, manufacturer, current_ticks_per_amp, time_ticks_per_sec, histogram_bucket_steps_per_sec)

    def model(self) -> str:
        return self.__model

    def manufacturer(self) -> str:
        return self.__manufacturer

    def current_ticks_per_amp(self) -> int:
        return self.__current_ticks_per_amp

    def time_ticks_per_sec(self) -> int:
        return self.__time_ticks_per_sec

    def histogram_bucket_steps_per_sec(self) -> int:
        return self.__histogram_bucket_steps_per_sec
