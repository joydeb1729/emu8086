.model small
.stack 100h

.data

msg1 db "Enter Num1 : $"
msg2 db "Enter Num2 : $"
msg3 db "Num1 - Num2 = $"

num1 db ?
num2 db ?



.code

main proc
    mov ax, @data
    mov ds, ax
    
    mov ah,9
    mov dl, offset msg1
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
    mov num1,al
    int 21h
    sub al,21h
    mov num2,al
    
    