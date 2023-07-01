import json
import os
#files = os.listdir('datasets/')
files = ['atco1_acordaos.json']
i=0
lista_output1 = []
lista_comuns = []
lista_prev = []
#percorrer a lista dos datasets
for file in files:
    dic = {}
    with open(file,encoding='utf-8') as json_file:
        #load do ficheiro
        data = json.load(json_file)
    #criar um set para nao ter repetidos 
    values_futuros = set()
    acordaos=data['acordaos']
    #percorrer a lista do json
    for acordao in acordaos:
        #meter as chaves numa lista
        lista=list(acordao.keys())
        #percorrer a lista das chaves
        for x in lista:
            #adicionar as chaves no set
            values_futuros.add(x)
    i+=1
    dic['Dicionario '+ str(i)] = list(values_futuros)
    lista_output1.append(dic)
    if i>1:
       lista_prev=lista_prev.intersection(values_futuros)
    else:
        lista_prev = values_futuros
lista_comuns=list(lista_prev)
with open("output1.json", "w") as outfile:
    json.dump(lista_output1, outfile,indent=1,ensure_ascii=False)


with open("output2.json", "w") as outfile:
    json.dump(lista_comuns, outfile,indent=1,ensure_ascii=False)

