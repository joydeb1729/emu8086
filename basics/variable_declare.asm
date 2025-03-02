.model small
.stack 100h   ; Allocate 256 bytes for the stack

.data
a db 5       ; Define a variable 'a' with an initial value of 5
b db ?       ; Define an uninitialized variable 'b' to store user input

.code

main proc

    mov ax, @data  ; Load the address of the data segment into AX
    mov ds, ax     ; Move AX into DS to initialize the data segment

    ; Take a single character input from the user and store it in 'b'
    mov ah, 1      ; DOS interrupt 21h function 1 (input a character)
    int 21h        ; Call interrupt to read a character
    mov b, al      ; Store the user-inputted character in variable 'b'

    ; Print a newline for better formatting
    mov ah, 2      ; DOS interrupt 21h function 2 (output a character)
    mov dl, 0Ah    ; Line Feed (LF) - Moves cursor to the next line
    int 21h        ; Call interrupt to print LF
    mov dl, 0Dh    ; Carriage Return (CR) - Moves cursor to the beginning of the line
    int 21h        ; Call interrupt to print CR

    ; Print the value of 'a' (which is 5)
    mov ah, 2      ; DOS interrupt 21h function 2 (output a character)
    mov dl, a      ; Load the value of 'a' into DL
    add dl, 48     ; Convert numerical value to ASCII (since '0' is ASCII 48)
    int 21h        ; Call interrupt to print the value of 'a'

    ; Print the user-inputted character stored in 'b'
    mov dl, b      ; Load the value of 'b' into DL
    int 21h        ; Call interrupt to print the character

exit:
    mov ah, 4Ch    ; DOS interrupt 21h function 4Ch (exit program)
    int 21h        ; Call interrupt to terminate the program

main endp
end main
