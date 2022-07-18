
from __future__ import annotations

# import asyncio
import math
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


class ProbeState:
    def __init__(self, timestamp_secs: float, steps: float, amps_a: float, amps_b: float, ticks_a: int, ticks_b: int):
        self.__timestamp_secs = timestamp_secs
        self.steps = steps
        self.amps_a = amps_a
        self.amps_b = amps_b
        self.ticks_a = ticks_a
        self.ticks_b = ticks_b

    @classmethod
    def decode(cls, data: bytearray, probe_info: ProbeInfo) -> (ProbeState | None):
        if len(data) != 15:
            logger.error(f"Invalid state data length {len(data)}.")
            return None
        #print(f"Data: {data.hex()}", flush=True)
        ticks_timestamp = int.from_bytes(
            data[0:6],  byteorder='big', signed=False)
        full_steps = int.from_bytes(data[6:10],  byteorder='big', signed=True)
        quadrant = int.from_bytes(data[10:11],  byteorder='big', signed=False)
        ticks_a = int.from_bytes(data[11:13],  byteorder='big', signed=True)
        ticks_b = int.from_bytes(data[13:15],  byteorder='big', signed=True)
        timestamp_secs = ticks_timestamp / probe_info.time_ticks_per_sec()
        amps_a = ticks_a / probe_info.current_ticks_per_amp()
        amps_b = ticks_b / probe_info.current_ticks_per_amp()
        # Compute steps with fractional resolution.
        steps = ProbeState.microsteps(full_steps, quadrant, ticks_a, ticks_b)
        return ProbeState(timestamp_secs, steps,  amps_a, amps_b, ticks_a, ticks_b)

    def __str__(self):
        return f"TS:{self.__timestamp_secs:9.3f}, Steps:{self.steps:8.2f}," \
            f" A:{self.amps_a:5.2f}, B:{self.amps_b:5.2f}, abs:{self.amps_abs():4.2f}" \
            f" ({self.ticks_a}, {self.ticks_b})"

    def timestamp_secs(self) -> float:
        return self.__timestamp_secs

    def steps(self) -> float:
        return self.step

    def amps_a(self) -> float:
        return self.amps_a

    def amps_b(self) -> float:
        return self.amps_b

    def amps_abs(self) -> float:
        return math.sqrt((self.amps_a * self.amps_a) + (self.amps_b * self.amps_b))

    # Power in Watts per 1ohm coil resistance.
    # def watts_per_ohm(self) -> float:
    #     return (self.amps_a * self.amps_a) + (self.amps_b * self.amps_b)

    @classmethod
    def microsteps(cls, full_steps: int, quadrant: int, ticks_a: int, ticks_b: int) -> float:
        # TODO: If both magnitudes are small, do not compute fraction,
        # equivalent to 'not energized' flag.

        # See quadrant diagram in doc directory for more
        # details.

        # Range is in [0, PI];
        radians = math.atan2(ticks_b, ticks_a)
        # Range [0, 2]
        microsteps = abs(radians * 2 / math.pi)

        # Adjust the fractional step per quadrant.
        if quadrant == 0:
            result = full_steps + microsteps - 0.5
        elif quadrant == 1:
            result = full_steps + microsteps - 1.5
        elif quadrant == 2:
            result = full_steps - microsteps + 1.5
        elif quadrant == 3:
            result = full_steps - microsteps + 0.5
        else:
            # Non reachable.
            result = 0

        return result
