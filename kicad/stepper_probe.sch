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
	6950 2125 6950 2200
Wire Wire Line
	8350 1825 8350 1625
Wire Wire Line
	8350 1625 8600 1625
Wire Wire Line
	8350 2125 8350 2200
Wire Wire Line
	7200 2125 7200 2200
Connection ~ 7200 2200
Wire Wire Line
	7200 1825 7200 1625
$Comp
L stepper_probe:+3V3 #PWR024
U 1 1 62794A9A
P 9375 1625
F 0 "#PWR024" H 9375 1475 50  0001 C CNN
F 1 "+3V3" V 9390 1753 50  0000 L CNN
F 2 "" H 9375 1625 50  0001 C CNN
F 3 "" H 9375 1625 50  0001 C CNN
	1    9375 1625
	0    1    1    0   
$EndComp
$Comp
L stepper_probe:GND #PWR025
U 1 1 62794283
P 9450 2225
F 0 "#PWR025" H 9450 1975 50  0001 C CNN
F 1 "GND" H 9454 2070 50  0001 C CNN
F 2 "" H 9450 2225 50  0001 C CNN
F 3 "" H 9450 2225 50  0001 C CNN
	1    9450 2225
	1    0    0    -1  
$EndComp
Wire Wire Line
	8350 2200 8600 2200
Connection ~ 8350 2200
Wire Wire Line
	8600 1825 8600 1625
Wire Wire Line
	8600 2125 8600 2200
$Comp
L Connector:Conn_01x04_Male J1
U 1 1 6279B2E2
P 950 1650
F 0 "J1" H 1100 1850 50  0000 R CNN
F 1 "Conn_01x04_Male" H 922 1623 50  0001 R CNN
F 2 "stepper_probe:connector_4pins_horizontal" H 950 1650 50  0001 C CNN
F 3 "~" H 950 1650 50  0001 C CNN
F 4 "C31753" H 950 1650 50  0001 C CNN "LCSC"
	1    950  1650
	1    0    0    1   
$EndComp
$Comp
L Connector:Conn_01x04_Male J2
U 1 1 627A7186
P 1275 2925
F 0 "J2" H 1375 3100 50  0000 R CNN
F 1 "Conn_01x04_Male" H 1850 3100 50  0001 R CNN
F 2 "stepper_probe:connector_4pins_horizontal" H 1275 2925 50  0001 C CNN
F 3 "~" H 1275 2925 50  0001 C CNN
F 4 "C31753" H 1275 2925 50  0001 C CNN "LCSC"
	1    1275 2925
	1    0    0    1   
$EndComp
$Comp
L stepper_probe-rescue:ACS70331_soic8-simple_stepper_motor_analyzer U1
U 1 1 627A85BB
P 3725 1700
F 0 "U1" H 2850 1975 50  0000 C CNN
F 1 "CC6920BSO-5A" H 3150 2125 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 4125 1650 50  0001 L CIN
F 3 "" H 3725 1700 50  0001 C CNN
F 4 "C2880430" H 3725 1700 50  0000 C CNN "LCSC"
	1    3725 1700
	1    0    0    -1  
$EndComp
Wire Wire Line
	3125 1500 3075 1500
Wire Wire Line
	3075 1500 3075 1550
Wire Wire Line
	3075 1600 3125 1600
Wire Wire Line
	3125 1800 3075 1800
Wire Wire Line
	3075 1800 3075 1850
Wire Wire Line
	3075 1900 3125 1900
Wire Wire Line
	3075 1550 1150 1550
Connection ~ 3075 1550
Wire Wire Line
	3075 1550 3075 1600
Wire Wire Line
	2150 2575 2100 2575
Wire Wire Line
	2100 2575 2100 2625
Wire Wire Line
	2100 2675 2150 2675
Wire Wire Line
	2150 2875 2100 2875
Wire Wire Line
	2100 2875 2100 2925
Wire Wire Line
	2100 2975 2150 2975
Connection ~ 2100 2925
Wire Wire Line
	2100 2925 2100 2975
Wire Wire Line
	1150 1650 1975 1650
Wire Wire Line
	1975 1650 1975 2625
Wire Wire Line
	1975 2625 2100 2625
Connection ~ 2100 2625
Wire Wire Line
	2100 2625 2100 2675
Wire Wire Line
	1475 2925 2100 2925
Wire Wire Line
	1475 2825 1875 2825
Wire Wire Line
	1875 2825 1875 1850
Wire Wire Line
	1875 1850 3075 1850
Connection ~ 3075 1850
Wire Wire Line
	3075 1850 3075 1900
Wire Wire Line
	1150 1450 1775 1450
Wire Wire Line
	1775 1450 1775 2725
Wire Wire Line
	1775 2725 1475 2725
Wire Wire Line
	1150 1750 1675 1750
Wire Wire Line
	1675 1750 1675 3025
Wire Wire Line
	1675 3025 1475 3025
$Comp
L stepper_probe:GND #PWR012
U 1 1 627B9B1A
P 3675 2175
F 0 "#PWR012" H 3675 1925 50  0001 C CNN
F 1 "GND" H 3679 2020 50  0001 C CNN
F 2 "" H 3675 2175 50  0001 C CNN
F 3 "" H 3675 2175 50  0001 C CNN
	1    3675 2175
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR08
U 1 1 627B9F00
P 2700 3250
F 0 "#PWR08" H 2700 3000 50  0001 C CNN
F 1 "GND" H 2704 3095 50  0001 C CNN
F 2 "" H 2700 3250 50  0001 C CNN
F 3 "" H 2700 3250 50  0001 C CNN
	1    2700 3250
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR010
U 1 1 627BB296
P 3150 2325
F 0 "#PWR010" H 3150 2075 50  0001 C CNN
F 1 "GND" H 3154 2170 50  0001 C CNN
F 2 "" H 3150 2325 50  0001 C CNN
F 3 "" H 3150 2325 50  0001 C CNN
	1    3150 2325
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR014
U 1 1 627BE8C2
P 4125 1250
F 0 "#PWR014" H 4125 1000 50  0001 C CNN
F 1 "GND" H 4129 1095 50  0001 C CNN
F 2 "" H 4125 1250 50  0001 C CNN
F 3 "" H 4125 1250 50  0001 C CNN
	1    4125 1250
	1    0    0    -1  
$EndComp
Text Label 4850 1600 2    50   ~ 0
CHA
Text Label 4850 2675 2    50   ~ 0
CHB
Wire Wire Line
	2775 2300 2700 2300
Wire Wire Line
	2700 2300 2700 2375
Wire Wire Line
	3075 2300 3150 2300
Wire Wire Line
	3150 2300 3150 2325
Wire Wire Line
	3675 2100 3675 2175
Wire Wire Line
	2700 3175 2700 3250
Wire Wire Line
	3750 1225 3675 1225
Wire Wire Line
	3675 1225 3675 1300
