# Atualiza os campos de contacto de um clinete
DELIMITER $$
CREATE PROCEDURE update_info_contacto_cliente (IN id_cliente_param INT, IN email_param VARCHAR(45), IN telemovel_param VARCHAR(15))
BEGIN
  UPDATE Cliente
    SET email = email_param, telemovel = telemovel_param
    WHERE id_cliente = id_cliente_param AND isDeleted = 0;
END $$
DELIMITER $$
# Soma o custo de cada item da encomenda e usa a distancia tambem para atualizar o custo total da encomenda
CREATE PROCEDURE calculate_order_cost (IN id_encomenda_param INT)
BEGIN
    DECLARE custo_total FLOAT;
    DECLARE distancia_total INT;

    SET custo_total = 0;

    SELECT SUM(i.preco * ei.quantidade) INTO custo_total
    FROM Encomenda_Item ei
    INNER JOIN Item i
    ON ei.id_item = i.id_item
    WHERE ei.id_ecomenda = id_encomenda_param AND i.isDeleted = 0;

    SELECT SUM(e.distancia) INTO distancia_total
    FROM Encomenda e
    WHERE e.id_encomenda = id_encomenda_param AND e.isDeleted = 0;

    SET custo_total = custo_total + (distancia_total * 0.10);

    UPDATE Encomenda
    SET Encomenda.custo = custo_total
    WHERE Encomenda.id_encomenda = id_encomenda_param AND Encomenda.isDeleted = 0;
END$$
DELIMITER $$
# Mostra as encomendas com a data_pedido de um certo mes e ano
CREATE PROCEDURE get_encomendas_mes (IN month INT, IN year INT)
BEGIN
  SELECT * FROM Encomenda
  WHERE MONTH(data_pedido) = month AND YEAR(data_pedido) = year AND Encomenda.isDeleted = 0
  ORDER BY data_pedido;
END$$
DELIMITER $$
CREATE PROCEDURE get_produtos_com_stock (IN armazem_id INT)
BEGIN
  SELECT Item.nome, Item_Armazem.stock
  FROM Item
  INNER JOIN Item_Armazem
  ON Item.id_item = Item_Armazem.id_item
  WHERE Item_Armazem.id_armazem = armazem_id AND Item_Armazem.isDeleted = 0
  ORDER BY Item.nome;
END$$
DELIMITER $$
CREATE PROCEDURE get_clientes_por_tipo (IN tipo_cliente_id INT)
BEGIN
  SELECT nome, email, telemovel
  FROM Cliente
  WHERE id_tipo_cliente = tipo_cliente_id AND Cliente.isDeleted = 0
  ORDER BY nome;
END$$
DELIMITER $$
CREATE PROCEDURE criar_cliente (IN nome_param VARCHAR(45), IN nif_param VARCHAR(9), IN email_param VARCHAR(45), IN telemovel_param VARCHAR(15), IN data_nascimento_param DATE, IN linha_endereco1_param VARCHAR(45), IN linha_endereco2_param VARCHAR(45), IN codigo_postal_param VARCHAR(45), IN localidade_param VARCHAR(45), IN tipo_cliente_param INT)
BEGIN
	START TRANSACTION;

	INSERT INTO Morada (linha_endereco1, linha_endereco2, codigo_postal, localidade)
	VALUES (linha_endereco1_param, linha_endereco2_param, codigo_postal_param, localidade_param);

	SET @id_morada = LAST_INSERT_ID();

	INSERT INTO Cliente (nome, nif, email, telemovel, data_nascimento, id_morada, id_tipo_cliente)
    VALUES (nome_param, nif_param, email_param, telemovel_param, data_nascimento_param, @id_morada, tipo_cliente_param);
    COMMIT;
END$$
DELIMITER $$
CREATE PROCEDURE adicionar_stock (IN item_param INT, armazem_param INT, stock_param INT)
BEGIN
    IF EXISTS (SELECT * FROM Item_Armazem WHERE id_item = item_param AND id_armazem = armazem_param AND Item_Armazem.isDeleted = 0) THEN
        IF EXISTS (SELECT * FROM Armazem WHERE id_armazem = armazem_param  AND Armazem.isDeleted = 0) THEN
            UPDATE Item_Armazem SET stock = stock + stock_param WHERE id_item = item_param AND id_armazem = armazem_param;
        ELSE IF (SELECT * FROM Armazem WHERE id_armazem = armazem_param AND Armazem.isDeleted = 0) THEN
            INSERT INTO Item_Armazem (id_item, id_armazem, stock) VALUES (item_param, armazem_param, stock_param);
        END IF;
        END IF;
    END IF;
END;$$
DELIMITER $$
CREATE PROCEDURE `beerlivery`.`eliminar_cliente` (IN `id_cliente_param` INT)
BEGIN
  UPDATE `beerlivery`.`Cliente` SET isDeleted = 1 WHERE id_cliente = id_cliente_param;
END$$
DELIMITER $$
CREATE PROCEDURE `beerlivery`.`marcar_como_entregue` (in `id_encomenda_param` INT)
BEGIN
    IF EXISTS(SELECT * FROM Encomenda WHERE id_encomenda = id_encomenda_param AND isDeleted=0) THEN
        UPDATE `beerlivery`.Encomenda SET data_entrega = NOW(), estado = 5
        WHERE id_encomenda = id_encomenda_param;
    end if;
end$$