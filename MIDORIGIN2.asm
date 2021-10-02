.MODEL SMALL
.STACK 100H
.DATA
    TOTAL EQU 10
    LETTER DB ?
    PREVIOUS_LETTER DB  ?
    NEXT_LETTER DB ?
    MSG1 DB 0AH,0DH,'THE LETTER IS: '
    MSG2 DB ? , ' THE PREVIOUS LETTER IS '
    MSG3 DB ? , ' THE NEXT LETTER IS '
    MSG4 DB ? , '$'

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
   
    
    MOV AH,1
    INT 21H
    
    MOV LETTER,AL
    MOV MSG2,AL
    INC AL
    MOV NEXT_LETTER,AL
    MOV MSG4,AL
    SUB AL,2
    MOV MSG3, AL
    MOV PREVIOUS_LETTER, AL
    
    
    MOV AH, 09H
    LEA DX, MSG1
    INT 21H
       
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN