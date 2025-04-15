;---------------------------------------
;2. Finding even odd from the array
;---------------------------------------


.model small
.stack 100h

.data
n dw 8
arr db 1,2,3,4,5,6,7,8
msg1 db "Odd numbers: $"
msg2 db 10,13,"Even numbers: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx,n                      ; Initialize loop counter for odd number checking
    mov si,0                      ; Initialize index to point to the first element
    
    mov ah,9
    mov dl,offset msg1
    int 21h                       ; Display "Odd numbers:" message
    
    print_odd:
    ; Loop to check each element for oddness.
    ; If remainder after division by 2 is not zero, the number is odd.
    mov ah,0
    mov al,arr[si]
    mov bl,2
    div bl
    cmp ah,0
    je not_odd
    
    mov ah,2
    mov dl,arr[si]
    add dl,48
    int 21h
    mov dl,32
    int 21h
    
    not_odd:
    inc si
    loop print_odd                ; Repeat until all elements are checked
    
    
    
    mov cx,n                      ; Reset loop counter for even number checking
    mov si,0                      ; Reset index to start from the first element
    
    mov ah,9
    mov dl, offset msg2
    int 21h                       ; Display "Even numbers:" message
    
    print_even:
    ; Loop to check each element for evenness.
    ; If remainder after division by 2 is zero, the number is even.
    mov ah,0
    mov al,arr[si]
    mov bl,2
    div bl
    cmp ah,1
    je not_even
    
    mov ah,2
    mov dl,arr[si]
    add dl,48
    int 21h
    mov dl,32
    int 21h
    
    not_even:
    inc si
    loop print_even               ; Repeat until all elements are checked
    
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
