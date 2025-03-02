.model small
.stack 100h

.code

main proc
        
    mov ah,1
    int 21h
    sub al,48    ; Read first digit and store it in AL
    mov bl,al    ; Store first digit in BL
    int 21h
    sub al,48    ; Read second digit and store it in AL
    
    mul bl       ; Multiply first and second digit (AL * BL), result stored in AX
    
    aam          ; Convert result in AX into unpacked BCD format (AH contains tens, AL contains ones)
    
    mov bx,ax    ; Store result in BX
    
    mov ah,2
    mov dl,0Ah   ; New line
    int 21h
    mov dl,0Dh   ; Carriage return
    int 21h
    
    mov dl,bh
    add dl,48    ; Display tens digit
    int 21h
    mov dl,bl
    add dl,48    ; Display ones digit
    int 21h
    

    exit:
    mov ah,4ch
    int 21h
    main endp
end main
