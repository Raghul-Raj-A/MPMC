// ***********************************************************
// Project:
// Author:
// Module description:
// ***********************************************************

#include <avr\io.h>              // Most basic include files
#include <avr\interrupt.h>       // Add the necessary ones
#include <avr\signal.h>          // here

// Define here the global static variables
//
int My_global;

// Interrupt handler example for INT0
//
SIGNAL(SIG_INTERRUPT0) {

}

// It is recommended to use this coding style to
// follow better the mixed C-assembly code in the
// Program Memory window
//
void my_function(void) {  // Put the open brace '{' here

   asm("nop");          // Inline assembly example
}

// ***********************************************************
// Main program
//
int main(void){
DDRD=0x3F;
DDRC=0X01;
PORTC=0X01;
while(1)
{
a=(ACSR&0x20);                              //check if ACO=1
if(a==0x20)
PORTC=0X00;
else
PORTC=0X01;
}


}

