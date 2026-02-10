-- ---------------------------
-- Function 
-- ---------------------------

-- deduçao do valor que se tem a pagar a um determinado funcionario pelas horas prestadas em todos os eventos em que esteve~
DELIMITER //

CREATE FUNCTION CalculateTotalSalaryForFuncionario(f_id INT) RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total_salary DECIMAL(10,2);

    SELECT SUM(TIMESTAMPDIFF(SECOND, e.hora_inicio, e.hora_final) / 3600 * 6)
    INTO total_salary
    FROM Evento e
    INNER JOIN Evento_tem_Funcionario ef ON e.id = ef.Evento_id
        AND e.Pedido_id = ef.Evento_Pedido_id
        AND e.Pedido_Cliente_id = ef.Evento_Pedido_Cliente_id
    WHERE ef.Funcionario_id = f_id;

    RETURN total_salary;
END //

DELIMITER ;

SELECT CalculateTotalSalaryForFuncionario(2) AS TotalSalary;