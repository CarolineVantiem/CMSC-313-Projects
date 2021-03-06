	;;  Convert user input to hexadecimal number.
	;;
	;;  Assemble using NASM:  nasm -f elf64 hexConverter.asm
	;;  Compile with gcc:     gcc hexConverter.o cfunc.c -o converter.out
	;;

	%define STDIN         0
	%define STDOUT        1
	%define SYSCALL_EXIT  60
	%define SYSCALL_READ  0
	%define SYSCALL_WRITE 1
	%define BUFLEN 		  21


	SECTION .data	; initialized data section

msg1:	   db "Enter Number: "	; user prompt
len1:	   equ $-msg1		; length of first message

msg2:	   db "Invalid Input!", 10 ; error message
len2:	   equ $-msg2

msg3:	   db "Hexadecimal value is: " ; Feedback
len3:	   equ $-msg3

msg4:	   db 10		; Linefeed
len4:	   equ $-msg4

hexTable:	db '0123456789ABCDEF' ; table for hex conversion
	
	SECTION .bss	; uninitialized data section
buf:	    resb BUFLEN	; buffer for read
newstr:	 resb BUFLEN	; converted string
count:	  resb 4	; reserve storage for user input bytes

	SECTION .text	; Code section.
	global  main	; let gcc see entry point
	extern printhex	; This routine is defined in the c function
	extern printf	; This routine will be utilized in the c function

main:		nop		; Entry point.
start:				; address for gdb

	;;  prompt user for input
	;;
	mov rax, SYSCALL_WRITE ; write function
	mov rdi, STDOUT	; Arg1: file descriptor
	mov rsi, msg1	; Arg2: addr of message
	mov rdx, len1	; Arg3: length of message
	syscall	; 64-bit system call

	;;  read user input
	;;
	mov rax, SYSCALL_READ ; read function
	mov rdi, STDIN	; Arg1: file descriptor
	mov rsi, buf	; Arg2: addr of message
	mov rdx, BUFLEN	; Arg3: length of message
	syscall	; 64-bit system call

	;;  error check
	;;
	mov [count], rax ; save length of string read
	cmp rax, 0	; check if any chars read
	jle invalid	; <=0 chars read = not valid

	cmp rax, 21	; check if 21 characters were read
	je	read_OK	; 21 characters read, we are good
	cmp rax, 20	; check if 20 characters were read
	je	read_OK	; 20 characters read, we are good

invalid:	mov rax, SYSCALL_WRITE ; Or Print Error Message
	mov rdi, STDOUT	       ; Arg1: file descriptor
	mov rsi, msg2  ; Arg2: addr of message
	mov rdx, len2	; Arg3: length of message
	syscall	; 64-bit system call
	jmp     exit	; skip over rest

read_OK:

	;;  Loop for conversion
	;;  assuming count > 0
	;;

	mov	r14, 0		; counter
	mov	r15, 0		; second counter
	mov	r8, 0		; counter for ascii_dec

	mov	rsi, buf
	mov	rax, 0		; zero out rax
	mov	rcx, [count]	; length of user input
	dec	rcx		; rid of null ending char

	jmp	check

check:				; check if input is 0-9
	cmp	r8, rcx		; conditional
	je	restart_dec	; pre conditions to convert to dec
	mov	al, [rsi]	; get a char
	cmp	al, '0'		; check if char is at least '0'
	jb	invalid		; char not at least '0'
	cmp	al, '9'		; check if char is at most '9'
	ja	invalid		; char greater than '9' ASCII
	inc	rsi		; inc counter
	inc	r8		; inc string length
	jmp	check		; loop thru input

restart_dec:			; pre conditions before converting ASCII -> dec

	mov	r8, 0		; zero out counter
	mov	rcx, [count] 	; length of input
	dec	rcx		; rid of null ending char
	mov	rsi, buf
	mov	rax, 0		; zero out rax for multp.
	mov	rdi, 0		; zero out rax for converting
	jmp	ASCII_DEC

ASCII_DEC:			; convert ASCII -> DEC.

	mov	dil, [rsi]	; dil for store char
	sub	dil, '0'	; sub first char from 0
	add	rax, rdi	; add stored values
	inc	rsi		; inc counter
	inc	r8		; inc counter for loop
	cmp	r8, rcx		; at end of user input
	je	restart_hex	; convert to hex
	mov	rbx, 10		; multiply by
	mul	rbx		; mul. conversion
	jmp	ASCII_DEC	; keep looping thru

restart_hex:			; pre conditions before converting ASCII -> dec

	mov	r8, 0		; zero out counter
	mov	rcx, [count]	; length of input
	dec	rcx		; rid of null ending char
	mov	rsi, buf
	jmp	DEC_HEX		; go to convert dec -> hex

DEC_HEX:			; convert DEC -> HEX

	mov	rdx, 0		; zero out rdx
	mov	rbx, 16		; div by
	div	rbx		; div func.
	add	rdx, hexTable	; go to look up table
	mov	dil, byte [rdx]	; save char
	push	rdi		; push to stack
	inc	r15		; inc counter
	cmp	rax, 0		; exit when at end of string
	jnz	DEC_HEX		; keep looping till end of string

init:				; printout the precursor message
	mov rax, SYSCALL_WRITE 	; Print Message
	mov rdi, STDOUT		; Arg1: file descriptor
	mov rsi, msg3		; Arg2: addr of message
	mov rdx, len3		; Arg3: length of message
	syscall			; 64-bit system call

print:				; print hex value after conversion
	cmp	r14, r15	; comp counters for length
	je	init2		; print hex
	dec	r15		; stack length
	pop	rdi		; pop char off stack
	call	printhex	; call cfunc
	jmp	print		; keep printing

init2:				; printout the linefeed
	
	mov rax, SYSCALL_WRITE 	; Print Message
	mov rdi, STDOUT		; Arg1: file descriptor
	mov rsi, msg4		; Arg2: addr of message
	mov rdx, len4		; Arg3: length of message
	syscall		; 64-bit system call

	;;  final exit
	;;
exit:	   mov 	rax, SYSCALL_EXIT
	mov 	rdi, 0	; exit to shell
	        syscall
