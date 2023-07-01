#Queries

# Devolve o nome, email e telemovel de todos os cliente da base de dados
select nome, email, telemovel from Cliente;

# Exemplo de um innerjoin que devolve a correspondência entre cervejas e a respetiva marca
select I.nome Cerveja, M.nome Marca from Item I
inner join Marca M
on I.id_marca = M.id_marca;

# Devolve as encomenda com o pedido feito nos últimos 6 meses
select id_encomenda, data_pedido from Encomenda
where data_pedido >= DATE_SUB(NOW(), INTERVAL 6 MONTH );

# Corresponde as cervejas da base de dados com o seu tipo
select I.nome Cerveja, C.nome Tipo from Item I
inner join Categoria C
on I.id_categoria = c.id_categoria;

# Corresponde id da encomenda, nome do cliente e data do pedido
select E.id_encomenda, C.nome, E.data_pedido from Encomenda as E
inner join Cliente as C
on E.id_cliente = C.id_cliente;

# Todas a encomendas que incluem a categoria pedida
select E.id_encomenda, I.nome, C.nome from Encomenda E
inner join Encomenda_Item EI
on E.id_encomenda = EI.id_ecomenda
inner join Item I on EI.id_item = I.id_item
inner join Categoria C on I.id_categoria = C.id_categoria
where C.nome = 'Stout';

# Valor total do custo das encomendas num intervalo de tempo
select SUM(custo) from Encomenda E
where E.data_pedido >= DATE_SUB(NOW(), interval 12 month);

INSERT INTO Encomenda (id_encomenda, distancia, data_pedido, data_entrega, custo, id_metodo_pagamento, estado, id_cliente, id_funcionario_armazem, id_estafeta, id_armazem)
VALUES (90,25,'2022-07-15 03:57:39',NULL,0,3,3,7,3,3,1);

select table_schema, sum((data_length+index_length)/1024/1024) AS MB from information_schema.tables group by 1;

select * from Encomenda

