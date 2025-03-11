;-------------------------------------------------
; Program to add 2 twenty times using a loop
; and display the result as a two-digit number.
;-------------------------------------------------

.model small    
.stack 100h    

.data
res db 0        ; Variable to store the result
n db 20         ; Number of iterations (20 times)
temp db ?       ; Temporary storage variable

.code

main proc
    mov ax, @data 
    mov ds, ax     
    
    mov cl, 1      ; Initialize loop counter to 1

for:
    cmp cl, n      ; Compare loop counter with 20
    jg print_result ; If cl > n, jump to print_result
    
    mov bl, 2      ; Load value 2 into BL
    add res, bl    ; Add 2 to the result variable
    inc cl         ; Increment loop counter
    jmp for        ; Jump back to the start of the loop

print_result:
    mov al, res    ; Load result into AL
    mov ah, 0      ; Clear AH before division
    mov bl, 10     ; Load divisor (10)
    div bl         ; AL = Quotient (tens place), AH = Remainder (units place)

    mov temp, ah   
    mov dl, al     
    add dl, 48   
    mov ah, 2     
    int 21h        ; Print first digit (tens place)

    mov dl, temp 
    add dl, 48    
    int 21h        ; Print second digit (units place)

exit:
    mov ah, 4Ch    
    int 21h

main endp
end main
