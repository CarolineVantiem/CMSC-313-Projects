Project Description

************************************************************************
0. Files:
************************************************************************

ReadMe.txt	- This file
atbash.asm	- The file you will be modifying and handing in

List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

Input:  abcdef
Output: zyxwvu

Input:  AbCdEfGhI
Output: ZyXwVuTsR

Input:  NoPqRsTuV
Output: MlKjIhGfE

Input:  1+1=Two
Output: 1+1=Gdl

Input:  retriever@umbc.edu
Output: ivgirvevi@fnyx.vwf

Input:  1 One 2 Two 3 Three 4 Four 5 Five 6 Six
Output: 1 Lmv 2 Gdl 3 Gsivv 4 Ulfi 5 Urev 6 Hrc

* only the enter key was input*
Input:  
Output:

Input:  'quotes!'
Output: 'jflgvh!' 

Input:  arithmetic+-%^&*
Output: zirgsnvgrx+-%^&*

Input:  wefjhdjw^%^&%&^$$
Output: dvuqswqd^%^&%&^$$   

************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

nasm -f elf64 atbash.asm
ld -o atbash atbash.o

Usage

./atbash

************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

In .data section ...

Created initialized data for the user to enter a string, and initialized data
for the original and converted string.

Created a lookup table called atbashTable and defined bytes (db)
for the atbash cipher encryption from Z-A, z-a.


In .bss section ...

Created uninitialized buf, and newString and counter for the program.


In .text section ...

Called the syscall_write function to prompt user for input, then called
syscall_read func. to read the string.

Created a loop for the atbash cipher.
Created initiazlised counter, buf and newString for the cipher.

Started off getting one char, and updating the source pointer.
Then I checked if the char was upper-case or lower-case and
depeneding on the case-sensitivity, the code compares the current
char with the ASCII value in functions upperCase or lowerCase.

Upper case funct. sub 41h becauase 5Ah corresponds to 'Z' which is 90 on ASCII
table and sub 41h  = 'A' 65 ASCII value to convert.
Lower case funct. sub 47h because 7Ah corresponds to 'z' which has an ASCII value of 122
and 61h corrresponds to 'a' 97 ASCII value.

I used a lookup table in atbash.asm to 
convert the character value input into an
offset by subtracting the ASCII value for 
lower and upper case. 

Then I cont to the next char with L1_cont.

In L1_end, I call SYSCALL_WRITE to print the user input message, and
print out msg2 which is the original and print out msg4 which is the
converted atbash encryption.

Then I exit the system call and call kernal.

************************************************************************
4. Limitations (if any)
************************************************************************

No Limitations - All test cases passed

No typescript needed.

************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

encrypting simple and complex phrases
that are case-sensitive and include special
characters and symbols.

This project could also be useful for ...

learning how loops and variables work together 
in assembly. And how the computer generates each 
original and final letter through loops and asm
commands. 

This project could be useful for ...

creating and encrypting messages or
for passwords that need to kept secret
so that people cannot encode the password
or secret message. Although the atbash cipher
doesn't map to a key it can still be useful
to have encrypted messages
