.MODEL SMALL
.STACK 100H
.DATA
    CNT DW 0
    M DW 0
    N DW 0
    MULTI DW 1
    PRINTNUM DW 0
    PRCN DW 0
    MSG1 DW "ENTER M: $"
    MSG2 DW 0AH,0DH,"ENTER N: $"
    MSG3 DW 0AH,0DH,"THE GCD IS: $"

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    MOV AH, 9
    LEA DX,MSG1
    INT 21H
    
    INPUT1:
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE MAKENUM1
    MOV AH, 0
    SUB AL, 48
    PUSH AX
    INC CNT
    JMP INPUT1
    
    
    MAKENUM1:
    CMP CNT, 0
    JE INPUTSWITCH
    DEC CNT
    MOV DX, 0
    POP AX
    MUL MULTI
    ADD M, AX
    MOV AX, 10
    MUL MULTI
    MOV MULTI, AX
    JMP MAKENUM1
    
    INPUTSWITCH:
    MOV AH, 9
    LEA DX,MSG2
    INT 21H
    
    INPUT2:
    MOV MULTI, 1
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE MAKENUM2
    MOV AH, 0
    SUB AL, 48
    PUSH AX
    INC CNT
    JMP INPUT2
    
    MAKENUM2:
    CMP CNT, 0
    JE GCD
    DEC CNT
    MOV DX, 0
    POP AX
    MUL MULTI
    ADD N, AX
    MOV AX, 10
    MUL MULTI
    MOV MULTI, AX
    JMP MAKENUM2
    
    
    PRINTCONTROL:
    INC PRCN
    CMP PRCN, 1
    JMP RETURN
    
    PRINTSTACK:
    CMP SP, 100H
    JE PRINTCONTROL
    POP DX
    MOV AH,2
    INT 21H
    JMP PRINTSTACK
    
    PN:
    CMP PRINTNUM, 0
    JE PRINTSTACK
    MOV CX, DX
    MOV DX, 0
    MOV AX, PRINTNUM
    MOV BX, 10
    DIV BX
    MOV PRINTNUM, AX
    MOV DH, 0
    ADD DL, 48
    PUSH DX
    MOV DX, CX
    JMP PN
    
    GCD:
    MOV AH, 9
    LEA DX,MSG3
    INT 21H
    
    PROCESS:
    MOV DX, 0
    MOV AX, M
    MOV BX, N
    DIV BX
    CMP DX, 0
    MOV PRINTNUM, BX
    JE PN
    MOV M, BX 
    MOV N, DX
    JMP PROCESS
   
    RETURN:  
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN