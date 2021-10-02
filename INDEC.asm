INDEC PROC
    PUSH BX
    PUSH CX
    PUSH DX
    
    BEGIN:
    MOV AH, 2
    MOV DL, '?'
    INT 21H                 ;PRINT ?
      
    XOR BX, BX              ;TOTAL (BX) = 0
    XOR CX, CX              ;NEGATIVE = FALSE (CX = 0)
    
    MOV AH, 1
    INT 21H                 ;TAKES A CHAR
    
    CMP AL, '-'             ;IS FIRST CHAR MINUS SIGN
    JE MINUS
    CMP AL, '+'
    JE PLUS                 ;IS FIRST CHAR PLUS SIGN
    JMP REPEAT2             ;IF NO SIGN JUMP TO REPEAT2
    
    MINUS:
    MOV CX, 1               ;NEAGTIVE = TRUE (CX = 1)
    
    PLUS:
    INT 21H                 ;NO NEED TO CHANGE, NEGATIVE = FALSE BY DEF
    
    REPEAT2:
    CMP AL, '0'
    JNGE NOT_DIGIT
    CMP AL, '9'
    JNLE NOT_DIGIT          ;CHECK IF CHAR IS BETWEEN 0 TO 9
    
    AND AX, 000FH           ;CONVERT ASCII TO INT
    PUSH AX                 ;STORE AX IN STACK
    MOV AX, 10              ;AX = 10
    MUL BX                  ;AX = AX * 10
    POP BX                  ;POP PREVIOUSLY STORED AX INTO BX
    ADD BX, AX              ;BX = BX + AX (TOTAL = TOTAL * 10 + INPUT)
    
    MOV AH, 1
    INT 21H                 ;TAKE ANOTHER INPUT
   
    CMP AL, 0DH             ;IF NOT CR, KEEP TAKING INPUT
    JNE REPEAT2
    
        
    MOV AX, BX              ;STORE TOTAL (BX) TO AX
    CMP CX, 0               ;IS NEGATIVE FALSE?
    JE EXIT                 ;IF NOT FALSE JUMP TO EXIT
    NEG AX                  ;OTHERWISE NEGATE AX
    
    EXIT:
    POP DX                  ;RESTORE THE VALUES
    POP CX
    POP BX
    RET                     ;RETURN
        
    NOT_DIGIT:
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    JMP BEGIN               ;IF NOT DIGIT, PRINT NEWLINE AND START AGAIN

INDEC ENDP                  ;END OF PROC INDEC