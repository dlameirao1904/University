//
// Created by Ideapad L340 on 08/05/2021.
//

#include "mystring.h"

/**
 *  funçao para criar uma string sem o primeiro elemento e retorna-lo na stack no fim da string
 *
 */
void rem_fstString(STACK *pilha){ // remove o primeiro elemento da string e coloca a frente na pilha principal

    char *s = pop_STRING(pilha);
    char c;

    s = rem_fstElem(s, &c);
    push_STRING(pilha, s);
    push_CHAR(pilha,c);
}

/**
 *  funçao para criar uma string sem o ultimo elemento e retorna-lo na stack no inicio da string.
 */
void rem_lstString(STACK *pilha){ // remove o ultimo elemento da string e coloca a frente na pilha principal
    char *s = pop_STRING(pilha);
    char c;

    s = rem_lstElem(s, &c);
    push_STRING(pilha, s);
    push_CHAR(pilha, c);
}

/**
 *  funçao para verificar se uma dada substring ocorre numa string
 *
 * @return cpos, devolve a posicao do primeiro elemento da substring agulha, na string palheiro
 */
long findstr(char *palheiro, char *agulha){ // devolve o indice da posiçao do primeiro elemento da agulha no palheiro;
    int i, j, pos=0;

    for(i=0; agulha[i]; i++){
        for(j=0; palheiro[j]; j++){
            if(agulha[i] == palheiro[j]){
                pos = j;
                while(agulha[i] == palheiro[j] && agulha[i]){
                    i++;
                    j++;
                }
            }
            if(agulha[i] != '\0'){
                i=0;
                pos = -1;
            }
        }
    }
    return pos;
}

/**
 *  funçao para concatenar strings
 *
 * @return x.String , devolve a string concatendada
 */
char * concat(DATA x, DATA y){
    strcat((x.STRING),y.STRING);
    return x.STRING;
}

/**
 *  funçao paraconcatenar a string com ela propria.
 *
 * @return res, devolve a string concatenada com ela propria x vezes.
 */
char * multconcat(DATA x,DATA y){
    char *res = malloc(sizeof(strlen(y.STRING))*x.LONG);
    if (has_type(x,LONG) && has_type(y,STRING)){
        strcat(res, y.STRING);
        int counter = x.LONG-1;
        while(counter>0){
            strcat(res, y.STRING);
            counter--;
        }
    }
    return res;
}

/**
 *  funçao para comparar strings ou devolver um string com os primeiros x elementos.
 *
 * @return res, devolve um valor booleano caso x e y sejam strings. Ou devolve os primeiros x elementos da string y.
 */
char * firstN_String(char *s, long x) { // funcao < Ir buscar X elems/carat do fim
    long p = 0;
    char *n = malloc(sizeof (char)*x);
    while (p != x) {
        n[p] = s[strlen(s)-p];
        p++;
    }
    return n;
}

/**
 *  funçao para comparar strings ou devolver um string com os ultimos x elementos.
 *
 * @return res, devolve um valor booleano caso x e y sejam strings. Ou devolve os ultimos x elementos da string y.
 */
char * lastN_String(char *s, long x) { // funcao < Ir buscar X elems/carat do fim
    long p = 0;
    char *n = malloc(sizeof (char) * x);
    while (p != x) {
        n[p] = s[p];
        p++;
    }
    return n;
}
