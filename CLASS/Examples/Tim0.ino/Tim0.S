#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:


work:

L1:
LDI R16, 0X01
STS TCCR0, R16
LDI R16, OX38
STS TCNT0, R16

L:
LDS R16, TIFR
ANDI R16, 0X01
BREQ L

LDI R16, 0X00
STS TCCR0, R16
LDI R16, 0X01
STS TIFR, R16
RJMP L1
