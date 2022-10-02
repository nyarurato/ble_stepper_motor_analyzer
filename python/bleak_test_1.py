#!python

# Testing BLE connection with bleak.

import asyncio
from bleak import BleakClient
from bleak import BleakScanner

# Replace with actual device address
DEVICE_ADDRESS = "EE:E7:C3:26:42:83"


async def main():
    print(f"Finding device {DEVICE_ADDRESS} ...", flush=True)
    device = await BleakScanner.find_device_by_address(DEVICE_ADDRESS, timeout=5)
    print(f"Device: {device}", flush=True)

    print(f"Creating client...", flush=True)
    client = BleakClient(device)
    print(f"Client created: {client}", flush=True)

    print(f"Connecting to device...", flush=True)
    await client.connect(timeout=5)
    print(f"Is connected: {client.is_connected}", flush=True)

    print("Device services:", flush=True)
    for s in client.services.services.values():
        print(f"  Service: {s}", flush=True)

    print("All done", flush=True)


asyncio.run(main())
