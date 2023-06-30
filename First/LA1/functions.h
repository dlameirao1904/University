/**
 * @file que guarda as defenições das funcoes usadas no file functions.c
*/
#ifndef CODE_FUNCTIONS_H
#define CODE_FUNCTIONS_H

#include <stdlib.h>
#include <string.h>
#include <assert.h>

#include "math.h"
#include "stack.h"
#include "converter.h"
#include "math_operations.h"
#include "logic.h"
#include "arrays.h"
#include "parser.h"
#include "mystring.h"
#include "parse_Array.h"
#include "parse_String.h"

char *mkstr(char , char *);

char *get_token(char *, char **);

char* get_delimited(char *line);

STACK *eval(char *line, STACK *init_stack);

void parseSelector(char *, STACK *);
#endif //CODE_FUNCTIONS_H
