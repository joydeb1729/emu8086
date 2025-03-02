.model small
.stack 100h

.code

main proc
    mov ah,1
    int 21h
    mov bl,al     
    
    sub bl,32     ; Convert lowercase letter to uppercase (only works for 'a' to 'z')
    
    mov ah,2
    mov dl,0Ah    
    int 21h
    mov dl,0Dh    
    int 21h
    
    mov dl,bl     ; Display the modified character
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
