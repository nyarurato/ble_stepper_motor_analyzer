#!python

import asyncio
from bleak import discover


async def scan():
    print("Scanning (5 sec)...", flush=True)
    devices = await discover(timeout=5)
    for d in devices:
        print(d, flush=True)


asyncio.run(scan())
