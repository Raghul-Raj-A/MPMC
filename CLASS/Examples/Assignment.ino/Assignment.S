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


LDI R16,0X0E //PB1,PB2,PB3  E  RS  RW
OUT DDRB,R16
LDI R16,0X0F //PC0,PC1,PC2,PC3 D0 D1 D2 D3
OUT DDRC,R16
LDI R16,0X3C //PD2,PD3,PD4,PD5  D4 D5 D6 D7
OUT DDRD,R16

//PIXEL MATRIX 5*7
LDI R16,0X38
CALL COMMAND

//turn on LCD
LDI R16,0X01
CALL COMMAND

//cursor ON/cursor Blink
LDI R16,0X0E
CALL COMMAND 



work:
LDI R16,0X41
CALL DATA


L: RJMP L 

//default
COMMAND:
        MOV R1,R16
        ANDI R16,0X0F
        OUT PORTC,R16
        MOV R16,R1
        ANDI R16,0XF0
        OUT PORTD,R16
        
        LDI R16,0X02
        OUT PORTB,R16
        LDI R16,0X00
        OUT PORTB,R16
        CALL DELAY
        RET
DATA:
        MOV R1,R16
        ANDI R16,0X0F
        OUT PORTC,R16
        MOV R16,R1
        ANDI R16,0XF0
        OUT PORTD,R16
        
        LDI R20,0X06
        OUT PORTB,R20
        LDI R20,0X04
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