Text Label 1575 1450 2    50   ~ 0
STEPPER4
Text Label 1575 1550 2    50   ~ 0
STEPPER3
Text Label 1575 1650 2    50   ~ 0
STEPPER2
Text Label 1575 1750 2    50   ~ 0
STEPPER1
$Comp
L stepper_probe-rescue:Motor-simple_stepper_motor_analyzer M1
U 1 1 6284B7A9
P 1000 3025
F 0 "M1" H 1050 3425 50  0001 L CNN
F 1 "Motor" H 900 3375 50  0001 L TNN
F 2 "stepper_probe:Empty" H 1010 3115 50  0001 C CNN
F 3 "" H 1010 3115 50  0001 C CNN
F 4 "DNP" H 1000 3025 50  0001 C CNN "LCSC"
	1    1000 3025
	0    -1   -1   0   
$EndComp
Text Notes 925  1525 2    50   ~ 0
A
Text Notes 925  1725 2    50   ~ 0
B
Wire Wire Line
	4050 1225 4125 1225
Wire Wire Line
	4125 1225 4125 1250
$Comp
L Device:LED D3
U 1 1 62873129
P 9200 5700
F 0 "D3" V 9275 5650 50  0000 R CNN
F 1 "LED R" V 9200 5650 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 9200 5700 50  0001 C CNN
F 3 "~" H 9200 5700 50  0001 C CNN
F 4 "C165980" V 8825 5700 50  0000 C CNN "LCSC"
	1    9200 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R5
U 1 1 6287420D
P 9200 5375
F 0 "R5" H 9175 5275 50  0000 R CNN
F 1 "5K1" H 9200 5475 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9200 5375 50  0001 C CNN
F 3 "~" H 9200 5375 50  0001 C CNN
F 4 "C25905" V 9300 5425 50  0000 C CNN "LCSC"
	1    9200 5375
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR018
U 1 1 6287501E
P 9200 5925
F 0 "#PWR018" H 9200 5675 50  0001 C CNN
F 1 "GND" H 9204 5770 50  0001 C CNN
F 2 "" H 9200 5925 50  0001 C CNN
F 3 "" H 9200 5925 50  0001 C CNN
	1    9200 5925
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:+3V3 #PWR017
U 1 1 628755EF
P 9200 5125
F 0 "#PWR017" H 9200 4975 50  0001 C CNN
F 1 "+3V3" H 9215 5298 50  0000 C CNN
F 2 "" H 9200 5125 50  0001 C CNN
F 3 "" H 9200 5125 50  0001 C CNN
	1    9200 5125
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 5475 9200 5550
Wire Wire Line
	9200 5850 9200 5925
$Comp
L Device:Crystal Y1
U 1 1 6288EBBE
P 2650 6925
F 0 "Y1" H 2650 7075 50  0000 C CNN
F 1 "32.768Khz" H 3125 7050 50  0000 C CNN
F 2 "stepper_probe:Crystal_SMD_3215-2Pin_3.2x1.5mm" H 2650 6925 50  0001 C CNN
F 3 "~" H 2650 6925 50  0001 C CNN
F 4 "C479190" H 3100 7150 50  0000 C CNN "LCSC"
	1    2650 6925
	1    0    0    -1  
$EndComp
Text Notes 9225 6900 2    79   ~ 0
BLE STEPPER MOTOR MONITOR  v1.3.1
$Comp
L Connector_Generic:Conn_02x05_Odd_Even J5
U 1 1 62893276
P 6875 3600
F 0 "J5" H 6925 4017 50  0000 C CNN
F 1 "SWD" H 6925 3926 50  0001 C CNN
F 2 "stepper_probe:PinHeader_2x05_P1.27mm_Vertical_SMD" H 6875 3600 50  0001 C CNN
F 3 "~" H 6875 3600 50  0001 C CNN
F 4 "C2935458" H 7025 3925 50  0000 C CNN "LCSC"
	1    6875 3600
	1    0    0    -1  
$EndComp
$Comp
L Connector:Conn_01x02_Male J3
U 1 1 628AD243
P 5550 1725
F 0 "J3" H 5650 1500 50  0000 R CNN
F 1 "BAT" H 5400 1675 50  0001 R CNN
F 2 "stepper_probe:PinHeader_1x02_P2.54mm_Horizontal_JLCPCB" H 5550 1725 50  0001 C CNN
F 3 "~" H 5550 1725 50  0001 C CNN
F 4 "C2935927" H 5550 1725 50  0001 C CNN "LCSC"
	1    5550 1725
	1    0    0    1   
$EndComp
Connection ~ 8600 1625
Connection ~ 8600 2200
Text Notes 5075 1725 0    50   ~ 0
VIN\n5-30VDC
Text Notes 10125 4250 2    50   ~ 0
SERIAL (DEV)
Text Label 9300 3600 0    50   ~ 0
TX
Text Label 9300 3700 0    50   ~ 0
RX
Text Notes 10125 3725 0    50   ~ 0
RX
Text Notes 10125 3625 0    50   ~ 0
TX\n
Text Notes 10125 3825 0    50   ~ 0
GND\n
Text Notes 10125 3525 0    50   ~ 0
3.3V\n
Wire Wire Line
	4000 5625 4600 5625
Text Label 1575 4925 0    50   ~ 0
LED2
Text Label 1575 4625 0    50   ~ 0
LED1
Wire Wire Line
	2800 6225 2800 6550
Wire Wire Line
	2900 6225 2900 6550
Text Label 2900 6550 1    50   ~ 0
CHB
Text Label 2800 6550 1    50   ~ 0
CHA
Wire Wire Line
	3200 6225 3200 6550
Text Label 3200 6550 1    50   ~ 0
TX
Text Label 3400 6550 1    50   ~ 0
RX
$Comp
L stepper_probe:GND #PWR06
U 1 1 6298A12E
P 2500 6325
F 0 "#PWR06" H 2500 6075 50  0001 C CNN
F 1 "GND" H 2504 6170 50  0001 C CNN
F 2 "" H 2500 6325 50  0001 C CNN
F 3 "" H 2500 6325 50  0001 C CNN
	1    2500 6325
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR013
U 1 1 6298A985
P 3700 6325
F 0 "#PWR013" H 3700 6075 50  0001 C CNN
F 1 "GND" H 3704 6170 50  0001 C CNN
F 2 "" H 3700 6325 50  0001 C CNN
F 3 "" H 3700 6325 50  0001 C CNN
	1    3700 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 6225 2500 6325
Wire Wire Line
	3700 6225 3700 6325
Wire Wire Line
	4000 4225 4400 4225
Wire Wire Line
	4400 4225 4400 4250
$Comp
L stepper_probe:GND #PWR04
U 1 1 629974E9
P 2125 4250
F 0 "#PWR04" H 2125 4000 50  0001 C CNN
F 1 "GND" H 2129 4095 50  0001 C CNN
F 2 "" H 2125 4250 50  0001 C CNN
F 3 "" H 2125 4250 50  0001 C CNN
	1    2125 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 4225 2125 4225
Wire Wire Line
	2125 4225 2125 4250
$Comp
L Device:C C3
U 1 1 629B66ED
P 2400 7100
F 0 "C3" H 2250 7200 50  0000 L CNN
F 1 "12pf" H 2200 7000 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 2438 6950 50  0001 C CNN
F 3 "~" H 2400 7100 50  0001 C CNN
F 4 "C26406" H 2225 6900 50  0000 C CNN "LCSC"
	1    2400 7100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C2
U 1 1 629B708E
P 2050 6050
F 0 "C2" H 1825 6025 50  0000 L CNN
F 1 "10u" H 1825 5950 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 2088 5900 50  0001 C CNN
F 3 "~" H 2050 6050 50  0001 C CNN
F 4 "C96446" H 1875 5850 50  0000 C CNN "LCSC"
	1    2050 6050
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D2
U 1 1 629B7E29
P 10050 5700
F 0 "D2" V 10125 5650 50  0000 R CNN
F 1 "LED Y" V 10050 5650 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 10050 5700 50  0001 C CNN
F 3 "~" H 10050 5700 50  0001 C CNN
F 4 "C165978" V 9675 5700 50  0000 C CNN "LCSC"
	1    10050 5700
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D1
U 1 1 629B8927
P 9625 5700
F 0 "D1" V 9700 5650 50  0000 R CNN
F 1 "LED R" V 9625 5650 50  0000 R CNN
F 2 "stepper_probe:LED_0402_1005Metric_Pad0.77x0.64mm_HandSolder" H 9625 5700 50  0001 C CNN
F 3 "~" H 9625 5700 50  0001 C CNN
F 4 "C165980" V 9250 5700 50  0000 C CNN "LCSC"
	1    9625 5700
	0    -1   -1   0   
$EndComp
$Comp
L stepper_probe:GND #PWR03
U 1 1 62A36546
P 2050 6325
F 0 "#PWR03" H 2050 6075 50  0001 C CNN
F 1 "GND" H 2054 6170 50  0001 C CNN
F 2 "" H 2050 6325 50  0001 C CNN
F 3 "" H 2050 6325 50  0001 C CNN
	1    2050 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	2200 5525 2050 5525
Wire Wire Line
	2050 5525 2050 5775
Wire Wire Line
	2050 6200 2050 6325
$Comp
L stepper_probe:+3V3 #PWR02
U 1 1 62A3FA8F
P 1575 5800
F 0 "#PWR02" H 1575 5650 50  0001 C CNN
F 1 "+3V3" H 1425 5900 50  0000 C CNN
F 2 "" H 1575 5800 50  0001 C CNN
F 3 "" H 1575 5800 50  0001 C CNN
	1    1575 5800
	1    0    0    -1  
$EndComp
$Comp
L Device:L L2
U 1 1 62A4503B
P 1675 5425
F 0 "L2" V 1600 5600 50  0000 C CNN
F 1 "10uh" V 1600 5425 50  0000 C CNN
F 2 "stepper_probe:coil_10uh" H 1675 5425 50  0001 C CNN
F 3 "~" H 1675 5425 50  0001 C CNN
F 4 "C107342" V 1825 5475 50  0000 C CNN "LCSC"
	1    1675 5425
	0    1    -1   0   
$EndComp
$Comp
L Device:L L3
U 1 1 62A4A382
P 1325 5425
F 0 "L3" V 1250 5250 50  0000 C CNN
F 1 "15nh" V 1250 5425 50  0000 C CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 1325 5425 50  0001 C CNN
F 3 "~" H 1325 5425 50  0001 C CNN
F 4 "C27143" V 1475 5425 50  0000 C CNN "LCSC"
	1    1325 5425
	0    1    -1   0   
$EndComp
Connection ~ 2050 5825
Wire Wire Line
	2050 5825 2050 5900
Wire Wire Line
	2200 5425 1825 5425
Wire Wire Line
	1525 5425 1475 5425
$Comp
L Device:C C1
U 1 1 62A71AC5
P 1075 6050
F 0 "C1" H 1275 5950 50  0000 L CNN
F 1 "1u" H 1100 5950 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 1113 5900 50  0001 C CNN
F 3 "~" H 1075 6050 50  0001 C CNN
F 4 "C52923" H 1250 5850 50  0000 C CNN "LCSC"
	1    1075 6050
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR01
U 1 1 62A72620
P 1075 6325
F 0 "#PWR01" H 1075 6075 50  0001 C CNN
F 1 "GND" H 1079 6170 50  0001 C CNN
F 2 "" H 1075 6325 50  0001 C CNN
F 3 "" H 1075 6325 50  0001 C CNN
	1    1075 6325
	1    0    0    -1  
$EndComp
Wire Wire Line
	1075 5325 2200 5325
Wire Wire Line
	1175 5425 1075 5425
Wire Wire Line
	1075 5325 1075 5425
Connection ~ 1075 5425
Wire Wire Line
	1075 5425 1075 5900
Wire Wire Line
	1075 6200 1075 6325
$Comp
L Device:C C5
U 1 1 62AF4EEE
P 2900 7100
F 0 "C5" H 2975 7200 50  0000 L CNN
F 1 "12pf" H 2975 7025 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 2938 6950 50  0001 C CNN
F 3 "~" H 2900 7100 50  0001 C CNN
F 4 "C26406" H 3125 6900 50  0000 C CNN "LCSC"
	1    2900 7100
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 6925 2400 6925
Wire Wire Line
	2400 6925 2400 6950
Wire Wire Line
	2800 6925 2900 6925
Wire Wire Line
	2900 6925 2900 6950
$Comp
L stepper_probe:GND #PWR09
U 1 1 62B0286A
P 2900 7275
F 0 "#PWR09" H 2900 7025 50  0001 C CNN
F 1 "GND" H 2904 7120 50  0001 C CNN
F 2 "" H 2900 7275 50  0001 C CNN
F 3 "" H 2900 7275 50  0001 C CNN
	1    2900 7275
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR05
U 1 1 62B02D10
P 2400 7275
F 0 "#PWR05" H 2400 7025 50  0001 C CNN
F 1 "GND" H 2404 7120 50  0001 C CNN
F 2 "" H 2400 7275 50  0001 C CNN
F 3 "" H 2400 7275 50  0001 C CNN
	1    2400 7275
	1    0    0    -1  
$EndComp
Wire Wire Line
	2400 7250 2400 7275
Wire Wire Line
	2900 7250 2900 7275
Wire Wire Line
	2700 6225 2700 6700
Wire Wire Line
	2700 6700 2900 6700
Wire Wire Line
	2900 6700 2900 6925
Connection ~ 2900 6925
Wire Wire Line
	2600 6225 2600 6700
Wire Wire Line
	2600 6700 2400 6700
Wire Wire Line
	2400 6700 2400 6925
Connection ~ 2400 6925
$Comp
L stepper_probe:GND #PWR019
U 1 1 62B7A28C
P 9625 5925
F 0 "#PWR019" H 9625 5675 50  0001 C CNN
F 1 "GND" H 9629 5770 50  0001 C CNN
F 2 "" H 9625 5925 50  0001 C CNN
F 3 "" H 9625 5925 50  0001 C CNN
	1    9625 5925
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR020
U 1 1 62B7A5EE
P 10050 5925
F 0 "#PWR020" H 10050 5675 50  0001 C CNN
F 1 "GND" H 10054 5770 50  0001 C CNN
F 2 "" H 10050 5925 50  0001 C CNN
F 3 "" H 10050 5925 50  0001 C CNN
	1    10050 5925
	1    0    0    -1  
$EndComp
Wire Wire Line
	9625 5850 9625 5925
Wire Wire Line
	10050 5850 10050 5925
Wire Wire Line
	9625 5275 9625 4950
Wire Wire Line
	10050 5275 10050 4950
Text Label 9625 5150 1    50   ~ 0
LED1
Text Label 10050 5150 1    50   ~ 0
LED2
Wire Wire Line
	9625 5475 9625 5550
Wire Wire Line
	10050 5475 10050 5550
$Comp
L stepper_probe:GND #PWR015
U 1 1 62992C14
P 4400 4250
F 0 "#PWR015" H 4400 4000 50  0001 C CNN
F 1 "GND" H 4404 4095 50  0001 C CNN
F 2 "" H 4400 4250 50  0001 C CNN
F 3 "" H 4400 4250 50  0001 C CNN
	1    4400 4250
	1    0    0    -1  
$EndComp
Wire Wire Line
	4000 4425 4900 4425
Wire Wire Line
	4000 4525 4900 4525
Text Label 4900 4425 2    50   ~ 0
SWDDIO
Text Label 4900 4525 2    50   ~ 0
SWDCLK
$Comp
L stepper_probe:+3V3 #PWR022
U 1 1 62C04FD3
P 6600 3350
F 0 "#PWR022" H 6600 3200 50  0001 C CNN
F 1 "+3V3" H 6615 3523 50  0000 C CNN
F 2 "" H 6600 3350 50  0001 C CNN
F 3 "" H 6600 3350 50  0001 C CNN
	1    6600 3350
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR023
U 1 1 62C0D3FD
P 6600 3850
F 0 "#PWR023" H 6600 3600 50  0001 C CNN
F 1 "GND" H 6604 3695 50  0001 C CNN
F 2 "" H 6600 3850 50  0001 C CNN
F 3 "" H 6600 3850 50  0001 C CNN
	1    6600 3850
	1    0    0    -1  
$EndComp
Wire Wire Line
	6675 3500 6600 3500
Wire Wire Line
	6675 3600 6600 3600
Wire Wire Line
	6600 3500 6600 3600
Connection ~ 6600 3600
Wire Wire Line
	6600 3600 6600 3800
Wire Wire Line
	6675 3800 6600 3800
Connection ~ 6600 3800
Wire Wire Line
	6600 3800 6600 3850
NoConn ~ 6675 3700
NoConn ~ 7175 3600
NoConn ~ 7175 3700
Wire Wire Line
	7175 3400 7625 3400
Wire Wire Line
	7175 3500 7625 3500
Text Label 7625 3400 2    50   ~ 0
SWDDIO
Text Label 7625 3500 2    50   ~ 0
SWDCLK
Text Notes 7125 4150 2    50   ~ 0
SWD (DEV)
NoConn ~ 2200 5025
NoConn ~ 2200 5125
NoConn ~ 2200 5225
NoConn ~ 3000 6225
NoConn ~ 3100 6225
NoConn ~ 3300 6225
NoConn ~ 4000 4925
NoConn ~ 4000 5125
NoConn ~ 4000 5225
NoConn ~ 4000 5325
NoConn ~ 4000 4325
Wire Wire Line
	4000 5525 4600 5525
Wire Wire Line
	6950 1825 6950 1625
$Comp
L Device:C C6
U 1 1 62AF34AF
P 3900 1225
F 0 "C6" V 3850 1300 50  0000 L CNN
F 1 "100n" V 3650 1150 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 3938 1075 50  0001 C CNN
F 3 "~" H 3900 1225 50  0001 C CNN
F 4 "C307331" V 3850 350 50  0000 C CNN "LCSC"
	1    3900 1225
	0    1    1    0   
$EndComp
$Comp
L Device:C C4
U 1 1 62AF538B
P 2925 2300
F 0 "C4" V 2900 2375 50  0000 L CNN
F 1 "100n" V 2700 2250 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 2963 2150 50  0001 C CNN
F 3 "~" H 2925 2300 50  0001 C CNN
F 4 "C307331" V 2775 2425 50  0000 C CNN "LCSC"
	1    2925 2300
	0    1    1    0   
$EndComp
Wire Wire Line
	8850 1625 8850 1825
Wire Wire Line
	8850 2200 8850 2125
Connection ~ 8850 2200
Wire Wire Line
	8850 2200 8600 2200
Wire Wire Line
	8850 1625 8600 1625
$Comp
L stepper_probe:DC_DC U4
U 1 1 62B3ECA9
P 7850 1625
F 0 "U4" H 7750 1925 50  0000 C CNN
F 1 "K7803MT-500R4" H 7950 1825 50  0000 C CNN
F 2 "stepper_probe:Converter_DCDC" H 7900 1375 50  0001 L CIN
F 3 "https://www.recom-power.com/pdf/Innoline/R-78Exx-0.5.pdf" H 7850 1625 50  0001 C CNN
F 4 "C2692194" H 8025 1925 50  0000 C CNN "LCSC"
	1    7850 1625
	1    0    0    -1  
$EndComp
Wire Wire Line
	7200 2200 7800 2200
Wire Wire Line
	7900 1925 7900 2200
Connection ~ 7900 2200
Wire Wire Line
	7900 2200 8350 2200
Wire Wire Line
	7800 1925 7800 2200
Connection ~ 7800 2200
Wire Wire Line
	7800 2200 7900 2200
$Comp
L Connector:Conn_01x04_Male J4
U 1 1 628A791E
P 10075 3600
F 0 "J4" H 10125 3825 50  0000 C CNN
F 1 "Serial Port" H 10250 3825 50  0001 C CNN
F 2 "stepper_probe:PinHeader_1x04_P2.54mm_Vertical" H 10075 3600 50  0001 C CNN
F 3 "~" H 10075 3600 50  0001 C CNN
F 4 "DNP" H 10075 3600 50  0001 C CNN "LCSC"
	1    10075 3600
	-1   0    0    -1  
$EndComp
Wire Wire Line
	9875 3500 9850 3500
Wire Wire Line
	9875 3800 9850 3800
Wire Wire Line
	9875 3600 9750 3600
Wire Wire Line
	9875 3700 9750 3700
$Comp
L Device:R_Small_US R8
U 1 1 62BD5E6B
P 9650 3600
F 0 "R8" V 9550 3475 50  0000 C CNN
F 1 "1K" V 9550 3625 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9650 3600 50  0001 C CNN
F 3 "~" H 9650 3600 50  0001 C CNN
F 4 "C11702" V 9450 3525 50  0000 C CNN "LCSC"
	1    9650 3600
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R9
U 1 1 62BD65EC
P 9650 3700
F 0 "R9" V 9750 3575 50  0000 C CNN
F 1 "1K" V 9750 3725 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9650 3700 50  0001 C CNN
F 3 "~" H 9650 3700 50  0001 C CNN
F 4 "C11702" V 9825 3625 50  0000 C CNN "LCSC"
	1    9650 3700
	0    1    1    0   
$EndComp
Wire Wire Line
	9550 3600 9300 3600
Wire Wire Line
	9550 3700 9300 3700
$Comp
L Device:R_Small_US R6
U 1 1 62C197D2
P 9625 5375
F 0 "R6" H 9600 5275 50  0000 R CNN
F 1 "5K1" H 9600 5450 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9625 5375 50  0001 C CNN
F 3 "~" H 9625 5375 50  0001 C CNN
F 4 "C25905" V 9725 5400 50  0000 C CNN "LCSC"
	1    9625 5375
	-1   0    0    1   
$EndComp
$Comp
L Device:R_Small_US R7
U 1 1 62C19C2B
P 10050 5375
F 0 "R7" H 10025 5250 50  0000 R CNN
F 1 "5K1" H 10000 5475 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 10050 5375 50  0001 C CNN
F 3 "~" H 10050 5375 50  0001 C CNN
F 4 "C25905" V 10150 5400 50  0000 C CNN "LCSC"
	1    10050 5375
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:MDBT42Q-512KV2 U3
U 1 1 62C25ED4
P 3100 4625
F 0 "U3" H 3100 5440 50  0000 C CNN
F 1 "MDBT42Q-512KV2" H 3100 5349 50  0000 C CNN
F 2 "stepper_probe:RAYTAC_MDBT42Q" H 3100 4625 50  0001 C CNN
F 3 "" H 3100 4625 50  0001 C CNN
	1    3100 4625
	1    0    0    -1  
$EndComp
Wire Wire Line
	6675 3400 6600 3400
Wire Wire Line
	6600 3400 6600 3350
Text Notes 8150 2500 0    50   ~ 0
Power Supply
NoConn ~ 4600 5525
NoConn ~ 4600 5625
Text Label 4275 5625 0    50   ~ 0
TEST1
Text Label 4275 5525 0    50   ~ 0
TEST2
NoConn ~ 4000 5025
Wire Wire Line
	2200 4625 1575 4625
Wire Wire Line
	2200 4725 1575 4725
NoConn ~ 4000 4725
NoConn ~ 4000 4825
Wire Wire Line
	3400 6225 3400 6550
$Comp
L stepper_probe:GND #PWR011
U 1 1 6294FC1A
P 4925 5875
F 0 "#PWR011" H 4925 5625 50  0001 C CNN
F 1 "GND" H 4929 5720 50  0001 C CNN
F 2 "" H 4925 5875 50  0001 C CNN
F 3 "" H 4925 5875 50  0001 C CNN
	1    4925 5875
	1    0    0    -1  
$EndComp
Text Label 4275 5425 0    50   ~ 0
DFU
Text Notes 5450 1650 0    50   ~ 0
+
$Comp
L Switch:SW_Push SW1
U 1 1 629716D2
P 4925 5650
F 0 "SW1" V 4925 5798 50  0000 L CNN
F 1 "SW_Push" V 4970 5798 50  0001 L CNN
F 2 "stepper_probe:SW_Push_SPST_NO_Alps_SKRK" H 4925 5850 50  0001 C CNN
F 3 "~" H 4925 5850 50  0001 C CNN
F 4 "C720477" V 5025 5975 50  0000 C CNN "LCSC"
	1    4925 5650
	0    1    1    0   
$EndComp
Wire Wire Line
	4925 5425 4925 5450
Wire Wire Line
	4000 5425 4925 5425
Wire Wire Line
	4925 5850 4925 5875
NoConn ~ 7175 3800
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
Text Notes 1825 4150 2    50   ~ 0
BLE SOC
$Comp
L Connector:Conn_01x02_Male J6
U 1 1 6295F498
P 5250 4625
F 0 "J6" H 5350 4425 50  0000 R CNN
F 1 "Reset header" H 5100 4575 50  0001 R CNN
F 2 "stepper_probe:PinHeader_1x02_P2.54mm_Vertical" H 5250 4625 50  0001 C CNN
F 3 "~" H 5250 4625 50  0001 C CNN
F 4 "DNP" H 5250 4625 50  0001 C CNN "LCSC"
	1    5250 4625
	-1   0    0    -1  
$EndComp
Wire Wire Line
	4000 4625 5050 4625
$Comp
L stepper_probe:GND #PWR0101
U 1 1 62973953
P 5000 4750
F 0 "#PWR0101" H 5000 4500 50  0001 C CNN
F 1 "GND" H 5004 4595 50  0001 C CNN
F 2 "" H 5000 4750 50  0001 C CNN
F 3 "" H 5000 4750 50  0001 C CNN
	1    5000 4750
	1    0    0    -1  
$EndComp
Wire Wire Line
	5050 4725 5000 4725
Wire Wire Line
	5000 4725 5000 4750
Text Label 4900 4625 2    50   ~ 0
RESET
Text Notes 5350 4650 2    50   ~ 0
R
Text Notes 5350 4750 2    50   ~ 0
G
$Comp
L Memory_EEPROM:M24C02-FMN U5
U 1 1 62D5C61F
P 6975 5600
F 0 "U5" H 6300 5975 50  0000 C CNN
F 1 "M24C02-FMN" H 6500 5900 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 6975 5950 50  0001 C CNN
F 3 "http://www.st.com/content/ccc/resource/technical/document/datasheet/b0/d8/50/40/5a/85/49/6f/DM00071904.pdf/files/DM00071904.pdf/jcr:content/translations/en.DM00071904.pdf" H 7025 5100 50  0001 C CNN
F 4 "C7562" H 6350 6075 50  0000 C CNN "LCSC"
	1    6975 5600
	1    0    0    -1  
$EndComp
Wire Wire Line
	8850 2200 9450 2200
Wire Wire Line
	9450 2200 9450 2225
Wire Wire Line
	2200 4925 1575 4925
Wire Wire Line
	2200 4825 1575 4825
$Comp
L stepper_probe:GND #PWR026
U 1 1 62E0FD09
P 6975 5950
F 0 "#PWR026" H 6975 5700 50  0001 C CNN
F 1 "GND" H 6979 5795 50  0001 C CNN
F 2 "" H 6975 5950 50  0001 C CNN
F 3 "" H 6975 5950 50  0001 C CNN
	1    6975 5950
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR028
U 1 1 62E10158
P 7425 5950
F 0 "#PWR028" H 7425 5700 50  0001 C CNN
F 1 "GND" H 7429 5795 50  0001 C CNN
F 2 "" H 7425 5950 50  0001 C CNN
F 3 "" H 7425 5950 50  0001 C CNN
	1    7425 5950
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR016
U 1 1 62E10507
P 6525 5950
F 0 "#PWR016" H 6525 5700 50  0001 C CNN
F 1 "GND" H 6529 5795 50  0001 C CNN
F 2 "" H 6525 5950 50  0001 C CNN
F 3 "" H 6525 5950 50  0001 C CNN
	1    6525 5950
	1    0    0    -1  
$EndComp
Wire Wire Line
	9200 5125 9200 5275
$Comp
L stepper_probe:+3V3 #PWR021
U 1 1 62E10B3B
P 6975 5100
F 0 "#PWR021" H 6975 4950 50  0001 C CNN
F 1 "+3V3" H 6950 5275 50  0000 C CNN
F 2 "" H 6975 5100 50  0001 C CNN
F 3 "" H 6975 5100 50  0001 C CNN
	1    6975 5100
	1    0    0    -1  
$EndComp
$Comp
L Device:C C12
U 1 1 62E1111B
P 7175 5200
F 0 "C12" V 7100 5275 50  0000 L CNN
F 1 "100n" V 7025 5275 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 7213 5050 50  0001 C CNN
F 3 "~" H 7175 5200 50  0001 C CNN
F 4 "C307331" V 6950 5325 50  0000 C CNN "LCSC"
	1    7175 5200
	0    1    1    0   
$EndComp
$Comp
L stepper_probe:GND #PWR027
U 1 1 62E12E1A
P 7375 5225
F 0 "#PWR027" H 7375 4975 50  0001 C CNN
F 1 "GND" H 7379 5070 50  0001 C CNN
F 2 "" H 7375 5225 50  0001 C CNN
F 3 "" H 7375 5225 50  0001 C CNN
	1    7375 5225
	1    0    0    -1  
$EndComp
Wire Wire Line
	7325 5200 7375 5200
Wire Wire Line
	7375 5200 7375 5225
Wire Wire Line
	6975 5100 6975 5200
Wire Wire Line
	7025 5200 6975 5200
Connection ~ 6975 5200
Wire Wire Line
	6975 5200 6975 5300
Wire Wire Line
	7375 5700 7425 5700
Wire Wire Line
	7425 5700 7425 5950
Wire Wire Line
	6975 5900 6975 5950
Wire Wire Line
	6575 5500 6525 5500
Wire Wire Line
	6525 5500 6525 5600
Wire Wire Line
	6575 5600 6525 5600
Connection ~ 6525 5600
Wire Wire Line
	6525 5600 6525 5700
Wire Wire Line
	6575 5700 6525 5700
Connection ~ 6525 5700
Wire Wire Line
	6525 5700 6525 5950
Wire Wire Line
	7375 5500 7650 5500
Wire Wire Line
	7375 5600 7950 5600
$Comp
L Device:R_Small_US R10
U 1 1 62E796A4
P 7650 5275
F 0 "R10" H 7575 5275 50  0000 R CNN
F 1 "10K" H 7575 5200 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 7650 5275 50  0001 C CNN
F 3 "~" H 7650 5275 50  0001 C CNN
F 4 "C25744" H 7425 5125 50  0000 C CNN "LCSC"
	1    7650 5275
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:+3V3 #PWR0102
U 1 1 62D5A4DA
P 7650 5100
F 0 "#PWR0102" H 7650 4950 50  0001 C CNN
F 1 "+3V3" H 7625 5275 50  0000 C CNN
F 2 "" H 7650 5100 50  0001 C CNN
F 3 "" H 7650 5100 50  0001 C CNN
	1    7650 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	7650 5375 7650 5500
Connection ~ 7650 5500
Wire Wire Line
	7650 5500 7950 5500
Wire Wire Line
	7650 5100 7650 5175
Text Label 7950 5500 2    50   ~ 0
SDA
Text Label 7950 5600 2    50   ~ 0
SCL
Text Label 1575 4725 0    50   ~ 0
SDA
Text Label 1575 4825 0    50   ~ 0
SCL
$Comp
L stepper_probe:+3V3 #PWR0103
U 1 1 62DB77A4
P 2700 2250
F 0 "#PWR0103" H 2700 2100 50  0001 C CNN
F 1 "+3V3" H 2650 2400 50  0000 C CNN
F 2 "" H 2700 2250 50  0001 C CNN
F 3 "" H 2700 2250 50  0001 C CNN
	1    2700 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	2700 2250 2700 2300
Connection ~ 2700 2300
$Comp
L stepper_probe:+3V3 #PWR0104
U 1 1 62DC2B17
P 3675 1175
F 0 "#PWR0104" H 3675 1025 50  0001 C CNN
F 1 "+3V3" H 3625 1325 50  0000 C CNN
F 2 "" H 3675 1175 50  0001 C CNN
F 3 "" H 3675 1175 50  0001 C CNN
	1    3675 1175
	1    0    0    -1  
$EndComp
Wire Wire Line
	3675 1175 3675 1225
Connection ~ 3675 1225
Text Notes 6600 6225 0    50   ~ 0
Settings EEPROM
$Comp
L stepper_probe:+3V3 #PWR0105
U 1 1 62EA5B3C
P 9850 3425
F 0 "#PWR0105" H 9850 3275 50  0001 C CNN
F 1 "+3V3" V 9865 3553 50  0000 L CNN
F 2 "" H 9850 3425 50  0001 C CNN
F 3 "" H 9850 3425 50  0001 C CNN
	1    9850 3425
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR0106
U 1 1 62EA6362
P 9850 3925
F 0 "#PWR0106" H 9850 3675 50  0001 C CNN
F 1 "GND" H 9854 3770 50  0001 C CNN
F 2 "" H 9850 3925 50  0001 C CNN
F 3 "" H 9850 3925 50  0001 C CNN
	1    9850 3925
	1    0    0    -1  
$EndComp
Wire Wire Line
	9850 3425 9850 3500
Wire Wire Line
	9850 3800 9850 3925
Wire Wire Line
	6950 2200 7200 2200
$Comp
L Device:C C11
U 1 1 62B00F1B
P 8850 1975
F 0 "C11" H 8875 2075 50  0000 L CNN
F 1 "10u" H 8875 1875 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 8888 1825 50  0001 C CNN
F 3 "~" H 8850 1975 50  0001 C CNN
F 4 "C96446" H 8850 1650 50  0000 C CNN "LCSC"
	1    8850 1975
	1    0    0    -1  
$EndComp
$Comp
L Device:C C10
U 1 1 62799F4E
P 8600 1975
F 0 "C10" H 8600 2075 50  0000 L CNN
F 1 "10u" H 8625 1875 50  0000 L CNN
F 2 "stepper_probe:C_0603_1608Metric_Pad1.08x0.95mm_HandSolder" H 8638 1825 50  0001 C CNN
F 3 "~" H 8600 1975 50  0001 C CNN
F 4 "C96446" H 8600 2250 50  0000 C CNN "LCSC"
	1    8600 1975
	1    0    0    -1  
$EndComp
$Comp
L Device:C C9
U 1 1 62AF1C75
P 8350 1975
F 0 "C9" H 8350 2075 50  0000 L CNN
F 1 "100n" H 8350 1875 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 8388 1825 50  0001 C CNN
F 3 "~" H 8350 1975 50  0001 C CNN
F 4 "C307331" H 8250 1650 50  0000 C CNN "LCSC"
	1    8350 1975
	1    0    0    -1  
$EndComp
$Comp
L Device:C C8
U 1 1 62AE4F00
P 7200 1975
F 0 "C8" H 7250 2075 50  0000 L CNN
F 1 "100n 50V" H 7250 1875 50  0000 L CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 7238 1825 50  0001 C CNN
F 3 "~" H 7200 1975 50  0001 C CNN
F 4 "C307331" H 7375 1675 50  0000 C CNN "LCSC"
	1    7200 1975
	1    0    0    -1  
