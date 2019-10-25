Project Description

************************************************************************
0. Files:
************************************************************************

ReadMe.txt	- This file
textSearch.asm	- The file you will be modifying and handing in


List expected inputs/outputs

************************************************************************
1. Expected inputs/outputs
************************************************************************

Input:  K
Output: Text you searched for, appears at 0 characters after the first.

Input:  Rider
Output: Text you searched for, appears at 7 characters after the first.

Input:  er,
Output: Text you searched for, appears at 253 characters after the first.

Input:  ht.
Ouput:  Text you searched for, appears at 287 characters after the first.

Input:  anger
Ouput:  Text you searched for, appears at 39 characters after the first.

Input:  criminals who operate above the law
Output: Text you searched for, appears at 206 characters after the first.

Input: cent
Output: Text you searched for, appears at 159 characters after the first.

Input:  Knight Rider,
Ouput:	Text you searched for, appears at 243 characters after the first.

Input:  a crusade
Output: Text you searched for, appears at 116 characters after the first.

Input:  random@3456
Output: String not found!


************************************************************************
2. How to compile and use this project
************************************************************************

Compilation

nasm -f elf64 textSearch.asm
ld -o textSearch textSearch.o

Usage

./textSearch


************************************************************************
3. Functionality (describe your contributions here)
************************************************************************

I implemented the naive string function with  4 functions.
A loop to traverse through the substring and through record.
A compare function to compare each char with the chars of record.
Next to get the next char in the substring and record and clear to
implement when the substring is not a match.

I have 3 counters and 1 register set to 0 to keep track of the first char
the substring is found at.

I have the compare function to compare each P[n] to T[m] of the substring
and text.

Then I loop until the end of record and call nope if the substring is not
in the text.

I used different registers for the buf and record and more registers for
counters and implemented jmps, je, and jne and mov and dec.

************************************************************************
4. Limitations (if any)
************************************************************************

No Limitations - All test cases passed

No typescript needed.


************************************************************************
5. Applications (your thoughts) of this project
************************************************************************

This project could be useful for ...

searching for substrings in documents or texts. 

It could also be useful for ...

implementing different registers in asm and
to see how to get the index of each register
and to practice using cmp, and jmps, je and jne.

This project can be useful for ...

Find the first instance of a character or string
in a text but could also be applied to numbers
or other type of numeric values that might be
used as data or needing to find a specific
first number in a sequence.
