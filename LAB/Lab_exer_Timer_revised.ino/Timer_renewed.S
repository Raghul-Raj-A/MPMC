#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:
SBI DDRB,5 //LED output
CBI PORTB,5 //initially turned off LED
LDI R16,0X00
STS TCCR1A,R16 //sets every bit to 0 for normal port operation(last 2 bits)and first 2 bits in TCCR1A 
LDI R16,0X04
STS TCCR1B,R16 //sets prescalar value of 256 :: 0100
LDI R16,0XC2   //count value C2F7 for 1000ms
STS TCNT1H,R16
LDI R16,0XF7
STS TCNT1L,R16

work:
SBIS TIFR1,0 //if ovf is not set it loops until set
RJMP work
SBI TIFR1,0
SBIS PINB,5
SBI PORTB,5
SBIC PINB,5
CBI PORTB,5
RET
