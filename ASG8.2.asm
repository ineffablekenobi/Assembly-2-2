.MODEL SMALL
.STACK 100H
.DATA
   ROUND DB 0
   CURLY DB 0
   SQUARE DB 0 
   MSG1 DB 0AH,0DH,"TO MANY LEFT BRACKETS",0AH,0DH, "$" 
   MSG2 DB 0AH,0DH,"TO MANY RIGHT BRACKETS",0AH,0DH,"$"
   MSG3 DB 0AH,0DH,"MISMATCH BETWEEN LEFT AND RIGHT BRACKETS", 0AH, 0DH, "$"
   MSG4 DB 0AH,0DH,"PRESS Y TO CONTINUE", 0AH, 0DH, "$"
   MSG5 DB 0AH,0DH,"EXPRESSION IS CORRECT", 0AH, 0DH, "$"
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    PROCESS:
    MOV ROUND, 0
    MOV CURLY, 0
    MOV SQUARE, 0
    
    INPUT:
    MOV AH,1
    INT 21H
    CMP AL, 0DH
    JE CHECK
    CMP AL,'('
    JE PUSHROUND
    CMP AL, ')'
    JE POPROUND
    CMP AL,'{'
    JE PUSHCURLY
    CMP AL, '}'
    JE POPCURLY
    CMP AL,'['
    JE PUSHSQUARE
    CMP AL, ']'
    JE POPSQUARE
    
    JMP INPUT
    
    
    PUSHROUND:
    MOV AH, 0
    PUSH AX
    INC ROUND
    JMP INPUT
    
    POPROUND:
    DEC ROUND
    CMP ROUND,0
    JL CHECK
    POP DX
    CMP DX, '('
    JNE MATCHFAIL
    JMP INPUT
    
    PUSHCURLY:
    MOV AH, 0
    PUSH AX
    INC CURLY
    JMP INPUT
    
    POPCURLY:
    DEC CURLY
    CMP CURLY,0
    JL CHECK
    POP DX
    CMP DX, '{'
    JNE MATCHFAIL
    JMP INPUT
    
    PUSHSQUARE:
    MOV AH, 0
    PUSH AX
    INC SQUARE
    JMP INPUT
    
    POPSQUARE:
    DEC SQUARE
    CMP SQUARE,0
    JL CHECK
    POP DX
    CMP DX, '['
    JNE MATCHFAIL
    JMP INPUT
    
    MATCHFAIL:
    MOV AH,9
    LEA DX, MSG3
    INT 21H
    JMP AGAIN
    
    
    PRINT_1:
    MOV AH,9
    LEA DX, MSG1
    INT 21H
    JMP AGAIN
    
    PRINT_2:
    MOV AH,9
    LEA DX, MSG2
    INT 21H
    JMP AGAIN
    
    CHECK:
    CMP ROUND, 0
    JG PRINT_1
    JL PRINT_2
    CMP CURLY, 0
    JG PRINT_1
    JL PRINT_2
    CMP SQUARE, 0
    JG PRINT_1
    JL PRINT_2
    MOV AH,9
    LEA DX, MSG5
    INT 21H
    
    AGAIN:
    MOV AH,9
    LEA DX, MSG4
    INT 21H
    MOV AH,1
    INT 21H
    CMP AL, 'Y'
    MOV AH,2
    MOV DL, 0AH
    INT 21H
    MOV DL, 0DH
    INT 21H
    JE PROCESS
    
        
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN