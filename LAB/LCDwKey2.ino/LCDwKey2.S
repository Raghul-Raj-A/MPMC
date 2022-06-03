#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

/*
 * ##CONNECTIONS
 * 
 * VSS - GND
 * VDD - 5V
 * VEE - GND(CONTRAST)
 * RS - PB1 (9)
 * R/W - PB2(10)
 * E - PB0(8)
 * D0 
 * D1
 * D2
 * D3    -- PD0-PD7
 * D4
 * D5
 * D6
 * D7
 * A - 5V
 * K - GND
 */

start:

//Loading stack pointer
LDI R16,0X04
OUT SPH,R16
LDI R16,0X5F
OUT SPL,R16

LDI R16,0XFF //Sets all pin as output 
OUT DDRD,R16 
LDI R16,0X07 //sets PB 0,1,2 as output
OUT DDRB,R16



//KEYPAD
SBI DDRB,5 //Led Output
CBI DDRC,0 //AP 0  input
CBI DDRC,1 //AP 1  input
SBI DDRC,2 //AP 2 output
SBI DDRC,3 //AP 3 output
SBI PORTC,0 //enabling pull-up  
SBI PORTC,1 //""

/*
 * KP  AP
 * 7    A0
 * 6    A1
 * 3    A2
 * 4    A3
 */

work:

// KEYPAD

CBI PORTC,2
SBI PORTC,3
IN R16,PINC
ANDI R16,0x0F

CPI R16,0x0A
BRNE L5

CALL LCD_ON
CALL BOUNCEDELAY
RJMP L8

L5:
CPI R16,0x09
BRNE L6
CALL RTL
CALL BOUNCEDELAY
RJMP L8

L6:
CBI PORTC,3
SBI PORTC,2
IN R16,PINC
ANDI R16,0x0F

CPI R16,0x06
BRNE L7

//CALL C

CALL BOUNCEDELAY
RJMP L8

L7:
CPI R16,0x05
BRNE L8

//CALL D

CALL BOUNCEDELAY
L8:
RJMP work
L: RJMP L 

//Functions
LCD_ON:

//TURNS ON LCD
LDI R16,0X0F
OUT PORTD,R16
CALL COMMAND

//PIXEL MATRIX 5*7
LDI R16,0X38
OUT PORTD,R16
CALL COMMAND

//clears the screen
LDI R16,0X01
OUT PORTD,R16
CALL COMMAND

//ACTIVATES 2ND LINE /ROW
LDI R16,0X3C
OUT PORTD,R16
CALL COMMAND

//cursor ON/cursor Blink
LDI R16,0X0E
OUT PORTD,R16
CALL COMMAND 

RET


LTR:
LDI R16,0X80
OUT PORTD,R16
CALL COMMAND

LDI R16,'A'
OUT PORTD,R16
CALL DATA

LDI R16,'B'
OUT PORTD,R16
CALL DATA

LDI R16,'C'
OUT PORTD,R16
CALL DATA

LDI R16,'D'
OUT PORTD,R16
CALL DATA

RET

RTL:

LDI R16,0X83
OUT PORTD,R16
CALL COMMAND

//DECREMENT CURSOR FROM RIGHT TO LEFT
//LDI R16,0X04
//OUT PORTD,R16
//CALL COMMAND

LDI R16,'D'
OUT PORTD,R16
CALL DATA

LDI R16,'C'
OUT PORTD,R16
CALL DATA

LDI R16,'B'
OUT PORTD,R16
CALL DATA

LDI R16,'A'
OUT PORTD,R16
CALL DATA

RET

COMMAND:
        LDI R16,0X01
        OUT PORTB,R16
        LDI R16,0X00
        OUT PORTB,R16
        CALL DELAY
        RET
DATA:
        LDI R20,0X03
        OUT PORTB,R20
        LDI R20,0X02
        OUT PORTB,R20
        CALL DELAY
        RET
DELAY:
        LDI R17,0XFF
        L1: LDI R18,0XFF
        L2: DEC R18
        BRNE L2
        DEC R17
        BRNE L1
        RET

DELAYT:
        LDI R21, 0XFF
        L10:LDI R22,0XFF
        L11:LDI R23,0XFF
        L12:DEC R23
        BRNE L12
        L13:DEC R22
        BRNE L13
        DEC R21
        BRNE L10
        RET

BOUNCEDELAY:
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        CALL DELAYT
        RET



/* 
Hex Code Command to LCD Instruction Register

0F LCD ON, cursor ON

01  Clear display screen

02  Return home

04  Decrement cursor (shift cursor to left)

06  Increment cursor (shift cursor to right)

05  Shift display right

07  Shift display left

0E  Display ON, cursor blinking

80  Force cursor to beginning of first line

C0  Force cursor to beginning of second line

38  2 lines and 5×7 matrix

83  Cursor line 1 position 3

3C  Activate second line

08  Display OFF, cursor OFF

C1  Jump to second line, position 1

OC  Display ON, cursor OFF

C1  Jump to second line, position 1

C2  Jump to second line, position 2

*/
