EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title "Stepper Motor BLE Probe"
Date ""
Rev "DRAFT"
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
Wire Wire Line
	7425 1900 7425 2075
Wire Wire Line
	8825 1600 8825 1400
Wire Wire Line
	8825 1400 9075 1400
Wire Wire Line
	8825 1900 8825 2075
Wire Wire Line
	7675 1900 7675 2075
Connection ~ 7675 2075
Wire Wire Line
	7675 1600 7675 1400
$Comp
L stepper_probe:+3V3 #PWR024
U 1 1 62794A9A
P 9850 1400
F 0 "#PWR024" H 9850 1250 50  0001 C CNN
F 1 "+3V3" V 9865 1528 50  0000 L CNN
F 2 "" H 9850 1400 50  0001 C CNN
F 3 "" H 9850 1400 50  0001 C CNN
	1    9850 1400
	0    1    1    0   
$EndComp
$Comp
L stepper_probe:GND #PWR025
U 1 1 62794283
P 9925 2100
F 0 "#PWR025" H 9925 1850 50  0001 C CNN
F 1 "GND" H 9929 1945 50  0001 C CNN
F 2 "" H 9925 2100 50  0001 C CNN
F 3 "" H 9925 2100 50  0001 C CNN
	1    9925 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	8825 2075 9075 2075
Connection ~ 8825 2075
Wire Wire Line
	9075 1600 9075 1400
Wire Wire Line
	9075 1900 9075 2075
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 6279B2E2
P 1000 1550
F 0 "J1" H 1150 1750 50  0000 R CNN
F 1 "Conn_01x04_Male" H 972 1523 50  0001 R CNN
F 2 "stepper_probe:connector_4pins_horizontal" H 1000 1550 50  0001 C CNN
F 3 "~" H 1000 1550 50  0001 C CNN
F 4 "C31753" H 1000 1550 50  0001 C CNN "LCSC"
	1    1000 1550
	1    0    0    1   
$EndComp
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 627A7186
P 1325 2825
F 0 "J2" H 1425 3000 50  0000 R CNN
F 1 "Conn_01x04_Male" H 1900 3000 50  0001 R CNN
F 2 "stepper_probe:connector_4pins_horizontal" H 1325 2825 50  0001 C CNN
F 3 "~" H 1325 2825 50  0001 C CNN
F 4 "C31753" H 1325 2825 50  0001 C CNN "LCSC"
	1    1325 2825
	1    0    0    1   
$EndComp
$Comp
L stepper_probe-rescue:ACS70331_soic8-simple_stepper_motor_analyzer U1
U 1 1 627A85BB
P 3775 1600
F 0 "U1" H 2950 1900 50  0000 C CNN
F 1 "CC6920BSO-5A" H 3200 2025 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 4175 1550 50  0001 L CIN
F 3 "" H 3775 1600 50  0001 C CNN
F 4 "C2880430" H 2900 2150 50  0000 L CNN "LCSC"
	1    3775 1600
	1    0    0    -1  
$EndComp
Wire Wire Line
	3175 1400 3125 1400
Wire Wire Line
	3125 1400 3125 1450
Wire Wire Line
	3125 1500 3175 1500
Wire Wire Line
	3175 1700 3125 1700
Wire Wire Line
	3125 1700 3125 1750
Wire Wire Line
	3125 1800 3175 1800
Wire Wire Line
	3125 1450 1200 1450
Connection ~ 3125 1450
Wire Wire Line
	3125 1450 3125 1500
Wire Wire Line
	2200 2475 2150 2475
Wire Wire Line
	2150 2475 2150 2525
Wire Wire Line
	2150 2575 2200 2575
Wire Wire Line
	2200 2775 2150 2775
Wire Wire Line
	2150 2775 2150 2825
Wire Wire Line
	2150 2875 2200 2875
Connection ~ 2150 2825
Wire Wire Line
	2150 2825 2150 2875
Wire Wire Line
	1200 1550 2025 1550
Wire Wire Line
	2025 1550 2025 2525
Wire Wire Line
	2025 2525 2150 2525
Connection ~ 2150 2525
Wire Wire Line
	2150 2525 2150 2575
Wire Wire Line
	1525 2825 2150 2825
Wire Wire Line
	1525 2725 1925 2725
Wire Wire Line
	1925 2725 1925 1750
Wire Wire Line
	1925 1750 3125 1750
Connection ~ 3125 1750
Wire Wire Line
	3125 1750 3125 1800
Wire Wire Line
	1200 1350 1825 1350
Wire Wire Line
	1825 1350 1825 2625
Wire Wire Line
	1825 2625 1525 2625
Wire Wire Line
	1200 1650 1725 1650
Wire Wire Line
	1725 1650 1725 2925
Wire Wire Line
	1725 2925 1525 2925
$Comp
L stepper_probe:GND #PWR012
U 1 1 627B9B1A
P 3725 2075
F 0 "#PWR012" H 3725 1825 50  0001 C CNN
F 1 "GND" H 3729 1920 50  0001 C CNN
F 2 "" H 3725 2075 50  0001 C CNN
F 3 "" H 3725 2075 50  0001 C CNN
	1    3725 2075
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR08
U 1 1 627B9F00
P 2750 3150
F 0 "#PWR08" H 2750 2900 50  0001 C CNN
F 1 "GND" H 2754 2995 50  0001 C CNN
F 2 "" H 2750 3150 50  0001 C CNN
F 3 "" H 2750 3150 50  0001 C CNN
	1    2750 3150
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR010
U 1 1 627BB296
P 3200 2225
F 0 "#PWR010" H 3200 1975 50  0001 C CNN
F 1 "GND" H 3204 2070 50  0001 C CNN
F 2 "" H 3200 2225 50  0001 C CNN
F 3 "" H 3200 2225 50  0001 C CNN
	1    3200 2225
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR014
U 1 1 627BE8C2
P 4175 1150
F 0 "#PWR014" H 4175 900 50  0001 C CNN
F 1 "GND" H 4179 995 50  0001 C CNN
F 2 "" H 4175 1150 50  0001 C CNN
F 3 "" H 4175 1150 50  0001 C CNN
	1    4175 1150
	1    0    0    -1  
$EndComp
Text Label 4900 1500 2    50   ~ 0
CHA
Text Label 4900 2575 2    50   ~ 0
CHB
Wire Wire Line
	2825 2200 2750 2200
Wire Wire Line
	2750 2200 2750 2275
Wire Wire Line
	3125 2200 3200 2200
Wire Wire Line
	3200 2200 3200 2225
Wire Wire Line
	3725 2000 3725 2075
Wire Wire Line
	2750 3075 2750 3150
Wire Wire Line
	3800 1125 3725 1125
Wire Wire Line
	3725 1125 3725 1200
