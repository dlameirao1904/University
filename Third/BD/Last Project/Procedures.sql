use Eventos;

-- Listar informações relativas a um evento específico
DELIMITER //

CREATE PROCEDURE GetEventDetails(
    IN evento_id INT,
    IN evento_pedido_id INT,
    IN evento_pedido_cliente_id INT
)
BEGIN
    SELECT *
    FROM Evento
    WHERE id = evento_id
        AND Pedido_id = evento_pedido_id
        AND Pedido_Cliente_id = evento_pedido_cliente_id;
END //

DELIMITER ;

CALL GetEventDetails(1, 1, 1);


-- Contar os eventos de um funcionário
DELIMITER //

CREATE PROCEDURE CountEventsForFuncionario(
    IN funcionario_id INT
)
BEGIN
    SELECT COUNT(*) AS TotalEvents
    FROM Evento_tem_Funcionario
    WHERE Funcionario_id = funcionario_id;
END //

DELIMITER ;

CALL CountEventsForFuncionario(1);

-- Atualizar o preço de um pedido
DELIMITER //

CREATE PROCEDURE UpdatePrecoMax(
    IN pedido_id INT,
    IN novo_preco_max DOUBLE
)
BEGIN
    UPDATE Pedido
    SET preco_max = novo_preco_max
    WHERE id = pedido_id;
END //

DELIMITER ;

CALL UpdatePrecoMax(1, 150.00);

