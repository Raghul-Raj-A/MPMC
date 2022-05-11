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


work:

LDI R16, 0X01
STS TCCR0, R16
LDI R16, OX38
STS TCNT0, R16
LDI R16,0X01
STS TIMSK,R16



SEI
L: RJMP L

ISR ADDRESS:
  LDI R16,0X38
  STS TCNT0,R16
  IRET
