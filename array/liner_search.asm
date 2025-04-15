;-----------------------------------------
;7. Search a number
;-----------------------------------------


.model small
.stack 100h

.data 
arr db 1,3,5,7,9,11,13,15,17,19   ; Array of 10 numbers

msg1 db "The Number is Found.$"      ; Message if key is found
msg2 db "The Number is not Found.$"  ; Message if key is not found
key db 11                            ; Number to search

.code
main proc
    mov ax, @data        
    mov ds, ax
    
    mov cx,10            ; Loop counter = 10
    mov si,0             ; Index to access array
    mov bl,key           ; Load key value into BL for comparision with arr element
    
    for:
    cmp arr[si], bl      ; Compare current array element with key
    je print_found       ; If equal, jump to print_found
    inc si               ; Move to next element
    loop for             ; Repeat until CX = 0
    
    jmp print_not_found  ; If not found after loop, jump to print_not_found
    
    print_found:
    mov ah,9             ; Function to display found message
    mov dl,offset msg1  
    int 21h              
    jmp exit             
    
    print_not_found:
    mov ah,9             ; Function to display not found message
    mov dl,offset msg2   
    int 21h              
    
    exit:
    mov ah,4ch           ; Terminate program
    int 21h
    main endp
end main
