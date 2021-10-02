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
    
    CALL INDEC
    
    CALL PRINTLN
    
    CALL OUTDEC
    
        
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

INCLUDE INDEC.asm
INCLUDE OUTDEC.asm
INCLUDE NEWLINE.asm

END MAIN