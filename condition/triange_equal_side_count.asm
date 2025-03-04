;--------------------------------------------------
; Check if a triangle has all equal sides or two equal or none
;--------------------------------------------------

.model small
.stack 100h

.data 
temp db ?        ; Temporary variable for storing intermediate calculations
a db ?           ; Variable to store number A
b db ?           ; Variable to store number B
c db ?           ; Variable to store number C

msg1 db 10,13,"Enter Side A (2 digit) : $"  ; Prompt message for input A
msg2 db 10,13,"Enter Side B (2 digit) : $"  ; Prompt message for input B
msg3 db 10,13,"Enter Side C (2 digit) : $"  ; Prompt message for input C

all_eq_msg db 10,13,"Triangle has all equal sides. $"  ; Message for an equilateral triangle
two_eq_msg db 10,13,"Triangle has two equal sides. $"  ; Message for an isosceles triangle
no_eq_msg db 10,13,"Triangle has no equal sides. $"    ; Message for a scalene triangle

.code

main proc
    mov ax, @data
    mov ds, ax  ; Initialize data segment
    
    ; Get input for A
    mov ah, 9
    mov dx, offset msg1  ; Display message for input A
    int 21h
    call ReadTwoDigitNum  ; Read 2-digit input
    mov a, al  ; Store input in 'a'

    ; Get input for B
    mov ah, 9
    mov dx, offset msg2  ; Display message for input B
    int 21h
    call ReadTwoDigitNum  ; Read 2-digit input
    mov b, al  ; Store input in 'b'

    ; Get input for C
    mov ah, 9
    mov dx, offset msg3  ; Display message for input C
    int 21h
    call ReadTwoDigitNum  ; Read 2-digit input
    mov c, al  ; Store input in 'c'
    
;----------------------------------------------------------
    ; Check for equality conditions among A, B, C
    mov al, a
    mov bl, b
    
    cmp al, bl
    je check_all_eq  ; If A == B, check if all three are equal
    
    cmp al, c
    je print_two_eq  ; If A == C, then it's an isosceles triangle
    
    cmp bl, c
    je print_two_eq  ; If B == C, then it's an isosceles triangle
    
    jmp print_no_eq  ; If no sides are equal, go to scalene triangle case

check_all_eq:
    cmp al, c
    je print_all_eq  ; If A == B == C, print equilateral triangle message
    
    jmp print_two_eq  ; Otherwise(A == B != C), it's an isosceles triangle
    
print_all_eq:
    mov ah, 9
    mov dl, offset all_eq_msg  ; Load address of equilateral triangle message
    int 21h  ; Print the message
    jmp exit  ; Exit program
    
print_two_eq:
    mov ah, 9
    mov dl, offset two_eq_msg  ; Load address of isosceles triangle message
    int 21h  ; Print the message
    jmp exit  ; Exit program
    
print_no_eq:
    mov ah, 9
    mov dl, offset no_eq_msg  ; Load address of scalene triangle message
    int 21h  ; Print the message
    jmp exit  ; Exit program

;------------------------------------------------
exit:
    mov ah, 4Ch
    int 21h  ; Terminate the program

main endp

;------------------------------------------------
; Function to read a 2-digit number
;------------------------------------------------
ReadTwoDigitNum proc
    ; Read first digit (tens place)
    mov ah, 1
    int 21h
    sub al, 48  ; Convert ASCII to integer
    mov bl, 10  ; Prepare for multiplication by 10
    mul bl      ; AL = AL * 10 (shifting the digit to tens place)
    mov temp, al  ; Store tens digit in temp

    ; Read second digit (ones place)
    mov ah, 1
    int 21h
    sub al, 48  ; Convert ASCII to integer
    add al, temp  ; Combine tens and ones place values

    ; AL now contains the full 2-digit number
    ret 

ReadTwoDigitNum endp
    
end main
