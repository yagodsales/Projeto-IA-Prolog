from flask import Flask, render_template, request
from class_prolog import Prolog

app = Flask(__name__)


@app.route('/inicio')
def renderiza_tela_menu():
    return render_template('tela_inicio.html', titulo='TESTE')


@app.route('/inicio/formulario')
def renderiza_prolog():
    nome = request.form['nome']
    cnpj = request.form['cnpj']
    numero = request.form['numero']
    data = request.form['data']
    valor = request.form['valor']
    produtos = request.form['produtos']

    return render_template('formulario.html')



@app.route('/inicio/formulario/prolog', methods=['POST'])
def processa_prolog():
    nome = request.form['nome']
    cnpj = request.form['cnpj']
    numero = request.form['numero']
    data = request.form['data']
    valor = request.form['valor']
    produtos = request.form['produtos']



app.run()
