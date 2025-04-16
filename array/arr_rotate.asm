;---------------------------------------------------
;Write a program that rotates the elements of the array 
;arr db 1, 2, 3, 4, 5 one position to the right.
;---------------------------------------------------  

.model small
.stack 100h

.data
n dw 5
arr db 1, 2, 3, 4, 5
temp db ?
last db ?

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Store the last element separately, as it will be moved to the first position later.
    
    mov cx,n
    dec cx
    mov si,cx
    mov bl,arr[si]
    mov last,bl

    ; Initialize temp with the first element to start rotation.
    
    mov si,0
    mov bl,arr[si]
    mov temp,bl
    inc si

    ; Shift all elements one position to the right.
    ; Loop stores the previous value in the current index.
    
    for:
    mov al,temp
    mov bl,arr[si]
    mov temp,bl
    mov arr[si],al

    inc si
    loop for

    ; Place the last element (previously saved) at the first position.
    
    mov bl,last
    mov arr[0],bl

    ; Display the rotated array.
    
    mov cx,n
    mov si, 0
    
    mov ah,2
    print:
    mov dl,arr[si]
    add dl,48
    int 21h
    mov dl,32
    int 21h

    inc si
    loop print

    ; Program termination.
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
