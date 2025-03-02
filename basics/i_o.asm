.model small
.stack 100h  ; Allocate 256 bytes for the stack

.code

main proc

    mov ah,1      ; Set AH = 1 for DOS interrupt 21h function to read a character
    int 21h       ; Call interrupt 21h to take input from the user
    mov bl, al    ; Store the input character in BL register for later use

    ; Print a newline (Carriage Return + Line Feed) for better output formatting
    mov ah,2      ; Set AH = 2 for DOS interrupt 21h function to print a character
    mov dl,0Ah    ; Line Feed (LF) - Moves cursor to the next line
    int 21h       ; Call interrupt to print LF
    mov dl,0Dh    ; Carriage Return (CR) - Moves cursor to the beginning of the line
    int 21h       ; Call interrupt to print CR

    ; Display the same character that was inputted
    mov ah,2      ; Set AH = 2 for DOS interrupt 21h function to print a character
    mov dl,bl     ; Load the stored input character into DL for output
    int 21h       ; Call interrupt to print the character

exit:
    mov ah,4ch    ; Set AH = 4Ch to terminate the program
    int 21h       ; Call interrupt to exit

main endp
end main
