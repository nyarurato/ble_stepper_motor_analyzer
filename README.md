# BLE Stepper Motor Monitor

The BLE Stepper Monitor allows to analyze and diagnose the behavior
of stepper motors within 3D printers and CNC machines. It is made 
of a small probe that analyzes the currents on the stepper motor, 
and sends the data over Bluetooth BLE to a computer program that 
display the results in real time.

The probe uses low power of about 50mw and can be powered from
a battery or from any DC supply in the range 4.5 to 30VDC. Since
the sensors on the probe are galvanic isolated, there is not
risk of ground loops or electrical interferance with the operation
of the motor. In a typicall application, one more more probes
are installed in a 3D printer, powered from its 24VDC supply and
being monitored from the commputer app when needed.

Each probe as a unique address such that individual probes
can be selected for monitoring as needed.


![](./www/screen1.jpg)

## Building your own

The hardware, firmware, and software of the BLE Stepper Motor Monitor
are available as open source with no restrictions on commercial use,
modifications, or attribution. In addition, this github repository
also contains the files necessary to order assembled units from
JLCPCB with the exception of the BLE module which needs to be
soldered seperatly, and the firmware that need to be flashed.

