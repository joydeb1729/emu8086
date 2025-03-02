.model small
.stack 100h

.code
main proc
    
    mov ah,2      
    mov dl,07     ; Bell (beep) character (ASCII 07h)
    int 21h       
    
    exit:
    mov ah,4ch    
    int 21h
    main endp
end main
