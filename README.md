# BLE Stepper Motor Monitor

STATUS: THIS PAGE IS NOW BEING AUTHORED. PLEASE IGNORE IT FOR NOW.  Aug 2022.

The BLE Stepper Monitor Analyzer is a variant of the Simple Stepper Motor Analyzer which replaces the touch screen LCD with a Bluetooth BLE radio link and a python app that provides the display or a desktop computer. This result in a smaller and less expensive board and a large display that leverages on the desktop computer capabilities.

TODO: Add a screenshot

![](./www/pcb_image.jpg)

## Highlights
* Open source hardware, firmware, and software design, with permissive license that allows commercial use and does not require attreibution.
* A small and inexpensive PCB that can be embedded in the 3D printer or CNC machine.
* Each PCB has a unique address and can monitored individually.
* The PCB's can be ordered preassembled from JLCPCB with all the parts but the nrf52 BLE module that need to be soldered separately.
* The stepper motor wires are galvanically isolated from the analyzer's electronics to minimize potential interference or ground loops.
* The analyzer can be powered from any 4.5 to 30VDC source and consumes very little power, about 50mw. Even a single 9V battery can power it for many hours.

## Caveats
* Updating the PCB firmware requires a programmer. Normally it can be an inexpensive Segger JLink EDU Mini which as of Aug 2022 are unavailable due to supply chain shortage. One alternative can be the more expensive Nordic nRF52832 DK.
* The current sensors that are available from JLCPCB are on the noisy side compare to Alegro GMR sensors. However, the analyzer still function properly with the noisier sensors.
* As of Aug 2022, the python application requires some TLC, for example the handle more gracefully wireless link disconnections.
* The PCB can be built with two versions of BLE modules, one with an internal antenna and one with a U.FL connector for an external antenna. External antennas may be needed for printers with metal plates that shileds the PCB.


## Connecting the board

* Always turn power off before connecting or disconnecting the PCB or the stepper motor.
* Connect the 4 wires of your stepper motor through the board such that one connector with four wires is connected to your controller and one connector with with the other 4 wires is connected to the stepper. The connector pins are arranges such that the two left ones are connected to each other on the PCB, then the two second from the left and so on.
* Connect a voltage source of 4.5 t0 30VDC to the connector J3. Pay attention to polarity though the PCB is protected against reversed polarity.
* Turn power on, observed that one LED is solid red and the other is blinking slowly. Also verify that your stepper motor function and is turning in the same direction as before.

## Installing and running the python application

* Download the python directory from github.
* Install python3 on your computer.
*...
* Run in the command line *python3 scanner_main.py*, after a few seconds, it will print a list of BLE devices it found.
* ...



## Building your own

* 

