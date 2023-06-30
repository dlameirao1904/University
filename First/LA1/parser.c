/**
 * @file funcao que diz respeito ao ficheiro parser
 */


#include "parser.h"

/**
 * Esta é a funcao responsável por verificar se tem alguns dos simbolos com significado na linha que foi
 * lida na funcao main, e se tiver, indicar o que fazer. 
 * 
 * Faz tambem a chamada as funcoes da stack
 */
void parse(char *token, STACK *pilha) {

    if (strcmp(token, "+") == 0) {//verifica se o "+" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            soma(pilha, x, y);
    } else if (strcmp(token, "-") == 0) {                       // verifica se o "-" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            sub(pilha, x, y);
    } else if (strcmp(token, "*") == 0) {                       // verifica se o "*" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            mult(pilha, x, y);
    } else if (strcmp(token, "/") == 0) {// verifica se o "/" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            divide(pilha, x, y);
    } else if (strcmp(token, "#") == 0) {                       // verifica se o "#" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            eleva(pilha, x, y);
    } else if (strcmp(token, "%") == 0) {                      // verifica se o "%" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            percentagem(pilha, x, y);
    } else if (strcmp(token, ")") == 0) {                      // verifica se o ")" esta na linha
            DATA x = pop(pilha);
            mais1(pilha, x);                                                   //incrementar (um valor + 1)
    } else if (strcmp(token, "(") == 0) {                     // verifica se o "(" esta na linha
            DATA x = pop(pilha);
            menos1(pilha, x);
    } else if (strcmp(token, "&") == 0) {               // verifica se o "&" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            e(pilha, x, y);
    } else if (strcmp(token, "|") == 0) {               // verifica se o "|" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            ou(pilha, x, y);
    } else if (strcmp(token, "^") == 0) {               // verifica se o "^" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            xore(pilha, x, y);
    } else if (strcmp(token, "~") == 0) { // verifica se o "~" esta na linha
            DATA x = pop(pilha);
            note(pilha, x);
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
                 pilha->valores[--bp]);       // push do elemento que se encontra n posiçoes atras do topo da pilha

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

    } else if (strcmp(token, "t") == 0) { // verifica se "l" esta na linha
            char x[100];
            assert(fgets(x, 100, stdin) != NULL); //se n funcionar, tentar implementar a fgetc
            push_STRING(pilha, strdup(x));

    } else if (strcmp(token, "=") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push_LONG(pilha, equals(x, y));

    } else if (strcmp(token, "<") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push_LONG(pilha, less(x, y));

    } else if (strcmp(token, ">") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push_LONG(pilha, greater(x, y));

    } else if (strcmp(token, "!") == 0) {
            long x = toLong(pop(pilha));
            push_LONG(pilha, not(x));

    } else if (strcmp(token, "e&") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push(pilha, and_shortcut(x, y));

    } else if (strcmp(token, "e|") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push(pilha, or_shortcut(x, y));

    } else if (strcmp(token, "e>") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push(pilha, greater_shortcut(x, y));

    } else if (strcmp(token, "e<") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            push(pilha, lesser_shortcut(x, y));

    } else if (strcmp(token, "?") == 0) {
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            long z = pop_LONG(pilha);
            push(pilha, if_than_else(x, y, z));

    }else if (strcmp(token, ",") == 0) {
            long size = pop_LONG(pilha);
            DATA *arr = comma(size);
            push_array(pilha, arr, size);


        }else if (isUpper(token[strlen(token)-1])) {
            char c = token[strlen(token) - 2];
            if (c == ':') {
                DATA value = topo(pilha);
                changeVar(pilha, token[strlen(token) - 1], value);
            } else {
                long idx = token[strlen(token) - 1] - 'A';
                if (idx == 13 || idx == 18) push_CHAR(pilha, pilha->var[idx].CHAR);
                else push_LONG(pilha, pilha->var[idx].LONG);
            }
        }

}
