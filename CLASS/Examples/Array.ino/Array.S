#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:

work:

LDI R1,0X00
LDI R26,OX60
CLR R27
LDI R16,0X0A
L:
  LDS R0,X+
  ADD R1,R0
  DEC R16
  BRNE L1
  STS OX6A,R1
  RET
