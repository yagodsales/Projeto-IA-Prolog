from flask import Flask, render_template, request
from prolog import PrologModel

prolog = PrologModel()

app = Flask(__name__)


@app.route("/", methods=("GET", "POST"))
def pagina_inicial():
    return render_template("tela_inicio.html")


@app.route("/cliente", methods=("GET", "POST"))
def cadastrar_cliente():
    try:
        nome = request.form["nome"]
        endereco = request.form["endereco"]
        prolog.cadastrar_cliente(nome, endereco)
        cadastrado = f"Cliente {nome} cadastrado com sucesso!"
    except:
        endereco = ""
        nome = ""
        cadastrado = ""
    return render_template("cadastrar_cliente.html", cadastrado=cadastrado)


@app.route("/nota-fiscal", methods=("GET", "POST"))
def gerar_nota_fiscal():
    return render_template("formulario.html")


@app.route(
    "/resposta",
    methods=[
        "POST",
    ],
)
def processa_prolog():
    nome = request.form["nome"]
    cnpj = request.form["cnpj"]
    numero = request.form["numero"]
    data = request.form["data"]
    valor = request.form["valor"]
    produtos = request.form["produtos"]
    # teste = prolog.emitir_nota(nome)
    nota = prolog.emitir_nota_com_impostos_e_estoque(nome)
    return render_template("resposta.html", nome=nome, nota=nota)


app.run(debug=True)
