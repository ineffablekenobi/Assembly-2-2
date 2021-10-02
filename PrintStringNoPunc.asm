DISP_STR PROC NEAR
    ; DISPLAY A STRING
    ;INPUT SI = OFFSET O A STRING
    ;BX = NUMBER OF CHARACTERS TO DISPLAY
    ;OUTPUT:NONE
    
    PUSH AX
    PUSH BX
    PUSH CX
    PUSH DX
    PUSH SI
    MOV CX, BX
    JCXZ P_EXIT
    CLD
    MOV AH, 2
    TOP:
    DEC CX
    CMP CX, 0
    JL P_EXIT
    LODSB  ;; DS:SI >> AL SI INCREMENTED
    MOV DL, AL
    CMP DL, 65
    JL TOP
    CMP DL, 90
    JG CHECK
    CHECKPASS:
    INT 21H
    JMP TOP
    JMP P_EXIT
    
    CHECK:
    CMP DL, 97
    JL TOP
    CMP DL, 122
    JG TOP
    JMP CHECKPASS
    
    P_EXIT:
    POP SI
    POP DX
    POP CX
    POP BX
    POP AX
    RET
    DISP_STR ENDP