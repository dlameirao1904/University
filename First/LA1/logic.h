/**
 * @file que guarda as defenições das funcoes usadas no file logic.c
*/
#ifndef PARSER_C_LOGIC_H
#define PARSER_C_LOGIC_H

#include "functions.h"

long equals(DATA x, DATA y);

long less(DATA x, DATA y);

long greater(DATA x, DATA y);

long not(long x);

DATA and_shortcut(DATA x, DATA y);

DATA or_shortcut(DATA x, DATA y);

DATA greater_shortcut(DATA x, DATA y);

DATA lesser_shortcut(DATA x, DATA y);

DATA if_than_else (DATA x, DATA y, long z);

#endif //PARSER_C_LOGIC_H
