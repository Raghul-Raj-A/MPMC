#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:
CBI DDRB,0 //sets DP 8 as input ICP1
SBI DDRB,5 //sets LED output
SBI PORTB,0 // 
SBI DDRD,6 //sets DP 6 as output OC0A
SBI PORTD,6 //enables pull-up
CBI PORTB,5 //initially turns off LED

LDI R16,0X00 //initially set TCNT1L & TCNT1H as 0
STS TCNT1L,R16
STS TCNT1H,R16
STS TCCR1A,R16 // set every bit to 0 for normal mode of operation
LDI R17,0XC1 //set last 2 bit to set oc0a on compare match and 0th bit to enable PWM phase correct 
OUT TCCR0A,R17
LDI R17,0X01 // 001 no pre-scaling
OUT TCCR0B,R17

LDI R17,0XF0 //Threshold : 7D :: CHECK BY +- THRESHOLD
OUT OCR0A,R17 //it'll generate waveform output on OC0A pin
LDI R18,0X41 //CHANGED :: PS DOESN'T MATTERS
STS TCCR1B,R18 // set 6th bit to 1 to enable input capture edge,and PS 8 010

L:
SBIS TIFR1,5 //checks the 5th bit if flag is set or not 
RJMP L
SBI TIFR1,5 //resets the flag
LDI R16,0X01
STS TCCR1B,R16 // set to no PS

L1:
SBIS TIFR1,5
RJMP L1
LDI R16,0X00
STS TCCR1B,R16 // NO CLOCK
LDS R16,ICR1L //check DP 8 value and updates the counter
CP R16,R17   //compare R16 value with threshold
BRLO L3
SBI PORTB,5
L3: RET

work:

RET
