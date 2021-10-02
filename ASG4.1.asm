.MODEL SMALL
.STACK 100H
.DATA
    
    MSG1 DB "INPUT THE CHARACTER: $"
    MSG2 DB "CONVERTED CHARACTER IS : $"
    ANS DB ?
    

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    
    ;PRINT A MESSAGE
    MOV AH , 9
    LEA DX , MSG1
    INT 21H
    
    MOV AH,1
    INT 21H
    
    ADD AL,20H
    MOV ANS, AL
    
    ;PRINT A NEW LINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H 
    
    
    ;PRINT A MESSAGE
    MOV AH , 9
    LEA DX , MSG2
    INT 21H
    
    ;PRINT A NEW LINE
    MOV AH, 2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H 
    
    
    MOV AH,2
    MOV DL,ANS
    INT 21H
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN