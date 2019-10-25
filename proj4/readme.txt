Caroline Vantiem
Project Description

************************************************************************
0. Files:
************************************************************************

Makefile	- Makes the binaries for the provided assembly file
ReadMe.txt	- This file
proj4.asm	- The file you will be modifying and handing in
driver.asm      - invokes the authorsForDate function with several year
		  parameters to verify that it is operating correctly
library.o       - defines a linked list of books that can be used to test
                  the code.  

List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

============
Program output matches expected


************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

chmod +x ./test.sh
make

Usage

make test

************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

In authorsForPrice ...

I created a loop func. to go through the contents of the libr. stack
The loop first makes a check comparison if its at the end of the libr,
then get the specific price using price_offset, at that point in the
library from the library.o file.

I used fcomp, and then fstsw to load the current status of the fpu into
ax, then compares the input price to the price at that specific author.
It jumps to printName if the price is above, and in printName I added a
few lines of code to keep iterating thru the libr. because it will need to
search all of the prices that are above, not just one price.

Once it finds one price, I used NEXT_OFFSET to go to the next author in
the library and extract the price again. Once it is at the end of the lib.
the func. cleanUp gets called.


************************************************************************
4. Limitations (if any)
************************************************************************

No limitations - No typescript needed.


************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

searching through an online repository or service that sells
goods, for a specific price or price ranged item. Since this shows
the books for prices that are above the input price, the code
can be modified to be used to search for prices that are below
or that are in between two price ranges.
