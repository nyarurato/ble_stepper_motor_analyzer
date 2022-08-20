#!python

# A python program to scan the bluetooth BLE devices
# nearby, looking for stepper motor analyzer ids which
# look like "STP-EA2307AE0794"

import asyncio
from bleak import discover


async def scan():
    print("Scanning (5 sec)...", flush=True)
    devices = await discover(timeout=5)
    for d in devices:
        print(d, flush=True)


asyncio.run(scan())
