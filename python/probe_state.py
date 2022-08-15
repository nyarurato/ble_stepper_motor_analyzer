
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
    def __init__(self, timestamp_secs: float, steps: float, amps_a: float, amps_b: 
        float, ticks_a: int, ticks_b: int, quadrant: int, is_reversed_direction: bool):
        self.__timestamp_secs = timestamp_secs
        self.steps = steps
        self.amps_a = amps_a
        self.amps_b = amps_b
        self.ticks_a = ticks_a
        self.ticks_b = ticks_b
        self.quadrant = quadrant
        self.is_reversed_direction = is_reversed_direction

    @classmethod
    def decode(cls, data: bytearray, probe_info: ProbeInfo) -> (ProbeState | None):
        if len(data) != 15:
            logger.error(f"Invalid state data length {len(data)}.")
            return None
        #print(f"Data: {data.hex()}", flush=True)
        ticks_timestamp = int.from_bytes(
            data[0:6],  byteorder='big', signed=False)
        full_steps = int.from_bytes(data[6:10],  byteorder='big', signed=True)
        flags = int.from_bytes(data[10:11],  byteorder='big', signed=False)
        quadrant = flags & 0x3
        is_reversed_direction = (flags & 0x10) != 0
        ticks_a = int.from_bytes(data[11:13],  byteorder='big', signed=True)
        ticks_b = int.from_bytes(data[13:15],  byteorder='big', signed=True)
        timestamp_secs = ticks_timestamp / probe_info.time_ticks_per_sec()
        amps_a = ticks_a / probe_info.current_ticks_per_amp()
        amps_b = ticks_b / probe_info.current_ticks_per_amp()
        # Compute steps with fractional resolution.
        steps = ProbeState.microsteps(full_steps, quadrant, ticks_a, ticks_b, is_reversed_direction)
        return ProbeState(timestamp_secs, steps,  amps_a, amps_b, ticks_a, ticks_b, quadrant, is_reversed_direction)

    def __str__(self):
        return f"TS:{self.__timestamp_secs:9.3f}, Steps:{self.steps:8.2f}," \
            f" A:{self.amps_a:5.2f}, B:{self.amps_b:5.2f}, abs:{self.amps_abs():4.2f}" \
            f" ({self.ticks_a}, {self.ticks_b} / {self.quadrant}, {self.is_reversed_direction})"

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
    def microsteps(cls, full_steps: int, quadrant: int, ticks_a: int, ticks_b: int, is_reversed_direction: bool) -> float:
        # TODO: If both magnitudes are small, do not compute fraction,
        # equivalent to 'not energized' flag.

        # See quadrant diagram in doc directory for more
        # details.

        # Range [0, PI] in radians;
        radians = math.atan2(ticks_b, ticks_a)
        # Range [0, 2] steps.
        microsteps = abs(radians * 2 / math.pi)

        # Compute fractional step adjustment by quadrant. 
        # Adjustment is in [-0.5, 0.5]
        if quadrant == 0:
            adjustment = microsteps - 0.5
        elif quadrant == 1:
            adjustment = microsteps - 1.5
        elif quadrant == 2:
            adjustment = -microsteps + 1.5
        elif quadrant == 3:
            adjustment = -microsteps + 0.5
        else:
            # Non reachable.
            result = 0

        if is_reversed_direction:
            result = full_steps - adjustment
        else:
            result = full_steps + adjustment


        return result
