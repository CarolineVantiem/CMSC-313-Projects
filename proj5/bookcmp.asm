; File: bookcmp.asm
;
;Defines the bookcmp subroutine for use by the sort algorithm in sort_books.c
;
    
%define TITLE_OFFSET 0
%define AUTHOR_OFFSET 41
%define YEAR_OFFSET 64

        SECTION .text                ; Code section.
        global  bookcmp              ; let loader see entry point

bookcmp:
    push   rbp                       ; push the base pointer
    mov    rbp, rsp                  ; move stack pointer onto rbp (Prologue)

    push   rdi                       ; push registers we want to use
    push   rsi
        
    mov    rdi, [rbp - 8]            ; move first book into rdi
    mov    rsi, [rbp - 16]           ; move second book into rsi
                                     ; fetch the year field
                                     ; and compare the year field to book1's
                                     ; If they're different, do not sort, treat the titles as lexicographically equivalent
    push   rbx			     ; push rbx to preserve
    push   rcx			     ; push rcx to preserve

    mov	   ebx, dword [rdi + YEAR_OFFSET] ; book 1's year in ebx
    mov    ecx, dword [rsi + YEAR_OFFSET] ; book 2's year in ecx

    cmp    ebx, ecx		     ; jmp if book 1 is greater
    jne    cmpDone		     ; jmp if else
	
cmpTitles:                           ; Fall through to here if years same
                                     ; Compare the book title strings
    xor    rdx, rdx		     ; zero out rdx
    mov    rdx, 0		     ; move zero in rdx - increment

index:			             ; traverse thru list
    xor    rbx, rbx		     ; zero out rbx
    xor    rcx, rcx		     ; zero out rcx

    mov    ebx, dword [rdi + rdx + TITLE_OFFSET] ; get letter of book 1's title
    mov    ecx, dword [rsi + rdx + TITLE_OFFSET] ; get letter of book 2's title

    cmp    bl, cl		     ; compare chars
    jg     L_gt			     ; if book1's char is greater - jump Ll_gt
    jl     L_lt			     ; jmp otherwise

    inc    rdx			     ; increment to next char
    jmp    index		     ; jmp back to index - to index thu list

cmpDone:                             ; Things to do after titles are compared
    mov    eax, -1                   ; -1 to eax
    jmp    end			     ; jmp to end when done

L_lt:
    mov    rax, -1                   ; book1 is strictly less than book2
    jmp    end
    
L_eq:    
    mov    rax, 0                    ; book1 equals book2
    jmp    end
    
L_gt:    
    mov    rax, 1                    ; book1 is strictly greater than book2

    ;; Clean up and finish
end:
    pop    rcx
    pop    rbx	
    pop    rsi                       ; clean up
    pop    rdi
    leave                            ; Sets RSP to RBP and pops off RBP (Epilogue)
    ret
