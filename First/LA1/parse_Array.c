#include "parse_Array.h"
/**
 * Esta é a funcao responsável por verificar se tem alguns dos simbolos com significado na linha que foi
 * lida na funcao main, e se tiver, indicar o que fazer. Especifica para Arrays.
 *
 * Faz tambem a chamada as funcoes da stack
 */
void parse_Array(char *token, STACK *pilha) {

    if (strcmp(token, "+") == 0) {//verifica se o "+" esta na linha
            DATA x = pop(pilha);
            DATA y = pop(pilha);
            soma(pilha, x, y);

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
            mais1(pilha, x);
            //incrementar (um valor + 1)
    } else if (strcmp(token, "(") == 0) {                     // verifica se o "(" esta na linha
            DATA x = pop(pilha);
            menos1(pilha, x);

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
                 pilha->valores[--bp]);     // push do elemento que se encontra n posiçoes atras do topo da pilha

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

    }else if (strcmp(token, ",") == 0) {
            long size = pop_LONG(pilha);
            DATA *arr = comma(size);
            push_array(pilha, arr, size);

    }
    int array_size = pilha->valores->ARRAY->sp;
    if(array_size > 0)push_array(pilha, pilha->valores->ARRAY->valores, array_size); // pilha main, pilha que vai pra pilha principal, tamanho da segunda pilha
}
