;------------------------------------------------------------------------
; Check Even or Odd
;Write an assembly program that takes an 8-bit number from the user and 
;checks whether it is even or odd using the IF-ELSE structure. 
;-----------------------------------------------------------------------
.model small
.stack 100h

.data

num db ?   ; Variable to store the input number

msg1 db "Enter a 3 digit number: $"  ;(3 digit input [0->256] for 2 or 1 digit use preceding 0's)
msg2 db 10,13,"The number is Odd. $"  
msg3 db 10,13,"The Number is Even. $" 

.code
main proc
    mov ax,@data
    mov ds, ax
    
    ; Display the prompt message
    mov ah,9
    mov dl, offset msg1
    int 21h
    
    ; Read first digit and multiply by 100
    mov ah,1
    int 21h
    sub al,48        
    mov bl,100       ; Multiply by 100
    mul bl
    mov num,al       
    
    ; Read second digit and multiply by 10
    mov ah,1
    int 21h
    sub al,48        
    mov bl,10        ; Multiply by 10
    mul bl
    add num,al       
    
    ; Read third digit and add directly
    mov ah,1
    int 21h
    sub al,48        
    add num,al       
    
    ;----------------------------------------------------------------
    ; Check if the number is even or odd
    mov al,num       ; Load num into AL
    mov ah,0         ; Clear AH for division
    mov bl,2         ; Divisor = 2
    div bl           ; AL / 2, remainder in AH
    
    cmp ah,1         ; Check if remainder is 1 (Odd condition)
    je odd           ; Jump to 'odd' if AH = 1
    
    cmp ah,0         ; Check if remainder is 0 (Even condition)
    je even          ; Jump to 'even' if AH = 0 
    
    ;------------------------------------------------------------------
    ; Display corresponding message.
    even:
    mov ah,9
    mov dl, offset msg3  ; Load even message address
    int 21h              ; Display even message
    jmp exit             ; Jump to exit
    
    odd:
    mov ah,9
    mov dl, offset msg2  ; Load odd message address
    int 21h              ; Display odd message
    jmp exit             ; Jump to exit
    ;-------------------------------------------------------------------
    exit:
    mov ah,4ch
    int 21h
    
main endp
end main
