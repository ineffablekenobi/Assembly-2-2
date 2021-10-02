.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0AH,0DH,"Input the number: $"
    MSG2 DB 0AH,0DH,"The sum is: $"
    MSG3 DB 0AH,0DH,"Invalid character. Try again. $"
    MSG4 DB 0AH,0DH,"Unsigned overflow $"
    NUM DW 0
    INP DW 0
    MSK DW 256
    CNT DB 0
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    INPUT:
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE  PRINT_NUM
    MOV AH, 0
    MOV INP, AX
    JMP CHECK
    CHECK_PASS:
    SUB INP, 48
    MOV BX, NUM
    ADD BX, INP
    MOV NUM, BX
    JMP INPUT
    
    
    CHECK:
    DIGIT:
    CMP INP,'0'
    JL CHECK_FAIL
    CMP INP, '9'
    JG CHECK_FAIL
    JMP CHECK_PASS
    
    CHECK_FAIL:
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    JMP RETURN
    
    
    PRINT_NUM:
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    MOV MSK, 1111b
    MOV CL, 12
    MOV AH, 2
    
    DO:
    MOV BX, NUM
    SHR BX, CL
    AND BX, MSK
    MOV DL, BL
    CMP DL, 9
    JLE ADD48
    SUB DL,10
    ADD DL, 65
    PRINT:
    INT 21H
    SUB CL, 4
    CMP CL, 0
    JL RETURN
    JMP DO
    
    ADD48: 
    ADD DL, 48
    JMP PRINT
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN