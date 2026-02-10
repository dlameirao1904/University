use Eventos;

-- Listar todos os eventos com detalhes dos Funcionários:
CREATE VIEW View_Eventos_Funcionarios AS
SELECT ef.Evento_id, ef.Evento_Pedido_id, ef.Evento_Pedido_Cliente_id, ef.Funcionario_id,
       f.nome AS Funcionario_Nome, f.contacto AS Funcionario_Contacto, f.tipo AS Funcionario_Tipo
FROM Evento_tem_Funcionario ef
INNER JOIN Funcionario f ON ef.Funcionario_id = f.id;

SELECT * FROM View_Eventos_Funcionarios;


-- Listar todos os eventos com detalhes dos clientes
CREATE VIEW View_Eventos_Cliente AS
SELECT e.id AS Evento_ID, e.data_final, e.tipo AS Evento_Tipo, e.local_final_rua, e.local_final_codigo_postal,
       e.preco_final, e.hora_final, e.n_pessoas, e.hora_inicio,
       p.id AS Pedido_ID, p.local_requisitado_rua, p.local_requisitado_codigo_postal, p.data_requisitada, p.preco_max, p.tipo AS Pedido_Tipo,
       c.id AS Cliente_ID, c.identificacao, c.contacto
FROM Evento e
INNER JOIN Pedido p ON e.Pedido_id = p.id AND e.Pedido_Cliente_id = p.Cliente_id
INNER JOIN Cliente c ON p.Cliente_id = c.id;


SELECT * FROM View_Eventos_Cliente;