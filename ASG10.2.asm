.MODEL SMALL
.STACK 100H
.DATA
  MAPTO DB 97 DUP(?),'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  MSG DB 0AH, 0DH, "THE MESSAGE IS: $"
  MAPPED DB 100 DUP('$')
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
  
    LEA SI, MAPTO
    MOV AX, 0
    MOV CX, 96
    
    FILL:
    MOV [SI] , AL
    INC AX
    INC SI
    LOOP FILL 
    
    LEA BX, MAPTO
    LEA SI, MAPPED
        
    INPUT:
    MOV AH, 1
    INT 21H
    CMP AL, 0DH
    JE PRINT
    XLAT
    MOV [SI], AL
    INC SI
    JMP INPUT
    
    PRINT:
    LEA DX,MSG
    MOV AH, 9
    INT 21H
    LEA DX, MAPPED
    INT 21H
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN