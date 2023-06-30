/**
 * @file que guarda as defenições das funcoes usadas no file parser.c
*/
#include "logic.h"

/**
 * Esta é a funcao responsável por verificar se duas variaveis tem o mesmo valor
 *
 * @returns 1 se a igualdade for verdadeira,ou 0 se a igualdade for falsa
 */
long equals(DATA x, DATA y){
    return (toDouble(x) == toDouble(y));
}

/**
 * Esta é a funcao responsável por verificar se uma variavel é menor do que outra
 * 
 * @returns 1 se a comparação for verdadeira, ou 0 se for falsa
 */
long less(DATA x, DATA y){
    return (toDouble(x) > toDouble(y));
}

/**
 * Esta é a funcao responsável por verificar se uma variavel é maior do que outra
 *
 * @returns 1 se a comparação for verdadeira, ou 0 se for falsa
 */
long greater(DATA x, DATA y){
    return (toDouble(x) < toDouble(y));
}

/**
 * Esta é a funcao responsável por verificar se a variavel é do tipo long
 * 
 * @returns 1 se for verdade, 0 se for falso
 */
long not(long x) {
    if (x == 0) return 1;
    else return 0;
}
/**
 * Função que recebe um valor booleano(1 ou 0) e um variavel tipo DATA
 * e faz a intersecao logica entre os dois valores
 *
 * @returns a variavel Data se o booleano tiver valor 1 ou 0 se o booleano tiver valor 0
 */
DATA and_shortcut(DATA x, DATA y){
    DATA r;
    if (x.LONG == 0) r = x;
    else if (y.LONG == 0) r = y;
    else if (has_type(x, LONG) && has_type(y, LONG)){
        if (x.LONG >= y.LONG) r = x;
        else r = y;
    }
    else {
        if (x.DOUBLE >= y.DOUBLE) r = x;
        else r = y;
    }
    return r;
}


/**
 * Função que recebe um valor booleano(1 ou 0) e um variavel tipo DATA
 * e faz a conjunção logica entre os dois valores
 *
 * @returns a variavel Data se o booleano tiver valor 0, ou 1 se o booleano tiver valor 1
 */
DATA or_shortcut(DATA x, DATA y){
    DATA r;
    if (x.LONG == 1) r = x;
    else if (y.LONG == 1) r = y;
    else if (has_type(x, LONG) && has_type(y, LONG)){
        if (x.LONG >= y.LONG) r = x;
        else r = y;
    }
    else {
        if (x.DOUBLE >= y.DOUBLE) r = x;
        else r = y;
    }
    return r;
}

/**
 * Função que compara se uma variavel e maior do que outra
 *
 * @returns o valor da maior variavel
 */
DATA greater_shortcut(DATA x, DATA y){
    if(toDouble(x) > toDouble(y)) return x;
    else return y;
}

/**
 * Função que compara se uma variavel e maior do que outra
 *
 * @returns o valor da menor variavel
 */
DATA lesser_shortcut(DATA x, DATA y) {
    if (toDouble(x) < toDouble(y)) return x;
    else return y;
}
/**
 * Função que verifica o valor de uma variavel booleana
 *
 * @returns o valor do ultimo elemento da stack se o valor da variavel booleana for falsa(i.e. 0),
 * ou o valor do penultimo elemento da stack se o valor da variavel booleana for verdadeira(i.e. 1)
 */
DATA if_than_else (DATA x, DATA y, long z){
    if(z) return y;
    else return x;
}
