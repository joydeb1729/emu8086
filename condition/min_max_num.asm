;--------------------------------------------------
; Compare Three Numbers. Find Max and Min (Updated for 2-digit input)
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

max_msg db 10,13,"Max = $"
min_msg db 10,13,"Min = $"

.code

main proc
    mov ax, @data
    mov ds, ax
    
    ; Get input for A
    mov ah, 9
    mov dx, offset msg1  ; Display message for input A
    int 21h
    call ReadTwoDigitNum
    mov a, al  ; Store input in 'a'

    ; Get input for B
    mov ah, 9
    mov dx, offset msg2  ; Display message for input B
    int 21h
    call ReadTwoDigitNum
    mov b, al  ; Store input in 'b'

    ; Get input for C
    mov ah, 9
    mov dx, offset msg3  ; Display message for input C
    int 21h
    call ReadTwoDigitNum
    mov c, al  ; Store input in 'c'
    
;----------------------------------------------------------
    ; Find maximum of A, B, C
    mov al, a
    cmp al, b
    jge check_max_with_c  ; If A >= B, skip to check max with C
    mov al, b

check_max_with_c:
    cmp al, c
    jge print_max         ; If max(A, B) >= C, print the max value
    mov al, c             ; Otherwise, set max to C
    
    ; Store the maximum value in temp
print_max:
    mov temp, al            ; Store the minimum value temporarily in temp
    
    ; Print Max value
    mov ah, 9
    mov dl, offset max_msg
    int 21h
    
    mov al, temp           ; Retrieve the stored max value from temp
    call PrintTwoDigitNum  ; Call to print the maximum value
    
;----------------------------------------------------------
    ; Find minimum of A, B, C
    jmp check_min

check_min:
    mov al, a
    cmp al, b
    jl check_min_with_c    ; If A < B, continue to check with C
    mov al, b

check_min_with_c:
    cmp al, c
    jl print_min           ; If min(A, B) < C, print the min value
    mov al, c              ; Otherwise, set min to C
    
    ; Store the minimum value in temp
print_min:
    mov temp, al           ; Store the minimum value temporarily in temp
    
    ; Print Min value
    mov ah, 9
    mov dl, offset min_msg
    int 21h
    mov al, temp           ; Retrieve the stored min value from temp
    call PrintTwoDigitNum  ; Call to print the minimum value
    
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
    ; Get tens place digit
    mov ah, 0
    mov bl, 10
    div bl             ; AL = quotient (tens digit), AH = remainder (ones digit)

    ; Print tens place digit
    add al, 48         ; Convert to ASCII
    mov dl, al
    mov temp, ah
    mov ah, 2
    int 21h            ; Print tens digit
    
    ; Print ones place digit
    add temp, 48       ; Convert to ASCII
    mov dl, temp
    mov ah, 2
    int 21h            ; Print ones digit
    
    ret

PrintTwoDigitNum endp
    
end main