Text Label 1625 1350 2    50   ~ 0
STEPPER4
Text Label 1625 1450 2    50   ~ 0
STEPPER3
Text Label 1625 1550 2    50   ~ 0
STEPPER2
Text Label 1625 1650 2    50   ~ 0
STEPPER1
$Comp
L stepper_probe-rescue:Motor-simple_stepper_motor_analyzer M1
U 1 1 6284B7A9
P 1050 2925
F 0 "M1" H 1100 3325 50  0001 L CNN
F 1 "Motor" H 950 3275 50  0001 L TNN
F 2 "stepper_probe:Empty" H 1060 3015 50  0001 C CNN
F 3 "" H 1060 3015 50  0001 C CNN
F 4 "DNP" H 1050 2925 50  0001 C CNN "LCSC"
	1    1050 2925
	0    -1   -1   0   
$EndComp
Text Notes 975  1425 2    50   ~ 0
A
Text Notes 975  1625 2    50   ~ 0
B
Wire Wire Line
	4100 1125 4175 1125
Wire Wire Line
	4175 1125 4175 1150
$Comp
L Device:LED D3
U 1 1 62873129
P 9000 5375
F 0 "D3" V 9075 5325 50  0000 R CNN
F 1 "LED R" V 9000 5325 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 9000 5375 50  0001 C CNN
F 3 "~" H 9000 5375 50  0001 C CNN
F 4 "C165980" V 8625 5375 50  0000 C CNN "LCSC"
	1    9000 5375
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R5
U 1 1 6287420D
P 9000 5050
F 0 "R5" H 8975 4950 50  0000 R CNN
F 1 "5K1" H 9000 5150 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9000 5050 50  0001 C CNN
F 3 "~" H 9000 5050 50  0001 C CNN
F 4 "C25905" V 9100 5100 50  0000 C CNN "LCSC"
	1    9000 5050
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR018
U 1 1 6287501E
P 9000 5600
F 0 "#PWR018" H 9000 5350 50  0001 C CNN
F 1 "GND" H 9004 5445 50  0001 C CNN
F 2 "" H 9000 5600 50  0001 C CNN
F 3 "" H 9000 5600 50  0001 C CNN
	1    9000 5600
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:+3V3 #PWR017
U 1 1 628755EF
P 9000 4800
F 0 "#PWR017" H 9000 4650 50  0001 C CNN
F 1 "+3V3" H 9015 4973 50  0000 C CNN
F 2 "" H 9000 4800 50  0001 C CNN
F 3 "" H 9000 4800 50  0001 C CNN
	1    9000 4800
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 5150 9000 5225
Wire Wire Line
	9000 5525 9000 5600
$Comp
L Device:Crystal Y1
U 1 1 6288EBBE
P 2575 6825
F 0 "Y1" H 2575 6975 50  0000 C CNN
F 1 "32.768Khz" H 3050 6950 50  0000 C CNN
F 2 "stepper_probe:Crystal_SMD_3215-2Pin_3.2x1.5mm" H 2575 6825 50  0001 C CNN
F 3 "~" H 2575 6825 50  0001 C CNN
F 4 "C479190" H 3025 7050 50  0000 C CNN "LCSC"
	1    2575 6825
	1    0    0    -1  
$EndComp
Text Notes 9575 6900 2    79   ~ 0
BLE STEPPER MOTOR MONITOR  v1.3.2
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J5
U 1 1 62893276
P 6825 3375
F 0 "J5" H 6875 3792 50  0000 C CNN
F 1 "SWD" H 6875 3701 50  0001 C CNN
F 2 "stepper_probe:PinHeader_2x05_P1.27mm_Vertical_SMD" H 6825 3375 50  0001 C CNN
F 3 "~" H 6825 3375 50  0001 C CNN
F 4 "C2935458" H 6975 3700 50  0000 C CNN "LCSC"
	1    6825 3375
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 628AD243
P 6025 1500
F 0 "J3" H 6125 1275 50  0000 R CNN
F 1 "BAT" H 5875 1450 50  0001 R CNN
F 2 "stepper_probe:PinHeader_1x02_P2.54mm_Horizontal_JLCPCB" H 6025 1500 50  0001 C CNN
F 3 "~" H 6025 1500 50  0001 C CNN
F 4 "C2935927" H 6025 1500 50  0001 C CNN "LCSC"
	1    6025 1500
	1    0    0    1   
$EndComp
Connection ~ 9075 1400
Connection ~ 9075 2075
Text Notes 5550 1500 0    50   ~ 0
VIN\n5-30VDC
Text Notes 9675 3950 2    50   ~ 0
SERIAL (DEV)
Text Label 8925 3225 0    50   ~ 0
TX
Text Label 8925 3325 0    50   ~ 0
RX
Text Notes 9750 3350 0    50   ~ 0
RX
Text Notes 9750 3250 0    50   ~ 0
TX\n
Text Notes 9750 3450 0    50   ~ 0
GND\n
Wire Wire Line
	3925 5525 4525 5525
Text Label 1500 4825 0    50   ~ 0
LED2
Text Label 1500 4525 0    50   ~ 0
LED1
Wire Wire Line
	2725 6125 2725 6450
Wire Wire Line
	2825 6125 2825 6450
Text Label 2825 6450 1    50   ~ 0
CHB
Text Label 2725 6450 1    50   ~ 0
CHA
Wire Wire Line
	3125 6125 3125 6450
Text Label 3125 6450 1    50   ~ 0
TX
Text Label 3325 6450 1    50   ~ 0
RX
$Comp
L stepper_probe:GND #PWR06
U 1 1 6298A12E
P 2425 6225
F 0 "#PWR06" H 2425 5975 50  0001 C CNN
F 1 "GND" H 2429 6070 50  0001 C CNN
F 2 "" H 2425 6225 50  0001 C CNN
F 3 "" H 2425 6225 50  0001 C CNN
	1    2425 6225
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR013
U 1 1 6298A985
P 3625 6225
F 0 "#PWR013" H 3625 5975 50  0001 C CNN
F 1 "GND" H 3629 6070 50  0001 C CNN
F 2 "" H 3625 6225 50  0001 C CNN
F 3 "" H 3625 6225 50  0001 C CNN
	1    3625 6225
	1    0    0    -1  
$EndComp
Wire Wire Line
	2425 6125 2425 6225
Wire Wire Line
	3625 6125 3625 6225
Wire Wire Line
	3925 4125 4325 4125
Wire Wire Line
	4325 4125 4325 4150
$Comp
L stepper_probe:GND #PWR04
U 1 1 629974E9
P 2050 4150
F 0 "#PWR04" H 2050 3900 50  0001 C CNN
F 1 "GND" H 2054 3995 50  0001 C CNN
F 2 "" H 2050 4150 50  0001 C CNN
F 3 "" H 2050 4150 50  0001 C CNN
	1    2050 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2125 4125 2050 4125
Wire Wire Line
	2050 4125 2050 4150
