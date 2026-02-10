-- -------------------------------------
-- Povoamento da Base de Dados
-- -------------------------------------

-- Povoamento da tabela Cliente 
-- -------------------------------------
INSERT INTO Cliente (id, identificacao, contacto) VALUES
(1, 'João Silva', 123456789),
(2, 'Maria Santos', 987654321),
(3, 'Pedro Almeida', 555666777),
(4, 'Ana Oliveira', 111222333),
(5, 'Carlos Pereira', 999888777),
(6, 'Sofia Rodrigues', 444555666),
(7, 'Miguel Costa', 777888999),
(8, 'Inês Ferreira', 666555444),
(9, 'Rui Sousa', 222333444),
(10, 'Lúcia Martins', 888999000);

-- -------------------------------------
-- Povoamento da tabela Pedido 
-- -------------------------------------
INSERT INTO Pedido (id, local_requisitado_rua, local_requisitado_codigo_postal, data_requisitada, preco_max, tipo, descricao, Cliente_id) VALUES
(1, 'Rua A', 12345,'2023-01-10 08:00:00', 50100, 'Concerto', NULL, 1),
(2, 'Rua B', 54321,'2023-02-15 14:30:00', 3400, 'Festa', NULL, 2),
(3, 'Rua C', 67890,'2023-03-20 10:45:00', 5000, 'Conferencia', NULL, 3),
(4, 'Rua D', 48217,'2023-04-05 09:00:00', 150.75, 'Normal', NULL, 4),
(5, 'Rua E', 24680,'2023-05-12 11:20:00', 6000, 'Palestra', NULL, 5),
(6, 'Rua F', 90356,'2023-06-25 16:00:00', 500, 'Aniversario', NULL, 6),
(7, 'Rua F', 90356,'2023-06-25 16:00:00', 3000, 'Teatro', NULL, 7),
(8, 'Rua G', 73980,'2023-08-19 09:30:00', 300.25, 'Urgente', NULL, 8),
(9, 'Rua I', 24873,'2023-09-30 10:00:00', 50.00, 'Normal', NULL, 9),
(10, 'Rua J', 60194,'2023-10-14 15:45:00', 180.00, 'Urgente', NULL, 10);


-- -------------------------------------
-- Povoamento da tabela Funcionario
-- -------------------------------------
INSERT INTO Funcionario(id, nome, contacto, tipo) VALUES
(1, 'Carlos Silva', 987654321, 'Gerente'),
(2, 'Ana Santos', 123456789, 'Assistente'),
(3, 'Miguel Pereira', 555666777, 'Assistente'),
(4, 'Sofia Ferreira', 111222333, 'Assistente'),
(5, 'João Almeida', 999888777, 'Assistente');

-- -------------------------------------
-- Povoamento da tabela Evento
-- -------------------------------------
INSERT INTO Evento (id, data_final, tipo, local_final_rua, local_final_codigo_postal, preco_final, hora_final, n_pessoas, hora_inicio, Pedido_id, Pedido_Cliente_id) VALUES
(1, '2023-01-20 17:00:00', 'Concerto', 'Rua A', '12345', 50000, '20:00:00', 100, '17:00:00', 1, 1),
(2, '2023-02-10 20:30:00', 'Festa', 'Rua B', '54321', 3000, '23:00:00', 50, '20:30:00', 2, 2),
(3, '2023-03-15 18:00:00', 'Conferência', 'Rua C', '67890', 2000, '23:00:00', 200, '18:00:00', 3, 3),
(5, '2023-05-18 17:30:00', 'Palestra', 'Rua E', '24680', 5000, '20:00:00', 30, '17:00:00', 5, 5),
(6, '2023-06-25 16:00:00', 'Aniversario', 'Rua F', '90356', 422, '17:00:00', 10, '16:00:00', 6, 6),
(7, '2023-06-25 16:00:00', 'Orgia', 'Rua F', '90356', 2150, '17:00:00', 7, '16:00:00', 7, 7);


-- -------------------------------------
-- Povoamento da tabela Evento_tem_Funcionario
-- -------------------------------------
INSERT INTO Evento_tem_Funcionario (Evento_id, Evento_Pedido_id, Evento_Pedido_Cliente_id, Funcionario_id) VALUES
(1, 1, 1, 2),    
(1, 1, 1, 3),	  
(1, 1, 1, 4),
(1, 1, 1, 5),
(2, 2, 2, 4),
(3, 3, 3, 3),
(3, 3, 3, 4),
(5, 5, 5, 2),
(5, 5, 5, 4),
(5, 5, 5, 5);
