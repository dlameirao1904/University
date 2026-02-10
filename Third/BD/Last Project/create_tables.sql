CREATE DATABASE IF NOT EXISTS Eventos 
DEFAULT CHARACTER SET utf8;
SHOW WARNINGS;


-- Indicação da base de dados de trabalho
USE Eventos;


-- -------------------------------------
-- Apagar a Base de dados
-- DROP DATABASE Eventos;


-- -------------------------------------
-- Criação das tabelas da base de dados
-- -------------------------------------

-- Criação da Tabela "Cliente"
-- DROP TABLE Cliente;
-- SELECT * FROM Cliente;
-- -------------------------------------


CREATE TABLE IF NOT EXISTS Cliente (
  id INT NOT NULL,
  identificacao VARCHAR(75) NOT NULL,
  contacto INT NOT NULL,
  
  PRIMARY KEY (id),
  UNIQUE KEY contacto(contacto));
  
  
 
-- -------------------------------------
-- Criação da Tabela "Pedido"
-- DROP TABLE Pedido;
--  select * from cliente;
-- -------------------------------------


CREATE TABLE IF NOT EXISTS Pedido (
  id INT NOT NULL,
  local_requisitado_rua VARCHAR(75) NOT NULL,
  local_requisitado_codigo_postal VARCHAR(75) NOT NULL,
  data_requisitada DATETIME NOT NULL,
  preco_max DOUBLE NOT NULL,
  tipo VARCHAR(75) NOT NULL,
  descricao VARCHAR(75) NULL,
  Cliente_id INT NOT NULL,
  
  PRIMARY KEY (id, Cliente_id),
  FOREIGN KEY (Cliente_id) REFERENCES Cliente(id));
  
-- -------------------------------------
-- Criação da Tabela "Funcionario"
-- DROP TABLE Funcionario;
-- SELECT * FROM Funcionario;
-- -------------------------------------


CREATE TABLE IF NOT EXISTS Funcionario (
  id INT NOT NULL,
  nome VARCHAR(75) NOT NULL,
  contacto INT NOT NULL,
  tipo VARCHAR(75) NOT NULL,
  PRIMARY KEY (id),
  UNIQUE KEY (contacto));

-- -------------------------------------
-- Criação da Tabela "Evento"
-- DROP TABLE Evento;
-- SELECT * FROM Evento;
-- -------------------------------------


CREATE TABLE IF NOT EXISTS Evento (
  id INT NOT NULL,
  data_final DATETIME NOT NULL,
  tipo VARCHAR(75) NOT NULL,
  local_final_rua VARCHAR(75) NOT NULL,
  local_final_codigo_postal VARCHAR(75) NOT NULL,
  preco_final DOUBLE NOT NULL,
  hora_final TIME NOT NULL,
  n_pessoas INT NOT NULL,
  hora_inicio TIME NOT NULL,
  Pedido_id INT NOT NULL,
  Pedido_Cliente_id INT NOT NULL,
  PRIMARY KEY (id, Pedido_id, Pedido_Cliente_id),
  FOREIGN KEY (Pedido_id, Pedido_Cliente_id) REFERENCES Pedido (id, Cliente_id));
  

-- -------------------------------------
-- Criação da Tabela "Evento_tem_Funcionario"
-- DROP TABLE Evento_tem_Funcionario;
-- SELECT * FROM Evento_tem_Funcionario;
-- -------------------------------------


CREATE TABLE IF NOT EXISTS Evento_tem_Funcionario (
  Evento_id INT NOT NULL,
  Evento_Pedido_id INT NOT NULL,
  Evento_Pedido_Cliente_id INT NOT NULL,
  Funcionario_id INT NOT NULL,
  PRIMARY KEY (Evento_id, Evento_Pedido_id, Evento_Pedido_Cliente_id, Funcionario_id),
  FOREIGN KEY (Evento_id, Evento_Pedido_id, Evento_Pedido_Cliente_id) REFERENCES Evento (id, Pedido_id, Pedido_Cliente_id),
  FOREIGN KEY (Funcionario_id) REFERENCES Funcionario (id));


     

