;REGISTER ADDRESSING MODE

MOV AX,1234
MOV BX,5678
ADD AX,BX
INT 3

;IMMEDIATE ADDRESSING MODE

MOV AX,1234
ADD AX,5678
INT 3

;DIRECT ADDRESSING MODE

MOV AX,1234
ADD AX,@3000
INT 3

;INDIRECT ADDRESSING MODE

MOV BX,8000
MOV AL,[BX]
INC BX
ADD AL,[BX]
INC BX
MOV [BX],AL
INT 3

;MULTIPLICATION
;8 bit                  16 bit
MOV AL,20               MOV AX,2000              
MOV DL,32               MOV BX,0032
MUL DL                  MUL BX
INT 3                   INT 3

;DIVISION
MOV AX,2244   ;(DX*AX)/BX  -- 16 BIT  
MOV BL,22      ;QUO - AX : REM - DX (32/16)
DIV BL         ;QUO - AL : REM - AH (16/8)
INT 3