$Comp
L Device:C C3
U 1 1 629B66ED
P 2325 7000
F 0 "C3" H 2200 7100 50  0000 L CNN
F 1 "12pf" H 2125 6925 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 2363 6850 50  0001 C CNN
F 3 "~" H 2325 7000 50  0001 C CNN
F 4 "C26406" H 2150 6825 50  0000 C CNN "LCSC"
	1    2325 7000
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 629B708E
P 1975 5950
F 0 "C2" H 1750 5925 50  0000 L CNN
F 1 "10u" H 1750 5850 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 2013 5800 50  0001 C CNN
F 3 "~" H 1975 5950 50  0001 C CNN
F 4 "C96446" H 1800 5750 50  0000 C CNN "LCSC"
	1    1975 5950
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 629B7E29
P 9850 5375
F 0 "D2" V 9925 5325 50  0000 R CNN
F 1 "LED Y" V 9850 5325 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 9850 5375 50  0001 C CNN
F 3 "~" H 9850 5375 50  0001 C CNN
F 4 "C165978" V 9475 5375 50  0000 C CNN "LCSC"
	1    9850 5375
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D1
U 1 1 629B8927
P 9425 5375
F 0 "D1" V 9500 5325 50  0000 R CNN
F 1 "LED R" V 9425 5325 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 9425 5375 50  0001 C CNN
F 3 "~" H 9425 5375 50  0001 C CNN
F 4 "C165980" V 9050 5375 50  0000 C CNN "LCSC"
	1    9425 5375
	0    -1   -1   0   
$EndComp
$Comp
L stepper_probe:GND #PWR03
U 1 1 62A36546
P 1975 6225
F 0 "#PWR03" H 1975 5975 50  0001 C CNN
F 1 "GND" H 1979 6070 50  0001 C CNN
F 2 "" H 1975 6225 50  0001 C CNN
F 3 "" H 1975 6225 50  0001 C CNN
	1    1975 6225
	1    0    0    -1  
$EndComp
Wire Wire Line
	2125 5425 1975 5425
Wire Wire Line
	1975 5425 1975 5675
Wire Wire Line
	1975 6100 1975 6225
$Comp
L stepper_probe:+3V3 #PWR02
U 1 1 62A3FA8F
P 1500 5700
F 0 "#PWR02" H 1500 5550 50  0001 C CNN
F 1 "+3V3" H 1350 5800 50  0000 C CNN
F 2 "" H 1500 5700 50  0001 C CNN
F 3 "" H 1500 5700 50  0001 C CNN
	1    1500 5700
	1    0    0    -1  
$EndComp
$Comp
L Device:L L2
U 1 1 62A4503B
P 1600 5325
F 0 "L2" V 1525 5500 50  0000 C CNN
F 1 "10uh" V 1525 5325 50  0000 C CNN
F 2 "stepper_probe:coil_10uh" H 1600 5325 50  0001 C CNN
F 3 "~" H 1600 5325 50  0001 C CNN
F 4 "C107342" V 1750 5375 50  0000 C CNN "LCSC"
	1    1600 5325
	0    1    -1   0   
$EndComp
$Comp
L Device:L L3
U 1 1 62A4A382
P 1250 5325
F 0 "L3" V 1175 5150 50  0000 C CNN
F 1 "15nh" V 1175 5325 50  0000 C CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 1250 5325 50  0001 C CNN
F 3 "~" H 1250 5325 50  0001 C CNN
F 4 "C27143" V 1400 5325 50  0000 C CNN "LCSC"
	1    1250 5325
	0    1    -1   0   
$EndComp
Connection ~ 1975 5725
Wire Wire Line
	1975 5725 1975 5800
Wire Wire Line
	2125 5325 1750 5325
Wire Wire Line
	1450 5325 1400 5325
$Comp
L Device:C C1
U 1 1 62A71AC5
P 1000 5950
F 0 "C1" H 1200 5850 50  0000 L CNN
F 1 "1u" H 1025 5850 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 1038 5800 50  0001 C CNN
F 3 "~" H 1000 5950 50  0001 C CNN
F 4 "C52923" H 1175 5750 50  0000 C CNN "LCSC"
	1    1000 5950
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR01
U 1 1 62A72620
P 1000 6225
F 0 "#PWR01" H 1000 5975 50  0001 C CNN
F 1 "GND" H 1004 6070 50  0001 C CNN
F 2 "" H 1000 6225 50  0001 C CNN
F 3 "" H 1000 6225 50  0001 C CNN
	1    1000 6225
	1    0    0    -1  
$EndComp
Wire Wire Line
	1000 5225 2125 5225
Wire Wire Line
	1100 5325 1000 5325
Wire Wire Line
	1000 5225 1000 5325
Connection ~ 1000 5325
Wire Wire Line
	1000 5325 1000 5800
Wire Wire Line
	1000 6100 1000 6225
$Comp
L Device:C C5
U 1 1 62AF4EEE
P 2825 7000
F 0 "C5" H 2850 7100 50  0000 L CNN
F 1 "12pf" H 2900 6925 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 2863 6850 50  0001 C CNN
F 3 "~" H 2825 7000 50  0001 C CNN
F 4 "C26406" H 3050 6825 50  0000 C CNN "LCSC"
	1    2825 7000
	1    0    0    -1  
$EndComp
Wire Wire Line
	2425 6825 2325 6825
Wire Wire Line
	2325 6825 2325 6850
Wire Wire Line
	2725 6825 2825 6825
Wire Wire Line
	2825 6825 2825 6850
$Comp
L stepper_probe:GND #PWR09
U 1 1 62B0286A
P 2825 7175
F 0 "#PWR09" H 2825 6925 50  0001 C CNN
F 1 "GND" H 2829 7020 50  0001 C CNN
F 2 "" H 2825 7175 50  0001 C CNN
F 3 "" H 2825 7175 50  0001 C CNN
	1    2825 7175
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR05
U 1 1 62B02D10
P 2325 7175
F 0 "#PWR05" H 2325 6925 50  0001 C CNN
F 1 "GND" H 2329 7020 50  0001 C CNN
F 2 "" H 2325 7175 50  0001 C CNN
F 3 "" H 2325 7175 50  0001 C CNN
	1    2325 7175
	1    0    0    -1  
$EndComp
Wire Wire Line
	2325 7150 2325 7175
Wire Wire Line
	2825 7150 2825 7175
Wire Wire Line
	2625 6125 2625 6600
Wire Wire Line
	2625 6600 2825 6600
Wire Wire Line
	2825 6600 2825 6825
Connection ~ 2825 6825
Wire Wire Line
	2525 6125 2525 6600
Wire Wire Line
	2525 6600 2325 6600
Wire Wire Line
	2325 6600 2325 6825
Connection ~ 2325 6825
$Comp
L stepper_probe:GND #PWR019
U 1 1 62B7A28C
P 9425 5600
F 0 "#PWR019" H 9425 5350 50  0001 C CNN
F 1 "GND" H 9429 5445 50  0001 C CNN
F 2 "" H 9425 5600 50  0001 C CNN
F 3 "" H 9425 5600 50  0001 C CNN
	1    9425 5600
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR020
U 1 1 62B7A5EE
P 9850 5600
F 0 "#PWR020" H 9850 5350 50  0001 C CNN
F 1 "GND" H 9854 5445 50  0001 C CNN
F 2 "" H 9850 5600 50  0001 C CNN
F 3 "" H 9850 5600 50  0001 C CNN
	1    9850 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9425 5525 9425 5600
Wire Wire Line
	9850 5525 9850 5600
Wire Wire Line
	9425 4950 9425 4625
Wire Wire Line
	9850 4950 9850 4625
Text Label 9425 4825 1    50   ~ 0
LED1
Text Label 9850 4825 1    50   ~ 0
LED2
Wire Wire Line
	9425 5150 9425 5225
Wire Wire Line
	9850 5150 9850 5225
$Comp
L stepper_probe:GND #PWR015
U 1 1 62992C14
P 4325 4150
F 0 "#PWR015" H 4325 3900 50  0001 C CNN
F 1 "GND" H 4329 3995 50  0001 C CNN
F 2 "" H 4325 4150 50  0001 C CNN
F 3 "" H 4325 4150 50  0001 C CNN
	1    4325 4150
	1    0    0    -1  
$EndComp
Wire Wire Line
	3925 4325 4825 4325
Wire Wire Line
	3925 4425 4825 4425
Text Label 4825 4325 2    50   ~ 0
SWDDIO
Text Label 4825 4425 2    50   ~ 0
SWDCLK
$Comp
L stepper_probe:+3V3 #PWR022
U 1 1 62C04FD3
P 6550 3125
F 0 "#PWR022" H 6550 2975 50  0001 C CNN
F 1 "+3V3" H 6565 3298 50  0000 C CNN
F 2 "" H 6550 3125 50  0001 C CNN
F 3 "" H 6550 3125 50  0001 C CNN
	1    6550 3125
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR023
U 1 1 62C0D3FD
P 6550 3625
F 0 "#PWR023" H 6550 3375 50  0001 C CNN
F 1 "GND" H 6554 3470 50  0001 C CNN
F 2 "" H 6550 3625 50  0001 C CNN
F 3 "" H 6550 3625 50  0001 C CNN
	1    6550 3625
	1    0    0    -1  
$EndComp
Wire Wire Line
	6625 3275 6550 3275
Wire Wire Line
	6625 3375 6550 3375
Wire Wire Line
	6550 3275 6550 3375
Connection ~ 6550 3375
Wire Wire Line
	6550 3375 6550 3575
Wire Wire Line
	6625 3575 6550 3575
Connection ~ 6550 3575
Wire Wire Line
	6550 3575 6550 3625
NoConn ~ 6625 3475
NoConn ~ 7125 3375
NoConn ~ 7125 3475
Wire Wire Line
	7125 3175 7575 3175
Wire Wire Line
	7125 3275 7575 3275
Text Label 7575 3175 2    50   ~ 0
SWDDIO
Text Label 7575 3275 2    50   ~ 0
SWDCLK
Text Notes 7075 3925 2    50   ~ 0
SWD (DEV)
NoConn ~ 2125 4925
NoConn ~ 2125 5025
NoConn ~ 2125 5125
NoConn ~ 2925 6125
NoConn ~ 3025 6125
NoConn ~ 3225 6125
NoConn ~ 3925 4825
NoConn ~ 3925 5025
NoConn ~ 3925 5125
NoConn ~ 3925 5225
NoConn ~ 3925 4225
Wire Wire Line
	3925 5425 4525 5425
Wire Wire Line
	7425 1600 7425 1400
$Comp
L Device:C C6
U 1 1 62AF34AF
P 3950 1125
F 0 "C6" V 3900 1200 50  0000 L CNN
F 1 "100n" V 3700 1050 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 3988 975 50  0001 C CNN
F 3 "~" H 3950 1125 50  0001 C CNN
F 4 "C307331" V 3575 1200 50  0000 C CNN "LCSC"
	1    3950 1125
	0    1    1    0   
$EndComp
$Comp
L Device:C C4
U 1 1 62AF538B
P 2975 2200
F 0 "C4" V 2950 2275 50  0000 L CNN
F 1 "100n" V 2750 2150 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 3013 2050 50  0001 C CNN
F 3 "~" H 2975 2200 50  0001 C CNN
F 4 "C307331" V 2825 2325 50  0000 C CNN "LCSC"
	1    2975 2200
	0    1    1    0   
$EndComp
Wire Wire Line
	9325 1400 9325 1600
Wire Wire Line
	9325 2075 9325 1900
Connection ~ 9325 2075
Wire Wire Line
	9325 2075 9075 2075
Wire Wire Line
	9325 1400 9075 1400
$Comp
L stepper_probe:DC_DC U4
U 1 1 62B3ECA9
P 8325 1400
F 0 "U4" H 8225 1700 50  0000 C CNN
F 1 "K7803MT-500R4" H 8425 1600 50  0000 C CNN
F 2 "stepper_probe:Converter_DCDC" H 8375 1150 50  0001 L CIN
F 3 "https://www.recom-power.com/pdf/Innoline/R-78Exx-0.5.pdf" H 8325 1400 50  0001 C CNN
F 4 "C2692194" H 8500 1700 50  0000 C CNN "LCSC"
	1    8325 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	7675 2075 8275 2075
Wire Wire Line
	8375 1700 8375 2075
Connection ~ 8375 2075
Wire Wire Line
	8375 2075 8825 2075
Wire Wire Line
	8275 1700 8275 2075
Connection ~ 8275 2075
Wire Wire Line
	8275 2075 8375 2075
Wire Wire Line
	9500 3425 9475 3425
Wire Wire Line
	9500 3225 9375 3225
Wire Wire Line
	9500 3325 9375 3325
$Comp
L Device:R_Small_US R8
U 1 1 62BD5E6B
P 9275 3225
F 0 "R8" V 9175 3100 50  0000 C CNN
F 1 "1K" V 9175 3250 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9275 3225 50  0001 C CNN
F 3 "~" H 9275 3225 50  0001 C CNN
F 4 "C11702" V 9075 3150 50  0000 C CNN "LCSC"
	1    9275 3225
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R9
U 1 1 62BD65EC
P 9275 3325
F 0 "R9" V 9375 3200 50  0000 C CNN
F 1 "1K" V 9375 3350 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9275 3325 50  0001 C CNN
F 3 "~" H 9275 3325 50  0001 C CNN
F 4 "C11702" V 9450 3250 50  0000 C CNN "LCSC"
	1    9275 3325
	0    1    1    0   
$EndComp
Wire Wire Line
	9175 3225 8925 3225
Wire Wire Line
	9175 3325 8925 3325
$Comp
L Device:R_Small_US R6
U 1 1 62C197D2
P 9425 5050
F 0 "R6" H 9400 4950 50  0000 R CNN
F 1 "5K1" H 9400 5125 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9425 5050 50  0001 C CNN
F 3 "~" H 9425 5050 50  0001 C CNN
F 4 "C25905" V 9525 5075 50  0000 C CNN "LCSC"
	1    9425 5050
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small_US R7
U 1 1 62C19C2B
P 9850 5050
F 0 "R7" H 9825 4925 50  0000 R CNN
F 1 "5K1" H 9800 5150 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9850 5050 50  0001 C CNN
F 3 "~" H 9850 5050 50  0001 C CNN
F 4 "C25905" V 9950 5075 50  0000 C CNN "LCSC"
	1    9850 5050
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:MDBT42Q-512KV2 U3
U 1 1 62C25ED4
P 3025 4525
F 0 "U3" H 2350 5325 50  0000 C CNN
F 1 "MDBT42Q-512KV2" H 2650 5250 50  0000 C CNN
F 2 "stepper_probe:RAYTAC_MDBT42Q" H 3025 4525 50  0001 C CNN
F 3 "" H 3025 4525 50  0001 C CNN
	1    3025 4525
	1    0    0    -1  
