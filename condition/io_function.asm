;--------------------------------------------------
; 2 digit number i/o function sample
;--------------------------------------------------

.model small
.stack 100h

.data 

temp db ?        ; Temporary variable for storing intermediate calculations
a db ?           ; Variable to store number A
b db ?           ; Variable to store number B
c db ?           ; Variable to store number C

msg1 db 10,13,"Enter A (2 digit) : $"
msg2 db 10,13,"Enter B (2 digit) : $"
msg3 db 10,13,"Enter C (2 digit) : $"


.code

main proc
    mov ax, @data
    mov ds, ax
    
    ; Get input for A
    mov ah, 9
    mov dx, offset msg1  ; Use DX instead of DL
    int 21h
    call ReadTwoDigitNum
    mov a, al  ; Store input in 'a'

    ; Get input for B
    mov ah, 9
    mov dx, offset msg2  ; Use DX instead of DL
    int 21h
    call ReadTwoDigitNum
    mov b, al  ; Store input in 'b'

    ; Get input for C
    mov ah, 9
    mov dx, offset msg3  ; Use DX instead of DL
    int 21h
    call ReadTwoDigitNum
    mov c, al  ; Store input in 'c'
    
    ; Print values of A, B, and C
    mov ah, 9
    mov dx, offset msg1  ; Print message before printing A
    int 21h
    mov al, a
    call PrintTwoDigitNum

    mov ah, 9
    mov dx, offset msg2  ; Print message before printing B
    int 21h
    mov al, b
    call PrintTwoDigitNum

    mov ah, 9
    mov dx, offset msg3  ; Print message before printing C
    int 21h
    mov al, c
    call PrintTwoDigitNum
    
    jmp exit

;------------------------------------------------
exit:
    mov ah, 4Ch
    int 21h

main endp

; Function to read a 2-digit number
ReadTwoDigitNum proc
    ; Read first digit (tens place)
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    mov bl, 10         ; Multiply by 10 (to shift the first digit to the tens place)
    mul bl             ; AL = AL * 10
    mov temp, al       ; Store tens digit in temp

    ; Read second digit (ones place)
    mov ah, 1
    int 21h
    sub al, 48         ; Convert ASCII to integer
    add al, temp       ; Add the tens digit (stored in temp)

    ; AL now contains the full 2-digit number
    ret 

ReadTwoDigitNum endp

; Function to print the two-digit number
PrintTwoDigitNum proc
    mov ah, 0
    mov bl, 10
    div bl             ; AL = quotient (tens digit), AH = remainder (ones digit)

    ; Print tens place digit
    add al, 48         ; Convert to ASCII
    mov dl, al
    mov temp,ah
    mov ah, 2
    int 21h            ; Print tens digit
    
    ; Print ones place digit
    add temp, 48         ; Convert to ASCII
    mov dl, temp
    mov ah, 2
    int 21h            ; Print ones digit
    
    ret

PrintTwoDigitNum endp
    
end main
