.model small
.stack 100h

.code

main proc
    
    mov ah,1      ; Take first character input
    int 21h
    mov bl,al     ; Store it in BL
    
    mov ah,1      ; Take second character input
    int 21h
    mov bh,al     ; Store it in BH
    
    xchg bl,bh    ; Swap the values of BL and BH
    
    mov ah,2
    mov dl,0Ah    ; Print newline
    int 21h
    mov dl,0Dh    ; Print carriage return
    int 21h
    
    mov ah,2
    mov dl,bl     ; Print swapped first character
    int 21h
    
    mov ah,2
    mov dl,0Ah    ; Print newline
    int 21h
    mov dl,0Dh    ; Print carriage return
    int 21h
    
    mov ah,2
    mov dl,bh     ; Print swapped second character
    int 21h
    
    exit:
    mov ah,4ch    ; Exit program
    int 21h
    main endp
end main
