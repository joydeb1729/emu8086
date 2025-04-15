;--------------------
;5. Reverse an array
;---------------------

.model small
.stack 100h

.data
n dw 8
arr db 1, 2, 3, 4, 5, 6, 7, 8
rev_arr db ?,?,?,?,?,?,?,?
msg1 db "Original Array: $"
msg2 db 10,13,"Reversed Array: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx,n
    mov si,0
    mov bx,n
    dec bx

    ; Loop for reversing the array.
    ; Copies elements from the original array into a new array in reverse order.
    ; BX starts at the last index, SI starts at the first, and both move inward until the full reverse is done.

    for:
    mov al,arr[bx]
    mov rev_arr[si],al
    dec bx
    inc si
    loop for

    mov cx,n
    mov si,0

    mov ah,9
    mov dl,offset msg1
    int 21h

    ; Loop to print the original array.
    ; Converts each number to ASCII and displays it on screen with a space between values.

    mov ah,2
    print_original:
    mov dl,arr[si]
    add dl,48
    int 21h
    mov dl,32
    int 21h

    inc si
    loop print_original

    mov ah,9
    mov dl,offset msg2
    int 21h

    mov cx,n
    mov si,0

    ; Loop to print the reversed array.
    ; Converts each reversed number to ASCII and displays it on screen with a space between values.

    mov ah,2
    print_rev:
    mov dl,rev_arr[si]
    add dl,48
    int 21h
    mov dl,32
    int 21h

    inc si
    loop print_rev

    exit:
    mov ah,4ch
    int 21h
    main endp
end main
