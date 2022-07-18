
from __future__ import annotations

# import asyncio
# import math
import logging

# from typing import Awaitable
# from typing import Callable
# from typing import Dict
from typing import List
# from typing import Optional
# from typing import Tuple

# from bleak import BleakScanner
# from bleak import BleakClient
# from numpy import full

from capture_signal import CaptureSignal
from probe_info import ProbeInfo
from probe import Probe


logger = logging.getLogger(__name__)


class CaptureSignalFetcher:
    def __init__(self, probe: Probe):
        self.__probe = probe
        self.__packets = []
        self.__new_cycle = True

    def reset(self):
        self.__packets = []
        self.__new_cycle = True

    async def loop(self) -> (CaptureSignal | None):
        # Send command to snap a new capture signal.
        if self.__new_cycle:
          await self.__probe.write_command_capture_signal_snapshot()
          self.__packets = []
          self.__new_cycle = False
          return

        # Read next packet
        packet = await self.__probe.read_capture_signal_packet()
        if not packet:
            logger.error(f"Error reading capture signal packet.")
            self.reset()
            return None

        if (packet[0] != 0x40):
            logger.error(
                    f"Unexpected capture signal packet format id: {packet[0]}.")
            self.reset()
            return None

        if ((packet[1] & 0x80) == 0):
            logger.error(f"Capture signal data not available. {packet[0]:02x}, {packet[1]:02x}")
            self.reset()
            return None

        self.__packets.append(packet)

        if (packet[1] & 0x01) != 0:
            return None  # More packets to read.

        result = CaptureSignal.decode(self.__packets, self.__probe.probe_info())
        self.reset()
        return result


    # @classmethod
    # def decode(cls, packets: List[bytearray], probe_info: ProbeInfo) -> (CaptureSignal | None):
    #     if len(packets) == 0:
    #         logger.error(f"No capture signal packets.")
    #         return None

    #     divider = int.from_bytes(packets[0][4:6],  byteorder='big', signed=False)

    #     # Decode data points.
    #     amps_a_list = []
    #     amps_b_list = []
    #     for packet in packets:
    #       # NOTE: For now we ignore the packet sequence number and offset field and
    #       # assume that the packets match.
    #       n = int.from_bytes(packet[6:8],  byteorder='big', signed=False)
    #       for i in range(n):
    #         # Offset of the a/b pair in the packet.
    #         base = 10 + (i * 4)
    #         ticks_a = int.from_bytes(packet[base:base+2],  byteorder='big', signed=True)
    #         ticks_b = int.from_bytes(packet[base+2:base+4],  byteorder='big', signed=True)
    #         amps_a = ticks_a / probe_info.current_ticks_per_amp()
    #         amps_b = ticks_b / probe_info.current_ticks_per_amp()
    #         amps_a_list.append(amps_a)
    #         amps_b_list.append(amps_b)
    #     return CaptureSignal(amps_a_list, amps_b_list, divider)

    # def __str__(self):
    #     return f"TS:{self.__timestamp_secs:9.3f}, Steps:{self.steps:8.2f}," \
    #         f" A:{self.amps_a:5.2f}, B:{self.amps_b:5.2f}, abs:{self.amps_abs():4.2f}" \
    #         f" ({self.ticks_a}, {self.ticks_b})"

    def amps_a(self) -> float:
        return self.amps_a

    def amps_b(self) -> float:
        return self.amps_b
