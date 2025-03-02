.model small
.stack 100h

.data
msg1 db "Enter 1st digit: $"
msg3 db "Answer: $"
a dw ?
sum db ?
reminder db ?

.code 
main proc
    mov ax,@data
    mov ds,ax
    
    ;printing 1st msg
    mov dl,offset msg1
    mov ah,9
    int 21h 
    
    ;1st input
    mov ah,1
    int 21h
    sub al,48
    mov ah,0
    mov bx,100
    mul bx
    mov a,ax 
    
    mov ah,1
    int 21h
    sub al,48
    mov ah,0
    mov bx,10
    mul bx
    add a,ax
    
    mov ah,1
    int 21h
    sub al,48
    mov ah,0
    add a,ax
    
    ;new line
    mov dl,10
    mov ah,2
    int 21h
    mov dl,13
    mov ah,2
    int 21h  
    

    
    ;printing ans
    mov dl,offset msg3
    mov ah,9
    int 21h
    
    mov ax,a 
    ;mov ah,0    // problem was here
    mov bl,100
    div bl
    mov reminder,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov al,reminder
    mov ah,0
    mov bl,10
    div bl
    mov reminder,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h  
    
    mov al,reminder
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    
    mov ax,4c00h
    int 21h
    
    main endp
end main
