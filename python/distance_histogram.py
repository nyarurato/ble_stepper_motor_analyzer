
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

from probe_info import ProbeInfo


logger = logging.getLogger(__name__)

class DistanceHistogram:
    def __init__(self, bucket_width: int, buckets: List[float]):
        self.__bucket_width:int = bucket_width
        self.__buckets:List[float] = buckets

    @classmethod
    def decode(cls, data: bytearray, probe_info: ProbeInfo) -> (DistanceHistogram | None):
        format = data[0]
        if format != 0x30:
            logger.error(f"Unexpected distance histogram format {format}.")
            return None

        bucket_count = data[1]

        buckets = []
        for i in range(bucket_count):
            offset = 2 + i*2
            rel_time_mils = int.from_bytes(data[offset: offset+2],  byteorder='big', signed=False)
            rel_time_percents = rel_time_mils / 100.0
            buckets.append(rel_time_percents)

        return DistanceHistogram(probe_info.histogram_bucket_steps_per_sec(), buckets)   

    def centers(self) -> List[float]:
        w = self.__bucket_width
        v = w / 2
        result = []
        for i in range(len(self.__buckets)):
            result.append(v)
            v += w
        return result

    def heights(self) -> List[float]:
        return self.__buckets

    def bucket_width(self) ->int:
        return self.__bucket_width

    

    
