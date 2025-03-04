.model small
.stack 100h

.data
    a db -25         ; Predefined number (change this to test different values)

    pos_msg db 10,13,"The Number is positive $"
    neg_msg db 10,13,"The Number is negative $"

.code

main proc
    mov ax, @data  
    mov ds, ax      ; Initialize data segment  

    mov bl, a       ; Load the predefined number into BL for checking
    cmp bl, 0       ; Compare it with 0  
    jge is_positive ; If >= 0, jump to is_positive  

is_negative:
    mov ah, 9
    mov dx, offset neg_msg  ; Load address of negative message  
    int 21h                 ; Print "The Number is negative"  
    jmp exit                ; Jump to exit  

is_positive:
    mov ah, 9
    mov dx, offset pos_msg   ; Load address of positive message  
    int 21h                 ; Print "The Number is positive"  

exit:
    mov ah, 4Ch
    int 21h                 ; Terminate program  

main endp    
end main
