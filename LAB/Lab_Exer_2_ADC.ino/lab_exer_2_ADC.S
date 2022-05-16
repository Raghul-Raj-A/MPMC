#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

//CONNECTIONS : A0 - 5V

start:

SBI DDRB,5  //output LED
CBI DDRC,0  //anolog input pin 0 
CBI PORTB,5 //initially LED is turned Off
LDI R16,0X60 //CW : Avcc with ADLAR enabled
STS ADMUX,R16
LDI R16,0XE3 //CW : ADEN 1 ADSOC 1 ADFR 1 PS 8(0 1 1)
STS ADCSRA,R16

work:

LDS R17,ADCSRA
ANDI R17,0X10 //check/compare whether the interrupt flag is set or not 
//BREQ work     //loops if flag is set ::no need for single conversion
LDS R18,ADCH  
LDS R17,ADCSRA
ORI R17,0X10  //resetting ADIF 
STS ADCSRA,R17

CPI R18,0XFF  //checks ADCH only with 5v(ff) coz of ADLAR (5/5)*2^8
BRNE L1       //If not equal ,turns off LED
SBI PORTB,5   //if equal turn on the LED
RJMP L2
L1: CBI PORTB,5
L2: RET
