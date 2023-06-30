#include "math_operations.h"

/**
 * Esta é a funcao responsável por somar duas variaveis que sao do mesmo tipo
 * 
 * Coloca o resultado de volta no topo da stack
 */
void soma(STACK *pilha, DATA x, DATA y){
    if (has_type(x, LONG) && has_type(y, LONG))
        push_LONG(pilha, x.LONG + y.LONG);
    else if (has_type(x, DOUBLE) && has_type(y, DOUBLE))
        push_DOUBLE(pilha, x.DOUBLE + y.DOUBLE);
    else if (has_type(x, CHAR) && has_type(y, CHAR))
        push_CHAR(pilha, x.CHAR + y.CHAR);
}

/**
 * Esta é a funcao responsável por subtrair duas variaveis que sao do mesmo tipo
 * 
 * Coloca o resultado de volta no topo da stack
 */
void sub(STACK *pilha, DATA x, DATA y){
    if (has_type(x, LONG) && has_type(y, LONG))
        push_LONG(pilha, y.LONG - x.LONG);
    else if (has_type(x, DOUBLE) && has_type(y, DOUBLE))
        push_DOUBLE(pilha, y.DOUBLE - x.DOUBLE);
    else if (has_type(x, CHAR) && has_type(y, CHAR))
        push_CHAR(pilha, y.CHAR - x.CHAR);
}

/**
 * Esta é a funcao responsável por multiplicar duas variaveis que sao do mesmo tipo
 * 
 * Coloca o resultado de volta no topo da stack
 */
void mult(STACK *pilha, DATA x, DATA y){
    if (has_type(y,STRING)){
        while(x.LONG != 0) push_STRING(pilha,y.STRING);
    }
    else if (has_type(x, LONG) && has_type(y, LONG))
        push_LONG(pilha, x.LONG * y.LONG);
    else
        push_DOUBLE(pilha, toDouble(x) * toDouble(y));
}

/**
 * Esta é a funcao responsável por dividir duas variaveis que sao do mesmo tipo
 * 
 * Coloca o resultado de volta no topo da stack
 */
void divide(STACK *pilha, DATA x, DATA y){
    if (has_type(x, LONG) && has_type(y, LONG))
        push_LONG(pilha, y.LONG / x.LONG);
    else
        push_DOUBLE(pilha, toDouble(y) / toDouble(x));
}

/**
 * Esta é a funcao responsável por elevar duas variaveis do mesmo tipo, i.e. o y e x, fica (y^x)
 * 
 * Coloca o resultado de volta no topo da stack
 */
void eleva(STACK *pilha, DATA x, DATA y){
    if (has_type(x, LONG) && has_type(y, LONG))
        push_LONG(pilha, (pow(y.LONG, x.LONG)));
    else
        push_DOUBLE(pilha, (pow(toDouble(y),toDouble(x))));
}

/**
 * Esta é a funcao responsável por calcular o resto da divisao de duas variaveis do tipo long
 * 
 * Coloca o resultado de volta no topo da stack
 */
void percentagem(STACK *pilha, DATA x, DATA y){ // verifica se o topo da pilha e LONG
        push_LONG(pilha, y.LONG % x.LONG);
}

/**
 * Esta é a funcao responsável por incrementar uma vez o valor de uma variavel
 * 
 * Coloca o resultado de volta no topo da stack
 */
void mais1(STACK *pilha, DATA x){
    if (has_type(x, LONG)) {
        push_LONG(pilha, x.LONG + 1);
    } else if (has_type(x, CHAR))
        push_CHAR(pilha, x.CHAR + 1);
}

/**
 * Esta é a funcao responsável por decrementar uma vez o valor de uma variavel
 * 
 * Coloca o resultado de volta no topo da stack
 */
void menos1(STACK *pilha, DATA x){
    if (has_type(x, LONG))
        push_LONG(pilha, x.LONG - 1);
    else if (has_type(x, CHAR))
        push_CHAR(pilha, x.CHAR - 1);
}

/**
 * Função que compara duas variaveis a nivel dos bits usando a regra da interseção
 * V V -> V
 * F V -> F
 * V F -> F
 * F F -> F
 * Coloca o resultado de volta no topo da stack
 */
void e(STACK *pilha, DATA x, DATA y){
        push_LONG(pilha, x.LONG & y.LONG);
}

/**
 * Função que compara duas variaveis a nivel dos bits usando a regra da disjunção
 * V V -> V
 * F V -> V
 * V F -> V
 * F F -> F
 * Coloca o resultado de volta no topo da stack
 */
void ou(STACK *pilha, DATA x, DATA y){
        push_LONG(pilha, x.LONG | y.LONG);
}

/**
 * Função que compara duas variaveis a nivel dos bits usando as seguintes regras
 * V V -> F
 * F V -> V
 * V F -> V
 * F F -> F
 * Coloca o resultado de volta no topo da stack
 */
void xore(STACK *pilha, DATA x, DATA y){
        push_LONG(pilha, x.LONG ^ y.LONG);
}

/**
 * Função que compara duas variaveis a nivel dos bits usando as seguintes regras
 * V V -> V
 * F V -> F
 * V F -> F
 * F F -> V
 * Coloca o resultado de volta no topo da stack
 */
void note(STACK *pilha, DATA x){
        push_LONG(pilha, ~(x.LONG));
}

/**
 * Esta é a funcao responsável por trocar a ordem das 2 primeiras variaveis na stack
 * 
 * Coloca o resultado de volta no topo da stack
 */
void troca(STACK *pilha, DATA x, DATA y){
    push(pilha, x);
    push(pilha, y);
}

/**
 * Esta é a funcao responsável por trocar a ordem das 3 primeiras variaveis na stack
 * 
 * Coloca o resultado de volta no topo da stack
 */
void troca3(STACK *pilha, DATA x, DATA y, DATA z){
    push(pilha, y);
    push(pilha, x);
    push(pilha, z);   // roda o posiçao dos 3 ultimos elementos da lista. EX: ABC ->  BCA
}

/**
 * Esta é a funcao responsável por trocar a ordem das 3 primeiras variaveis na stack
 * 
 * Coloca o resultado de volta no topo da stack
 */
void dupLast(STACK *pilha){
     push(pilha, topo(pilha));
}


