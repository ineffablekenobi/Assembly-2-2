.MODEL SMALL
.STACK 100H
.DATA
    MSG0 DB "How many digits your number has? ",0AH,0DH,"$"
    MSG1 DB 0AH,0DH,"Input the number: $"
    MSG2 DB 0AH,0DH,"The Binary is: $"
    MSG3 DB 0AH,0DH,"Invalid character. Try again. $"
    NUM DW 0
    INP DW 0
    SCNT DB 12 
    MSK DW 256
    DIVISOR DW 2
    DIGITS DW ?
.CODE

MAIN PROC
    
    MOV AX, @DATA
    MOV DS, AX
    
    ;INPUT FUNCTION AH -> 1 DATA SAVED AT AL
    ;PRINT FUNCTION AH -> 2 SAVE DATA AT DL 
    
    MOV AH,9
    LEA DX,MSG0
    INT 21H
    
    MOV AH,1
    INT 21H
    MOV AH,0
    MOV DX,0
    MOV DIGITS,AX
    SUB DIGITS,48
    SUB AL, 49
    MOV CL, 4
    MUL CL
    MOV SCNT, AL
    CMP DIGITS, 0
    JLE CHECK_FAIL
    CMP DIGITS, 4
    JG CHECK_FAIL
    
    MOV AH,9
    LEA DX,MSG1
    INT 21H
    
    MOV CX, DIGITS
    
    INPUT:
    MOV AH,1
    INT 21H
    MOV AH, 0
    MOV INP, AX
    JMP CHECK
    CHECK_PASS:
    MOV BX, CX
    MOV CL, SCNT
    SHL INP,CL
    MOV CX, BX
    MOV BX, INP
    OR NUM, BX
    SUB SCNT, 4
    LOOP INPUT
    
    JMP PRINT_NUM
    
    CHECK:
    DIGIT:
    CMP INP,'0'
    JL CHECK_FAIL
    CMP INP, '9'
    JG LETTER
    SUB INP, 48
    JMP CHECK_PASS
    
    LETTER:
    CMP INP, 'A'
    JL CHECK_FAIL
    CMP INP, 'Z'
    JG CHECK_FAIL
    SUB INP,65
    ADD INP,10
    JMP CHECK_PASS
    
    CHECK_FAIL:
    MOV AH,9
    LEA DX,MSG3
    INT 21H
    JMP RETURN
    
    
    PRINT_NUM:
    MOV AH,9
    LEA DX,MSG2
    INT 21H
    MOV MSK, 8000h
    MOV BX, NUM
    
    DO:
    CMP MSK,0
    JE RETURN ;; CHANGE
    MOV AX, MSK
    AND MSK, BX
    MOV DX,0
    DIV DIVISOR
    CMP MSK,0
    MOV MSK,AX
    JE PRINT_0
    JMP PRINT_1   
    
    PRINT_1:
    MOV AH,2
    MOV DL, '1'
    INT 21H
    JMP DO
    
    PRINT_0:
    MOV AH,2
    MOV DL, '0'
    INT 21H
    JMP DO
    
    
    RETURN:    
    MOV AH, 4CH
    INT 21H
    MAIN ENDP  

END MAIN