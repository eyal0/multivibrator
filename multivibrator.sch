EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:multivibrator-cache
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L R R1
U 1 1 57D00A5E
P 2650 2350
F 0 "R1" V 2730 2350 50  0000 C CNN
F 1 "330" V 2650 2350 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 2580 2350 50  0001 C CNN
F 3 "" H 2650 2350 50  0000 C CNN
	1    2650 2350
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 57D00C34
P 3150 2350
F 0 "R2" V 3230 2350 50  0000 C CNN
F 1 "10k" V 3150 2350 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 3080 2350 50  0001 C CNN
F 3 "" H 3150 2350 50  0000 C CNN
	1    3150 2350
	1    0    0    -1  
$EndComp
$Comp
L R R3
U 1 1 57D00CB3
P 3550 2350
F 0 "R3" V 3630 2350 50  0000 C CNN
F 1 "10k" V 3550 2350 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 3480 2350 50  0001 C CNN
F 3 "" H 3550 2350 50  0000 C CNN
	1    3550 2350
	1    0    0    -1  
$EndComp
$Comp
L R R4
U 1 1 57D00D18
P 4050 2350
F 0 "R4" V 4130 2350 50  0000 C CNN
F 1 "330" V 4050 2350 50  0000 C CNN
F 2 "Resistors_ThroughHole:Resistor_Horizontal_RM7mm" V 3980 2350 50  0001 C CNN
F 3 "" H 4050 2350 50  0000 C CNN
	1    4050 2350
	1    0    0    -1  
$EndComp
$Comp
L CP1 C1
U 1 1 57D00DB4
P 2900 2650
F 0 "C1" H 2925 2750 50  0000 L CNN
F 1 "10uF" H 2925 2550 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L6_P2.5" H 2900 2650 50  0001 C CNN
F 3 "" H 2900 2650 50  0000 C CNN
	1    2900 2650
	0    -1   -1   0   
$EndComp
$Comp
L CP1 C2
U 1 1 57D00DFE
P 3800 2650
F 0 "C2" H 3825 2750 50  0000 L CNN
F 1 "10uF" H 3825 2550 50  0000 L CNN
F 2 "Capacitors_ThroughHole:C_Radial_D5_L6_P2.5" H 3800 2650 50  0001 C CNN
F 3 "" H 3800 2650 50  0000 C CNN
	1    3800 2650
	0    1    -1   0   
$EndComp
$Comp
L Q_NPN_EBC Q1
U 1 1 57D00F4C
P 2750 3050
F 0 "Q1" H 3050 3100 50  0000 R CNN
F 1 "Q_NPN_EBC" H 3350 3000 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Narrow_Oval" H 2950 3150 50  0001 C CNN
F 3 "" H 2750 3050 50  0000 C CNN
	1    2750 3050
	-1   0    0    -1  
$EndComp
$Comp
L Q_NPN_EBC Q2
U 1 1 57D00F94
P 3950 3050
F 0 "Q2" H 4250 3100 50  0000 R CNN
F 1 "Q_NPN_EBC" H 4550 3000 50  0000 R CNN
F 2 "TO_SOT_Packages_THT:TO-92_Inline_Narrow_Oval" H 4150 3150 50  0001 C CNN
F 3 "" H 3950 3050 50  0000 C CNN
	1    3950 3050
	1    0    0    -1  
$EndComp
$Comp
L LED D2
U 1 1 57D0105D
P 4050 3550
F 0 "D2" H 4050 3650 50  0000 C CNN
F 1 "LED" H 4050 3450 50  0000 C CNN
F 2 "LEDs:LED-5MM" H 4050 3550 50  0001 C CNN
F 3 "" H 4050 3550 50  0000 C CNN
	1    4050 3550
	0    -1   -1   0   
$EndComp
$Comp
L LED D1
U 1 1 57D0111A
P 2650 3550
F 0 "D1" H 2650 3650 50  0000 C CNN
F 1 "LED" H 2650 3450 50  0000 C CNN
F 2 "LEDs:LED-5MM" H 2650 3550 50  0001 C CNN
F 3 "" H 2650 3550 50  0000 C CNN
	1    2650 3550
	0    -1   -1   0   