$EndComp
Wire Wire Line
	6625 3175 6550 3175
Wire Wire Line
	6550 3175 6550 3125
Text Notes 8100 2350 0    50   ~ 0
Power Supply
NoConn ~ 4525 5425
NoConn ~ 4525 5525
Text Label 4200 5525 0    50   ~ 0
TEST1
Text Label 4200 5425 0    50   ~ 0
TEST2
NoConn ~ 3925 4925
Wire Wire Line
	2125 4525 1500 4525
Wire Wire Line
	2125 4625 1500 4625
NoConn ~ 3925 4625
NoConn ~ 3925 4725
Wire Wire Line
	3325 6125 3325 6450
$Comp
L stepper_probe:GND #PWR011
U 1 1 6294FC1A
P 4925 5775
F 0 "#PWR011" H 4925 5525 50  0001 C CNN
F 1 "GND" H 4929 5620 50  0001 C CNN
F 2 "" H 4925 5775 50  0001 C CNN
F 3 "" H 4925 5775 50  0001 C CNN
	1    4925 5775
	1    0    0    -1  
$EndComp
Text Label 4200 5325 0    50   ~ 0
DFU
Text Notes 5925 1425 0    50   ~ 0
+
$Comp
L Switch:SW_Push SW1
U 1 1 629716D2
P 4925 5550
F 0 "SW1" V 4925 5698 50  0000 L CNN
F 1 "SW_Push" V 4970 5698 50  0001 L CNN
F 2 "stepper_probe:SW_Push_SPST_NO_Alps_SKRK" H 4925 5750 50  0001 C CNN
F 3 "~" H 4925 5750 50  0001 C CNN
F 4 "C720477" V 5025 5875 50  0000 C CNN "LCSC"
	1    4925 5550
	0    1    1    0   
$EndComp
Wire Wire Line
	4925 5325 4925 5350
Wire Wire Line
	3925 5325 4925 5325
Wire Wire Line
	4925 5750 4925 5775
NoConn ~ 7125 3575
$Comp
L Graphic:Logo_Open_Hardware_Small #LOGO1
U 1 1 62CFF40A
P 10550 6875
F 0 "#LOGO1" H 10550 7150 50  0001 C CNN
F 1 "Logo_Open_Hardware_Small" H 10550 6650 50  0001 C CNN
F 2 "" H 10550 6875 50  0001 C CNN
F 3 "~" H 10550 6875 50  0001 C CNN
	1    10550 6875
	1    0    0    -1  
$EndComp
Text Notes 1750 4050 2    50   ~ 0
BLE SOC
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 6295F498
P 5175 4625
F 0 "J6" H 5275 4425 50  0000 R CNN
F 1 "Reset header" H 5025 4575 50  0001 R CNN
F 2 "stepper_probe:PinHeader_1x02_P2.54mm_Vertical" H 5175 4625 50  0001 C CNN
F 3 "~" H 5175 4625 50  0001 C CNN
F 4 "DNP" H 5175 4625 50  0001 C CNN "LCSC"
	1    5175 4625
	-1   0    0    1   
$EndComp
Wire Wire Line
	3925 4525 4975 4525
$Comp
L stepper_probe:GND #PWR0101
U 1 1 62973953
P 4925 4650
F 0 "#PWR0101" H 4925 4400 50  0001 C CNN
F 1 "GND" H 4929 4495 50  0001 C CNN
F 2 "" H 4925 4650 50  0001 C CNN
F 3 "" H 4925 4650 50  0001 C CNN
	1    4925 4650
	1    0    0    -1  
$EndComp
Wire Wire Line
	4975 4625 4925 4625
Wire Wire Line
	4925 4625 4925 4650
Text Label 4825 4525 2    50   ~ 0
RESET
Text Notes 5275 4550 2    50   ~ 0
R
Text Notes 5275 4650 2    50   ~ 0
G
$Comp
L Memory_EEPROM:M24C02-FMN U5
U 1 1 62D5C61F
P 6925 5250
F 0 "U5" H 6250 5625 50  0000 C CNN
F 1 "M24C02-FMN" H 6450 5550 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 6925 5600 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/b0/d8/50/40/5a/85/49/6f/DM00071904.pdf/files/DM00071904.pdf/jcr:content/translations/en.DM00071904.pdf" H 6975 4750 50  0001 C CNN
F 4 "C7562" H 6300 5725 50  0000 C CNN "LCSC"
	1    6925 5250
	1    0    0    -1  
$EndComp
Wire Wire Line
	9925 2075 9925 2100
Wire Wire Line
	2125 4825 1500 4825
Wire Wire Line
	2125 4725 1500 4725
$Comp
L stepper_probe:GND #PWR026
U 1 1 62E0FD09
P 6925 5600
F 0 "#PWR026" H 6925 5350 50  0001 C CNN
F 1 "GND" H 6929 5445 50  0001 C CNN
F 2 "" H 6925 5600 50  0001 C CNN
F 3 "" H 6925 5600 50  0001 C CNN
	1    6925 5600
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR028
U 1 1 62E10158
P 7375 5600
F 0 "#PWR028" H 7375 5350 50  0001 C CNN
F 1 "GND" H 7379 5445 50  0001 C CNN
F 2 "" H 7375 5600 50  0001 C CNN
F 3 "" H 7375 5600 50  0001 C CNN
	1    7375 5600
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR016
U 1 1 62E10507
P 6475 5600
F 0 "#PWR016" H 6475 5350 50  0001 C CNN
F 1 "GND" H 6479 5445 50  0001 C CNN
F 2 "" H 6475 5600 50  0001 C CNN
F 3 "" H 6475 5600 50  0001 C CNN
	1    6475 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	9000 4800 9000 4950
$Comp
L stepper_probe:+3V3 #PWR021
U 1 1 62E10B3B
P 6925 4750
F 0 "#PWR021" H 6925 4600 50  0001 C CNN
F 1 "+3V3" H 6900 4925 50  0000 C CNN
F 2 "" H 6925 4750 50  0001 C CNN
F 3 "" H 6925 4750 50  0001 C CNN
	1    6925 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 62E1111B
P 7125 4850
F 0 "C12" V 7050 4925 50  0000 L CNN
F 1 "100n" V 6950 4900 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 7163 4700 50  0001 C CNN
F 3 "~" H 7125 4850 50  0001 C CNN
F 4 "C307331" V 6875 4975 50  0000 C CNN "LCSC"
	1    7125 4850
	0    1    1    0   
