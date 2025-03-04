;---------------------------------------------------------------
; Write an assembly program to add two 16-bit numbers stored in memory
; and store the result in AX. If there is a carry, store it in DX.
; Example: If 1234H and 5678H are added, the result should be 68ACH.
;---------------------------------------------------------------

.model small         ; Defines the memory model as small (Code < 64KB, Data < 64KB)
.stack 100h         ; Defines a stack of 256 bytes (100h)

.data 

a dw 1234H          ; First 16-bit number stored in memory
b dw 5678H          ; Second 16-bit number stored in memory

.code
main proc
    mov ax, @data   ; Load the data segment address into AX
    mov ds, ax      ; Set DS (Data Segment Register) to the value in AX
    
    mov ah, 0       ; Clear AH register (ensuring AX is clean)
    mov al, 0       ; Clear AL register
    
    mov ax, a       ; Load the first 16-bit number from memory (a) into AX
    add ax, b       ; Add the second 16-bit number (b) to AX
                    ; Result of addition is stored in AX
    
    jc has_carry    ; If the addition generates a carry, jump to 'has_carry'
    
    jmp exit        ; If no carry, jump to 'exit' and terminate the program
    
has_carry:
    ; If carry occurs, execute this block
    inc dx          ; Increment DX to indicate that a carry occurred

exit:
    mov ah, 4Ch     ; DOS interrupt function to terminate the program
    int 21h         ; Call DOS interrupt to exit

main endp
end main
