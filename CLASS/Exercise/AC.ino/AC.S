//ALP using ATmega 8 to turn on a timer when  external interrupt is triggered ar rising edge on timer ovf switch on the analog comp and when voltage across 
//PD7 AC0 is high,switch on the LED connected in PB5 using interrupt.

SBI DDDB,5
CBI PORTB,5
CBI DDRD,2
CBI DDRD,7
SBI PORTB,2
SBI PORTB,7

LDI R16, 0X04
OUT SPH, R16
LDI R16, 0X5F
OUT SPL, R16

LDI R16,0X03
STS MCUCR,R16
LDI R16,0X40
STS GICR,R16


SEI 
L: RJMP L


//ISR INT0

LDI R16,0X01
OUT TCCR0,R16
LDI R16,0X00
OUT TCNT0,R16
LDI R16,0X01
OUT TIMSK,R16

SEI
L1: RJMP L1
IRET


//ISR TIMER0 OVF

LDI R16,0X0A
OUT ACSR,R16

CBI DDRD,6
CBI DDRD,7

SEI 
L2: RJMP L2
IRET

//ISR AC

//SBI DDRB,5
SBI PORTB,5
L3:  RJMP L3
IRET