$EndComp
$Comp
L stepper_probe:GND #PWR027
U 1 1 62E12E1A
P 7325 4875
F 0 "#PWR027" H 7325 4625 50  0001 C CNN
F 1 "GND" H 7329 4720 50  0001 C CNN
F 2 "" H 7325 4875 50  0001 C CNN
F 3 "" H 7325 4875 50  0001 C CNN
	1    7325 4875
	1    0    0    -1  
$EndComp
Wire Wire Line
	7275 4850 7325 4850
Wire Wire Line
	7325 4850 7325 4875
Wire Wire Line
	6925 4750 6925 4850
Wire Wire Line
	6975 4850 6925 4850
Connection ~ 6925 4850
Wire Wire Line
	6925 4850 6925 4950
Wire Wire Line
	7325 5350 7375 5350
Wire Wire Line
	7375 5350 7375 5600
Wire Wire Line
	6925 5550 6925 5600
Wire Wire Line
	6525 5150 6475 5150
Wire Wire Line
	6475 5150 6475 5250
Wire Wire Line
	6525 5250 6475 5250
Connection ~ 6475 5250
Wire Wire Line
	6475 5250 6475 5350
Wire Wire Line
	6525 5350 6475 5350
Connection ~ 6475 5350
Wire Wire Line
	6475 5350 6475 5600
Wire Wire Line
	7325 5150 7600 5150
Wire Wire Line
	7325 5250 7900 5250
$Comp
L Device:R_Small_US R10
U 1 1 62E796A4
P 7600 4925
F 0 "R10" H 7525 4925 50  0000 R CNN
F 1 "10K" H 7525 4850 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 7600 4925 50  0001 C CNN
F 3 "~" H 7600 4925 50  0001 C CNN
F 4 "C25744" H 7375 4775 50  0000 C CNN "LCSC"
	1    7600 4925
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:+3V3 #PWR0102
U 1 1 62D5A4DA
P 7600 4750
F 0 "#PWR0102" H 7600 4600 50  0001 C CNN
F 1 "+3V3" H 7575 4925 50  0000 C CNN
F 2 "" H 7600 4750 50  0001 C CNN
F 3 "" H 7600 4750 50  0001 C CNN
	1    7600 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	7600 5025 7600 5150
Connection ~ 7600 5150
Wire Wire Line
	7600 5150 7900 5150
Wire Wire Line
	7600 4750 7600 4825
Text Label 7900 5150 2    50   ~ 0
SDA
Text Label 7900 5250 2    50   ~ 0
SCL
Text Label 1500 4625 0    50   ~ 0
SDA
Text Label 1500 4725 0    50   ~ 0
SCL
$Comp
L stepper_probe:+3V3 #PWR0103
U 1 1 62DB77A4
P 2750 2150
F 0 "#PWR0103" H 2750 2000 50  0001 C CNN
F 1 "+3V3" H 2700 2300 50  0000 C CNN
F 2 "" H 2750 2150 50  0001 C CNN
F 3 "" H 2750 2150 50  0001 C CNN
	1    2750 2150
	1    0    0    -1  
$EndComp
Wire Wire Line
	2750 2150 2750 2200
Connection ~ 2750 2200
$Comp
L stepper_probe:+3V3 #PWR0104
U 1 1 62DC2B17
P 3725 1075
F 0 "#PWR0104" H 3725 925 50  0001 C CNN
F 1 "+3V3" H 3675 1225 50  0000 C CNN
F 2 "" H 3725 1075 50  0001 C CNN
F 3 "" H 3725 1075 50  0001 C CNN
	1    3725 1075
	1    0    0    -1  
$EndComp
Wire Wire Line
	3725 1075 3725 1125
Connection ~ 3725 1125
Text Notes 6550 5875 0    50   ~ 0
Settings EEPROM
$Comp
L stepper_probe:GND #PWR0106
U 1 1 62EA6362
P 9475 3625
F 0 "#PWR0106" H 9475 3375 50  0001 C CNN
F 1 "GND" H 9479 3470 50  0001 C CNN
F 2 "" H 9475 3625 50  0001 C CNN
F 3 "" H 9475 3625 50  0001 C CNN
	1    9475 3625
	1    0    0    -1  
$EndComp
Wire Wire Line
	9475 3425 9475 3625
Wire Wire Line
	7425 2075 7675 2075
$Comp
L Device:C C11
U 1 1 62B00F1B
P 9325 1750
F 0 "C11" H 9350 1850 50  0000 L CNN
F 1 "10u" H 9350 1650 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 9363 1600 50  0001 C CNN
F 3 "~" H 9325 1750 50  0001 C CNN
F 4 "C96446" H 9325 1350 50  0000 C CNN "LCSC"
	1    9325 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 62799F4E
P 9075 1750
F 0 "C10" H 9075 1850 50  0000 L CNN
F 1 "10u" H 9100 1650 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 9113 1600 50  0001 C CNN
F 3 "~" H 9075 1750 50  0001 C CNN
F 4 "C96446" H 9075 2175 50  0000 C CNN "LCSC"
	1    9075 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 62AF1C75
P 8825 1750
F 0 "C9" H 8825 1850 50  0000 L CNN
F 1 "100n" H 8825 1650 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 8863 1600 50  0001 C CNN
F 3 "~" H 8825 1750 50  0001 C CNN
F 4 "C307331" H 8825 1350 50  0000 C CNN "LCSC"
	1    8825 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 62AE4F00
P 7675 1750
F 0 "C8" H 7725 1850 50  0000 L CNN
F 1 "100n 50V" H 7725 1650 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 7713 1600 50  0001 C CNN
F 3 "~" H 7675 1750 50  0001 C CNN
F 4 "C307331" H 7825 1350 50  0000 C CNN "LCSC"
	1    7675 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 62788E2E
P 7425 1750
F 0 "C7" H 7300 1850 50  0000 L CNN
F 1 "10u 50v" H 7275 1650 50  0000 L CNN
F 2 "stepper_probe:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 7463 1600 50  0001 C CNN
F 3 "~" H 7425 1750 50  0001 C CNN
F 4 "C440198" H 7375 1350 50  0000 C CNN "LCSC"
	1    7425 1750
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 62E89E59
P 3300 2950
F 0 "C13" H 2975 3125 50  0000 L CNN
F 1 "DNP" H 3125 2925 50  0000 R CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 3338 2800 50  0001 C CNN
F 3 "~" H 3300 2950 50  0001 C CNN
F 4 "DNP" H 3125 3025 50  0000 R CNN "LCSC"
	1    3300 2950
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR0108
U 1 1 62E8AEC1
P 3300 3150
F 0 "#PWR0108" H 3300 2900 50  0001 C CNN
F 1 "GND" H 3304 2995 50  0001 C CNN
F 2 "" H 3300 3150 50  0001 C CNN
F 3 "" H 3300 3150 50  0001 C CNN
	1    3300 3150
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe-rescue:ACS70331_soic8-simple_stepper_motor_analyzer U2
U 1 1 627AA0D1
P 2800 2675
F 0 "U2" H 2050 2350 50  0000 C CNN
F 1 "CC6920BSO-5A" H 2300 2250 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 3200 2625 50  0001 L CIN
F 3 "" H 2800 2675 50  0001 C CNN
F 4 "C2880430" H 2200 2150 50  0000 C CNN "LCSC"
	1    2800 2675
	1    0    0    -1  
