;-----------------------------
;Take an array as input and print it
;------------------------------

.model small
.stack 100h

.data

arr db ?,?,?,?,?      ; Declare an array of 5 uninitialized bytes to store input characters
n dw 5                ; Total number of elements to process (array size)

.code
main proc
    mov ax, @data     
    mov ds, ax        

    mov cx,n          ; Set loop counter CX to the value of n (5) — total number of inputs expected
    mov si,0          ; Initialize index register SI to 0 — start at the beginning of the array

    input:            ; input loop
    mov ah,1         
    int 21h          
    mov arr[si],al    ; Store the entered character into the array at the current SI position
    inc si            ; Move SI to the next array position for the next input
    loop input        ; Decrease CX by 1, if CX ? 0, jump back to 'input' label and repeat

    mov cx,n          ; Reset loop counter for output — print `n` elements
    mov si,0          ; Reset SI to point to the start of the array

    mov ah,2         
    mov dl,10         ; Print New Line
    int 21h       
    mov dl,13         
    int 21h           

    print:            ; output loop
    mov dl,arr[si]    
    inc si            
    mov ah,2         
    int 21h        

    mov dl,32       
    int 21h          

    loop print       

    exit:           
    mov ah,4ch      
    int 21h      
    main endp
end main
