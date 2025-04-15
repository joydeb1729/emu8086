;-----------------------------------
;4. Adding two array values of similar positions and storing them in a new array
;-------------------------------------

.model small
.stack 100h

.data
n dw 10
arr1 db 9, 23, 45, 2, 56, 78, 14, 56, 32, 10
arr2 db 67, 34, 6, 78, 34, 21, 33, 21, 9, 87
sum db 10 dup(?)
temp db ?

msg1 db "1st Array: $"
msg2 db 10,13,"2nd Array: $"
msg3 db 10,13,"Summation array: $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, n
    mov si, 0

    ; Loop to add corresponding elements from arr1 and arr2.
    ; Each sum is stored in the same index of the sum array.
    
    for:
    mov al,0
    add al,arr1[si]
    add al,arr2[si]
    mov sum[si],al
    
    inc si
    loop for

    mov ah,9
    mov dl, offset msg1
    int 21h
    
    mov cx, n
    mov si, 0

    ; Loop to print elements of the first array.
    ; Converts each number into two ASCII characters before displaying.

    print_arr1:
    mov al, arr1[si]
    mov ah,0
    mov bl,10
    div bl
    mov temp,ah
    mov dl,al
    
    mov ah,2
    add dl,48
    int 21h
    mov dl,temp
    add dl,48
    int 21h
    mov dl,32
    int 21h
    
    inc si
    loop print_arr1

    mov ah,9
    mov dl, offset msg2
    int 21h
    mov cx, n
    mov si, 0

    ; Loop to print elements of the second array.
    ; Converts each number into two ASCII characters before displaying.

    print_arr2:
    mov al, arr2[si]
    mov ah,0
    mov bl,10
    div bl
    mov temp,ah
    mov dl,al
    
    mov ah,2
    add dl,48
    int 21h
    mov dl,temp
    add dl,48
    int 21h
    mov dl,32
    int 21h
    
    inc si
    loop print_arr2

    mov ah,9
    mov dl, offset msg3
    int 21h
    mov cx, n
    mov si, 0

    ; Loop to print elements of the sum array.
    ; Converts each number into two ASCII characters before displaying.

    print_sum:
    mov al, sum[si]
    mov ah,0
    mov bl,10
    div bl
    mov temp,ah
    mov dl,al
    
    mov ah,2
    add dl,48
    int 21h
    mov dl,temp
    add dl,48
    int 21h
    mov dl,32
    int 21h
    
    inc si
    loop print_sum
