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

//PIXEL MATRIX 5*7
LDI R16,0X38
OUT PORTD,R16
CALL COMMAND

//turn on LCD
LDI R16,0X01
OUT PORTD,R16
CALL COMMAND

//cursor ON/cursor Blink
LDI R16,0X0E
OUT PORTD,R16
CALL COMMAND 



work:

//DATA
/*LDI R16,0X41
OUT PORTD,R16
CALL DATA
LDI R16,0X43
OUT PORTD,R16
CALL DATA
LDI R16,'B'
OUT PORTD,R16
CALL DATA*/
LDI R16,'R'
OUT PORTD,R16
CALL DATA
LDI R16,'A'
OUT PORTD,R16
CALL DATA
LDI R16,'G'
OUT PORTD,R16
CALL DATA
LDI R16,'H'
OUT PORTD,R16
CALL DATA
LDI R16,'U'
OUT PORTD,R16
CALL DATA
LDI R16,'L'
OUT PORTD,R16
CALL DATA
L: RJMP L 

//default
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
