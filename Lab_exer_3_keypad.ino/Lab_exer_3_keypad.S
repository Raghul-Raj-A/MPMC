# define __SFR_OFFSET 0
# include "avr/io.h"

.global start
.global work

start:
SBI DDRB,5 //Led Output
CBI DDRB,0 //DP 8  input
CBI DDRB,1 //DP 9  input
SBI DDRB,2 //DP 10 output
SBI DDRB,3 //DP 11 output
SBI PORTB,0 //enabling pull-up  
SBI PORTB,1 //""

work:
CBI PORTB,2 //clearing DP 10
SBI PORTB,3 //enabling DP 11
IN R16,PINB //getting status of PINB 
ANDI R16,0X0F //sets msb to 0
CPI R16,0X0A  //checks key "1" nibble 1010 
BRNE L1
SBI PORTB,5
RJMP L4

L1:
CPI R16,0X09 // check key "4" nibble 1001 
BRNE L2
SBI PORTB,5
RJMP L4

L2:
CBI PORTB,3
SBI PORTB,2

IN R16,PINB
ANDI R16,0X0F
CPI R16,0X06 //check key "2" nibble 0110
BRNE L3
CBI PORTB,5
RJMP L4

L3:
CPI R16,0X05 //checks key "5" nibble 0101
BRNE L4
CBI PORTB,5

L4:
RJMP work
