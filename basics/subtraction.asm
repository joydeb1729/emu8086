.model small
.stack 100h

.code

main proc
    mov ah,1
    int 21h
    mov bl,al   ; Read first digit (ASCII)
    int 21h
    mov bh,al   ; Read second digit (ASCII)
    
    sub bl,bh   ; Subtract second digit from first (ASCII subtraction issue)
    add bl,48   ; Convert back to ASCII (incorrect for negative results)
    
    mov ah,2
    mov dl,0Ah  ; Newline
    int 21h
    mov dl,0Dh
    int 21h
    
    mov dl,bl   ; Display result (incorrect if negative)
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
