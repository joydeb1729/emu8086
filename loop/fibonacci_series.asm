;-------------------------------------------------
; Program to generate the Fibonacci series up to N terms.
; The series follows: 0, 1, 1, 2, 3, 5, 8, ...
;-------------------------------------------------

.model small    
.stack 100h      

.data
n dw 20         ; Number of terms in the Fibonacci series
prev1 dw 1      ; Store the previous Fibonacci number (initially 1)
prev2 dw 0      ; Store the second previous Fibonacci number (initially 0)
temp dw ?       

.code
main proc
    ; Initialize the data segment
    mov ax, @data  
    mov ds, ax     
    
    mov cx, 1      ; CX is used as the loop counter, starting from 1

for:
    cmp cx, n      ; Compare CX with the number of terms (N)
    jg exit        ; If CX > N, exit the loop
    
    mov bx, cx     ; Store CX in BX
    inc cx         ; Increment CX for the next iteration

    ; Print the first number (0) for the first term
    cmp bx, 1      
    je print_zero  
    
    ; Print the second number (1) for the second term
    cmp bx, 2      
    je print_one   

    ; Calculate the next Fibonacci number
    mov ax, prev2  ; AX = prev2 (second previous number)
    mov bx, prev1  ; BX = prev1 (previous number)
    add ax, bx     ; AX = prev1 + prev2 (next Fibonacci number)
    mov prev1, ax  ; Store the new Fibonacci number in prev1
    mov prev2, bx  ; Move old prev1 to prev2

print_num:  
    ; Convert and print the number in decimal format
    mov bx, 1000   ; Divide by 1000 to get the thousands place
    mov dx, 0
    div bx
    mov temp, dx   ; Store remainder
    cmp al, 0
    je skip_thousand  ; If quotient is 0, skip printing this place
    mov dl, al
    add dl, 48     
    mov ah, 2
    int 21h        ; Print the thousands digit

skip_thousand:
    mov ax, temp   ; Get the remainder
    mov bx, 100    ; Divide by 100 to get the hundreds place
    mov dx, 0
    div bx
    mov temp, dx   ; Store remainder
    cmp al, 0
    je skip_hundred  ; If quotient is 0, skip printing this place
    mov dl, al
    add dl, 48     
    mov ah, 2
    int 21h        ; Print the hundreds digit

skip_hundred:
    mov ax, temp   ; Get the remainder
    mov bx, 10     ; Divide by 10 to get the tens place
    mov dx, 0
    div bx
    mov temp, dx   ; Store remainder
    cmp al, 0
    je skip_ten    ; If quotient is 0, skip printing this place
    mov dl, al
    add dl, 48     
    mov ah, 2
    int 21h        ; Print the tens digit

skip_ten:
    mov ax, temp   ; Get the units place
    mov dl, al
    add dl, 48     
    mov ah, 2
    int 21h        ; Print the units digit

    ; Print space for separation
    mov ah, 2
    mov dl, 32     ; ASCII code for space (' ')
    int 21h

    jmp for        ; Continue the loop for the next Fibonacci number

;-------------------------------------------------
; Printing predefined values (0 and 1)
;-------------------------------------------------

print_zero:
    mov ah, 2
    mov dl, '0'    ; Print '0'
    int 21h
    mov dl, 32     
    int 21h
    jmp for

print_one:
    mov ah, 2
    mov dl, '1'    ; Print '1'
    int 21h
    mov dl, 32     
    int 21h
    jmp for   

exit:
    mov ah, 4Ch    
    int 21h

main endp
end main
