; File: atbash.asm
;
; Convert user input - atbash cipher encryption
;
; Assemble using NASM: nasm -f elf64 atbash.asm
; Link with ld:        ld -o atbash atbash.o

%define STDIN		0
%define STDOUT		1
%define SYSCALL_EXIT	60
%define SYSCALL_READ	0
%define SYSCALL_WRITE	1
%define BUFLEN		256

	SECTION .data		; initialized data section

msg1:	db "Enter string: "	; user prompt
len1:	equ $-msg1		; length of first message

msg2:	db "Original: "		; original string
len2:	equ $-msg2		; length of second message

msg3:	db "Convert: "		; converted string
len3:	equ $-msg3		;

msg4:	db 10, "Read error", 10	; error message
len4:	equ $-msg4		;

; Look-up table - atbash cipher 
atbashTable:	db 'ZYXWVUTSRQPONMLKJIHGFEDCBAzyxwvutsrqponmlkjihgfedcba'

	SECTION .bss		; uninitialized data section

buf:		resb BUFLEN	; buffer for read
newString:	resb BUFLEN	; atbash encrypted string
counter:	resb 4		; reserve storage for user input bytes

	SECTION .text		; code section
	global _start		; let loader see entry point

_start:	nop			; entry point
start:				; address for gdb

	; prompt user input
	mov rax, SYSCALL_WRITE	; write function
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, msg1		; arg2: addr of message
	mov rdx, len1		; arg3: len of message
	syscall			; 64-bit system call

	; read user input
	mov rax, SYSCALL_READ	; read function
	mov rdi, STDIN		; arg1: file descriptor
	mov rsi, buf		; arg2: addr of message
	mov rdx, BUFLEN		; arg3: len of message
	syscall			; 64-bit system call

	; error check
	mov [counter], rax	; save length of string read
	cmp rax, 0		; check if any chars read
	jg  read_OK		; >0 chars read = ok
	mov rax, SYSCALL_WRITE	; or print error message
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, msg4		; arg2: addr of message
	mov rdx, len4		; arg3: len of message
	syscall			; 64-bit system call
	jmp	exit		; skip over rest
read_OK:

	; Loop for atbash cipher encryption
L1_init:
	mov	rcx, [counter]	; initialize count
	mov	rsi, buf	; point to start of buffer
	mov 	rdi, newString	; point to start of new string

L1_top:
	xor	rax, rax	;
	mov	rax, 0
	mov	al, [rsi]	; get a char
	inc	rsi		; update source pointer

	; check char - upper case
	cmp	al, 'A'		; less than 'A'
	jb	L1_cont		; go to next char
	cmp	al, 'Z'		; less than 'Z'
	jbe	upperCase	; go to atbashTable

	; check char - lower case
	cmp	al, 'a'		; less than 'a'
	jb	L1_cont		; go to next char
	cmp	al, 'z'		; less than 'z'
	jbe	lowerCase	; go to atbashTable

	jmp	L1_cont		; if conditions are not met

upperCase:
	add	rax, atbashTable ; reference table
	sub 	rax, 41h	 ; 5Ah = 'Z' 90 ASCII value | sub 41h = 'A' 65 ASCII value to convert
	mov	al, byte [rax]	 ; go to atbashTable
	jmp	L1_cont		 ; go to next char

lowerCase:
	add	rax, atbashTable ; reference table
	sub 	rax, 47h	 ; 7Ah = 'z' 122 ASCII value | sub 61h = 'a' 97 ASCII value
	mov	al, byte [rax]	 ; go to atbashTable
	jmp	L1_cont		 ; go to next char

L1_cont:
	mov	[rdi], al	; store char in new string
	inc	rdi		; update dest pointer
	dec	rcx		; update char counter
	jnz	L1_top		; loop back to top

L1_end:
	; print out user input
	mov rax, SYSCALL_WRITE	; print message
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, msg2		; arg2: addr of message
	mov rdx, len2		; arg3: len og message
	syscall			; 64-bit system call

	mov rax, SYSCALL_WRITE	; write user input
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, buf		; arg2: addr of message
	mov rdx, [counter]	; arg3: len of message
	syscall			; 64-bit system call

	; print out converted string
	mov rax, SYSCALL_WRITE	; print message
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, msg3		; arg2: addr of message
	mov rdx, len3		; arg3: len of message
	syscall			; 64-bit system

	mov rax, SYSCALL_WRITE	; print encrypted string
	mov rdi, STDOUT		; arg1: file descriptor
	mov rsi, newString	; arg2: addr of message
	mov rdx, [counter]	; arg3: len of message
	syscall			; 64-bit system call

	; final exit
exit:	mov rax, SYSCALL_EXIT	; exit system call
	mov rdi, 0		; no errors
	syscall			; call kernal
