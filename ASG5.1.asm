.MODEL SMALL
.STACK 100H
.DATA

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    MOV AX, 7FFFH
    MOV BX, 0001H
    ADD AX,BX
    
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

END MAIN