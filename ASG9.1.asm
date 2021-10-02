.MODEL SMALL
.STACK 100H
.DATA
    CNT DW 0
    NUM DW 0
    MULTI DW 1
    PRINTNUM DW 0
    PRCN DW 0
    MSG1 DW 0AH, 0DH, "HOURS: $"
    MSG2 DW 0AH, 0DH, "MINUTES: $"
    MSG3 DW 0AH,0DH,"SECONDS: $"

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
    JE MAKENUM
    MOV AH, 0
    SUB AL, 48
    PUSH AX
    INC CNT
    JMP INPUT
    
    
    MAKENUM:
    CMP CNT, 0
    JE PROCESS
    DEC CNT
    MOV DX, 0
    POP AX
    MUL MULTI
    ADD NUM, AX
    MOV AX, 10
    MUL MULTI
    MOV MULTI, AX
    JMP MAKENUM
    
    PRINTCONTROL:
    INC PRCN
    CMP PRCN, 1
    JE PRINTMINUTES
    CMP PRCN,2
    JE PRINTSECONDS
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
    
    
    PROCESS:
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV AX, NUM 
    MOV DX, 0
    MOV BX, 3600
    DIV BX
    
    MOV PRINTNUM, AX
    MOV NUM, DX
    JMP PN
    
    PRINTMINUTES:
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    MOV DX, 0
    MOV AX, NUM
    MOV BX, 60
    DIV BX
    
    MOV PRINTNUM, AX
    MOV NUM, DX
    JMP PN
    
    PRINTSECONDS:
    MOV PRINTNUM, DX
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    JMP PN
   
    RETURN:  
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN