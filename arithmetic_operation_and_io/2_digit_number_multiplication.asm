.model small  
.stack 100h  

.data  
msg1 db "Enter A: $"  ; Message prompt for first number  
msg2 db "Enter B: $"  ; Message prompt for second number  
msg3 db "A x B = $"  ; Message prompt for multiplication result  

a db ?   ; Variable to store first number (A)  
b db ?   ; Variable to store second number (B)  
ans db ?  ; Variable to store the multiplication result  
temp1 db ?  ; Temporary storage for calculations  
temp2 db ?  ; Temporary storage for calculations  

.code  

main proc  
    mov ax, @data  
    mov ds, ax  ; Initialize data segment  

    ; --- Input first number (A) ---
    mov ah, 9  
    mov dl, offset msg1  
    int 21h  ; Display "Enter A: "  

    mov ah,1  
    int 21h  ; Take first digit input  
    sub al, 48  ; Convert ASCII to numeric value  
    mov bl,10  
    mul bl  ; Multiply by 10 (for two-digit input)  
    mov a,al  ; Store in variable A  

    mov ah,1  
    int 21h  ; Take second digit input  
    sub al,48  ; Convert ASCII to numeric value  
    add al,a  ; Combine with previous digit  
    mov a,al  ; Store updated A  

    ; Print newline  
    mov ah,2  
    mov dl,0Ah  
    int 21h  
    mov dl, 0Dh  
    int 21h  

    ; --- Input second number (B) ---
    mov ah, 9  
    mov dl, offset msg2  
    int 21h  ; Display "Enter B: "  

    mov ah,1  
    int 21h  ; Take first digit input  
    sub al, 48  ; Convert ASCII to numeric value  
    mov bl,10  
    mul bl  ; Multiply by 10  
    mov b,al  ; Store in variable B  

    mov ah,1  
    int 21h  ; Take second digit input  
    sub al,48  ; Convert ASCII to numeric value  
    add al,b  ; Combine with previous digit  
    mov b,al  ; Store updated B  

    ; --- Multiplication (A * B) ---
    mov bl,10  
    mov al,b  
    mov ah,0  
    div bl  ; Split B into tens and ones digits  
    mov temp1,ah  ; Store ones digit of B  
    mov temp2,al  ; Store tens digit of B  

    mov ah,0  
    mov al, a  
    mov bl, temp1  
    mul bl  ; Multiply A with ones digit of B  
    mov ans,al  ; Store partial result  

    mov al,a  
    mov bl,temp2  
    mul bl  ; Multiply A with tens digit of B  
    mov bl,10  
    mul bl  ; Shift left by multiplying by 10  
    add al,ans  ; Add previous multiplication result  
    mov ans,al  ; Store final result  

    ; --- Printing the Result ---
    mov ah,2  
    mov dl,0Ah  
    int 21h  
    mov dl, 0Dh  
    int 21h  ; Print newline  

    mov ah, 9  
    mov dl, offset msg3  
    int 21h  ; Display "A x B = "  

    ; Convert and display 3-digit multiplication result  
    mov al,ans  
    mov ah,0  
    mov bl,100  
    div bl  ; Extract hundreds place  
    mov temp1,ah  ; Store remainder  
    mov dl,al  
    add dl,48  ; Convert to ASCII  
    mov ah,2  
    int 21h  ; Print hundreds digit  

    mov al,temp1  
    mov ah,0  
    mov bl,10  
    div bl  ; Extract tens place  
    mov temp1,ah  ; Store remainder  
    mov dl,al  
    add dl,48  
    mov ah,2  
    int 21h  ; Print tens digit  

    mov dl,temp1  
    add dl,48  
    int 21h  ; Print ones digit  

    ; --- Exit program ---  
    exit:  
    mov ah,4ch  
    int 21h  
    main endp  
end main  
