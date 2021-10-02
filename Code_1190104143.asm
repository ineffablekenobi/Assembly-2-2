.MODEL SMALL
.STACK 100H
.DATA
    B EQU 5
    C DB 2
    A DB ?
    MSG DB 'THE VALUE OF A IS: '
    MSG1 DB ? , '$'

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    ;MUL AND DIV IS DONE WITH AL 
           
    MOV BL, C
    ADD BL, 1
    MOV AL, B
    SUB AL, BL
    MOV A, AL
    ADD AL,48
    MOV MSG1, AL
    
    MOV AH, 09H
    LEA DX,MSG
    INT 21H  
   
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN