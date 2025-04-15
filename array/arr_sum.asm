;----------------------------------------------
;3. Adding every alternative number of an array
;----------------------------------------------

.model small
.stack 100h

.data
n dw 7
arr db 10, 34, 12, 17, 12, 45, 25
sum db 0
temp db ?
msg db "Sum = $"

.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov cx, n
    mov si,0

    ; Loop starts: iterates n times to process each element in the array.
    ; The current logic is summing all the array elements, one by one.
    ; If the intention was to add only every alternative number (like index 0,2,4,...),
    ; then SI should increase by 2 in each loop, but here SI increases by 1 — meaning all elements are being summed.
    ; After each addition, the result is stored back into 'sum' for the next iteration.

    for:
    mov al,sum
    add al, arr[si]
    inc si
    mov sum,al
    
    loop for

    ; After completing the loop and summing values, this block handles printing the output.
    ; The sum is first converted from binary to ASCII representation and then printed digit by digit.
    ; The logic uses division to extract hundreds, tens, and units to show the final result on screen.

    mov ah,9
    mov dl,offset msg
    int 21h
    
    mov al,sum
    mov ah,0
    mov bl,100
    div bl
    mov temp,ah
    mov dl,al
    add dl,48
    
    mov ah,2
    int 21h
    
    mov al,temp
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
