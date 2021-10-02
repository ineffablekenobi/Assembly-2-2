.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0AH,0DH,'Enter 2 Capital Letters:',0AH,0DH,'$'
    MSG2 DB 0AH,0DH,'The letters are:',0AH,0DH,'$'
    INP DB ?         

.CODE


MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    
    PROCESS:
    
    MOV AH, 9
    LEA DX, MSG1
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV INP, AL
    INT 21H
    MOV BL,AL
    
    CMP BL,INP
    JL SWAP
    JMP PRINT
    
    SWAP:
    XCHG BL,INP
    
    PRINT:
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    MOV AH, 2
    MOV DL, INP
    INT 21H
    MOV DL, BL
    INT 21H
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN