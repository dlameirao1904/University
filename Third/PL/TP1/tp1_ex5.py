from asyncore import write
from multiprocessing.sharedctypes import Value
from operator import index
from pickle import FALSE
from tokenize import group
import ply.lex as lex
import re
from statistics import *
import ply.lex as lex


#-------------------------------------------------------------------------------------
#resumo - queremos passar de csv para json
#-------------------------------------------------------------------------------------

#lista de tipos de tokens que podem existir 
tokens = ["SEP","TOP", "NUMVAL", "NUMVALFUNC"]

def t_NUMVALFUNC(t):
    r'\w+\{\d+\}::\w+'
    return t

#por exemplo: Notas{5} - diz que ha uma lista de 5 notas
def t_NUMVAL(t):
    r'\w+\{\d+\}'
    return t


def t_TOP(t):
    r'(\w+)( \w+)*'
    return t


#er que capta um numero (que pode ser int ou float)
def t_NUM(t):
    r'\d+(\.\d+)?'
    t.value = float(t.value)
    return t

#separador, neste caso a virgula
def t_SEP(t):
    r'\,'
    return t

t_ignore = '\n\t '

def t_error(t):
    print("ERROR: Illegal character")
    print("error:" + t.value)
    t.lexer.skip(1)

lexer = lex.lex()

#abrir ficheiro input - so para leitura
#csv = open("emd.csv", "r")
csv = open("alunos2.csv", "r")

#le o cabeçalho do csv
#le as linhas todas do ficheiro csv com informaçoes
#fecha o ficheiro
firstline = csv.readline()
texto = csv.readlines()
num_linhas = len(texto)
csv.close()

#print(texto)

lexer.input(firstline)
flag_func = False
func = ""

tops = []
tops_len = len(tops)
num_notas=0
#preenche a lista tops com os elementos do cabeçalho do csv
for tok in lexer:
    print(tok.value)
    if tok.type != "SEP": 
        if tok.type == "NUMVALFUNC":
            num_notas = int(tok.value[6])
            func = tok.value[10:]
            tok.value = tok.value[0:5]
            flag_func = True
            print(func)
        elif tok.type == "NUMVAL":
            num_notas = int(tok.value[6])
            tok.value = tok.value[0:5]
        tops.append(tok.value)
    
tops_len = len(tops)
print(tops)
print(num_notas)

i = 0
j = 0

newline=False
last2=1
ant_not_sep = False
nome = ""
#escrever no ficheiro json
json = open("alunosconver.json", "w")
json.write("[ \n")
dic = {}
dic_final= {}
for linha in texto:
    lexer.input(linha)
    newline=False
    array=[]
    for word in lexer:
        if j < tops_len:
            #print(word)

            #a partir daqui estou a escrever no dicionario
            if word.type != "SEP" and ant_not_sep == False:
                    
                if word.type == "TOP":
                    dic[tops[j]]=word.value
                    #print(word.value + " top \n")
                    nome = word.value
                    ant_not_sep = True
                    if j==tops_len-1 and tops_len>3:
                        array.append(int(word.value))
                
                j+=1 

            elif word.type != "SEP" and ant_not_sep == True:
                nome = nome + " " + word.value
                dic[tops[j-1]]=nome
                ant_not_sep = True  

            else:
                ant_not_sep = False
        
            #j += 1

        elif j == tops_len and word:
            if tops_len > 3:
                if word.type != "SEP": 
                    array.append(int(word.value))
                    dic[tops[j-1]]=array
            else:
                nome = nome + " " + word.value
                dic[tops[j-1]]=nome
            

    if flag_func == True:
        x = eval(func + "("+str(array)+")")
        dic[tops[j-1]] = x
    #print(j)
    j = 0
    print(dic)
    i += 1
    ant_not_sep = False
    #print(dic.items())
    json.write("{ \n")
    last = 1
    for index,(key,value) in enumerate(dic.items()):
        json.write(f'"{key}": "{value}"')
        if last<tops_len:
            json.write(",")
            last+=1
    json.write("\n} \n")

    #json.write(dic.items())
    if last2<num_linhas:
        json.write(",\n")
    last2+=1

print(dic_final)#para ver como estao os dicionarios
print(tops) #imprime a lista dos topicos que queremos no nosso dicionario que queremos 


#escrever o dic
json.write("]")
#fecha os ficheiro json aberto
json.close()





#299b6f65-bc7e-4075-8b10-f7e12cfb9eb0 - nº de entrega