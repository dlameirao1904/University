#include "stack.h"

/**
 * Esta é a funcao verifica se o elemento fornecido pela stack tem o mesmo tipo da mascara.
 *
 * @returns 1 se for verdade, 0 se for falso.
 */
int has_type(DATA elem, int mascara){
    return (elem.tipo & mascara) != 0;
}

/**
 * Esta é a funcao que cria a stack. 
 * 
 * @returns s devolve uma stack vazia..
 */
STACK *createStack(){
    STACK *s = (STACK *) malloc(sizeof(STACK));
    s->sp = 0; // STACK vazia... o proximo valor vai ser colocado na pos 0
    s->tamanho = MAX;
    s->valores = (DATA *) calloc(s->tamanho, sizeof (DATA));
    buildVars(s);
    return s;
}

/**
 *Esta é a função que define as variáveis pré-definidas.
 */
void buildVars(STACK *pilha){
    DATA a,b,c,d,e,f,n,s,x,y,z;

    a.LONG = 10;
    pilha->var[0] = a;

    b.LONG = 11;
    pilha->var[1] = b;

    c.LONG = 12;
    pilha->var[2] = c;

    d.LONG = 13;
    pilha->var[3] = d;

    e.LONG = 14;
    pilha->var[4] = e;

    f.LONG = 15;
    pilha->var[5] = f;

    x.LONG = 0;
    pilha->var[6] = x;
    pilha->var[7] = x;
    pilha->var[8] = x;
    pilha->var[9] = x;
    pilha->var[10] = x;
    pilha->var[11] = x;
    pilha->var[12] = x;

    n.CHAR = '\n';
    pilha->var[13] = n;

    pilha->var[14] = x;
    pilha->var[15] = x;
    pilha->var[16] = x;
    pilha->var[17] = x;

    s.CHAR = ' ';
    pilha->var[18] = s;

    pilha->var[19] = x;
    pilha->var[20] = x;
    pilha->var[21] = x;
    pilha->var[22] = x;

    pilha->var[23] = x;

    y.LONG = 1;
    pilha->var[24] = y;

    z.LONG = 2;
    pilha->var[25] = z;
    }

int isUpper(char c){
    return (c>= 'A' || c<= 'Z');
}

void changeVar(STACK *pilha, char name, DATA value){
    long idx = name - 'A';
    //printf("idx na changevar = %ld\n", idx);
    if(has_type(value,CHAR)) pilha->var[idx].CHAR = value.CHAR;
    if(has_type(value,DOUBLE)) pilha->var[idx].LONG = value.DOUBLE;
    else pilha->var[idx].LONG = value.LONG;
}

/**
 * Esta é a funcao que verifica se a stack se encontra vazia.
 *
 * @returns retorna 1 caso a stack se encontre vazia e 0 caso tenho algum elemento.
 */
int is_empty(STACK *pilha){
    return (pilha->sp == 0);
}

/**
 *Esta é a funcao que adiciona um elemento ao topo da stack.  
 */
void push (STACK *pilha, DATA val) {
    if(pilha->tamanho == pilha->sp) {
        pilha->tamanho += 1024; // alocar mais espaço caso a pilha fique cheia
        pilha->valores = (DATA *) realloc(pilha->valores, pilha->tamanho * sizeof (DATA));
    }
    pilha->valores[pilha->sp] = val;
    pilha->sp++;
}

void push_array(STACK *pilha, DATA *arr, long size){
    long i;
    for(i=0; i<size; i++) push_LONG(pilha, arr[i].LONG);
}

/**
 *Esta é a funcao que retira o elemento do topo da stack
 *
 * @returns  retorna o valor que foi retirado da stack
 */
DATA pop (STACK *pilha){
    pilha->sp -= 1;
    return pilha->valores[pilha->sp];
}

/**
 * Esta é a funcao que retorna o elemento do topo da lista
 *
 * @returns retorna o valord que foi retirar, sem retira-lo da lista .
 */
DATA topo(STACK *pilha){
    return pilha->valores[pilha->sp - 1];
}

/**
 * Esta é a funcao responsavel por dar print a stack  
 */
void print_stack(STACK *pilha){
    int i;
    for (i = 0; i < pilha->sp; i++) {
        DATA elem = pilha->valores[i];
        TYPE tp = elem.tipo;
        switch (tp) {
            case LONG:
                printf("%ld",elem.LONG); break;
            case DOUBLE:
                printf("%g", elem.DOUBLE); break;
            case CHAR:
                printf("%c",elem.CHAR); break;
            case STRING:
                printf("%s", elem.STRING); break;
            case ARRAY:
                 break;
        }
    }
    printf("\n");
}


/**
 * Esta é a funcao responsavel por verificar o tipo das variaveis 
 *  
 * @returns o tipo da variavel
 */
#define  STACK_OPERATION(_type, _name)           \
    void push_##_name(STACK *s, _type val) {     \
        DATA elem;                               \
        elem.tipo = _name;                       \
        elem._name = val;                        \
        push(s, elem);                           \
    }                                            \
    _type pop_##_name(STACK *s) {                \
    DATA elem = pop(s);                          \
    return elem._name;                           \
}

STACK_OPERATION(long, LONG)
STACK_OPERATION(double , DOUBLE)
STACK_OPERATION(char , CHAR)
STACK_OPERATION(char *, STRING)

