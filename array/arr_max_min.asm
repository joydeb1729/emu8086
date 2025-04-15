;----------------------------
;6. Finding maximum or minimum 
;-----------------------------

.model small
.stack 100h

.data
n dw 8
arr db 2, 4, 78, 34, 120, 45, 32, 104
temp db ?
max db ?
min db ?
max_msg db "Maximum = $"
min_msg db 10,13,"Minimum = $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, n
    mov si, 0
    mov bl, arr[si]

    ; Loop for finding maximum value in the array.
    ; Each element is compared with the current maximum stored in BL.
    ; If a larger value is found, BL is updated.
    ; After the loop ends, BL holds the maximum value and it is stored in 'max'.

    find_max:
    cmp arr[si],bl
    jle not_max
    
    mov bl,arr[si]
    
    not_max:
    inc si
    loop find_max
    
    mov max,bl

    mov cx, n
    mov si, 0
    mov bl, arr[si]

    ; Loop for finding minimum value in the array.
    ; Each element is compared with the current minimum stored in BL.
    ; If a smaller value is found, BL is updated.
    ; After the loop ends, BL holds the minimum value and it is stored in 'min'.

    find_min:
    cmp arr[si],bl
    jge not_min
    
    mov bl,arr[si]
    
    not_min:
    inc si
    loop find_min
    
    mov min,bl

    ; After calculating maximum and minimum, this section handles the output.
    ; The values are converted from binary to ASCII characters and displayed on the screen,
    ; printing both the maximum and minimum results one by one.

    mov ah,9
    mov dl, offset max_msg
    int 21h
    
    mov al, max
    mov ah,0
    mov bl,100
    div bl
    mov temp,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov al, temp
    mov ah,0
    mov bl,10
    div bl
    mov temp,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov dl,temp
    add dl,48
    mov ah,2
    int 21h

    mov ah,9
    mov dl, offset min_msg
    int 21h
    
    mov al, min
    mov ah,0
    mov bl,100
    div bl
    mov temp,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov al, temp
    mov ah,0
    mov bl,10
    div bl
    mov temp,ah
    mov dl,al
    add dl,48
    mov ah,2
    int 21h
    
    mov dl,temp
    add dl,48
    mov ah,2
    int 21h 

    exit:
    mov ah,4ch
    int 21h
    main endp
end main