$EndComp
$Comp
L GND #PWR01
U 1 1 57D0153D
P 3350 4000
F 0 "#PWR01" H 3350 3750 50  0001 C CNN
F 1 "GND" H 3350 3850 50  0000 C CNN
F 2 "" H 3350 4000 50  0000 C CNN
F 3 "" H 3350 4000 50  0000 C CNN
	1    3350 4000
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR02
U 1 1 57D0164B
P 3350 2100
F 0 "#PWR02" H 3350 1950 50  0001 C CNN
F 1 "VCC" H 3350 2250 50  0000 C CNN
F 2 "" H 3350 2100 50  0000 C CNN
F 3 "" H 3350 2100 50  0000 C CNN
	1    3350 2100
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 2100 3350 2200
Wire Wire Line
	2650 2200 4050 2200
Connection ~ 3550 2200
Connection ~ 3350 2200
Connection ~ 3150 2200
Wire Wire Line
	2650 2500 2650 2850
Wire Wire Line
	2650 2650 2750 2650
Wire Wire Line
	3150 2500 3150 2650
Wire Wire Line
	3150 2650 3050 2650
Wire Wire Line
	3550 2500 3550 2650
Wire Wire Line
	3550 2650 3650 2650
Wire Wire Line
	4050 2500 4050 2850
Wire Wire Line
	4050 2650 3950 2650
Connection ~ 4050 2650
Connection ~ 2650 2650
Wire Wire Line
	3550 2650 3150 3050
Wire Wire Line
	3150 3050 2950 3050
Wire Wire Line
	3150 2650 3550 3050
Wire Wire Line
	3550 3050 3750 3050
Wire Wire Line
	4050 3250 4050 3350
Wire Wire Line
	2650 3250 2650 3350
Wire Wire Line
	2650 3750 4050 3750
Wire Wire Line
	3350 3750 3350 4000
Connection ~ 3350 3750
$Comp
L PWR_FLAG #FLG03
U 1 1 57D01E2B
P 2500 1400
F 0 "#FLG03" H 2500 1495 50  0001 C CNN
F 1 "PWR_FLAG" H 2500 1580 50  0000 C CNN
F 2 "" H 2500 1400 50  0000 C CNN
F 3 "" H 2500 1400 50  0000 C CNN
	1    2500 1400
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR04
U 1 1 57D021C2
P 2500 1500
F 0 "#PWR04" H 2500 1250 50  0001 C CNN
F 1 "GND" H 2500 1350 50  0000 C CNN
F 2 "" H 2500 1500 50  0000 C CNN
F 3 "" H 2500 1500 50  0000 C CNN
	1    2500 1500
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1400 2500 1500
$Comp
L BARREL_JACK CON1
U 1 1 57D02787
P 1300 1400
F 0 "CON1" H 1300 1650 50  0000 C CNN
F 1 "BARREL_JACK" H 1300 1200 50  0000 C CNN
F 2 "Connect:BARREL_JACK" H 1300 1400 50  0001 C CNN
F 3 "" H 1300 1400 50  0000 C CNN
	1    1300 1400
	1    0    0    -1  
$EndComp
Wire Wire Line
	2500 1500 1600 1500
Wire Wire Line
	1600 1500 1600 1400
$Comp
L VCC #PWR05
U 1 1 57D02930
P 1600 1200
F 0 "#PWR05" H 1600 1050 50  0001 C CNN
F 1 "VCC" H 1600 1350 50  0000 C CNN
F 2 "" H 1600 1200 50  0000 C CNN
F 3 "" H 1600 1200 50  0000 C CNN
	1    1600 1200
	1    0    0    -1  
$EndComp
Wire Wire Line
	1600 1200 1600 1300
Wire Wire Line
	2950 1250 3150 1250
$Comp
L PWR_FLAG #FLG06
U 1 1 57D01E71
P 2950 1250
F 0 "#FLG06" H 2950 1345 50  0001 C CNN
F 1 "PWR_FLAG" H 2950 1430 50  0000 C CNN
F 2 "" H 2950 1250 50  0000 C CNN
F 3 "" H 2950 1250 50  0000 C CNN
	1    2950 1250
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR07
U 1 1 57D01EDD
P 3150 1250
F 0 "#PWR07" H 3150 1100 50  0001 C CNN
F 1 "VCC" H 3150 1400 50  0000 C CNN
F 2 "" H 3150 1250 50  0000 C CNN
F 3 "" H 3150 1250 50  0000 C CNN
	1    3150 1250
	1    0    0    -1  
$EndComp
$EndSCHEMATC
