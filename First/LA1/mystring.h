/**
 * @file que guarda as defenições das funcoes usadas no file mystring.c
*/
#ifndef CODE_MYSTRING_H
#define CODE_MYSTRING_H

#include "functions.h"

void rem_fstString(STACK *pilha);

void rem_lstString(STACK *pilha);

long findstr(char *, char *);

char * concat(DATA , DATA );

char * multconcat(DATA ,DATA );

char * firstN_String(char *s, long x);

char * lastN_String(char *s, long x);

#endif //CODE_MYSTRING_H
