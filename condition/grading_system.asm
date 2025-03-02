.model small
.stack 100h

.data
msg1 db "Enter 3 digit mark : $"      ; Prompt message for input (must be 3 digit (0 -> 100) [add preceding 0 for 2 or 1 digit marks]) 
msg2 db 10,13,"Your Grade : $"        ; Message to display "Your Grade" 

a_plus db "A+ $"                       ; Grade A+
a db "A $"                             ; Grade A
a_minus db "A- $"                      ; Grade A-
b db "B $"                             ; Grade B
c db "C $"                             ; Grade C
d db "D $"                             ; Grade D
f db "F $"                             ; Grade F

num db ?                               ; Variable to store the total marks

.code
main proc
    ; Initialize data segment
    mov ax, @data
    mov ds, ax
    
    ; Display "Enter 3 digit mark :"
    mov ah, 9
    mov dx, offset msg1
    int 21h
    
    ; Read the first digit of the mark (hundreds place)
    mov ah, 1
    int 21h
    sub al, 48          
    mov bl, 100         ; Multiply by 100 for hundreds place
    mul bl
    mov num, al         ; Store result in num
    
    ; Read the second digit of the mark (tens place)
    mov ah, 1
    int 21h
    sub al, 48          
    mov bl, 10          ; Multiply by 10 for tens place
    mul bl
    add num, al         

    ; Read the third digit of the mark (ones place)
    mov ah, 1
    int 21h
    sub al, 48          
    add num, al         
    
    ; Display "Your Grade :"
    mov ah, 9
    mov dx, offset msg2
    int 21h

    ; Compare the total marks and determine the grade
    mov bl, num         ; Load total marks into bl

    cmp bl, 80          ; If marks >= 80, jump to A+
    jge if1
    
    cmp bl, 70          ; If marks >= 70, jump to A
    jge if2
    
    cmp bl, 60          ; If marks >= 60, jump to A-
    jge if3
    
    cmp bl, 50          ; If marks >= 50, jump to B
    jge if4
    
    cmp bl, 40          ; If marks >= 40, jump to C
    jge if5
    
    cmp bl, 33          ; If marks >= 33, jump to D
    jge if6
    
    cmp bl, 0           ; If marks >= 0, jump to F
    jge if7

    ; Grade A+ (if marks >= 80)
if1:
    mov ah, 9
    mov dx, offset a_plus
    int 21h
    jmp exit

    ; Grade A (if marks >= 70 but < 80)
if2:
    mov ah, 9
    mov dx, offset a
    int 21h
    jmp exit

    ; Grade A- (if marks >= 60 but < 70)
if3:
    mov ah, 9
    mov dx, offset a_minus
    int 21h
    jmp exit

    ; Grade B (if marks >= 50 but < 60)
if4:
    mov ah, 9
    mov dx, offset b
    int 21h
    jmp exit

    ; Grade C (if marks >= 40 but < 50)
if5:
    mov ah, 9
    mov dx, offset c
    int 21h
    jmp exit

    ; Grade D (if marks >= 33 but < 40)
if6:
    mov ah, 9
    mov dx, offset d
    int 21h
    jmp exit

    ; Grade F (if marks < 33)
if7:
    mov ah, 9
    mov dx, offset f
    int 21h
    jmp exit

exit:
    ; Exit the program
    mov ah, 4Ch       
    int 21h
main endp
end main
