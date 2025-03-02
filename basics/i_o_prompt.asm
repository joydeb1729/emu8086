.model small
.stack 100h  

.data
input_msg db "Enter a number : $"  
output_msg db "You Entered : $"  
num db ?    

.code

main proc
    mov ax, @data  
    mov ds, ax    

    ; Display input prompt
    mov ah, 9  
    lea dx, input_msg  
    int 21h    

    ; Read user input
    mov ah, 1  
    int 21h    
    mov num, al    

    ; Print newline
    mov ah, 2  
    mov dl, 0Ah  
    int 21h    
    mov dl, 0Dh  
    int 21h    

    ; Display output message
    mov ah, 9  
    lea dx, output_msg  
    int 21h    

    ; Print user-inputted character
    mov ah, 2  
    mov dl, num  
    int 21h    

exit:
    mov ah, 4Ch  
    int 21h    

main endp
end main
