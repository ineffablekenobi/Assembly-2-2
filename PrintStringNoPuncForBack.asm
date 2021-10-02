DISP_STR PROC NEAR
    ; DISPLAY A STRING
    ;INPUT SI = OFFSET O A STRING
    ;BX = NUMBER OF CHARACTERS TO DISPLAY
    ;OUTPUT:NONE
    ;PUTTING VALUE TO STACK AND PRINTING IN REVERSE
    ;IF NOT PALLINDROME CX > 0 ELSE CX 0
    
    PUSH AX
    PUSH BX
    ;;PUSH CX
    PUSH DX
    PUSH SI
    MOV CX, BX 
    MOV BX, 0
    JCXZ P_EXIT
    CLD
    MOV AH, 2
    MOV DI, SI
    TOP:
    DEC CX
    CMP CX, 0
    JL BW
    LODSB  ;; DS:SI >> AL SI INCREMENTED
    MOV DL, AL
    CMP DL, 65
    JL TOP
    CMP DL, 90
    JG CHECK
    CHECKPASS:
    INC BX
    PUSH DX
    INT 21H
    JMP TOP
    JMP BW
    
    CHECK:
    CMP DL, 97
    JL TOP
    CMP DL, 122
    JG TOP
    JMP CHECKPASS
    
    BW:
    MOV SI, DI
    MOV CX, 0 
    MOV AH,2
    MOV DL, 0DH
    INT 21H
    MOV DL, 0AH
    INT 21H
    
    BACKWARD:
    CMP BL, 0
    DEC BL
    JL P_EXIT
    MOV AH, 2
    POP DX
    
    INVALID:
    LODSB
    JMP CHECK1
    VALID:
    CMP AL, DL
    INT 21H
    JNE NOTPALINDROME
    JMP BACKWARD
    
    CHECK1:
    CMP AL, 65
    JL INVALID
    CMP AL, 90
    JG CHECK2
    JMP VALID
    
    CHECK2:
    CMP AL, 97
    JL INVALID
    CMP AL, 122
    JG INVALID
    JMP VALID
    
    
    NOTPALINDROME:
    INC CX
    JMP BACKWARD
    
    P_EXIT:
    POP SI
    POP DX
    ;;POP CX
    POP BX
    POP AX
    RET
    DISP_STR ENDP