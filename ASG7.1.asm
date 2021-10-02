.MODEL SMALL
.STACK 100H
.DATA
    
    MSG1 DB "Input a character: $"
    MSG2 DB 0AH,0DH,"The Binary is: $"
    MSG3 DB 0AH,0DH,"NUMBER OF ONES: $"
    CNT DB 48
    INP DB ?
    MSK DB 128d

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AH,1
    INT 21H
    
    MOV BL,AL
    MOV INP, AL
    
    MOV BH,2
    
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    
    DO:
    CMP MSK,0
    JE COUNTS
    MOV AH, 0
    MOV AL, MSK
    AND MSK, BL
    DIV BH
    CMP MSK,0
    MOV MSK,AL
    JE PRINT_0
    JMP PRINT_1   
    
    PRINT_1:
    INC CNT
    MOV AH,2
    MOV DL, '1'
    INT 21H
    JMP DO
    
    PRINT_0:
    MOV AH,2
    MOV DL, '0'
    INT 21H
    JMP DO
    
    COUNTS:
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    
    MOV AH,2
    MOV DL, CNT
    INT 21H
    
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN