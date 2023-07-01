CREATE VIEW V_encomenda_cliente
AS
SELECT
    E.id_encomenda AS `ID Encomenda`,
    E.distancia AS `Distância (Km)`,
    E.data_pedido AS `Data do Pedido`,
    E.data_entrega AS `Data da Entrega`,
    E.custo AS `Custo`,
    MP.descricao AS `Método de Pagamento`,
    Estado.descricao_estado AS `Entado da Entrega`,
    C.nome AS `Nome do Cliente`,
    C.nif AS `NIF do Cliente`,
    C.email AS `Email do Cliente`,
    C.telemovel AS `Contacto do Cliente`
FROM
    Encomenda E
        INNER JOIN Cliente C
                   ON E.id_cliente = C.id_cliente
        INNER JOIN Estado
                   ON E.estado = Estado.id_estado
        INNER JOIN Metodo_Pagamento MP
                   on E.id_metodo_pagamento = MP.id_metodo_pagamento;

CREATE VIEW `total_encomendado_por_cliente`
AS
SELECT C.nome AS Nome,
    SUM(EI.quantidade) AS `Total Encomendado`
FROM Cliente C
    JOIN Encomenda E
    ON C.id_cliente = E.id_cliente
    JOIN Encomenda_Item EI
    ON E.id_encomenda = EI.id_ecomenda
    GROUP BY C.id_cliente;
