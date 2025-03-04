;--------------------------------------------------
; Compare Three Numbers. Find Max and Min (For 2-digit input)
;--------------------------------------------------

.model small
.stack 100h

.data 

temp db ?         ; Temporary variable to store intermediate values
a db ?            ; Variable to store number A
b db ?            ; Variable to store number B
c db ?            ; Variable to store number C

msg1 db "Enter A (2 digit) : $"  ; Prompt message for input A
msg2 db 10,13,"Enter B (2 digit) : $"  ; Prompt message for input B
msg3 db 10,13,"Enter C (2 digit) : $"  ; Prompt message for input C

a_max db 10,13,"Max = A $"  ; Message when A is the maximum
b_max db 10,13,"Max = B $"  ; Message when B is the maximum
c_max db 10,13,"Max = C $"  ; Message when C is the maximum

a_min db 10,13,"Min = A $"  ; Message when A is the minimum
b_min db 10,13,"Min = B $"  ; Message when B is the minimum
c_min db 10,13,"Min = C $"  ; Message when C is the minimum

.code

main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax
    
    ; Get input for A
    mov ah, 9
    mov dl, offset msg1
    int 21h               ; Print message for input A
    call ReadTwoDigitNum  ; Call function to read 2-digit number for A
    mov a, al             ; Store input in 'a'

    ; Get input for B
    mov ah, 9
    mov dl, offset msg2
    int 21h               ; Print message for input B
    call ReadTwoDigitNum  ; Call function to read 2-digit number for B
    mov b, al             ; Store input in 'b'

    ; Get input for C
    mov ah, 9
    mov dl, offset msg3
    int 21h               ; Print message for input C
    call ReadTwoDigitNum  ; Call function to read 2-digit number for C
    mov c, al             ; Store input in 'c'
    
    ;------------------------------------------------
    
    ; Find maximum
    mov al, a             ; Start by assuming A is the max
    cmp al, b             ; Compare A with B
    jge check_max_with_c  ; If A >= B, skip changing to B
    mov al, b             ; Otherwise, update max to B

check_max_with_c:
    cmp al, c             ; Compare current max (either A or B) with C
    jge print_max         ; If current max >= C, print max value
    mov al, c             ; Otherwise, update max to C

print_max:
    ; Determine which value was the maximum and print corresponding message
    cmp al, a             ; If A was the maximum
    je print_a_max
    cmp al, b             ; If B was the maximum
    je print_b_max
    cmp al, c             ; If C was the maximum
    je print_c_max

print_a_max:
    mov ah, 9
    mov dl, offset a_max  ; Print message for A being the max
    int 21h
    jmp check_min         ; Proceed to check the minimum

print_b_max:
    mov ah, 9
    mov dl, offset b_max  ; Print message for B being the max
    int 21h
    jmp check_min         ; Proceed to check the minimum

print_c_max:
    mov ah, 9
    mov dl, offset c_max  ; Print message for C being the max
    int 21h
    jmp check_min         ; Proceed to check the minimum
    
;-----------------------------------------------

check_min:
    mov al,a              ; Start by assuming A is the min
    cmp al,b              ; Compare A with B
    jl check_min_with_c   ; If A < B, move to the next comparison with C
    mov al,b              ; Otherwise, update min to B

check_min_with_c:
    cmp al,c              ; Compare current min (either A or B) with C
    jl print_min          ; If current min < C, print min value
    mov al,c              ; Otherwise, update min to C

print_min:
    ; Determine which value was the minimum and print corresponding message
    cmp al, a             ; If A was the minimum
    je print_a_min
    cmp al, b             ; If B was the minimum
    je print_b_min
    cmp al, c             ; If C was the minimum
    je print_c_min
    
print_a_min:
    mov ah, 9
    mov dl, offset a_min  ; Print message for A being the min
    int 21h
    jmp exit              ; Exit program

print_b_min:
    mov ah, 9
    mov dl, offset b_min  ; Print message for B being the min
    int 21h
    jmp exit              ; Exit program

print_c_min:
    mov ah, 9
    mov dl, offset c_min  ; Print message for C being the min
    int 21h
    jmp exit              ; Exit program


;------------------------------------------------
exit:
    mov ah, 4Ch
    int 21h               ; Exit the program

main endp


; Function to read a 2-digit number
ReadTwoDigitNum proc
    mov ah,1              ; Wait for user input
    int 21h
    sub al,48             ; Convert ASCII to integer
    mov bl,10
    mul bl                ; Multiply by 10 (to shift the first digit to the tens place)
    mov temp, al          ; Store first digit value in temp

    mov ah,1              ; Wait for second digit
    int 21h
    sub al,48             ; Convert ASCII to integer
    add temp, al          ; Add second digit value to temp

    mov al, temp          ; Store the result in AL (return value)
    ret 

ReadTwoDigitNum endp
    

end main
