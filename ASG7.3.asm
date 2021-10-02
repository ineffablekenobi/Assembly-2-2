.MODEL SMALL
.STACK 100H
.DATA
    MSG1 DB 0AH,0DH,"Input the number: $"
    MSG2 DB 0AH,0DH,"The sum is: $"
    MSG3 DB 0AH,0DH,"Invalid character. Try again. $"
    MSG4 DB 0AH,0DH,"Unsigned overflow $"
    NUM DW 0
    NUM1 DW 0
    NUM2 DW 0
    INP DW 0
    MSK DW 256
    DIVISOR DW 2
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
    
    INPUT1:
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE  INP2
    MOV AH, 0
    MOV INP, AX
    JMP CHECK
    CHECK_PASS:
    SHL NUM1,4  ;; IS IT GOOD?
    MOV BX, INP
    OR NUM1, BX
    JMP INPUT1
    
    
    
    INP2:
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    
    INPUT2:
    INC CNT
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE  PRINT_NUM
    MOV AH, 0
    MOV INP, AX
    JMP CHECK
    CHECK_PASS1:
    SHL NUM2,4
    MOV BX, INP
    OR NUM2, BX
    JMP INPUT2
        
    JMP PRINT_NUM
    
    CHECK:
    DIGIT:
    CMP INP,'0'
    JL CHECK_FAIL
    CMP INP, '9'
    JG LETTER
    SUB INP, 48
    CMP CNT,0
    JE CHECK_PASS
    JMP CHECK_PASS1
    
    LETTER:
    CMP INP, 'A'
    JL CHECK_FAIL
    CMP INP, 'Z'
    JG CHECK_FAIL
    SUB INP,65
    ADD INP,10     
    CMP CNT,0
    JE CHECK_PASS
    JMP CHECK_PASS1
    
    CHECK_FAIL:
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    JMP RETURN
    
    OVERFLOW:
    CMP NUM1, 0
    JNE OVERFLOW_FAIL
    CMP NUM2, 0
    JE OVERFLOW_PASS
    OVERFLOW_FAIL:
    MOV AH,9
    LEA DX,MSG4
    INT 21H
    JMP RETURN
    
    
    PRINT_NUM:
    MOV BX, NUM1
    ADD NUM , BX
    MOV BX, NUM2
    ADD NUM , BX
    CMP NUM, 0
    JE OVERFLOW
    
    OVERFLOW_PASS:
    
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
    ADD DL, 65
    SUB DL, 10
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