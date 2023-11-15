from pyswip import Prolog


class PrologModel(Prolog):
    def __init__(self) -> None:
        self.consult("prolog.pl")

    def emitir_nota(self, name) -> list:
        query = f"emitir_nota([({name}, 2), (macbook, 1), (apple_watch, 3)], Total)."
        return list(self.query(query))

    def emitir_nota_com_impostos_e_estoque(self, nome) -> list:
        produtos = "[(iphone, 2), (macbook, 1), (apple_watch, 3)]"
        query = f"emitir_nota_com_impostos_e_estoque({produtos}, {nome}, Total, ICMS, ISS, PIS, PASEP, COFINS, CSLL, IRPJ, INSS)"
        return list(self.query(query))

    def cadastrar_cliente(self, nome, endereco) -> None:
        cria_cliente = f"cliente({nome})"
        cria_endereco = f'endereco({nome}, "{endereco}")'

        self.assertz(cria_cliente)
        self.assertz(cria_endereco)

    def cadastrar_produto(self, nome, preco) -> None:
        produto = f"produto(preco({nome}, {preco}))"
        self.assertz(produto)
