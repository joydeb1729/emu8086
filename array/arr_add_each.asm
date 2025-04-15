;---------------------------------------------
;1. Adding a number to all values of the array
;---------------------------------------------

.model small
.stack 100h

.data
n dw 6                   ; Define the total number of elements in the array (6 elements)
arr db 12, 13, 45, 76, 87, 5 
num db 10                ; Value to be added to each array element
temp db ?                ; Temporary storage for the remainder during division

.code
main proc
    mov ax, @data       
    mov ds, ax           
    
    
    mov si, 0            ; Initialize SI register to point to the start of the array
    mov cx, n            ; Set loop counter CX to the number of elements in the array
    
    for:                 ; Label for the addition loop
    mov al,arr[si]       ; Load the current array element into AL
    add al,num           ; Add the value of 'num' (10) to the array element
    mov arr[si],al       ; Store the updated value back into the array
    inc si               ; Move to the next array element
    
    loop for             ; Decrement CX and repeat the loop if CX != 0
    
    mov cx,n             ; Reset loop counter to the number of elements for printing
    mov si,0             ; Reset SI to point to the first array element
    
    print:               ; Label for the printing loop
    mov ah,0             
    mov al, arr[si]      
    inc si               
    mov bl,10            
    div bl               
    mov temp,ah          
    mov dl,al           
    add dl,48            
    
    mov ah,2       
    int 21h         
    
    mov dl,temp       
    add dl,48        
    int 21h             
    
    mov dl,32            ; Load ASCII for space (' ') into DL
    int 21h            
    
    loop print          
    
    exit:                
    mov ah, 4ch         
    int 21h            
    main endp
end main
