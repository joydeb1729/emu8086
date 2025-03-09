.model small      
.stack 100h       

.data
n db '0'          ; Declares a variable 'n' with the ASCII value '0' (loop limit)

.code

main proc

    mov ax, @data  
    mov ds, ax    

    mov cl, '9'    ; Initialize CL with ASCII '9' (starting character for loop)

for:              
    cmp cl, n      ; Compare CL with 'n' (ASCII '0')
    jl exit        ; If CL < '0', jump to exit

    mov ah, 2      ; DOS interrupt function to print a character
    mov dl, 32     ; ASCII code for space (' ')
    int 21h        ; Print space

    mov dl, cl     ; Load current character (CL) into DL
    int 21h        ; Print the character

    sub cl,1       ; Decrement CL to the next ASCII character
    jmp for        ; Repeat loop

exit:
    mov ah, 4Ch    ; DOS interrupt function to terminate the program
    int 21h

main endp
end main
