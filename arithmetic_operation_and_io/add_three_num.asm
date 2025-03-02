.model small
.stack 100h

.code

main proc
    
    mov ah,1    
    int 21h
    mov bl,al   ; Read first digit
    int 21h
    mov bh,al   ; Read second digit
    int 21h
    mov cl,al   ; Read third digit
    
    add bl,bh   ; Add first and second digits
    sub bl,48   ; Convert from ASCII to numerical value
    add bl,cl   ; Add third digit
    sub bl,48   ; Convert from ASCII to numerical value
    
    mov ah,2
    mov dl,0Ah  ; Newline
    int 21h
    mov dl,0Dh
    int 21h
    
    mov dl,bl   ; Print the result 
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