$EndComp
$Comp
L Device:C C7
U 1 1 62788E2E
P 6950 1975
F 0 "C7" H 6825 2075 50  0000 L CNN
F 1 "10u 50v" H 6800 1875 50  0000 L CNN
F 2 "stepper_probe:C_0805_2012Metric_Pad1.18x1.45mm_HandSolder" H 6988 1825 50  0001 C CNN
F 3 "~" H 6950 1975 50  0001 C CNN
F 4 "C440198" H 6950 1675 50  0000 C CNN "LCSC"
	1    6950 1975
	1    0    0    -1  
$EndComp
$Comp
L Device:C C13
U 1 1 62E89E59
P 3250 3050
F 0 "C13" H 2925 3225 50  0000 L CNN
F 1 "DNP" H 3075 3025 50  0000 R CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 3288 2900 50  0001 C CNN
F 3 "~" H 3250 3050 50  0001 C CNN
F 4 "DNP" H 3075 3125 50  0000 R CNN "LCSC"
	1    3250 3050
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR0108
U 1 1 62E8AEC1
P 3250 3250
F 0 "#PWR0108" H 3250 3000 50  0001 C CNN
F 1 "GND" H 3254 3095 50  0001 C CNN
F 2 "" H 3250 3250 50  0001 C CNN
F 3 "" H 3250 3250 50  0001 C CNN
	1    3250 3250
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe-rescue:ACS70331_soic8-simple_stepper_motor_analyzer U2
U 1 1 627AA0D1
P 2750 2775
F 0 "U2" H 2000 2450 50  0000 C CNN
F 1 "CC6920BSO-5A" H 2250 2350 50  0000 C CNN
F 2 "stepper_probe:SOIC-8_LCPCB_ROT" H 3150 2725 50  0001 L CIN
F 3 "" H 2750 2775 50  0001 C CNN
F 4 "C2880430" H 2150 2250 50  0000 C CNN "LCSC"
	1    2750 2775
	1    0    0    -1  
$EndComp
Wire Wire Line
	3150 2875 3250 2875
Wire Wire Line
	3250 2875 3250 2900
Wire Wire Line
	3250 3200 3250 3250
$Comp
L Device:C C14
U 1 1 62ECE48F
P 4225 1975
F 0 "C14" H 3900 2150 50  0000 L CNN
F 1 "DNP" H 4050 1950 50  0000 R CNN
F 2 "stepper_probe:C_0402_1005Metric_Pad0.74x0.62mm_HandSolder" H 4263 1825 50  0001 C CNN
F 3 "~" H 4225 1975 50  0001 C CNN
F 4 "DNP" H 4050 2050 50  0000 R CNN "LCSC"
	1    4225 1975
	-1   0    0    1   
$EndComp
$Comp
L stepper_probe:GND #PWR0109
U 1 1 62ECEDC1
P 4225 2175
F 0 "#PWR0109" H 4225 1925 50  0001 C CNN
F 1 "GND" H 4229 2020 50  0001 C CNN
F 2 "" H 4225 2175 50  0001 C CNN
F 3 "" H 4225 2175 50  0001 C CNN
	1    4225 2175
	1    0    0    -1  
$EndComp
Wire Wire Line
	4125 1800 4225 1800
Wire Wire Line
	4225 1800 4225 1825
Wire Wire Line
	4225 2125 4225 2175
$Comp
L stepper_probe:GND #PWR0111
U 1 1 62EFA692
P 5125 7200
F 0 "#PWR0111" H 5125 6950 50  0001 C CNN
F 1 "GND" H 5129 7045 50  0001 C CNN
F 2 "" H 5125 7200 50  0001 C CNN
F 3 "" H 5125 7200 50  0001 C CNN
	1    5125 7200
	1    0    0    -1  
$EndComp
$Comp
L stepper_probe:GND #PWR0112
U 1 1 62EFAB50
P 5125 6850
F 0 "#PWR0112" H 5125 6600 50  0001 C CNN
F 1 "GND" H 5129 6695 50  0001 C CNN
F 2 "" H 5125 6850 50  0001 C CNN
F 3 "" H 5125 6850 50  0001 C CNN
	1    5125 6850
	1    0    0    -1  
$EndComp
$Comp
L Device:R_Small_US R11
U 1 1 62EFB038
P 4975 6800
F 0 "R11" V 5075 6900 50  0000 R CNN
F 1 "DNP" V 5075 6700 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4975 6800 50  0001 C CNN
F 3 "~" H 4975 6800 50  0001 C CNN
F 4 "DNP" H 4975 6800 50  0001 C CNN "LCSC"
	1    4975 6800
	0    -1   -1   0   
$EndComp
$Comp
L Device:R_Small_US R12
U 1 1 62EFBB37
P 4975 7150
F 0 "R12" V 5050 7250 50  0000 R CNN
F 1 "DNP" V 5050 7050 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4975 7150 50  0001 C CNN
F 3 "~" H 4975 7150 50  0001 C CNN
F 4 "DNP" H 4975 7150 50  0001 C CNN "LCSC"
	1    4975 7150
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5075 6800 5125 6800
Wire Wire Line
	5125 6800 5125 6850
Wire Wire Line
	5075 7150 5125 7150
Wire Wire Line
	5125 7150 5125 7200
Text Label 4425 6800 0    50   ~ 0
CFG1
Wire Wire Line
	4425 6800 4875 6800
Wire Wire Line
	4425 7150 4875 7150
Text Label 4425 7150 0    50   ~ 0
CFG2
Wire Wire Line
	3500 6225 3500 6550
Wire Wire Line
	3600 6225 3600 6550
Text Label 3500 6550 1    50   ~ 0
CFG1
Text Label 3600 6550 1    50   ~ 0
CFG2
Text Notes 5375 7075 0    50   ~ 0
Reserved for future\nconfigurations.
Text Notes 3925 3025 0    50   ~ 0
Current sensors
Connection ~ 7200 1625
$Comp
L Device:R_Small_US R14
U 1 1 62FBED44
P 9100 1625
F 0 "R14" V 8875 1575 50  0000 C CNN
F 1 "0R" V 8875 1800 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 9100 1625 50  0001 C CNN
F 3 "~" H 9100 1625 50  0001 C CNN
F 4 "C17168" V 9000 1675 50  0000 C CNN "LCSC"
	1    9100 1625
	0    1    1    0   
$EndComp
Connection ~ 8350 1625
Wire Wire Line
	8150 1625 8350 1625
Wire Wire Line
	9375 1625 9300 1625
Wire Wire Line
	9000 1625 8850 1625
Connection ~ 8850 1625
$Comp
L power:PWR_FLAG #FLG0101
U 1 1 62C72EBD
P 9300 1675
F 0 "#FLG0101" H 9300 1750 50  0001 C CNN
F 1 "PWR_FLAG" H 9250 1825 50  0000 C CNN
F 2 "" H 9300 1675 50  0001 C CNN
F 3 "~" H 9300 1675 50  0001 C CNN
	1    9300 1675
	-1   0    0    1   
$EndComp
Wire Wire Line
	9300 1675 9300 1625
Connection ~ 9300 1625
Wire Wire Line
	9300 1625 9200 1625
