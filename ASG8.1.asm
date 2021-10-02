.MODEL SMALL
.STACK 100H
.DATA
    
    STACK2 DW 50H
    SIZE1 DW 0
    SIZE2 DW 0
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    INPUT:
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE SECONDSTACK
    INC SIZE1
    MOV AH, 0
    PUSH AX
    JMP INPUT
    
    
    
    SECONDSTACK:
    CMP SIZE1, 0
    JE PROCESS
    DEC SIZE1
    INC SIZE2
    POP DX
    XCHG STACK2, SP
    PUSH DX
    XCHG STACK2, SP
    JMP SECONDSTACK
    
    PROCESS:
    MOV AH,2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    XCHG STACK2, SP
                   
    DO:
    CMP SIZE2, 0
    JE PRINTSTACK
    DEC SIZE2
    POP DX
    CMP DX, ' '
    XCHG STACK2, SP
    JE PRINTSTACK
    PUSH DX
    INC SIZE1
    PRINTDONE:
    CMP SIZE2, 0
    JE PRINTSTACK
    XCHG STACK2, SP
    JMP DO
    
    CHECK:
    CMP SIZE2, 0
    JE RETURN
    JMP PRINTDONE
    
    PRINTSTACK:
    MOV AH,2
    MOV DL, ' '
    INT 21H
    
    PRINT:
    CMP SIZE1, 0
    JE CHECK
    DEC SIZE1
    POP DX
    MOV AH,2
    INT 21H
    JMP PRINT
    
                   
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN