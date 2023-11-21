:- dynamic produto/1.
:- dynamic estoque/2.
:- dynamic cliente/1.
:- dynamic fornecedor/1.
:- dynamic endereco/2.

% Definir os clientes e seus endereços
cliente(joao).
cliente(maria).

% Definir os fornecedor e seus endereços
fornecedor(jose).
fornecedor(claudia).

% Definir endereço de clientes
endereco(joao, "Rua da Amostra, 123").
endereco(maria, "Rua da festa, 654").

%Definir endereço de fornecedores
endereco(jose, "Rua do fornecedor Jose, 021").
endereco(claudia, "Rua da festa, 654").

% Definir os produtos e seus preços por unidade
produto(preco(iphone, 1250)).
produto(preco(macbook, 1500)).
produto(preco(apple_watch, 400)).
produto(preco(ipad, 800)).

% Verificar estoque
estoque(iphone, 10000000).
estoque(macbook, 10000000).
estoque(apple_watch, 10000000).
estoque(ipad, 10000000).

% Definir impostos
calcular_icms(Total, Imposto) :- Imposto is Total * 0.18.
calcular_iss(Total, Imposto) :- Imposto is Total * 0.05.
calcular_pis(Total, Imposto) :- Imposto is Total * 0.02.
calcular_pasep(Total, Imposto) :- Imposto is Total * 0.1225.
calcular_cofins(Total, Imposto) :- Imposto is Total * 0.076.
calcular_csll(Total, Imposto) :- Imposto is Total * 0.12.
calcular_irpj(Total, Imposto) :- Imposto is Total * 0.15.
calcular_inss(Total, Imposto) :- Imposto is Total * 0.05.

% Regras para calcular o total da nota fiscal
calcular_total([], 0).
calcular_total([(Produto, Quantidade) | Resto], Total) :-
    produto(preco(Produto, PrecoUnitario)),
    calcular_total(Resto, TotalResto),
    Total is (PrecoUnitario * Quantidade) + TotalResto.

% Definir desconto para produtos
aplicar_desconto(Produto, Quantidade, Desconto) :-
    produto(preco(Produto, PrecoUnitario)),
    Desconto is PrecoUnitario * Quantidade * 0.05. % 5% de desconto

% Regra para emitir uma nota fiscal
emitir_nota(Produtos, Total) :-
    calcular_total(Produtos, Total),
    write('Nota fiscal:'), nl,
    imprimir_produtos(Produtos),
    write('Total: $'), write(Total).

emitir_nota_com_cliente(Produtos, Cliente) :-
    calcular_total(Produtos, Total),
    cliente(Cliente),
    endereco(Cliente, Endereco),
    write('Nota fiscal para: '), write(Cliente), nl,
    write('Endereço de entrega: '), write(Endereco), nl,
    imprimir_produtos(Produtos),
    write('Total: $'), write(Total).

calcular_total_com_desconto([], 0).
calcular_total_com_desconto([(Produto, Quantidade) | Resto], Total) :-
    aplicar_desconto(Produto, Quantidade, Desconto),
    calcular_total_com_desconto(Resto, TotalResto),
    write('PrecoUnitario: $'), write(PrecoUnitario), nl,
    Total is (PrecoUnitario * Quantidade - Desconto) + TotalResto.

verificar_estoque([]).
verificar_estoque([(Produto, Quantidade) | Resto]) :-
    estoque(Produto, EstoqueAtual),
    EstoqueAtual >= Quantidade,
    NovoEstoque is EstoqueAtual - Quantidade,
    retract(estoque(Produto, EstoqueAtual)),
    asserta(estoque(Produto, NovoEstoque)),
    verificar_estoque(Resto).

% Regra auxiliar para imprimir a lista de produtos
imprimir_produtos([]).
imprimir_produtos([(Produto, Quantidade) | Resto]) :-
    write(Produto), write(' x '), write(Quantidade), nl,
    imprimir_produtos(Resto).

emitir_nota_com_impostos_e_estoque(Produtos, Cliente, Fornecedor, Cliente, Endereco, Fornecedor, EnderecoFornecedor, Produtos, Total, ICMS, ISS, PIS, PASEP, COFINS, CSLL, IRPJ, INSS, TotalComImpostos) :-
    verificar_estoque(Produtos),
    calcular_total(Produtos, Total),
    calcular_icms(Total, ICMS),
    calcular_iss(Total, ISS),
    calcular_pis(Total, PIS),
    calcular_pasep(Total, PASEP),
    calcular_cofins(Total, COFINS),
    calcular_csll(Total, CSLL),
    calcular_irpj(Total, IRPJ),
    calcular_inss(Total, INSS),
    cliente(Cliente),
    endereco(Cliente, Endereco),
    fornecedor(Fornecedor),
    endereco(Fornecedor, EnderecoFornecedor),
    write('Nota fiscal para: '), write(Cliente), nl,
    write('Endereço de entrega: '), write(Endereco), nl,
    imprimir_produtos(Produtos),
    write('Total: $'), write(Total), nl,
    write('ICMS: $'), write(ICMS), nl,
    write('ISS: $'), write(ISS), nl,
    write('PIS: $'), write(PIS), nl,
    write('PASEP: $'), write(PASEP), nl,
    write('COFINS: $'), write(COFINS), nl,
    write('CSLL: $'), write(CSLL), nl,
    write('IRPJ: $'), write(IRPJ), nl,
    write('INSS: $'), write(INSS), nl,
    TotalComImpostos is Total + ICMS + ISS + PIS + PASEP + COFINS + CSLL + IRPJ + INSS,
    write('Total com impostos: $'), write(TotalComImpostos).

cadastrar_cliente(Cliente) :-
    assertz(cliente(Cliente)),
    write('Cliente:'), write(' [ '), write(Cliente), write(' ] cadastrado com sucesso!').

cadastrar_endereco(Cliente, Endereco) :-
 	assertz(endereco(Cliente, Endereco)),
    write('Endereco:'), write(' [ '), write(Cliente), write(', '), write(Endereco), write(' ] cadastrado com sucesso!').

cadastrar_fornecedor(Fornecedor) :-
	 assertz(fornecedor(Fornecedor)),
     write('Fornecedor:'), write(' [ '), write(Fornecedor), write(' ] cadastrado com sucesso!').

cadastrar_produto(Produto, Valor) :-
	assertz(produto(preco(Produto, Valor))),
    write('Produto:'), write(' [ '), write(Produto), write(', '), write(Valor), write(' ] cadastrado com sucesso!'). write().

cadastrar_estoque(Produto, Estoque) :-
    assertz(estoque(Produto, Estoque)),
    write('Estoque:'), write(' [ '), write(Produto), write(', '), write(Estoque), write(' ] cadastrado com sucesso!').

cancelar_nota :-
    write('Nota fiscal cancelada com sucesso!').
