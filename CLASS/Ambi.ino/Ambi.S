#define __SFR_OFFSET 0
#include "avr/io.h"

start:
ldi r16,0x04
out sph,r16
ldi r16,0x5F
out spl,r16
ldi r16,'S'
sts 0x60,r16
SBI PORTB,0 //enables internal pull up 
SBI DDRD,6  //sets DP 6 as output OC0A
SBI PORTD,6 //enables pull-up
CBI PORTB,5 //initially turns off LED

LDI R16,0X00 //initially set TCNT1L & TCNT1H as 0
ldi r16,'A'
sts 0x61,r16
ldi r16,'S'
sts 0x62,r16
ldi r16,'T'
sts 0x63,r16
ldi r16,'R'
sts 0x64,r16
ldi r16,'A'
sts 0x65,r16

ldi r16,0x48
out tcnt1h,r16
ldi r16,0xe5
out tcnt1l,r16
ldi r16,0x00
out tccr1a,r16
ldi r16,0x03
out tccr1b,r16

l1: lds r16,tifr
andi r16,0x04
brne l1
ldi r16,0x04
sts tifr,r16

ldi r16,0xff
out ddrd,r16
ldi r16,0x07
out ddrb,r16
ldi r16,0x38
out portd,r16
call command
ldi r16,0x01
out portd,r16
call command
ldi r16,0x0e
out portd,r16
call command

ldi r26,0x60
clr r27
ldi r16,0x06
l2: ld r0,x+
out portd,r0
call data
brne l2

ldi r16,0x48
out tcnt1h,r16
ldi r16,0xe5
out tcnt1l,r16
ldi r16,0x00
out tccr1a,r16
ldi r16,0x03
out tccr1b,r16

l3: lds r16,tifr
andi r16,0x04
brne l3
ldi r16,0x04
sts tifr,r16

ldi r16,0x01
out portd,r16
call command
l:rjmp l



command:
ldi r19,0x01
out portb,r19
ldi r19,0x00
out portb,r19
call delay

data:
ldi r20,0x03
out portb,r20
ldi r20,0x02
out portb,r20
call delay

delay:
ldi r17,0xff
l5:ldi r18,0xff
l4:dec r18
brne l4
dec r17
brne l5
ret
