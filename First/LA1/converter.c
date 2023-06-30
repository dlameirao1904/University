/**
 * @file funcoes que dizem respeito ao ficheiro converter
 */

#include "converter.h"

/**
* Esta é a funcao responsável por converter variaveis do tipo DATA,
* para variaveis do tipo long, lidas na funcao parser.
*
* @returns y devolve um long.
*/
long toLong(DATA x){  // converte valores do tipo DATA para long
    if(has_type(x,LONG)) {
        return x.LONG;
    }
    else if(has_type(x,DOUBLE)){
        long y = x.DOUBLE;
        return y;
    }
    else if(has_type(x,CHAR)){
        long y = x.CHAR;
        return y;
    }
    else if(has_type(x,STRING)){
        char *str;
        long y = strtol(x.STRING, &str, 10); //verifica se o valor e um inteiro
        return y;
    }

    return 0;
}

/**
* Esta é a funcao responsável por converter variaveis do tipo DATA,
* para variaveis do tipo double, lidas na funcao parser.
*
* @returns y devolve um double.
*/
double toDouble(DATA x){                    //converte valores do tipo DATA para double
    if(has_type(x,LONG)) {
        double y = (double) x.LONG;
        return y;
    }
    else if(has_type(x,DOUBLE)){
        return x.DOUBLE;
    }
    else if(has_type(x,STRING)){
        char *str;
        double y = strtod(x.STRING, &str); //verifica se o valor e um inteiro
        return y;
    }

    return 0;
}

/**
* Esta é a funcao responsável por converter variaveis do tipo DATA,
* para variaveis do tipo char, lidas na funcao parser.
*
* @returns y devolve um char.
*/
char toChar(DATA x){                    //converte valores do tipo DATA para char
    if(has_type(x,LONG)) {
        char y = x.LONG;
        return y;
    }
    else if(has_type(x,CHAR)){
        return x.CHAR;
    }
  //da erro muito provavelmente aqui            <---------------ERROR!

  return '0';
}

/**
* Esta é a funcao responsável por converter variaveis do tipo DATA,
* para variaveis do tipo char*(string), lidas na funcao parser.
*
* @returns y devolve um char*(string).
*/
char* toString (DATA x){   // converte valores do tipo DATA para String
    if(has_type(x,LONG)) {
        char *str = malloc (20 * sizeof (char));
        sprintf(str, "%ld", x.LONG);
       return str;
    }
    else if(has_type(x,DOUBLE)){
        char *str = malloc (20 * sizeof (char));
        sprintf(str, "%g", x.DOUBLE);
        return str;
    }
    //da erro muito provavelmente aqui            <---------------ERROR!

    return "erro";
}
