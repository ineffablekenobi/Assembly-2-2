;; LOAD LENGTH OF ARR AT CL
;; LOAD ARR AT SI
INSERTIONREVSORT PROC
    PUSH AX
    PUSH DX
    PUSH CX
    PUSH SI
    PUSH DI
    PUSH BX
             ;STORE THE VALUES OF REGISTERS
    
    MOV BX, 0
    LOOPTHIS:
    CMP CL, 0
    JE SORTED
    DEC CL
    MOV BL, [SI]  ;; FOR WORD ARRAY USE BX
    MOV DI, SI
    INC SI
    LOOPTHIS1:
    DEC DI
    CMP DI, 0
    JL LOOPTHIS
    CMP BL, [DI]
    JG SHIFT
    JMP LOOPTHIS
    SHIFT:
    MOV CH, 0
    MOV CH, [DI]
    INC DI
    MOV [DI], CH
    DEC DI
    MOV [DI], BL
    JMP LOOPTHIS1
    
    SORTED:    
    POP BX
    POP DI
    POP SI
    POP CX
    POP DX
    POP AX          ;RESTORE THE VALUES OF REGISTERS
    RET             ;RETURN
INSERTIONREVSORT ENDP 