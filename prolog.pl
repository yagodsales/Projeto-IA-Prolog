% Definir os clientes e seus endereços
cliente(joao).
endereco(joao, "Rua da Amostra, 123").
 
%cliente(maria).
%endereco(maria, "Rua da festa, 654").
 
% Definir os produtos e seus preços por unidade
produto(preco(iphone, 1000)).
produto(preco(macbook, 1500)).
produto(preco(apple_watch, 400)).
produto(preco(ipad, 800)).
 
% Regras para calcular o total da nota fiscal
calcular_total([], 0).
calcular_total([(Produto, Quantidade) | Resto], Total) :-
    produto(preco(Produto, PrecoUnitario)),
    calcular_total(Resto, TotalResto),
    Total is (PrecoUnitario * Quantidade) + TotalResto.
 
% Definir desconto para produtos
aplicar_desconto(Produto, Quantidade, Desconto) :-
    produto(preco(Produto, PrecoUnitario)),
    Desconto is PrecoUnitario * Quantidade * 0.1. % 10% de desconto
 
% Regra para emitir uma nota fiscal
emitir_nota(Produtos) :-
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
    Total is (PrecoUnitario * Quantidade - Desconto) + TotalResto.
 
% Regra auxiliar para imprimir a lista de produtos
imprimir_produtos([]).
imprimir_produtos([(Produto, Quantidade) | Resto]) :-
    write(Produto), write(' x '), write(Quantidade), nl,
    imprimir_produtos(Resto).
