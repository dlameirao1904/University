#include "parse_String.h"
/**
 * Esta é a funcao responsável por verificar se tem alguns dos simbolos com significado na linha que foi
 * lida na funcao main, e se tiver, indicar o que fazer. Especifica para Strings.
 *
 * Faz tambem a chamada as funcoes da stack
 */
void parse_String(char *token, STACK * pilha){
    if (strcmp(token, "+") == 0) {//verifica se o "+" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        char *s = concat(y, x);    // Concatenar strings
        push_STRING(pilha, s);

    } else if (strcmp(token, "*") == 0) {                       // verifica se o "*" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        char *s = multconcat(x, y);                  // Concatenar várias vezes strings ou arrays
        push_STRING(pilha,s);

    } else if (strcmp(token, "/") == 0) {// verifica se o "/" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        divide(pilha, x, y);

    } else if (strcmp(token, "#") == 0) {                       // verifica se o "#" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        long pos = findstr(y.STRING, x.STRING);
        push_LONG(pilha, pos);

    } else if (strcmp(token, "%") == 0) {                      // verifica se o "%" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        percentagem(pilha, x, y);

    } else if (strcmp(token, ")") == 0) {                      // verifica se o ")" esta na linha
        rem_lstString(pilha);                                    //Remover últ. elt. e colocar na stack


    } else if (strcmp(token, "(") == 0) {                     // verifica se o "(" esta na linha
        rem_fstString(pilha);                                 // Remover 1º elt. e colocar na stack

    } else if (strcmp(token, "_") == 0) { // verifica se o "_" esta na linha
        dupLast(pilha);

    } else if (strcmp(token, ";") == 0) { // verifica se o ";" esta na linha
        pop(pilha);

    } else if (strcmp(token, "\\") == 0) { // verifica se "\" o  esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        troca(pilha, x, y);

    } else if (strcmp(token, "@") == 0) { // verifica se o "@" esta na linha
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        DATA z = pop(pilha);
        troca3(pilha, x, y, z);

    } else if (strcmp(token, "$") == 0) { // verifica se o "$" esta na linha
        long n = pop_LONG(pilha);
        int bp = 0;
        if (n <= pilha->sp) bp = pilha->sp - n;
        push(pilha,
             pilha->valores[--bp]);     // push do elemento que se encontra n posiçoes atras do topo da pilha

    } else if (strcmp(token, "=") == 0) {
        DATA x = pop(pilha);
        DATA y = pop(pilha);
        char c = y.STRING[x.LONG];
        push_CHAR(pilha, c);

    } else if (strcmp(token, "<") == 0) {
        long x = pop_LONG(pilha);
        char *y = pop_STRING(pilha);
        char *res = firstN_String(y,x);
        push_STRING(pilha, res);

    } else if (strcmp(token, ">") == 0) {
        long x = pop_LONG(pilha);
        char *y = pop_STRING(pilha);
        char *res = lastN_String(y, x);
        push_STRING(pilha, res);

    }else if (strcmp(token, ",") == 0) {
        char *s = pop_STRING(pilha);
        long size = (long) strlen(s);
        push_LONG(pilha, size);

    } else if (strcmp(token, "i") == 0) { // verifica se o "s" esta na linha
        DATA x = pop(pilha);
        long y = toLong(x);              //converte para long variaveis do tipo DATA
        push_LONG(pilha, y);

    } else if (strcmp(token, "f") == 0) {  // verifica se o "f" esta na linha
        DATA x = pop(pilha);
        push_DOUBLE(pilha, toDouble(x));

    } else if (strcmp(token, "c") == 0) {
        DATA x = pop(pilha);
        push_CHAR(pilha, toChar(x));      // introduz na stack valores do tipo char

    } else if (strcmp(token, "s") == 0) {
        DATA x = pop(pilha);
        push_STRING(pilha, toString(x)); // introduz na stack uma string

    }
}

