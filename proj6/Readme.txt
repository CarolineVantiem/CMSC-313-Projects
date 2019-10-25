Project Description

************************************************************************
0. Files:
************************************************************************

ReadMe.txt	- This file
frac_heap.h	- .h file w func declarations
frac_heap.c	- main file w c program
test1-6.c  	- test files 1-6
typescript  	- shows that the test programs compiled and ran.


List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

See typescript

************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

make proj6
make test1.out
make test2.out
make test3.out
make test4.out
make test5.out
make test6.out

Usage

./proj6
./test1.out
./test2.out
./test3.out
./test4.out
./test5.out
./test6.out

************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

I initialized a ptr of type fraction_block called head to NULL
in the init_heap(). Initializes an empty free list.

In new_frac(), I check to see if theres more memory. If there is then I
set the head to malloc() with parameters of the size of the block mult. by
10 new blocks. And if there isn't then print an error.

And print out contents of the head[i].

In del_frac() I had a ptr to frac that adds the item to the free block
list.

In dump_heap(), I printed out the headers and printed out the address
of each block on the free list. Prints out "free list is empty" if
the free list is empty. 


************************************************************************
4. Limitations (if any)
************************************************************************

No limitations - Typescript for showing program compiles and runs with
all test files.

************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

practicing using pointers and dynamic memory in C.
Also useful for keeping track of a heap, with fractions.
