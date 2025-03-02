.model small  
.stack 100h  

.data  

msg1 db "Please Enter 3 digit number: $"  ; Message to prompt user input  
msg2 db "You Entered : $"                 ; Message to display the entered number  

num dw ?          ; Variable to store the input number  
reminder db ?     ; Variable to store the remainder  
quotient db ?     ; Variable to store the quotient  

.code  

main proc  
    mov ax, @data   ; Load data segment address  
    mov ds, ax      ; Set DS register  
    
    ; Display the first message (prompt)  
    mov ah, 9  
    mov dl, offset msg1  
    int 21h  

    ; Read first digit  
    mov ah, 1  
    int 21h  
    mov ah, 0  
    sub al, 48      ; Convert ASCII to number  
    mov bx, 100     ; Multiply by 100 to get the hundred's place  
    mul bx  
    mov num, ax     ; Store the result in num  

    ; Read second digit  
    mov ah, 1  
    int 21h  
    mov ah, 0  
    sub al, 48      ; Convert ASCII to number  
    mov bx, 10      ; Multiply by 10 to get the ten's place  
    mul bx  
    add num, ax     ; Add result to num  

    ; Read third digit  
    mov ah, 1  
    int 21h  
    mov ah, 0  
    sub al, 48      ; Convert ASCII to number  
    add num, ax     ; Add result to num  

    ; Print newline and carriage return  
    mov ah, 2  
    mov dl, 0Ah  
    int 21h  
    mov dl, 0Dh  
    int 21h  

    ; Display second message  
    mov ah, 9  
    mov dl, offset msg2  
    int 21h  

    ; Extract and print the hundred's place  
    mov bl, 100     ; Divisor = 100  
    mov ax, num     ; Load num into AX  
    div bl          ; AX / BL ? Quotient in AL, Remainder in AH  
    mov reminder, ah  
    mov quotient, al  
    mov dl, quotient  
    add dl, 48      ; Convert number to ASCII  
    mov ah, 2  
    int 21h         ; Print the hundred's place  

    ; Extract and print the ten's place  
    mov bl, 10      ; Divisor = 10  
    mov ah, 0       ; Clear AH before division  
    mov al, reminder  ; Load previous remainder  
    div bl          ; AL / BL ? Quotient in AL, Remainder in AH  
    mov reminder, ah  
    mov quotient, al  
    mov dl, quotient  
    add dl, 48      ; Convert number to ASCII  
    mov ah, 2  
    int 21h         ; Print the ten's place  

    ; Extract and print the one's place  
    mov dl, reminder  
    add dl, 48      ; Convert number to ASCII  
    mov ah, 2  
    int 21h         ; Print the one's place  

exit:  
    mov ah, 4Ch     ; Exit program  
    int 21h  

main endp  
end main  
