;-------------------------------------------------
; Program to find and display even numbers 
; between 1 to 20 using a loop.
;-------------------------------------------------

.model small     
.stack 100h      

.data
start db 1       ; Start number (1)
last db 20       ; Last number (20)
num db ?         ; Variable to store the current number
temp db ?        

.code
main proc
    mov ax, @data  
    mov ds, ax     
    
    mov cl, start  ; Initialize loop counter with start value (1)

for:
    cmp cl, last   ; Compare current value with last (20)
    jg exit        ; If cl > 20, exit the loop
    
    mov al, cl     ; Move current value to AL
    mov num, cl    ; Store the current number in `num`
    inc cl         ; Increment loop counter for the next iteration
    
    ; Check if the number is even
    mov ah, 0      ; Clear AH before division
    mov bl, 2      ; Load divisor (2)
    div bl         ; AL = Quotient, AH = Remainder

    cmp ah, 1      ; If remainder is 1, it's an odd number
    je print_num   ; If even (AH = 0), jump to print_num
    jmp for        ; Otherwise, continue loop

print_num:
    ; Print space for better formatting
    mov ah, 2      ;
    mov dl, 32     ; ASCII for space (' ')
    int 21h        ; Print space

    ; Convert the number to ASCII and print it
    mov al, num    ; Load current number into AL
    mov ah, 0      ; Clear AH before division
    mov bl, 10     ; Load divisor (10) for decimal conversion
    div bl         ; AL = Quotient (tens place), AH = Remainder (units place)
    
    mov temp, ah   ; Store remainder (units place) in temp
    
    cmp al, 0      
    je skip_ten    ; If quotient is 0, skip printing the tens place
    
    mov dl, al     ; Load quotient into DL
    add dl, 48     
    mov ah, 2      
    int 21h        ; Print tens digit

skip_ten:
    mov dl, temp   ; Load remainder (units place)
    add dl, 48    
    mov ah, 2     
    int 21h        ; Print units digit

    jmp for        ; Continue loop

exit:
    mov ah, 4Ch    
    int 21h

main endp
end main
