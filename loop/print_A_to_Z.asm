.model small     
.stack 100h       

.data
n db 'Z'          ; Declares a variable 'n' with the ASCII value 'Z' (loop limit)

.code

main proc

    mov ax, @data  
    mov ds, ax     

    mov cl, 'A'    ; Initialize CL with ASCII 'A' (starting character for loop)

for:               ; Loop label
    cmp cl, n      ; Compare CL with 'n' (ASCII 'Z')
    jg exit        ; If CL > 'Z', jump to exit

    mov ah, 2      ; DOS interrupt function to print a character
    mov dl, 32     ; ASCII code for space (' ')
    int 21h        ; Print space

    mov dl, cl     ; Load current character (CL) into DL
    int 21h        ; Print the character

    inc cl         ; Increment CL to the next ASCII character
    jmp for        ; Repeat loop

exit:
    mov ah, 4Ch   
    int 21h

main endp
end main
