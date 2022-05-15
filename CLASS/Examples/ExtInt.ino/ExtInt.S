#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:

//stack initialisation
LDI R16, 0X04
OUT SPH, R16
LDI R16, 0X5F
OUT SPL, R16

SBI DDRB, 5
CBI DDRD, 2
SBI PORTD, 2
LDI R16, 0X40
STS GICR, R16
LDI R17, 0X02
STS MCUCR, R17

//JUMPS TO ISR ADDRESS 
work:

L1:
LDS R17, GIFR
ANDI R17, 0X40   // 0100 0000 
BREQ L1           //0100 0000
SBI PORTB, 5


SEI
L: RJMP L
