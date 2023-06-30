/**
 * @file que guarda as defenições das funcoes usadas no file stack.c
 */

#ifndef STACK_H
#define STACK_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/**
    compile comand:
    gcc -std=gnu11 -Wall -Wextra -pedantic-errors -O *.c -lm
*/


/**
    Esta linha define uma macro MAX como sendo 10240
*/
#define MAX     10240

#define VAR(s,name) s->var[toChar(name) - 'A']


/**
    define um tipo de da           \
    definA      po de aa 10        \
    definB      po de ba 11        \
    definC      po de ca 12        \
    definD      po de da 13        \
    definE      po de ea 14        \
    definF      po de fa 15        \
     os vXlores a frenxe 0        po de ba 11        \
    definY       po de ya 1        \
    definZ       po de za 2        \
 das variaveis sao potencias de dois
*/
typedef enum {LONG = 1, DOUBLE = 2, CHAR = 4, STRING = 8, ARRAY = 10} TYPE;

/** DATA */
typedef struct data {
    /** a mascara da variavel */
    TYPE tipo;
    /** Long */
    long LONG;
    /** Double*/
    double DOUBLE;
    /** Char */
    char CHAR;
    /** String */
    char *STRING;
    /** Array */
    struct stack *ARRAY;
} DATA;                                                       // e o tipo de dados


/** Stack */
typedef struct stack{
    /** Stack pointer */
    int sp; //stack pointer, a posicao onde vai ser colocado o proximo valor
    /** Armazena os valores da stack  */
    DATA *valores;
    /** Tamanho maximo da stack */
    int tamanho;
    /** Variaveis */
    DATA var[26];
} STACK;

int has_type(DATA elem, int mascara);

/**
 * Esta é a funcao responsável por verificar se o char que lhe foi atribuido é uma letra maiúscula
 */
int isUpper(char c);

/**
 * Esta é a função responsável por alterar o valor da variável
 */
void changeVar(STACK *pilha, char name, DATA value);

STACK *createStack();

/**
 * Esta é a função responsável por definir as variáveis pré-definidas
 */
void buildVars(STACK *pilha);

void push (STACK *pilha, DATA val);

/**
 * Esta é a função responsável por inserir na pilha um array de tamanho (size)
 */
void push_array(STACK *pilha, DATA *arr, long size);

DATA pop (STACK *pilha);

DATA topo(STACK *pilha);

int is_empty(STACK *pilha);

void print_stack(STACK *pilha);


/**
 * Define funções macros, dependendo do tipo de dados que se pretente inserir na pilha (push) ou remover (pop).
 */
#define STACK_OPERATION_PROTO(_type, _name) \
    void push_##_name(STACK *pilha, _type val); \
    _type pop_##_name(STACK *pilha);

STACK_OPERATION_PROTO(long, LONG)
STACK_OPERATION_PROTO(double , DOUBLE)
STACK_OPERATION_PROTO(char, CHAR)
STACK_OPERATION_PROTO(char *, STRING)



#endif