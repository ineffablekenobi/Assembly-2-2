.MODEL SMALL
.STACK 100H
.DATA
    ARR DB 5,6,10,8,2,3
    IND DB 2
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    ;;CALL INDEC
    
    LEA SI, ARR
    MOV BX, 6
    CALL SELECT
    
    MOV CX, 6
    MOV SI, 0
    PRINTARR:
    MOV AH, 0
    MOV AL, [SI]
    CALL OUTDEC
    INC SI
    LOOP PRINTARR
        
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

;;INCLUDE InsertionSortReverse.asm
INCLUDE SELECTIONSORT.asm
INCLUDE INDEC.asm
INCLUDE OUTDEC.asm
INCLUDE NEWLINE.asm

END MAIN