;Square waveform generator

MOV AL,80
MOV DX,0FFE6 ;CONTROL REGISTER
OUT DX,AL

L:	
MOV AL,00
MOV DX,0FFE0 ;ADDRESS OF PORTA 
OUT DX,AL
CALL 3000
MOV AL,FF
MOV DX,0FFE0
OUT DX,AL
CALL 3000
JMP L

@3000:
MOV CL,FF
L:DEC CL
JNZ L
RET

OR

LOOP 3003
RET

08 00
09 30
0A 00

3000 : TWG