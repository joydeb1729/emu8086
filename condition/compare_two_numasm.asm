.model small
.stack 100h

.data
msg1 db "Enter Number : $"      ; Prompt message
msg2 db "Large Number : $"      ; Output message

.code
main proc
    mov ax, @data
    mov ds, ax

    ; Display "Enter Number :"
    mov ah,9
    mov dx, offset msg1
    int 21h

    ; Read first number
    mov ah,1
    int 21h
    sub al,48       
    mov bl, al

    ; Newline
    mov ah,2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h

    ; Display "Enter Number :"
    mov ah,9
    mov dx, offset msg1
    int 21h

    ; Read second number
    mov ah,1
    int 21h
    sub al,48       
    mov bh, al

    ; Newline
    mov ah,2
    mov dl, 0Ah
    int 21h
    mov dl, 0Dh
    int 21h

    ; Display "Large Number :"
    mov ah,9
    mov dx, offset msg2
    int 21h

    ; Compare first and second number
    cmp bl, bh       ; Compare bl with bh
    jge N1           ; Jump if bl >= bh
    jmp N2           ; If bl < bh, jump to N2

N1: ; Block executes if bl >= bh
    mov ah,2
    mov dl, bl       ; Store bl in dl for printing
    add dl, 48       
    int 21h
    jmp exit         ; Jump to exit after printing

N2: ; Block executes if bl < bh
    mov ah,2
    mov dl, bh       ; Store bh in dl for printing
    add dl, 48       
    int 21h 

exit:
    mov ah,4Ch       
    int 21h
main endp
end main


; Different conditional jumps that can be used:
    ; je  Equal       ; Jump if bl == bh
    ; jne NotEqual   ; Jump if bl != bh
    ; jg  N1         ; Jump if bl > bh (signed comparison)
    ; jge N1           ; Jump if bl >= bh (signed)
    ; jl  N2         ; Jump if bl < bh (signed)
    ; jle N2         ; Jump if bl <= bh (signed)