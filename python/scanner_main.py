#!python

# A python program to scan the bluetooth BLE devices
# nearby, looking for stepper motor analyzer ids which
# look like "STP-EA2307AE0794"

import asyncio
from bleak import discover


async def scan():
    print("Scanning...", flush=True)
    devices = await discover()
    for device in devices:
        # print(device, flush=True)
        name = device.name or "---"
        print(f"{device.address}  {name}", flush=True)


asyncio.run(scan())
