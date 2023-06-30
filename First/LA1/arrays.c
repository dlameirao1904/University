#include "arrays.h"
/**
 * Esta é a funcao responsável por criar um array que vai do 0 ate a variavel do tipo DATA -1
 * comando 5 , -> 01234
 *
 * @return array, devolve o array criado
 */
DATA *comma(long size){
    DATA *array = (DATA *) malloc(sizeof (DATA) * size);
    long i;
    for(i=0; i<size; i++)
        array[i].LONG = i;

    return array;
}
/**
 * Esta é a funcao responsável por remover o primeiro elemento de uma string
 *
 * @return n, devolve a string sem o primeiro elemento
 */
char *rem_fstElem(char *s, char *c){

    char *n = malloc(sizeof(char)*strlen(s)); //alocar memoria para uma string auxiliar
    unsigned long i;                                         // string pointer
    for(i=0; i < strlen(s); i++){
        n[i] = s[i+1];                             // copiar os valores da string original sem o primeiro elem
    }
    *c = s[0];                                     // atribuir a varivel c o valor do primeiro elemento da string original
    return n;                                      // devolver a string sem o primeiro elemento
}

/**
 * Esta é a funcao responsável por remover o ultimo elemento de uma string
 *
 * @return n, devolve a string sem o ultimo elemento
 */
char *rem_lstElem(char *s, char *c){

    char *n= malloc(sizeof(char)*strlen(s)-1);
    unsigned long i;
    for(i=0; i < strlen(s); i++){
        if(i < strlen(s)-1)  n[i] = s[i+1];         // copiar os valores da string original sem o ultimo elem
    }
    *c = s[0];                                     // atribuir a varivel c o valor do ultimo elemento da string original
    return n;
}

/**
 * Esta é a funcao responsável por verificar se existe um elemento
 */
 void exist_elem (STACK *pilha, DATA x){
    int p;
    for(p=0; p < pilha->valores->ARRAY->sp ; p++)
        if(equals(pilha->valores->ARRAY->valores[p], x)) push_LONG(pilha, p);
}

/**
 * Esta é a funcao responsável por dar push de un numero n de elemenstos/caracteres apartir do fim
 */
void firstN(STACK *pilha, long x) { // funcao < Ir buscar X elems/carat do fim
    long p = 0;
    while (p != x) {
        push(pilha, pilha->valores->ARRAY->valores[p]);
        p++;
    }
}
/**
 * Esta é a funcao responsável por dar push de un numero n de elemenstos/caracteres apartir do inicio
 */
void lastN(STACK *pilha, long x){ // funcao > Ir buscar X elems/carat do início
    long p = 0;
    while(p != x){
        push(pilha, pilha->valores->ARRAY->valores[pilha->valores->ARRAY->sp - p]);
        p++;
    }
 }
