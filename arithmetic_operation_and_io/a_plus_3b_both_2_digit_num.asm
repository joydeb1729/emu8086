.model small
.stack 100h

.data

msg1 db "Enter A : $"  ; Message to prompt user for first number input
msg2 db "Enter B : $"  ; Message to prompt user for second number input
msg3 db "A + 3B = $"            ; Message to display sum result

a db ?  ; Variable to store first number
b db ?  ; Variable to store second number

r1 db ?  ; Stores the remainder of first number when divided by 10 (units place)
r2 db ?  ; Stores the remainder of second number when divided by 10 (units place)
q1 db ?  ; Stores the quotient of first number when divided by 10 (tens place)
q2 db ?  ; Stores the quotient of second number when divided by 10 (tens place)

sum db ?  ; Stores the final sum result
temp db ?   ; Temporary storage variable

.code

main proc
    ; Initialize Data Segment
    mov ax, @data
    mov ds, ax
    
    ; Display "Enter Number1 :"
    mov ah, 9
    mov dl, offset msg1
    int 21h
    
    ; Input first number (2-digit)
    mov ah,1    ; Read first digit
    int 21h
    sub al,48   ; Convert ASCII to integer
    mov bl,10
    mul bl      ; Multiply by 10 to shift digit to tens place
    mov a,al
    
    mov ah,1    ; Read second digit
    int 21h
    sub al,48   ; Convert ASCII to integer
    add al,a    ; Add to previous value
    mov a, al   ; Store final 2-digit number in 'a'
    
    ; Print new line
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl, 0Dh
    int 21h
    
    ; Display "Enter Number2 :"
    mov ah, 9
    mov dl, offset msg2
    int 21h
    
    ; Input second number (2-digit)
    mov ah,1    ; Read first digit
    int 21h
    sub al,48   ; Convert ASCII to integer
    mov bl,10
    mul bl      ; Multiply by 10 to shift digit to tens place
    mov b,al
    
    mov ah,1    ; Read second digit
    int 21h
    sub al,48   ; Convert ASCII to integer
    add al,b    ; Add to previous value
    
    ;for a+3b
    mov bl,3    
    mul bl      ; al = b x 3
    
    mov b, al   ; Store final 2-digit number in 'b'
    
    ; Print new line
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl, 0Dh
    int 21h
    
    ; Extract digits from first number
    mov al, a
    mov ah,0
    mov bl, 10
    div bl      ; Divide by 10 to get quotient (tens place) and remainder (units place)
    mov r1,ah   ; Store remainder (units place)
    mov q1,al   ; Store quotient (tens place)
    
    ; Extract digits from second number
    mov al, b
    mov ah,0
    mov bl, 10
    div bl      ; Divide by 10 to get quotient (tens place) and remainder (units place)
    mov r2,ah   ; Store remainder (units place)
    mov q2,al   ; Store quotient (tens place)
    
    ; Add unit place digits
    mov al,r1
    add al,r2
    mov temp, al   ; Store sum of unit digits in temp
    
    ; Add tens place digits
    mov al, q1
    add al, q2
    mov bl,10
    mul bl      ; Multiply tens place sum by 10 to shift back
    add al,temp ; Add unit place sum
    mov sum,al  ; Store final sum result
    
    ; Print new line
    mov ah,2
    mov dl,0Ah
    int 21h
    mov dl, 0Dh
    int 21h
    
    ; Display "Sum ="
    mov ah, 9
    mov dl, offset msg3
    int 21h
    
    ; Extract and print hundreds place (if any)
    mov al,sum
    mov ah,0
    mov bl,100
    div bl       ; Divide by 100 to get hundreds place
    mov temp,ah  ; Store remainder for next step
    mov dl,al
    add dl,48    ; Convert to ASCII
    mov ah,2
    int 21h      ; Print hundreds place (if applicable)
    
    ; Extract and print tens place
    mov al,temp
    mov ah,0
    mov bl,10
    div bl       ; Divide by 10 to get tens place
    mov temp,ah  ; Store remainder for next step
    mov dl,al
    add dl,48    ; Convert to ASCII
    mov ah,2
    int 21h      ; Print tens place
    
    ; Print units place
    mov dl,temp
    add dl,48    ; Convert to ASCII
    mov ah,2
    int 21h      ; Print units place
    
    exit:
    mov ah, 4ch  ; Exit program
    int 21h
    main endp
end main
