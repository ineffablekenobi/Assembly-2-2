.MODEL SMALL
.STACK 100H
.DATA
CLASS   DB 'MARY ALLEN  ' ,67,45,98,33
        DB 'SCOTT BAYLIS',70,56,87,44
        DB 'GEORGE FRANK',82,72,89,40
        DB 'SAM WONG    ',78,76,92,60
              
LOOPCOUNT DW 0              
SUM DW 0
PRINTNUM DW ?

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    LEA SI, CLASS
  
    LOOPTHIS:
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    INC LOOPCOUNT
    CMP LOOPCOUNT, 4
    JG RETURN
    MOV CX,12
    
    PRINTNAME:
    MOV DL, [SI]
    INC SI
    MOV AH, 2
    INT 21H
    LOOP PRINTNAME
    MOV SUM, 0
    MOV CX, 4
    
    ADDALL:
    MOV AH, 0
    MOV AL, [SI]
    ADD SUM, AX
    INC SI
    LOOP ADDALL
    SHR SUM, 2
    MOV BX, SUM
    MOV PRINTNUM, BX
    JMP PN
    
    PRINTSTACK:
    CMP SP, 100H
    JE LOOPTHIS
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
        
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN