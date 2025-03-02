.model small
.stack 100h

.data
input_prompt1 db "Enter number 1: $"
input_prompt2 db "Enter number 2: $"
output_prompt db "Summation = $"
num1 db ?
num2 db ?

.code

main proc
    mov ax,@data
    mov ds,ax
    
    mov ah,9
    lea dx,input_prompt1
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
    mov num1,al
    
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    mov ah,9
    lea dx,input_prompt2
    int 21h
    
    mov ah,1
    int 21h
    sub al,48
    mov num2,al
    
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl,0Dh
    int 21h
    
    mov ah,9
    lea dx,output_prompt
    int 21h
    
    mov ah,2
    mov dl,num1
    add dl,num2
    add dl,48
    int 21h
    
    exit:
    mov ah,4ch
    int 21h
    main endp
end main
