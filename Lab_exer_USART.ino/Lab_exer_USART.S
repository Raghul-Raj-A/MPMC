#define __SFR_OFFSET 0
#include "avr/io.h"
.global start
.global work

start:
LDI R16,0
STS UCSR0A,R16 // 7&6 bits are initially sets to 0 rx & tx flags
LDI R16,0X18
STS UCSR0B,R16 //4 & 3 bits are set to 1,to enable rx and tx
LDI R16,0X86  
STS UCSR0C,R16 //7 th bit set to 1 for ursel UR Register select and first 3 bits to 011 to set 8 bit
LDI R16,0
STS UBRR0H,R16 
LDI R16,0X67
STS UBRR0L,R16 //sets BAUD rate of 9600 ;; UBRR = (Frequency/(16*baud rate))
RET

work:

LDS R16,UCSR0A
ANDI R16,0X80 // check if data is received
BREQ work
ORI R16,0X80 //resets the flag
STS UCSR0A,R16
LDS R17,UDR0 // load data to R17
INC R17
STS UDR0,R17 //store manipulated data to UDR0

L1: LDS R17,UCSR0A
ANDI R17,0X40 //check if data is transmitted
BREQ L1
ORI R17,0X40 //resets flag 
STS UCSR0A,R17
RET 
