; ******************************************************
; BASIC .ASM template file for AVR
; ******************************************************

.include "C:\VMLAB\include\m8def.inc"

; Define here the variables
;
.def  temp  =r16

; Define here Reset and interrupt vectors, if any
;
reset:
   rjmp start
   reti      ; Addr $01
   reti      ; Addr $02
   reti      ; Addr $03
   reti      ; Addr $04
   rjmp ISR      ; Addr $05
   reti      ; Addr $06        Use 'rjmp myVector'
   reti      ; Addr $07        to define a interrupt vector
   reti      ; Addr $08
   reti      ; Addr $09
   reti      ; Addr $0A
   reti      ; Addr $0B        This is just an example
   reti      ; Addr $0C        Not all MCUs have the same
   reti      ; Addr $0D        number of interrupt vectors
   reti      ; Addr $0E
   reti      ; Addr $0F
   reti      ; Addr $10

; Program starts here after Reset
;
start:
 cbi ddrb,0
 ldi r16,0x04
 out sph,r16

  ldi r16,0x5f
 out spl,r16
 ldi r26,0x70
 clr r27
 ldi r16,0x20
 out timsk,r16
 out tifr,r16
 ldi r17,0x00
 out tccr1a,r17

 ldi r17,0x01
 out tccr1b,r17
 sei
 l:rjmp l

ISR: in r18,icr1l
in r19,icr1h
st x+,r18
st x+,r19
in r0,tccr1b
ldi r21,0x40
eor r0,r21
out tccr1b,r0
cpi r26,0x76
brne l5
ldi r17,0x00
out timsk,r17
l5:reti
