;;; layout of the structure
%define TITLE_OFFSET 0
%define AUTHOR_OFFSET 48
%define PRICE_OFFSET 96
%define YEAR_OFFSET 104
%define NEXT_OFFSET 112

;;; our usual system call stuff
%define STDOUT 1
%define SYSCALL_EXIT  60
%define SYSCALL_WRITE 1

    SECTION .data
;;; Here we declare initialized data. For example: messages, prompts,
;;; and numbers that we know in advance

newline:        db 10

    SECTION .bss
;;; Here we declare uninitialized data. We're reserving space (and
;;; potentially associating names with that space) that our code
;;; will use as it executes. Think of these as "global variables"

    SECTION .text
;;; This is where our program lives.
global _start                               ; make start global so ld can find it
extern library
global authorsForPrice

printNewline:
        push rax
        push rbx
        push rcx
        push rdx
        push rsi

        mov rax, SYSCALL_WRITE
        mov rdi, STDOUT
        mov rsi, newline
        mov rdx, 1
        syscall

        pop rsi
        pop rdx
        pop rcx
        pop rbx
        pop rax
        ret

;;; rax should point to the string. on return, rax is the length
stringLength:
;;; Students: Feel free to use this code in your submission but you
;;; must add comments explaining the code to prove that you
;;; know how it works.

        push 	rsi		; preserve rsi register
        mov 	rsi, rax	; move rax contents into rsi stack
        mov 	rax, 0		; set rax to 0

loopsl:
        cmp 	[rsi], byte 0	; compare 
        je 	endsl		; if equal jmp out of loop --> pop stack

        inc 	rax		; increment rax - length of the string
        inc 	rsi		; increment rsi - get next char
        jmp 	loopsl		; keep incrementing

endsl:
        pop 	rsi		; pop off stack contents
        ret 			; return back to printName

;;; this label will be called as a subroutine by the code in driver.asm
authorsForPrice:
        ;; protect the registers we use
        push rax 		
        push rbx	
        push rcx	
        push rdx	
        push rsi	

        ;; print the first author in the library
        mov rsi, [library]

loop:	
	cmp	rsi, 0				; check if at end of lib.
	je	cleanUp				; go to clean up func.

	fld	qword[rsi+ PRICE_OFFSET] 	; get price at spec. location

	fcomp					; compare st(0) with st(1) pop register stack
	fstsw	ax				; loads the current status of the FPU onto AX
	cmp	ax, 3900h			; compare price values w ax and price at spec. author in libr.
	jl	printName			; if above price, print name at spec. author
	
	mov	rsi, [rsi+NEXT_OFFSET]
	jmp	loop 				; keep looping thru 
	
printName:

        lea rax, [rsi + AUTHOR_OFFSET]  ; Load-Effective-Address computes the address in
                                        ; the brackets and returns it instead of looking it up.

        call stringLength               ; after this, RAX will have the length of the author name

        mov rdx, rax                    ; copy it to the count register for the system call
        mov rax, SYSCALL_WRITE
        mov rdi, STDOUT
        lea rcx, [rsi + AUTHOR_OFFSET]
        push rsi                        ; preserve RSI
        mov rsi, rcx
        syscall

        pop rsi                         ; restore RSI

        call printNewline	        
        mov	rsi, [rsi+NEXT_OFFSET]  ; get next authr.
	jmp	loop			; keep looping thru lib.
	
cleanUp:
        fstp st0                        ; pop off top of stack

        pop rsi
        pop rdx
        pop rcx
        pop rbx
        pop rax
        
        ret
