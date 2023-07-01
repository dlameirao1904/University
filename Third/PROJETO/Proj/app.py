from flask import Flask, render_template, jsonify
import json

app = Flask(__name__)

with open('datasets/atco1_acordaos_Ids.json', 'r',encoding='utf-8') as f:
#with open('datasets/datasetFinal.json', 'r',encoding='utf-8') as f:
        acordaos = json.load(f)

@app.route("/")
def homepage():
     return render_template('homepage.html')

@app.route("/informações")
def mostrar_informaçoes():
     return render_template('informações.html')

@app.route("/informações/autores")
def mostrar_autores():
     return render_template('autores.html')

@app.route("/acordaos")
def mostrar_acordaos():
    return render_template('acordaos.html', acordaos=acordaos)

@app.route("/acordaos/<id>")
def mostra_acordaos(id):
    for acordao in acordaos['acordaos']:
        if acordao['id'] == id:
            return render_template('acordao.html', acordao=acordao)
    return jsonify({'erro':'nao encontrado'})


if __name__=="__main__":
    app.run(debug=True)





