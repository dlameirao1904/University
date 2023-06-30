/**
 * @file que contem a funcao principal do programa 
 */

#include <stdio.h>
#include <assert.h>


#include "parser.h"

/**
 * Esta é a funcao principal do programa. 
 * 
 * @returns 0 devolve o valor 0.
 */
int main() {
    char line[10240];

    assert( fgets(line,10240, stdin) !=NULL);
    STACK * mainPilha = eval(line, NULL);
    print_stack(mainPilha);
   
    return 0;
}
