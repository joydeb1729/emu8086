;----------------------------------
; 1*x + 2*x + ... + n*x = ? (16-bit version)
; Final result digits will be displayed
;----------------------------------

.model small
.stack 100h  ; Define stack size

.data
n dw 10      ; 16-bit variable for 'n'
x dw 5       ; 16-bit variable for 'x'
res dw 0     ; 16-bit variable to store the result
temp dw ?    ; Temporary variable for remainder storage  

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax
    
    mov cx, 1     ; Initialize loop counter (starting from 1)
    mov bx, x     ; Load 'x' value into BX
    
    for:
    cmp cx, n     ; Compare CX with n (loop limit)
    jg print_result  ; If CX > n, jump to print_result
    
    mov ax, cx    ; Move CX (loop counter) into AX                
    mul bx        ; Multiply AX by BX (AX = CX * X)
                                                                   
    add res, ax   ; Add the result to 'res' (accumulate sum)
    
    inc cx        ; Increment counter
    jmp for       ; Repeat loop
    
    
    ; Once the sum is calculated, print the result
    print_result:
    
    mov ax, res   ; Load result into AX
    mov dx, 0     ; Clear DX for division
    mov bx, 1000  ; Divide by 1000 to get thousands place
    div bx        ; AX / 1000, quotient in AX, remainder in DX
    mov temp, dx  ; Store remainder in temp
    
    cmp ax, 0     ; Check if quotient is zero (skip leading zeros)
    je skip_thousands
    add al, 48    
    mov dl, al
    mov ah, 2
    int 21h       
    
    skip_thousands:
    mov ax, temp  ; Load remainder from previous division
    mov dx, 0
    mov bx, 100   ; Divide by 100 to get hundreds place
    div bx
    mov temp, dx  ; Store remainder in temp
    
    cmp ax, 0     ; Check if quotient is zero (skip leading zeros)
    je skip_hundred
    add al, 48    
    mov dl, al
    mov ah, 2
    int 21h       
    
    skip_hundred:
    mov ax, temp  ; Load remainder from previous division
    mov dx, 0
    mov bx, 10    ; Divide by 10 to get tens place
    div bx
    mov temp, dx  ; Store remainder in temp
    
    cmp al, 0     ; Check if quotient is zero (skip leading zeros)
    je skip_ten
    add al, 48    
    mov dl, al
    mov ah, 2
    int 21h       
    
    skip_ten:
    mov ah, 2
    mov bx, temp  ; Load last remaining digit
    mov dl, bl    ; Move it to DL for printing
    add dl, 48    
    int 21h       ; Print last digit

    ; Exit the program
    exit:
    mov ah, 4ch
    int 21h
    main endp
end main