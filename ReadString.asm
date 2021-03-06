READ_STR PROC NEAR
    ;READS AND STORES A STRING
    ;INPUT:DI OFFSET OF STRING
    ;OUTPUT:DI OFFSET OF STRING
    ;BX NUMBER OF CHARACTERS READ
    
    PUSH AX
    PUSH DI
    CLD ;; DIRECTION FLAG 0
    XOR BX, BX
    MOV AH,1
    INT 21H
    WHILE1:
    CMP AL, 0DH
    JE END_WHILE1
    ;IF CHARACTER IS BACKSAPCE
    CMP AL,8H
    JNE ELSE1
    
    DEC DI
    DEC BX
    JMP READ
    ELSE1:
    STOSB   ;; AL---->> ES:DI DI INCREMENTED
    INC BX
    READ:
    INT 21H
    JMP WHILE1
    END_WHILE1:
    POP DI
    POP AX
    RET
    READ_STR ENDP