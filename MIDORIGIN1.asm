.MODEL SMALL
.STACK 100H
.DATA
    TOTAL EQU 10
    A DB 3
    X DB ?
    Y DB ?
    MSG DB 0DH,0AH,"THE NUMBER IS: $"
    BALANCE DB 2    

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    
    
    MOV AH,1
    INT 21H
    
    MOV X, AL
    
    MOV AH,1
    INT 21H
    
    MOV Y, AL
    
    MOV AH, 9
    LEA DX, MSG
    INT 21H    
    
    
    
    
    MOV BL,X
    ADD BL,Y
    
    ADD BALANCE,48
    
    SUB BL,BALANCE
    
    
    MOV AH, 2
    MOV DL, BL
    INT 21H
    
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN