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
   LDI R16,0XFF
  		OUT DDRD,R16 ; configuring portd as output
  		CBI DDRB,3 ;configuring MOSI as input
                        CBI DDRB,5; configuring SCK as input
SBI DDRB,4 ; configuring MISO as output
CBI DDRB,2; configuring SS as input
		LDI R16,0X60
  		OUT SPCR,R16

forever:
            CONT:
  		SBIS SPSR,7; waiting for end of reception
  	            RJMP CONT
  		IN R17,SPDR ; reading data from data register
  		OUT PORTD,R17 ; writing data to portd
RJMP forever

