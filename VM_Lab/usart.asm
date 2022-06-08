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
      rjmp  RX       ; Addr $0B        This is just an example
   reti      ; Addr $0C        Not all MCUs have the same
      rjmp  TX            ; Addr $0D        number of interrupt vectors
   reti      ; Addr $0E
   reti      ; Addr $0F
   reti      ; Addr $10

; Program starts here after Reset
;
start:
  LDI R16,0X04;
  OUT SPH, R16;
  LDI R16,0X5F;
  OUT SPL,R16;

  LDI R16,0X02;
  OUT DDRD,R16;
  LDI R16,0X00;
  OUT UCSRA,R16;
  LDI R16,0XD8;
  OUT UCSRB,R16;
  LDI R16,0X86;
  OUT UCSRC,R16;
  LDI R16,0X00;
  OUT UBRRH,R16;
  LDI R16,0X06;
  OUT UBRRL,R16;
  SEI;

forever:



rjmp forever

RX:  IN R17,UDR;
        inc r17
        out udr,r17
         RETI;

TX:
        RETI;




