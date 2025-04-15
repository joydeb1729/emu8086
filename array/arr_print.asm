;-------------------------------
;Print all the element of an array
;------------------------------


.model small
.stack 100h

.data
arr db 1,2,3,4,5,6,7,8,9   ; Array of numbers 1 to 9

.code
main proc
    mov ax, @data         ; Initialize data segment
    mov ds, ax
    
    mov cx,9              ; Loop counter = 9
    mov si, offset arr    ; SI points to start of array
    ;mov si, 0            ; This would set SI to 0 instead of the address of the array                                 
    mov ah,2              ; Function to display character
    
    ;loop for: Decrements cx and jumps to for: if cx != 0.
    for:
    mov dl,[si]           ; Load array element into DL
    ;mov dl,arr[si]       ; Alternative syntax to access array element.
    add dl,48             ; Convert number to ASCII
    int 21h               ; Print character in DL
    inc si                ; Move to next array element
    loop for              ; Repeat until CX = 0
    
    mov ah,4ch            ; Terminate program
    int 21h
    main endp
end main
