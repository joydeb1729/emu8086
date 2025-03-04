.model small
.stack 100h

.data
    a db ?              ; Stores the number  
    sign_bit db ?       ; Stores the first input (could be a sign)  
    neg_flag db 0       ; Flag for negative numbers  
    
    pos_msg db 10,13,"The Number is positive $"  
    neg_msg db 10,13,"The Number is negative $"  

.code

main proc
    mov ax, @data  
    mov ds, ax          ; Initialize data segment  
    
    mov ah, 1
    int 21h             ; Read first character (could be a sign or a digit)  
    mov sign_bit, al    ; Store the first input in sign_bit  

    mov ah, 1
    int 21h             ; Read first digit  
    sub al, 48          ; Convert ASCII to integer  
    mov bl, 10          ; Prepare for multiplying by 10  
    mul bl              ; AL = AL * 10 (shift first digit to tens place)  
    mov a, al           ; Store the result in variable 'a'  

    ; Read second digit (ones place)  
    mov ah, 1
    int 21h             ; Read next character  
    sub al, 48          ; Convert ASCII to integer  
    add a, al           ; Add it to form the final number  

    ; Check if the first input was a negative sign ('-')  
    cmp sign_bit, 45    ; Compare sign_bit with ASCII value of '-'  
    je make_neg         ; If '-' is detected, jump to make_neg  
    
    jmp check           ; Otherwise, continue checking  

make_neg:
    neg a               ; Convert number to negative if sign was '-'  

check:
    mov bl, a           ; Move the final number into BL for comparison  
    cmp bl, 0           ; Compare it with 0  
    jge is_positive     ; If greater than or equal to 0, jump to is_positive  

is_negative:
    mov ah, 9
    mov dl, offset neg_msg  ; Load address of negative message  
    int 21h                 ; Print "The Number is negative"  
    jmp exit                ; Jump to exit  

is_positive:
    mov ah, 9
    mov dl, offset pos_msg   ; Load address of positive message  
    int 21h                 ; Print "The Number is positive"  

exit:
    mov ah, 4Ch
    int 21h                 ; Terminate program  

main endp    
end main
