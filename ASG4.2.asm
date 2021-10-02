.MODEL SMALL
.STACK 100H
.DATA
    
    MSG1 DB "INPUT 2 NUMBERS: $"
    MSG2 DB "THE SUM IS : $"
    
    

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
    MOV BL , AL
    
    SUB BL,48
    
    INT 21H
    
    SUB AL, 48
    
    ADD BL, AL
    
    ADD BL,48
    
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
    MOV DL,BL
    INT 21H
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN