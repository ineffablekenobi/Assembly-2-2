.MODEL SMALL
.STACK 100H
.DATA
    STRING DB 100 DUP (?)
    NEWLINE DB 0DH,0AH,'$'
    S DW ?
    N DW ?
    STRLEN DW ?
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    
    LEA DI, STRING
    CALL READ_STR
    
    MOV STRLEN, BX
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    CALL INDEC
    
    MOV S, AX
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    CALL INDEC
    
    MOV N , AX
    
    
    MOV CX, AX ;; NUMBER OF DELETIONS
    INC CX
    LEA SI, STRING
    MOV DI, SI
    
    WHILE:
    
    MOV SI, DI
    MOV AX, S
    ADD SI, AX
    CMP CX, 0
    DEC CX
    JE PRINT
 
    COPY:
    CMP AX, STRLEN
    JE DELETED ;; STRING LENGTH EXCEEDED
    MOV BX, [SI + 1] 
    MOV [SI], BX
    INC AX
    INC SI
    JMP COPY
    
    DELETED:
    DEC STRLEN
    MOV AX, STRLEN
    MOV SI, DI
    ADD SI, AX
    MOV [SI], '$'
    JMP WHILE
    
    PRINT:
    MOV AH, 9
    LEA DX, STRING
    INT 21H
        
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

INCLUDE INDEC.asm
INCLUDE ReadString.asm

END MAIN