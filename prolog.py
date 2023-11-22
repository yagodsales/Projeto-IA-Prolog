from pyswip import Prolog


class PrologModel(Prolog):
    def __init__(self) -> None:
        self.consult("prolog.pl")

    def emitir_nota_com_impostos_e_estoque(self, nome, fornecedor, produtos) -> list:
        query_produtos = "["
        lista_linha_produto = produtos.split("\r\n")

        for linha_produto in lista_linha_produto:
            if linha_produto.strip() == "":
                continue
            query_produtos += f"({linha_produto}), "

        query_produtos = query_produtos[:-2]
        query_produtos += "]"

        query = f"emitir_nota_com_impostos_e_estoque({query_produtos}, {nome}, {fornecedor}, Cliente, Endereco, Fornecedor, EnderecoFornecedor, Produtos, Total, ICMS, ISS, PIS, PASEP, COFINS, CSLL, IRPJ, INSS, TotalComImpostos)"
        return list(self.query(query))[0]

    def cadastrar_cliente(self, nome, endereco) -> None:
        add_cliente = f"cliente({nome})"
        add_endereco = f'endereco({nome}, "{endereco}")'

        self.assertz(add_cliente)
        self.assertz(add_endereco)

    def cadastrar_fornecedor(self, nome, endereco) -> None:
        add_fornecedor = f"fornecedor({nome})"
        add_endereco = f'endereco({nome}, "{endereco}")'

        self.assertz(add_fornecedor)
        self.assertz(add_endereco)

    def cadastrar_produto(self, nome, preco, estoque) -> None:
        add_produto = f"produto(preco({nome}, {preco}))"
        add_estoque = f"estoque({nome}, {estoque})"

        self.assertz(add_produto)
        self.assertz(add_estoque)
