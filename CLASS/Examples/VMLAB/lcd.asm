; ******************************************************
; BASIC .ASM template file for AVR
; ******************************************************

.include "C:\VMLAB\include\m32def.inc"

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
LDI R16,0X04
OUT SPH,R16
LDI R16,0X5F
OUT SPL,R16

LDI R16,0XFF
OUT DDRD,R16
LDI R16,0X07
OUT DDRB,R16


LDI R16,0X38
OUT PORTD,R16
CALL COMMAND


LDI R16,0X01
OUT PORTD,R16
CALL COMMAND


LDI R16,0X0E
OUT PORTD,R16
CALL COMMAND    ;

forever:
LDI R16,'A'
OUT PORTD,R16
CALL DATA
LDI R16,'B'
OUT PORTD,R16
CALL DATA
LDI R16,'C'
OUT PORTD,R16
CALL DATA

L: RJMP L

rjmp forever

COMMAND:
        LDI R16,0X01
        OUT PORTB,R16
        LDI R16,0X00
        OUT PORTB,R16
        CALL DELAY
        RET
DATA:
        LDI R20,0X03
        OUT PORTB,R20
        LDI R20,0X02
        OUT PORTB,R20
        CALL DELAY
        RET
DELAY:
        LDI R17,0XFF
        L1: LDI R18,0XFF
        L2: DEC R18
        BRNE L2
        DEC R17
        BRNE L1
        RET
