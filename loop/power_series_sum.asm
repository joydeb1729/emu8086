; ------------------------------------------------------
; This program calculates the sum of the following series:
; 
;     S = 1x^1 + 2x^2 + 3x^3 + ... + nx^n
; ------------------------------------------------------

.model small   
.stack 100h    

.data         
n dw 5         
x dw 2         
res dw 0       ; res = 0 (stores the final sum of series)
temp dw ?      ; Temporary variable for division results
temp_c dw ?    ; Temporary variable to store the loop counter
pow dw ?       ; Variable for power calculation (not used in the code)

.code          
main proc
    mov ax, @data  ; Load address of data segment
    mov ds, ax     ; Initialize DS with the address of data segment
    
    mov cx,1       ; Initialize loop counter (i = 1)
    
    for_i:
    cmp cx,n       ; Compare i with n
    jg print_result ; If i > n, go to print_result
    
    mov temp_c,cx  ; Store i in temp_c
    mov ax,cx      ; Store i in ax
    mov cx,1       ; Initialize j = 1 for inner loop
    
    for_j: 
    cmp cx,temp_c  ; Compare j with i
    jg add_num     ; If j > i, go to add_num
    
    mov bx,x       ; Load base x into bx
    mul bx         ; Multiply ax by bx (ax = ax * bx)
    inc cx         ; Increment j
    jmp for_j      ; Repeat inner loop
    
    add_num:
    add res,ax     ; Add the computed power to res
    mov cx,temp_c  ; Restore i
    inc cx         ; Increment i
    
    jmp for_i      ; Repeat outer loop
    
    print_result:  ; Print the final result stored in res
    mov ax,res     ; Load res into ax
    mov bx,1000    ; Prepare to divide by 1000
    mov dx,0       ; Clear dx before division
    div bx         ; ax = res / 1000, remainder in dx
    mov temp,dx    ; Store remainder in temp
    cmp al,0       ; Check if quotient is 0
    je skip_thousand ; If quotient is 0, skip printing
    
    mov dl,al      
    add dl,48      
    mov ah,2       
    int 21h        
    
    skip_thousand:
    mov ax,temp   
    mov bx,100     ; Prepare to divide by 100
    mov dx,0       ; Clear dx
    div bx         ; ax = remainder / 100, remainder in dx
    mov temp,dx    ; Store new remainder
    cmp al,0       ; Check if quotient is 0
    je skip_hundred ; If quotient is 0, skip printing
    
    mov dl,al     
    add dl,48     
    mov ah,2       
    int 21h       
    
    skip_hundred:
    mov ax,temp    
    mov bx,10      ; Prepare to divide by 10
    mov dx,0       
    div bx         ; ax = remainder / 10, remainder in dx
    mov temp,dx    
    cmp al,0      
    je skip_ten    ; If quotient is 0, skip printing
    
    mov dl,al     
    add dl,48     
    mov ah,2       
    int 21h        
    
    skip_ten:
    mov ax,temp    ; Load remainder (last digit)
    mov dl,al      ; Move last digit into dl for printing
    add dl,48      
    mov ah,2       
    int 21h        
    
    exit:
    mov ah,4ch    
    int 21h        
    
    main endp
end main
``