$Comp
L Device:R_Small_US R15
U 1 1 630B99F4
P 1750 5825
F 0 "R15" V 1850 5750 50  0000 C CNN
F 1 "0R" V 1850 5875 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 1750 5825 50  0001 C CNN
F 3 "~" H 1750 5825 50  0001 C CNN
F 4 "C17168" V 1650 5825 50  0000 C CNN "LCSC"
	1    1750 5825
	0    1    1    0   
$EndComp
Wire Wire Line
	1850 5825 2050 5825
Wire Wire Line
	1575 5800 1575 5825
Wire Wire Line
	1575 5825 1650 5825
$Comp
L power:PWR_FLAG #FLG0104
U 1 1 630D43FC
P 2175 5750
F 0 "#FLG0104" H 2175 5825 50  0001 C CNN
F 1 "PWR_FLAG" H 2050 5900 50  0000 C CNN
F 2 "" H 2175 5750 50  0001 C CNN
F 3 "~" H 2175 5750 50  0001 C CNN
	1    2175 5750
	1    0    0    -1  
$EndComp
Wire Wire Line
	2175 5750 2175 5775
Wire Wire Line
	2175 5775 2050 5775
Connection ~ 2050 5775
Wire Wire Line
	2050 5775 2050 5825
$Comp
L Device:R_Small_US R16
U 1 1 630E9BC4
P 4500 1600
F 0 "R16" V 4400 1475 50  0000 C CNN
F 1 "1K" V 4400 1625 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4500 1600 50  0001 C CNN
F 3 "~" H 4500 1600 50  0001 C CNN
F 4 "C11702" V 4300 1525 50  0000 C CNN "LCSC"
	1    4500 1600
	0    1    1    0   
$EndComp
$Comp
L Device:R_Small_US R17
U 1 1 630EA395
P 4500 2675
F 0 "R17" V 4400 2550 50  0000 C CNN
F 1 "1K" V 4400 2700 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 4500 2675 50  0001 C CNN
F 3 "~" H 4500 2675 50  0001 C CNN
F 4 "C11702" V 4300 2600 50  0000 C CNN "LCSC"
	1    4500 2675
	0    1    1    0   
$EndComp
Wire Wire Line
	4600 1600 4850 1600
Wire Wire Line
	4600 2675 4850 2675
Wire Wire Line
	4125 1600 4400 1600
Wire Wire Line
	3150 2675 4400 2675
Wire Wire Line
	7200 1625 7325 1625
Wire Wire Line
	7325 1575 7325 1625
Connection ~ 7325 1625
Wire Wire Line
	7325 1625 7550 1625
Connection ~ 6950 1625
Text Notes 5450 1750 0    50   ~ 0
-
Wire Wire Line
	5750 1725 5775 1725
Wire Wire Line
	5775 1725 5775 2100
Connection ~ 6950 2200
Wire Wire Line
	6950 1625 7200 1625
$Comp
L power:PWR_FLAG #FLG0103
U 1 1 630790D2
P 7325 1575
F 0 "#FLG0103" H 7325 1650 50  0001 C CNN
F 1 "PWR_FLAG" H 7350 1725 50  0000 C CNN
F 2 "" H 7325 1575 50  0001 C CNN
F 3 "~" H 7325 1575 50  0001 C CNN
	1    7325 1575
	1    0    0    -1  
$EndComp
$Comp
L power:PWR_FLAG #FLG0102
U 1 1 630668EE
P 5725 2100
F 0 "#FLG0102" H 5725 2175 50  0001 C CNN
F 1 "PWR_FLAG" V 5625 2300 50  0000 C CNN
F 2 "" H 5725 2100 50  0001 C CNN
F 3 "~" H 5725 2100 50  0001 C CNN
	1    5725 2100
	0    -1   -1   0   
$EndComp
Wire Wire Line
	5775 2200 6050 2200
Wire Wire Line
	5725 2100 5775 2100
Connection ~ 5775 2100
Wire Wire Line
	5775 2100 5775 2200
$Comp
L stepper_probe:P_MOSFET Q1
U 1 1 62F752CB
P 6375 1725
F 0 "Q1" V 6790 1725 50  0000 C CNN
F 1 "PJA3439" V 6699 1725 50  0000 C CNN
F 2 "stepper_probe:SOT-23_JLCPCB" H 6575 1650 50  0001 L CIN
F 3 "http://www.aosmd.com/pdfs/datasheet/AO3401A.pdf" H 6375 1725 50  0001 L CNN
F 4 "C2844879" V 6608 1725 50  0000 C CNN "LCSC"
	1    6375 1725
	0    -1   -1   0   
$EndComp
Wire Wire Line
	6525 1625 6625 1625
Wire Wire Line
	5750 1625 6050 1625
Connection ~ 6050 1625
Wire Wire Line
	6050 1625 6225 1625
Connection ~ 6050 2200
$Comp
L Device:R_Small_US R1
U 1 1 62FB34BF
P 6050 1975
F 0 "R1" H 6175 1875 50  0000 C CNN
F 1 "300k" H 6175 1950 50  0000 C CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 6050 1975 50  0001 C CNN
F 3 "~" H 6050 1975 50  0001 C CNN
F 4 "C25774" H 6050 2275 50  0000 C CNN "LCSC"
	1    6050 1975
	-1   0    0    1   
$EndComp
Wire Wire Line
	6050 1625 6050 1875
Wire Wire Line
	6050 2075 6050 2200
Wire Wire Line
	6050 2200 6375 2200
$Comp
L Device:R_Small_US R2
U 1 1 6300821D
P 6375 2050
F 0 "R2" H 6325 2050 50  0000 R CNN
F 1 "20k" H 6375 2150 50  0000 R CNN
F 2 "stepper_probe:R_0402_1005Metric_Pad0.72x0.64mm_HandSolder" H 6375 2050 50  0001 C CNN
F 3 "~" H 6375 2050 50  0001 C CNN
F 4 "C25765" H 6350 2275 50  0000 C CNN "LCSC"
	1    6375 2050
	-1   0    0    1   
$EndComp
Wire Wire Line
	6375 2150 6375 2200
Connection ~ 6375 2200
Wire Wire Line
	6375 2200 6950 2200
Wire Wire Line
	6375 1950 6375 1900
$Comp
L stepper_probe:zenner D4
U 1 1 6303728C
P 6625 1775
F 0 "D4" V 6700 1625 50  0000 L CNN
F 1 "5V6" V 6725 1775 50  0000 L CNN
F 2 "stepper_probe:D_MiniMELF_zenner" H 6625 1600 50  0001 C CNN
F 3 "http://www.vishay.com/docs/85790/zpy3v9.pdf" H 6625 1775 50  0001 C CNN
F 4 "C8062" V 6800 1775 50  0000 C CNN "LCSC"
	1    6625 1775
	0    1    1    0   
$EndComp
Wire Wire Line
	6625 1675 6625 1625
Connection ~ 6625 1625
Wire Wire Line
	6625 1625 6950 1625
Wire Wire Line
	6625 1875 6625 1900
Wire Wire Line
	6625 1900 6375 1900
Connection ~ 6375 1900
Wire Wire Line
	6375 1900 6375 1825
$EndSCHEMATC