$EndComp
Wire Wire Line
	3200 2775 3300 2775
Wire Wire Line
	3300 2775 3300 2800
Wire Wire Line
	3300 3100 3300 3150
$Comp
L Device:C C14
U 1 1 62ECE48F
P 4275 1875
F 0 "C14" H 3950 2050 50  0000 L CNN
F 1 "DNP" H 4100 1850 50  0000 R CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 4313 1725 50  0001 C CNN
F 3 "~" H 4275 1875 50  0001 C CNN
F 4 "DNP" H 4100 1950 50  0000 R CNN "LCSC"
	1    4275 1875
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR0109
U 1 1 62ECEDC1
P 4275 2075
F 0 "#PWR0109" H 4275 1825 50  0001 C CNN
F 1 "GND" H 4279 1920 50  0001 C CNN
F 2 "" H 4275 2075 50  0001 C CNN
F 3 "" H 4275 2075 50  0001 C CNN
	1    4275 2075
	1    0    0    -1  
$EndComp
Wire Wire Line
	4175 1700 4275 1700
Wire Wire Line
	4275 1700 4275 1725
Wire Wire Line
	4275 2025 4275 2075
$Comp
L stepper_probe:GND #PWR0111
U 1 1 62EFA692
P 4925 7000
F 0 "#PWR0111" H 4925 6750 50  0001 C CNN
F 1 "GND" H 4929 6845 50  0001 C CNN
F 2 "" H 4925 7000 50  0001 C CNN
F 3 "" H 4925 7000 50  0001 C CNN
	1    4925 7000
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR0112
U 1 1 62EFAB50
P 4925 6650
F 0 "#PWR0112" H 4925 6400 50  0001 C CNN
F 1 "GND" H 4929 6495 50  0001 C CNN
F 2 "" H 4925 6650 50  0001 C CNN
F 3 "" H 4925 6650 50  0001 C CNN
	1    4925 6650
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R11
U 1 1 62EFB038
P 4775 6600
F 0 "R11" V 4875 6700 50  0000 R CNN
F 1 "DNP" V 4875 6500 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4775 6600 50  0001 C CNN
F 3 "~" H 4775 6600 50  0001 C CNN
F 4 "DNP" H 4775 6600 50  0001 C CNN "LCSC"
	1    4775 6600
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R12
U 1 1 62EFBB37
P 4775 6950
F 0 "R12" V 4850 7050 50  0000 R CNN
F 1 "DNP" V 4850 6850 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4775 6950 50  0001 C CNN
F 3 "~" H 4775 6950 50  0001 C CNN
F 4 "DNP" H 4775 6950 50  0001 C CNN "LCSC"
	1    4775 6950
	0    -1   -1   0   
$EndComp
Wire Wire Line
	4875 6600 4925 6600
Wire Wire Line
	4925 6600 4925 6650
Wire Wire Line
	4875 6950 4925 6950
Wire Wire Line
	4925 6950 4925 7000
Text Label 4225 6600 0    50   ~ 0
CFG1
Wire Wire Line
	4225 6600 4675 6600
Wire Wire Line
	4225 6950 4675 6950
Text Label 4225 6950 0    50   ~ 0
CFG2
Wire Wire Line
	3425 6125 3425 6450
Wire Wire Line
	3525 6125 3525 6450
Text Label 3425 6450 1    50   ~ 0
CFG1
Text Label 3525 6450 1    50   ~ 0
CFG2
Text Notes 3975 2925 0    50   ~ 0
Current sensors
Connection ~ 7675 1400
$Comp
L Device:R_Small_US R14
U 1 1 62FBED44
P 9575 1400
F 0 "R14" V 9350 1350 50  0000 C CNN
F 1 "0R" V 9350 1575 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9575 1400 50  0001 C CNN
F 3 "~" H 9575 1400 50  0001 C CNN
F 4 "C17168" V 9475 1450 50  0000 C CNN "LCSC"
	1    9575 1400
	0    1    1    0   
$EndComp
Connection ~ 8825 1400
Wire Wire Line
	8625 1400 8825 1400
Wire Wire Line
	9850 1400 9775 1400
Wire Wire Line
	9475 1400 9325 1400
Connection ~ 9325 1400
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 62C72EBD
P 9775 1450
F 0 "#FLG0101" H 9775 1525 50  0001 C CNN
F 1 "PWR_FLAG" H 9725 1600 50  0000 C CNN
F 2 "" H 9775 1450 50  0001 C CNN
F 3 "~" H 9775 1450 50  0001 C CNN
	1    9775 1450
	-1   0    0    1   
$EndComp
Wire Wire Line
	9775 1450 9775 1400
Connection ~ 9775 1400
Wire Wire Line
	9775 1400 9675 1400
$Comp
L Device:R_Small_US R15
U 1 1 630B99F4
P 1675 5725
F 0 "R15" V 1850 5625 50  0000 C CNN
F 1 "0R" V 1750 5625 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 1675 5725 50  0001 C CNN
F 3 "~" H 1675 5725 50  0001 C CNN
F 4 "C17168" V 1575 5725 50  0000 C CNN "LCSC"
	1    1675 5725
	0    1    1    0   
$EndComp
Wire Wire Line
	1775 5725 1975 5725
Wire Wire Line
	1500 5700 1500 5725
Wire Wire Line
	1500 5725 1575 5725
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 630D43FC
P 2100 5650
F 0 "#FLG0104" H 2100 5725 50  0001 C CNN
F 1 "PWR_FLAG" H 1975 5800 50  0000 C CNN
F 2 "" H 2100 5650 50  0001 C CNN
F 3 "~" H 2100 5650 50  0001 C CNN
	1    2100 5650
	1    0    0    -1  
$EndComp
Wire Wire Line
	2100 5650 2100 5675
Wire Wire Line
	2100 5675 1975 5675
Connection ~ 1975 5675
Wire Wire Line
	1975 5675 1975 5725
$Comp
L Device:R_Small_US R16
U 1 1 630E9BC4
P 4550 1500
F 0 "R16" V 4450 1375 50  0000 C CNN
F 1 "1K" V 4450 1525 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4550 1500 50  0001 C CNN
F 3 "~" H 4550 1500 50  0001 C CNN
F 4 "C11702" V 4350 1425 50  0000 C CNN "LCSC"
	1    4550 1500
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R17
U 1 1 630EA395
P 4550 2575
F 0 "R17" V 4450 2450 50  0000 C CNN
F 1 "1K" V 4450 2600 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4550 2575 50  0001 C CNN
F 3 "~" H 4550 2575 50  0001 C CNN
F 4 "C11702" V 4350 2500 50  0000 C CNN "LCSC"
	1    4550 2575
	0    1    1    0   
$EndComp
Wire Wire Line
	4650 1500 4900 1500
Wire Wire Line
	4650 2575 4900 2575
Wire Wire Line
	4175 1500 4450 1500
