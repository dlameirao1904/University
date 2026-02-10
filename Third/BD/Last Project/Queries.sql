-- -------------------------------------
-- Queries
-- -------------------------------------


-- Listar todos os clientes;
SELECT * FROM cliente;

----------------------------------------------------------------------------------------------------

-- Listar os eventos e os respetivos clientes por ordem das datas mais recentes em que vão acontecer;
SELECT Cliente.identificacao, Evento.tipo, Evento.data_final FROM Evento
JOIN Pedido ON Evento.Pedido_id = Pedido.id
JOIN Cliente ON Pedido.Cliente_id = Cliente.id
ORDER BY Evento.data_final;

-- Deve disponibilizar uma lista decrescente dos funcionários que trabalharam em mais eventos;
SELECT Funcionario.nome, COUNT(Evento_tem_Funcionario.Funcionario_id) AS Participacoes FROM Evento_tem_Funcionario
JOIN Funcionario ON Evento_tem_Funcionario.Funcionario_id = Funcionario.id
GROUP BY Funcionario.nome
ORDER BY COUNT(Evento_tem_Funcionario.Funcionario_id) DESC;



-- Apresentar o pedido feito por um determinado cliente;
SELECT Cliente.identificacao FROM Cliente
WHERE (Cliente.id = 5);

-- Mostrar uma lista com os clientes que tenham o maior valor gasto com os seus eventos;
SELECT Cliente.identificacao, SUM(Evento.preco_final) AS Total_Gasto FROM Evento
JOIN Pedido ON Evento.Pedido_id = Pedido.id
JOIN Cliente ON Pedido.Cliente_id = Cliente.id
GROUP BY Cliente.identificacao
ORDER BY SUM(Evento.preco_final) DESC;  

-- Listar o tempo de duracao de cada evento;
SELECT Evento.id, Evento.tipo, TIMEDIFF(hora_final, hora_inicio) AS Duracao FROM Evento;