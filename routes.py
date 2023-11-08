from flask import Flask, render_template, request
from pyswip import Prolog

prolog = Prolog()
prolog.consult("prolog.pl")

app = Flask(__name__)


@app.route('/', methods=('GET', 'POST'))
def renderiza_prolog():
    return render_template('formulario.html')


@app.route('/resposta', methods=['POST',])
def processa_prolog():
    nome = request.form['nome']
    cnpj = request.form['cnpj']
    numero = request.form['numero']
    data = request.form['data']
    valor = request.form['valor']
    produtos = request.form['produtos']
    teste = prolog.query("emitir_nota([(iphone, 2), (macbook, 1), (apple_watch, 3)]).")
    print(nome)
    return render_template('resposta.html', nome=nome, teste=teste)



app.run(debug=True)
