#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:
SBI DDRB,1 //sets DP 9 as output CONTAINS OC1A
CBI DDRD,2 //sets DP 2 as input
SBI PORTD,2// enables pull-up
SBI DDRB,5 //LED as output
CBI PORTB,5
LDI R16,0X00 
STS OCR1AH,R16 //initially sets all bits to 0
STS OCR1AL,R16 // "  "
LDI R16,0X81
STS TCCR1A,R16//sets last bits to 1,0 to clear OC1A/OC1B on compare match & last 2 bits to 0,1 for PWM phase correct 8-bit,
    /*^Set OC1A/OC1B on compare match when up-counting. Clear OC1A/OC1B on compare match when down counting*/
LDI R19,0X01
STS TCCR1B,R19// 001 no pre-scaling
LDI R17,0X40
LDI R18,0XFF
RET

work:

SBIS PIND,2
STS OCR1AL,R17
SBIC PIND,2
STS OCR1AL,R18
SBIS PINB,1
CBI PORTB,5
SBIC PINB,1
SBI PORTB,5
RET
