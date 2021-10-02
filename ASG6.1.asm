.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0AH,0DH,'Enter a number in hex:',0AH,0DH,'$'
    MSG2 DB 0AH,0DH,'The number in decimal is: $'
    MSG3 DB 0AH,0DH,'Please enter a valid number',0AH,0DH,'$'
    MSG4 DB 0AH,0DH,'Do it again? : ',0AH,0DH,'$'
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
    
    CMP INP, '0'
    JL TRY_AGAIN
    CMP INP, '9'
    JG LETTER
    JMP PRINT_SD
    
    
    LETTER:
    CMP INP, 'A'
    JL TRY_AGAIN
    CMP INP, 'F'
    JG TRY_AGAIN
    JMP PRINT_DD
    
    
    PRINT_SD:
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    MOV AH,2
    MOV DL,INP
    INT 21H
    JMP CONTROL
    
    PRINT_DD:
    MOV AH, 9
    LEA DX, MSG2
    INT 21H
    MOV AH,2
    MOV DL,'1'
    INT 21H
    MOV DL,INP
    SUB DL,'A'
    ADD DL,'0'
    INT 21H
    JMP CONTROL
    
    
    TRY_AGAIN:
    MOV AH, 9
    LEA DX, MSG3
    INT 21H
    
    CONTROL:
    MOV AH, 9
    LEA DX, MSG4
    INT 21H
    MOV AH,1
    INT 21H
    MOV INP, AL
    CMP INP, 'Y'
    JNE RETURN
    JMP PROCESS   
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN