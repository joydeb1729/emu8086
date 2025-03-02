.model small
.stack 100h

.code

main proc
    mov al,7      ; AL = 7 (Dividend)
    mov bl,2      ; BL = 2 (Divisor)
    
    div bl        ; Divide AL by BL, quotient in AL, remainder in AH
    
    mov cl,al     ; Move quotient to CL
    mov ch,ah     ; Move remainder to CH
    
    mov ah,2
    mov dl,cl
    add dl,48     ; Convert quotient to displayable character
    int 21h
    mov dl,ch
    add dl,48     ; Convert remainder to displayable character
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
