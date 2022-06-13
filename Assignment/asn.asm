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
   rjmp l3   ; Addr $05
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
SBI DDRB,0 ;configure PB0 as I/P

;Stack pointer initialisation
LDI R16,0X04	
OUT SPH,R16
LDI R16,0X5F
OUT SPL,R16
;LCD Initialisation
LDI R16,0XFF
OUT DDRD,R16
LDI R16,0X0E
OUT DDRB,R16
;Display On 5*7 Matrix
LDI R16,0X38
OUT PORTD,R16
CALL COMMAND
;Clear Display screen
LDI R16,0X01
OUT PORTD,R16
CALL COMMAND
;Cursor on
LDI R16,0X0E
OUT PORTD,R16
CALL COMMAND

;IC
LDI R26,0X70	;X memory pointer initialisation
CLR R27
LDI R16,0X20	;enable IC interrupt enable
OUT TIMSK,R16
OUT TIFR,R16	;clearing ICF
LDI R16,0X00	
OUT TCCR1A,R16	;clearing TCCR1A
LDI R16,0X41	;edge select = 1;rising edge;clock source enabled
OUT TCCR1B,R16
SEI				;enables global interrupt
L:RJMP L

L3:
IN R18,ICR1L
IN R19,ICR1H
ST X+,R18
ST x+,R19
IN R0,TCCR1B
LDI R21,0X40
EOR R0,R21
OUT TCCR1B,R0

CPI R26,0X76
BRNE L5
LDI R17,0X00
OUT TIMSK,R17


;operation
LDI R28,0X70
CLR R29
LD R8,Y
LDI R28,0X72
CLR R29
LD R9,Y
LDI R28,0X74
CLR R29
LD R10,Y
SUB R8,R9
SUB R9,R10
CP R9,R8
BRLO L4
CALL OFF


L5:RETI

;LCD Command & data
ON:
LDI R16,'O'
OUT PORTD,R16
CALL DATA
LDI R16,'N'
OUT PORTD,R16
CALL DATA
RET

OFF:
LDI R16,'O'
OUT PORTD,R16
CALL DATA
LDI R16,'F'
OUT PORTD,R16
CALL DATA
LDI R16,'F'
OUT PORTD,R16
CALL DATA
RET


L4:
CALL ON
RET

COMMAND:
        LDI R16,0X02
        OUT PORTB,R16
        LDI R16,0X00
        OUT PORTB,R16
        CALL DELAY
        RET
DATA:
        LDI R20,0X06
        OUT PORTB,R20
        LDI R20,0X04
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

;Mission Accomplished





