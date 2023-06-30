#include "functions.h"

/**
 *  funçao para criar uma string a partir de um char
 *
 * @return c, devolve a string criada
 */
char *mkstr(char l, char *s){
    char *c;
    if(s == NULL){
        c = malloc(sizeof(char)+1);
        c[0] = l;
        c[1] = '\0';
    }
    else {
        c = malloc(sizeof(char)*strlen(s)+2);
        strcpy(c, s);
        c[strlen(s)] = l;
        c[strlen(s)+1] = '\0';
    }

    return c;
}

/**
 * funçao semelhante à strtok, definida para retirar um (ou mais)
 * token(s) de uma string
 *
 * @return c, devolve o token atual
 */
char *get_token(char *line, char **rest){
    int size=0, i;
    while(line[size] != ' ' && line[size] != '\t' && line[size] != '\n')size++;

    char *c = malloc(sizeof(char)*size+1);

    for(i=0; i <= size; i++){
        if(i == size) c[i] = '\0';
        else c[i] = line[i];
    }
    if (line[i] == ' ') i++;
    *rest = line+i;
    return c;
}

/**
 * funçao para retornar os valores/elementos/caracteres
 * de strings do tipo :
 * [...]
 * ou
 * "..."
 * sem os delimitadores "\" []"
 *
 * @return c, devolve a string ou array sem os delimitadores correspondentes
 */
char* get_delimited(char *line){
    char *c = malloc(sizeof(char)*(strlen(line)));
    int j = 0;

    if (line[0] == '[' || line[0] == '"'){
        for (unsigned long i = 1; i < strlen(line); i++) {
            if (line[i] != ']' && line[i] != ' ' && line[i] != '"'){
                c[j] = line[i];
                j++;
            }
        }
    }
    c[j] = '\0';
    return c;
}

/**
 ** funçao definida para avaliar a line
 * e definir se é um array uma string, entre outros
 * e trabalhar com esses criando uma stack auxiliar se necessario para trabalhar com a line
 *
 * @return init_stack, devolve o stack atual
 */
STACK *eval(char *line, STACK *init_stack) {
    if (init_stack == NULL) {
        init_stack = createStack();
        init_stack = eval(line, init_stack);
    } else {
        for (char *token = get_token(line, &line); *token != '\0'; token = get_token(line, &line)) {
            char *sobra_i;
            char *sobra_d;
            char *s = NULL;

            double val_d = strtod(token, &sobra_d);
            long val_i = strtol(token, &sobra_i, 10); //verifica se o valor e um inteiro

            if (token[0] == '[') {
                for(; *token != ']'; token = get_token(line, &line)) s = mkstr(*token,s);
                char *subToken = get_delimited(s);
                STACK *subStack = eval(subToken, NULL);
                push_array(init_stack, subStack->valores, subStack->sp);
                free(subStack);

            } else if (token[0] == '"') {
                char *string = get_delimited(token);
                push_STRING(init_stack, string);

            } else if (strlen(sobra_i) == 0) {
                push_LONG(init_stack, val_i);

            }  else if (strlen(sobra_d) == 0) {
                push_DOUBLE(init_stack, val_d);

            }  else if (strcmp(token, "l") == 0) { // verifica se "l" esta na linha
                char x[10];
                assert(fgets(x, 10, stdin) != NULL);
                push_STRING(init_stack, strdup(x));
            }else if (strcmp(token, "t") == 0) { // verifica se "l" esta na linha
                char x[100];
                assert(fgets(x, 100, stdin) != NULL); //se n funcionar, tentar implementar a fgetc
                push_STRING(init_stack, strdup(x));

            } else {
                parseSelector(token, init_stack);
            }
        }
    }
    return init_stack;
}

/**
 * funçao definida para selecionar que tipo de interpretador
 * escolher, consoante o tipo de dados recolhidos (strings, arrays ou numeros)
 */
void parseSelector(char *token ,STACK *pilha) {

    if (pilha->sp < 2) {
        parse(token, pilha);
    } else {
        DATA x = pilha->valores[pilha->sp - 1];
        DATA y = pilha->valores[pilha->sp - 2];

        if (has_type(x, STRING) || has_type(y, STRING)) {
            parse_String(token, pilha);

        } else if (has_type(x, DOUBLE) || has_type(y, DOUBLE)) {
            parse(token, pilha);

        } else if (has_type(x, ARRAY) || has_type(y, ARRAY)) {
            parse_Array(token, pilha);

        } else {
            parse(token, pilha);
        }
    }
}