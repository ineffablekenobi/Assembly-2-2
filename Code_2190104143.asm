.MODEL SMALL
.STACK 100H
.DATA
    TOTAL EQU 10
    GREEN DB 3
    PURPLE DB 5
    ORANGE DB ?
    MSG0 DB 'TOTAL BOX CAPACITY IS 10'
    MSG1 DB 0AH,0DH,'GREEN '
    MSG2 DB ?, ' BALLS',0AH,0DH,'PURPLE '
    MSG3 DB ?, ' BALLS',0AH,0DH,'WHITE '
    MSG4 DB ?, ' BALLS$'

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
   
    
    MOV AL,GREEN
    ADD AL,PURPLE
    MOV BL,TOTAL
    SUB BL,AL
    ADD BL,48
    
    
    ADD GREEN,48
    ADD PURPLE,48
    MOV BH,GREEN
    MOV MSG2, BH
    MOV BH,PURPLE
    MOV MSG3, BH
    MOV MSG4, BL
    
    MOV AH, 09H
    LEA DX, MSG0
    INT 21H
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN