.MODEL SMALL
.STACK 100H
.DATA
    STRING DB 90 DUP (?)
    NEWLINE DB 0DH,0AH,'$'
    MSG1 DB "THE STRING IS A PALINDROME $"
    MSG2 DB "THE STRIN IS NOT A PALINDROME$"

.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    MOV ES, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    
    LEA DI, STRING
    CALL READ_STR
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    LEA SI, STRING
    CALL DISP_STR
    
    LEA DX, NEWLINE
    MOV AH, 9
    INT 21H
    
    CMP CX , 0
    JG NOTPALI
    
    PALINDROME:
    LEA DX, MSG1
    MOV AH, 9
    INT 21H
    JMP RETURN
    
    NOTPALI:
    LEA DX, MSG2
    MOV AH, 9
    INT 21H
        
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP

INCLUDE PrintStringNoPuncForBack.asm
INCLUDE ReadString.asm

END MAIN