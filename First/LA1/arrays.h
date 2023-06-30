/**
 * @file que guarda as defenições das funcoes usadas no file arrays.c
*/
#ifndef CODE_ARRAYS_H
#define CODE_ARRAYS_H

#include "functions.h"

DATA *comma(long size);

void buildArray(STACK *pilha, char *token);

void exist_elem (STACK *pilha, DATA x);

void firstN(STACK *pilha, long x);

void lastN(STACK *pilha, long x);

char *rem_fstElem(char *, char *);

char *rem_lstElem(char *, char *);


#endif //CODE_ARRAYS_H
