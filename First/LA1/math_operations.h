/**
 * @file que guarda as defenições das funcoes usadas no file math_operations.c
*/

#ifndef MATH_OPERATIONS_H
#define MATH_OPERATIONS_H

#include "functions.h"

void soma(STACK *pilha, DATA x, DATA y);
void sub(STACK *pilha, DATA x, DATA y);
void mult(STACK *pilha, DATA x, DATA y);
void divide(STACK *pilha, DATA x, DATA y);
void eleva(STACK *pilha, DATA x, DATA y);
void percentagem(STACK *pilha, DATA x, DATA y);
void mais1(STACK *pilha, DATA x);
void menos1(STACK *pilha, DATA x);
void e(STACK *pilha, DATA x, DATA y);
void ou(STACK *pilha, DATA x, DATA y);
void xore(STACK *pilha, DATA x, DATA y);
void note(STACK *pilha, DATA x);
void troca(STACK *pilha, DATA x, DATA y);
void troca3(STACK *pilha, DATA x, DATA y, DATA z);
void dupLast(STACK *pilha);

#endif
