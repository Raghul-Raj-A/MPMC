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
   reti      ; Addr $05
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
   nop       ; Initialize here ports, stack pointer,
   nop       ; cleanup RAM, etc.
   nop       ;
   nop       ;

LDI R16, $04
OUT SPH,R16
LDI R16, $5F
OUT SPL,R16

  ldi R16,$FF
  OUT DDRD, R16
  ldi R16,$07
  OUT DDRB, R16
  ldi R16,$38
  OUT PORTD, R16
  CALL COMMAND
  CALL DELAY
  ldi R16,$01
  OUT PORTD, R16
  CALL COMMAND
  CALL DELAY
  ldi R16,$0E
  OUT PORTD, R16
  CALL COMMAND
  CALL DELAY

   ldi R16,$80
  OUT PORTD, R16
  CALL COMMAND
  CALL DELAY

  LDI R16, 'A'
  OUT PORTD, R16
  CALL DATA
  CALL DELAY
L: RJMP L

COMMAND:
 LDI R19,$01
OUT PORTB,R19
 LDI R19,$00
 OUT PORTB,R19
 CALL DELAY
 RET

DATA:
 LDI R20,$03
 OUT PORTB,R20
 LDI R20,$02
 OUT PORTB,R20
 CALL DELAY
 RET

 DELAY:

 RET






