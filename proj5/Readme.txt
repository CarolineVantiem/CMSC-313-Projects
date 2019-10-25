Project Description

************************************************************************
0. Files:
************************************************************************

Makefile	- Makes the binaries for the provided assembly file
ReadMe.txt	- This file
proj5.c         - C file that contains libraries and sorting functions
bookcmp.asm     - This file does the comparison
test.sh         - Test file for the body of the project
driver.c        - Calls functions 
book.h          - Contains variables for book compare


List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

Program output matches expected

************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

make, chmod 777 ./test.sh
nasm -f elf64 -g -F dwarf bookcmp.asm
gcc -g driver.c proj5.c bookcmp.o -o proj5

Usage

./proj5 > output.txt
make test

************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

In proj5.c ...

I filled in the missing paramters for sort_books, with a pointer to
allBooks and the num of books.

I used a for loop to print the list of books.

In bookcmp.asm ...

I preserved rbx & rcx. Moved book1 and book2 year in ebx & ecx.
And comapred the values.

I wrote an index function to traverse thru the list. I used rdi, rdx, and rsi and TITLE_OFFSET
to get letter of book1 and book2 title.
And compared the values.

When the comparing is done, mov -1 in eax and jmp to end.


Then pop rcx, rsi, rdi and rbx off the top of the stack

************************************************************************
4. Limitations (if any)
************************************************************************

No limitations - No typescript needed


************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

sorting or organizing files or books.
Also for sorting something in a database.
