import ply.lex as lex
import re
import sys

#armazenamento dos tokens 
tokens = ["NOME","NUMBER","INT","PLUS", "MINUS", "TIMES", "DIVIDE", "EQUALS","GEQ", "LEQ", "NEQ", "EQEQ", "BIGGER", "MINOR", "ENQUANTO", "FAZ","SE","SENAO", "E", "OU", "LER", "ESCREVER", "ARRAY","MATRIZ", "PAA",  "PAF", "PCA", "PCF","VIRG","STOPCOM"]
#ER's que definem os tokens de cima 

#tokens identificadores de numeros/nomes e do tipo de numeros, neste caso, int
def t_NUMBER(t):
    r'\d+'
    return t

def t_INT(t):
    r'int'
    return t

def t_NOME(t):
    r'[a-z]+'
    t.type = 'NOME'
    return t

#tokens de operaçoes
def t_PLUS(t):
	r'\+'
	return t
	 
def t_MINUS(t):
	r'-'
	return t
	 
def t_TIMES(t):
	r'\*'
	return t
	 
def t_DIVIDE(t):
	r'\/'
	return t

def t_EQUALS(t):
    r'\='
    return t

def t_GEQ(t):
    r'\>\='
    return t

def t_LEQ(t):
    r'\<\='
    return t

def t_NEQ(t):
    r'\!\='
    return t

def t_EQEQ(t):
    r'\=\='
    return t

def t_BIGGER(t):
    r'\>'
    return t

def t_MINOR(t):
    r'\<'
    return t

#tokens identificadores das funçoes da nossa linguagem
def t_ENQUANTO(t):
    r'ENQUANTO'
    return t

#def t_PARA(t):
#    r'PARA'
#    return t

def t_FAZ(t):
    r'\:'
    return t

def t_SE(t):
    r'SE'
    return t

def t_SENAO(t):
    r'SEN'
    return t

#def t_SENAOSE(t):
#    r'SENAOSE'
#    return t

def t_E(t):
    r'E'
    return t

def t_OU(t):
    r'OU'
    return t

def t_LER(t):
    r'LER'
    return t

def t_ESCREVER(t):
    r'Write'
    return t

#tokens de identificadores de funçoes, arrays, condicionantes, fim de comandos
def t_ARRAY(t):
    r'ARR'
    return t

def t_MATRIZ(t):
    r'MAT'
    return t

t_PAA = r'\['
t_PAF = r'\]'
t_PCA = r'\('
t_PCF = r'\)'
t_VIRG = r'\,'
t_STOPCOM = r'\;'

t_ignore = ' \r\t\n'

def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)


lexer = lex.lex() # cria um AnaLex especifico a partir da especificação acima usando o gerador 'lex' do objeto 'lex'


#so para confirmar que os operadores batem todos certos
# Reading input
'''
for linha in sys.stdin:
    lexer.input(linha) 
    tok = lexer.token()
    while tok:
        print(tok)
        tok = lexer.token()
'''
