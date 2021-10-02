OUTDEC PROC
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX         ;STORE THE VALUES OF REGISTERS
    
    CMP AX, 0       
    JGE ENDIF       ;IF POSITIVE, JUMP TO ENDIF
    

    PUSH AX         ;PUSH AX TO STACK
    MOV DL, '-'     
    MOV AH, 2
    INT 21H         ;PRINT MINUS SIGN
    
    POP AX          ;RESTORE THE VALUE OF AX
    NEG AX          ;NEGATE AX
    ENDIF:
    MOV CX, 0       ;INITIALIZE CX AS COUNTER
    MOV BX, 10D     ;BX = 10
    
    REPEAT:
    MOV DX, 0       ;CLEARING DX
    DIV BX          ;DIVIDE AX BY BX
    PUSH DX         ;PUSH DX TO STACK
    INC CX          ;COUNTER = COUNTER + 1 
    
    CMP AX, 0        
    JNE REPEAT      ;IF AX != 0 CALL REPEAT
        
    MOV AH, 2
    PRINT:
    POP DX          ;POP THE STORED DIGITS IN DX
    OR DL, 30H      ;CONVERT THE INT VALUE TO ASCII
    INT 21H
    LOOP PRINT      ;LOOP UNTIL COUNTER IS 0
   
    POP DX
    POP CX
    POP BX
    POP AX          ;RESTORE THE VALUES OF REGISTERS
    RET             ;RETURN
OUTDEC ENDP         ;END OF PROC OUTDEC