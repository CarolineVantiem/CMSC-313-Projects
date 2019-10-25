Project Description

************************************************************************
0. Files:
************************************************************************

ReadMe.txt		- This file
hexConverterh.asm	- The file you will be modifying and handing in
cfunc.c 		- Printing function


List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

Enter Number: 18446744073709551615
Hexadecimal value: FFFFFFFFFFFFFFFF

Enter Number: afadf
Invalid Input!

Enter Number: 245453
Invalid Input!

Enter Number: afdg dbdgbsgbfnnhnfhnh45647637
Invalid Input!

Enter Number: 3564276575375787dfjhfdjdtj
Invalid Input!

Enter Number: 1107895634578278122
Hexadecimal value is: F600935B33E86EA

Enter Number: 9223372036854775808
Hexadecimal value is: 8000000000000000

Enter Number: 12683270251100288260
Hexadecimal value is: B0040718331CB504

Enter Number: 15683272751237288260
Hexadecimal value is: D9A62D79450FD144

Enter Number: 9346678735677288564
Hexadecimal value is: 81B612CA0DBDF074


************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

nasm -g -f elf64 -F dwarf hexConverter.asm
gcc -g hexConverter.o cfunc.c -o converter.out


Usage

./converter.out


************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

I check the user input for ASCII char that aren't 0-9.
Then goes into a ASCII -> DEC loop that stores the multiplied
value in dil.

Once the string is converted, it goes into a dec-hex loop which divides
rax by 16 and stores the values in a stack which I use push and pop rdi.

Then I print out the stack by calling printhex and popping the rdi.


************************************************************************
4. Limitations (if any)
************************************************************************

No type script needed - All test cases passed


************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

converting any ASCII value to decimal and then to hexadecimal.
This could also convert ASCII to any base number like binary or
octal because the code can be changed to divide by a different
number or it can be changed to convert from ASCII to other
values.

This project could be useful for ...

an easy conversion calculator. 
