.model small
.stack 100h

.code

main proc
    mov al,2
    mov bl,4
    mul bl     ; Multiply AL by BL, result stored in AX (only AL used for single-byte values)

    add dl,48  ; Convert result to ASCII for display
    int 21h

    exit:
    mov ah,4ch
    int 21h
    main endp
end main
