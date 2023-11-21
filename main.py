from flask import Flask, render_template, request
from prolog import PrologModel

prolog = PrologModel()

app = Flask(__name__)


@app.route("/", methods=("GET", "POST"))
def pagina_inicial():
    return render_template("home.html")


@app.route("/cliente", methods=("GET", "POST"))
def cadastrar_cliente():
    try:
        nome = request.form["nome"]
        endereco = request.form["endereco"]

        prolog.cadastrar_cliente(nome, endereco)
        cadastrado = f"Cliente {nome} cadastrado com sucesso!"
    except:
        cadastrado = ""
    return render_template("cadastrar_cliente.html", cadastrado=cadastrado)


@app.route("/produto", methods=("GET", "POST"))
def cadastrar_produto():
    try:
        nome = request.form["nome"]
        preco = request.form["preco"]
        estoque = request.form["estoque"]

        prolog.cadastrar_produto(nome, preco, estoque)
        cadastrado = f"Produto {nome} cadastrado com sucesso!"
    except:
        cadastrado = ""
    return render_template("cadastrar_produto.html", cadastrado=cadastrado)


@app.route("/fornecedor", methods=("GET", "POST"))
def cadastrar_fornecedor():
    try:
        nome = request.form["nome"]
        endereco = request.form["endereco"]

        prolog.cadastrar_fornecedor(nome, endereco)
        cadastrado = f"Fornecedor {nome} cadastrado com sucesso!"
    except:
        cadastrado = ""
    return render_template("cadastrar_fornecedor.html", cadastrado=cadastrado)


@app.route("/nota-fiscal", methods=("GET", "POST"))
def gerar_nota_fiscal():
    return render_template("gerar_nota.html")


@app.route(
    "/nota-fiscal/nota",
    methods=[
        "POST",
    ],
)
def processa_prolog():
    try:
        nome = request.form["nome"]
        produtos = request.form["produtos"]
        nota = prolog.emitir_nota_com_impostos_e_estoque(nome, produtos)

        nota["Endereco"] = nota["Endereco"].decode("utf-8")
        nota["EnderecoFornecedor"] = nota["EnderecoFornecedor"].decode("utf-8")
        nota["Produtos"] = produtos

        print(nota)
    except:
        nota = "Não foi possível gerar Nota Fiscal."
    return render_template("nota_fiscal.html", nota=nota)


app.run(debug=True)
