/* Author: Caroline Vantiem
  Class:   CMSC 313 - Proj6
  File:    frac_heap.c
*/

#include <stdlib.h>
#include <stdio.h>
#include "frac_heap.h"

#define BLOCK 10 


union fraction_block_u {
  union fraction_block_u *next;
  fraction new_Frac;
};

typedef union fraction_block_u fraction_block;
static fraction_block *head;


/* Func:    init_heap()
   Purpose: initializes free block list
*/
void init_heap() {
  head = NULL;
}


/* Func:    *new_frac()
   Purpose: returns a ptr to fractions
*/
fraction *new_frac() {
  fraction_block *temp;

  // calc. if theres more memory
  if (head == NULL) {
    head = malloc(sizeof(fraction_block) * BLOCK);

    // no more memory
    if (head == NULL) {
      printf("Error: No more memory to be allocated.\n");
      exit(1);
    }

    printf("called malloc(%d): return %p\n\n", sizeof(fraction_block) * BLOCK, head);

    // print out contents of list
    int i;
    for (i = 0; i < BLOCK; i++) {
      if (i == BLOCK - 1) {
	head[i].next = NULL;
      }
      else {
	head[i].next = &head[i + 1];
      }
    }
  }

  // go to next frac
  temp = head;
  head = head->next;
  return &(temp->new_Frac);
}


/* Func:    del_frac(fraction *frac)
   Purpose: adds ptr fraction to free list block
*/
void del_frac(fraction *frac) {
  // null at frac
  if (frac == NULL) 
    printf("Error: del_frac() called on NULL pointer.\n");
  
  else {
    fraction_block *temp;
    temp = (fraction_block *) frac;

    // set head to temp frac
    temp->next = head;
    head = temp;
  }
}


/* Func:    dump_heap()
   Purpose: print out contents of list / address.
*/
void dump_heap() {
  // print headers
  char begin_dump[] = "***** BEGIN HEAP DUMP *****";
  char end_dump  [] = "***** END HEAP DUMP *****";

  printf("%s\n\n", begin_dump);

  fraction_block *ptr = head;

  while (ptr != NULL) {
    printf("      %p\n", ptr);
    ptr = ptr->next;
  }
  
  printf("\n");
  printf("%s\n\n", end_dump);
}
