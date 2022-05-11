
#define __SFR_OFFSET 0x20
#include "avr/io.h"

.global start
.global work

start:

//SBI DDRB,5
//CBI PORTB,5
//SBI PORTB,0 //enables pull-up register

LDI R16,0x01
STS DDRB,R16
LDI R17,0x00
STS PORTB,R17

LDI R16, 0x00
STS TCCR1A, R16
RET

work:

LDI R16, 0xC2
STS TCNT1H, R16   
LDI R16, 0xF7
STS TCNT1L, R16 // Setting counter value F424
LDI R16,0x05 //prescalar value 1024 Bin 0101
STS TCCR1B,R16

//F424 = 62500
//writing C2F7 or F424 (16 bit) in 2*8 bit registers
//C2F7 = 49911 in decimal ? can also be used

L:
LDS R0,TIFR1
SBRS R0,0 //skips the rjump if ovf is 1 ::JUNK 
RJMP L //Loops ♾ly by resetting OVF 

LDI R16,0x00
STS TCCR1B,R16 //stops the counter
LDI R16,0x01
STS TIFR1,R16  //clears the OVF
COM R17
STS PORTB,R17
//SBI PORTB,5

RET 

/*
#define __SFR_OFFSET 0x20
  
#include "avr/io.h"

.global start
.global work

start:
  LDI R16, 0x01     ; Setting 1st bit of PORTB as output
  STS DDRB, R16
  LDI R17, 0x00
  STS PORTB, R17    ; Writing 0 to PORTB
  LDI R16, 0x00
  STS TCCR1A, R16   ; Setting all bits of TCCR1A as 0
  RET

work: 
  LDI R16, 0xC2
  STS TCNT1H, R16   ; Writing 0xC2 into TCNT1H (8-bit)
  LDI R16, 0xF7
  STS TCNT1L, R16   ; Writing 0xF7 into TCNT1H (8-bit)
  LDI R16, 0x05
  STS TCCR1B, R16   ; Writing 0x05 into TCCR1B
L:LDS R0, TIFR1     ; Load the value of TIFR1 into R0
  SBRS R0, 0        ; Skip the next statement if overflow has occured. 
  RJMP L            ; Loop until overflow occurs.
  LDI R16, 0x00
  STS TCCR1B, R16   ; Stop the Timer/Counter1
  LDI R16, 0x01
  STS TIFR1, R16    ; Clear the overflow flag by writing 1 to it
  COM R17           ; Complement R17 register
  STS PORTB, R17    ; Toggle the LED output
  RET
  */
