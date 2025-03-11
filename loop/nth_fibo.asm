;-------------------------------------------------
; Program to find the Nth Fibonacci number.
; This program computes only the Nth number based on input N.
;-------------------------------------------------

.model small    
.stack 100h      

.data
n dw 20         ; Input: N (position in Fibonacci sequence)
prev1 dw 1     ; Store the previous Fibonacci number (initially 1)
prev2 dw 0     ; Store the second previous Fibonacci number (initially 0)
temp dw ?      

.code
main proc
    ; Initialize the data segment
    mov ax, @data  
    mov ds, ax     
    
    ; Check if N = 1, print "0" and exit
    mov bx, n
    cmp bx, 1
    je print_zero
    
    ; Check if N = 2, print "1" and exit
    cmp bx, 2
    je print_one
    
    ; Prepare for Fibonacci calculation
    mov cx, 1      ; CX is used as the loop counter, starting from 1
    sub n, 1       ; Since we already checked first term, adjust N

for:
    cmp cx, n       ; Compare loop counter CX with N-1
    je print_num    ; If CX reaches N-1, print the final computed Fibonacci number

    ; Compute the next Fibonacci number
    mov ax, prev2   ; AX = prev2 (second previous number)
    mov bx, prev1   ; BX = prev1 (previous number)
    add ax, bx      ; AX = prev1 + prev2 (next Fibonacci number)
    mov prev1, ax   ; Store the new Fibonacci number in prev1
    mov prev2, bx   ; Move old prev1 to prev2
    
    inc cx          ; Increment counter
    jmp for         ; Repeat loop

;-------------------------------------------------
; Convert and print the Nth Fibonacci number
;-------------------------------------------------
print_num:  
    ; Convert the final computed number to ASCII and print it
    mov bx, 1000   ; Divide by 1000 to extract the thousands place
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
    mov bx, 100    ; Divide by 100 to extract the hundreds place
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
    mov bx, 10     ; Divide by 10 to extract the tens place
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

    jmp exit        ; Exit the program

;-------------------------------------------------
; Print predefined values for N = 1 and N = 2
;-------------------------------------------------

print_zero:
    mov ah, 2
    mov dl, '0'    ; Print "0" for the 1st Fibonacci number
    int 21h
    jmp exit

print_one:
    mov ah, 2
    mov dl, '1'    ; Print "1" for the 2nd Fibonacci number
    int 21h
    jmp exit   

exit:
    mov ah, 4Ch    ; DOS interrupt to terminate the program
    int 21h

main endp
end main
