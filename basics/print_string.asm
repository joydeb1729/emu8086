.model small
.stack 100h   ; Allocate 256 bytes for the stack

.data
str db "Hello World$"  ; Define a null-terminated string with '$' as the delimiter

.code

main proc
    ; Initialize Data Segment
    mov ax, @data  ; Load the address of the data segment into AX
    mov ds, ax     ; Move AX into DS to initialize the data segment

    ; Display the string using DOS interrupt 21h function 9
    mov ah, 9      ; DOS function 9 - Print a string
    lea dx, str    ; Load effective address of 'str' into DX
    int 21h        ; Call interrupt to display the string

exit:
    ; Terminate the program
    mov ah, 4Ch    ; DOS interrupt 21h function 4Ch (exit program)
    int 21h        ; Call interrupt to terminate execution

main endp
end main