Wire Wire Line
	3200 2575 4450 2575
Wire Wire Line
	7675 1400 7800 1400
Wire Wire Line
	7800 1350 7800 1400
Connection ~ 7800 1400
Wire Wire Line
	7800 1400 8025 1400
Connection ~ 7425 1400
Text Notes 5925 1525 0    50   ~ 0
-
Wire Wire Line
	6225 1500 6250 1500
Connection ~ 7425 2075
Wire Wire Line
	7425 1400 7675 1400
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 630790D2
P 7800 1350
F 0 "#FLG0103" H 7800 1425 50  0001 C CNN
F 1 "PWR_FLAG" H 7825 1500 50  0000 C CNN
F 2 "" H 7800 1350 50  0001 C CNN
F 3 "~" H 7800 1350 50  0001 C CNN
	1    7800 1350
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 630668EE
P 9775 2050
F 0 "#FLG0102" H 9775 2125 50  0001 C CNN
F 1 "PWR_FLAG" H 9825 2200 50  0000 C CNN
F 2 "" H 9775 2050 50  0001 C CNN
F 3 "~" H 9775 2050 50  0001 C CNN
	1    9775 2050
	1    0    0    -1  
$EndComp
Wire Wire Line
	6250 2075 6525 2075
$Comp
L stepper_probe:P_MOSFET Q1
U 1 1 62F752CB
P 6850 1500
F 0 "Q1" V 7265 1500 50  0000 C CNN
F 1 "PJA3439" V 7174 1500 50  0000 C CNN
F 2 "stepper_probe:SOT-23_JLCPCB" H 7050 1425 50  0001 L CIN
F 3 "http://www.aosmd.com/pdfs/datasheet/AO3401A.pdf" H 6850 1500 50  0001 L CNN
F 4 "C2844879" V 7083 1500 50  0000 C CNN "LCSC"
	1    6850 1500
	0    -1   -1   0   
$EndComp
Wire Wire Line
	7000 1400 7100 1400
Wire Wire Line
	6225 1400 6525 1400
Connection ~ 6525 1400
Wire Wire Line
	6525 1400 6700 1400
Connection ~ 6525 2075
$Comp
L Device:R_Small_US R1
U 1 1 62FB34BF
P 6525 1750
F 0 "R1" H 6650 1650 50  0000 C CNN
F 1 "300k" H 6650 1725 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 6525 1750 50  0001 C CNN
F 3 "~" H 6525 1750 50  0001 C CNN
F 4 "C25774" H 6550 2150 50  0000 C CNN "LCSC"
	1    6525 1750
	-1   0    0    1   
$EndComp
Wire Wire Line
	6525 1400 6525 1650
Wire Wire Line
	6525 1850 6525 2075
Wire Wire Line
	6525 2075 6850 2075
$Comp
L Device:R_Small_US R2
U 1 1 6300821D
P 6850 1900
F 0 "R2" H 6775 1875 50  0000 R CNN
F 1 "20k" H 6775 1975 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 6850 1900 50  0001 C CNN
F 3 "~" H 6850 1900 50  0001 C CNN
F 4 "C25765" H 6825 2150 50  0000 C CNN "LCSC"
	1    6850 1900
	-1   0    0    1   
$EndComp
Wire Wire Line
	6850 2000 6850 2075
Connection ~ 6850 2075
Wire Wire Line
	6850 2075 7425 2075
Wire Wire Line
	6850 1800 6850 1675
$Comp
L stepper_probe:zenner D4
U 1 1 6303728C
P 7100 1550
F 0 "D4" V 7175 1400 50  0000 L CNN
F 1 "5V6" V 7200 1550 50  0000 L CNN
F 2 "stepper_probe:D_MiniMELF_zenner" H 7100 1375 50  0001 C CNN
F 3 "http://www.vishay.com/docs/85790/zpy3v9.pdf" H 7100 1550 50  0001 C CNN
F 4 "C8062" V 7275 1550 50  0000 C CNN "LCSC"
	1    7100 1550
	0    1    1    0   
$EndComp
Wire Wire Line
	7100 1450 7100 1400
Connection ~ 7100 1400
Wire Wire Line
	7100 1400 7425 1400
Wire Wire Line
	7100 1650 7100 1675
Wire Wire Line
	7100 1675 6850 1675
Connection ~ 6850 1675
Wire Wire Line
	6850 1675 6850 1600
Text Notes 5525 6850 0    50   ~ 0
1K
Text Notes 5275 6725 0    50   ~ 0
DNP
Text Notes 5525 6725 0    50   ~ 0
DNP
Text Notes 5275 6850 0    50   ~ 0
DNP
Text Notes 5275 6975 0    50   ~ 0
1K
Text Notes 5525 6975 0    50   ~ 0
DNP
Text Notes 5525 7100 0    50   ~ 0
1K
Text Notes 5275 7100 0    50   ~ 0
1K
Text Notes 5775 6850 0    50   ~ 0
400
Text Notes 5750 6600 0    50   ~ 0
mv/A
Text Notes 5775 6725 0    50   ~ 0
270
Text Notes 5525 6600 0    50   ~ 0
R11
Text Notes 5275 6600 0    50   ~ 0
R12
Wire Notes Line width 4 style solid
	6000 6500 6000 7125
Wire Notes Line width 4 style solid
	6000 7125 5225 7125
Wire Notes Line width 4 style solid
	5225 7125 5225 6500
Wire Notes Line width 4 style solid
	5225 6500 6000 6500
Wire Notes Line width 4 style solid
	5225 6625 6000 6625
Wire Notes Line width 4 style solid
	5225 6750 6000 6750
Wire Notes Line width 4 style solid
	5225 6875 6000 6875
Wire Notes Line width 4 style solid
	5225 7000 6000 7000
Wire Notes Line width 4 style solid
	5475 6500 5475 7125
Wire Notes Line width 4 style solid
	5725 6500 5725 7125
Text Notes 4550 7350 0    50   ~ 0
Current sensor Configuration
Text Notes 2900 950  0    50   ~ 0
270mv/A
Text Notes 2000 3350 0    50   ~ 0
270mv/A
Text Notes 3275 3750 0    50   ~ 0
For an external antenna, replace\nwith MDBT42Q-U512KV2
$Comp
L Connector:Conn_01x03_Male J4
U 1 1 630B52C0
P 9700 3325
F 0 "J4" H 9875 3025 50  0000 R CNN
F 1 "Conn_01x03_Male" H 9875 3075 50  0001 R CNN
F 2 "stepper_probe:PinHeader_1x03_P2.54mm_Vertical" H 9700 3325 50  0001 C CNN
F 3 "~" H 9700 3325 50  0001 C CNN
F 4 "C49257" H 9700 3325 50  0001 C CNN "LCSC"
	1    9700 3325
	-1   0    0    1   
$EndComp
Wire Wire Line
	6250 1500 6250 2075
Wire Wire Line
	9775 2050 9775 2075
Wire Wire Line
	9325 2075 9775 2075
Connection ~ 9775 2075
Wire Wire Line
	9775 2075 9925 2075
$EndSCHEMATC
