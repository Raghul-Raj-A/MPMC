#define __SFR_OFFSET 0
#include "avr/io.h"

.global start
.global work

start:
SBI DDRB,5  //sets pb5 as input
CBI DDRB,0  //sets pb0 as output
SBI PORTB,0 //enables pull-up register
RET

work:
SBIS PINB,0 //check status of pin b if portb is 1 it skips the next step
SBI PORTB,5 //sets portb as HIGH
SBIC PINB,0 //check status of pin b if portb is 0 it skips the next step
CBI PORTB,5 //sets portb as HIGH
RET
