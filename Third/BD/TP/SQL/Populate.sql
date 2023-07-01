use beerlivery;

# Tipo_Cliente
INSERT INTO `Tipo_Cliente` (`id_tipo_cliente`, `descricao`) VALUES (1, 'Particular');
INSERT INTO `Tipo_Cliente` (`id_tipo_cliente`, `descricao`) VALUES (2, 'Empresarial');

# Medodo_Pagamento
INSERT INTO `Metodo_Pagamento` (`id_metodo_pagamento`, `descricao`) VALUES (1, 'numerário');
INSERT INTO `Metodo_Pagamento` (`id_metodo_pagamento`, `descricao`) VALUES (2, 'Cartão de débito');
INSERT INTO `Metodo_Pagamento` (`id_metodo_pagamento`, `descricao`) VALUES (3, 'Cartão de crédito');
INSERT INTO `Metodo_Pagamento` (`id_metodo_pagamento`, `descricao`) VALUES (4, 'Transferência bancária');

# Morada
INSERT INTO `Morada` (id_morada, linha_endereco1, linha_endereco2, codigo_postal, localidade) VALUES
(1,'Rua das bases de dados 8',NULL,'4700-217','Braga'),
(2,'Rua dos combatentes',NULL,'4700-089','Braga'),
(3,'Avenida Julio Pinheiro',NULL,'4720-458','Porto'),
(4,'Rua São José',NULL,'3597-452','Braga'),
(5,'R. da Nora',NULL,'4200-117','Vila Verde'),
(6,'R. do Monte',NULL,'4750-266','Fafe'),
(7,'Av. do Rio',NULL,'4706-278','Ponte de Lima'),
(8,'R. dos Sobreiros',NULL,'4714-002','Porto'),
(9,'Travessa campelos',NULL,'3696-287','Vila Verde'),
(10,'R. Campo Verde',NULL,'3568-985','Ponte de Lima'),
(11,'Rua das flores 9',NULL,'4700-217','Braga'),
(12,'Rua dos amigos',NULL,'4700-089','Braga'),
(13,'Avenida das árvores',NULL,'4720-458','Porto'),
(14,'Rua São Pedro',NULL,'3597-452','Braga'),
(15,'R. da Praia',NULL,'4200-117','Vila Verde'),
(16,'R. do Campo',NULL,'4750-266','Fafe'),
(17,'Av. das montanhas',NULL,'4706-278','Ponte de Lima'),
(18,'R. dos Jardins',NULL,'4714-002','Porto'),
(19,'Travessa das aves',NULL,'3696-287','Vila Verde'),
(20,'R. Campo Alegre',NULL,'3568-985','Ponte de Lima');

# Cliente
INSERT INTO `Cliente` (id_cliente, nome, nif, email, telemovel, data_nascimento, id_morada, id_tipo_cliente) VALUES
(1,'João Alves Labadie III','7','delmer.west@outlook.com','923743731','1994-08-08',1,1),
(2,'Isabel Silva','5','jake.kunze@icloud.com','964602791','1997-07-07',2,2),
(3,'Filipe Castro','3','thauck@gmail.pt','910930637','1987-12-21',3,1),
(4,'Pedro Ferreira','7','white.alva@gmail.com','927097227','1983-10-03',4,2),
(5,'Nelson Alves','6','bert.o\'connell@outlook.com','911581330','1990-03-31',5,1),
(6,'Bar ato','1','barato@gmail.pt','930366462','1994-10-28',6,2),
(7,'Isabel Lira','3','slangworth@gmail.pt','965205108','2000-11-30',7,1),
(8,'Restaurante come-se bem','4','ncole@hotmail.com','931765560','1973-06-16',8,2),
(9,'Joana Costa','8','joana.costa@gmail.com','912345678','1995-01-01',9,1),
(10,'Carlos Silva','7','carlos.silva@gmail.com','923456789','1992-02-02',10,2),
(11,'Ana Martins','5','ana.martins@gmail.com','912341234','1989-03-03',11,1),
(12,'Rui Santos','3','rui.santos@gmail.com','923451234','1986-04-04',12,2),
(13,'Sofia Oliveira','7','sofia.oliveira@gmail.com','912345678','1983-05-05',13,1),
(14,'Luis Fernandes','6','luis.fernandes@gmail.com','923456789','1980-06-06',14,2),
(15,'Maria Silva','3','maria.silva@gmail.com','912345678','1977-07-07',15,1),
(16,'Miguel Rodrigues','4','miguel.rodrigues@gmail.com','923456789','1974-08-08',16,2),
(17,'António Sousa','8','antonio.sousa@gmail.com','912345678','1971-09-09',17,1),
(18,'João Pinto','7','joao.pinto@gmail.com','923456789','1968-10-10',18,2),
(19,'Rita Silva','5','rita.silva@gmail.com','912345678','1965-11-11',19,1),
(20,'Manuela Rodrigues','3','manuela.rodrigues@gmail.com','923456789','1962-12-12',20,2);

# Armazem
INSERT INTO `Armazem` (id_armazem, nome, id_morada) VALUES (1,'Armazem1',9),(2,'Armazem2',10);

# Funcionario_Armazem
INSERT INTO `Funcionario_Armazem` (id_funcionario_armazem, nome, data_nascimento, nif, id_armazem) VALUES
(1, 'Filipe Gomes', '1985-11-08', '123456789', 1),
(2, 'Ricardo Magalhães', '1999-06-03', '287654321', 2),
(3, 'Catarina Vilaça', '1979-12-02', '112345678', 1),
(4, 'Luís Azevedo', '1999-07-18', '276543219', 2),
(5, 'Sofia Silva', '1989-01-01', '198765432', 1),
(6, 'Carlos Santos', '1992-02-02', '210123456', 2),
(7, 'Ana Martins', '1985-03-03', '254321098', 1),
(8, 'Rui Fernandes', '1999-04-04', '209876543', 2),
(9, 'Joana Oliveira', '1995-05-05', '321098765', 1),
(10, 'Luis Costa', '1989-06-06', '132109876', 2),
(11, 'Maria Silva', '1986-07-07', '243210187', 1),
(12, 'Miguel Rodrigues', '1999-08-08', '254321190', 2),
(13, 'António Sousa', '1991-09-09', '265432198', 1),
(14, 'João Pinto', '1988-10-10', '276543210', 2),
(15, 'Rita Silva', '1985-11-11', '287654321', 1),
(16, 'Manuela Rodrigues', '1992-12-12', '198765432', 2);

# Tipo_Veiculo
INSERT INTO `Tipo_Veiculo` (id_tipo_veiculo, nome) VALUES
(1,'Automóvel ligeiro'),
(2,'Motociclo'),
(3,'Veículo pesado');

# Veiculo
INSERT INTO `Veiculo` (id_veiculo, id_tipo_veiculo, quilometragem, combustivel) VALUES
(1,1,4534,'41'),
(2,2,584,'33'),
(3,3,5260,'20'),
(4,1,2041,'17'),
(5,1,1234,'41'),
(6,2,567,'33'),
(7,3,7890,'20'),
(8,1,3321,'17'),
(9,2,1234,'33');

# Estafeta
INSERT INTO `Estafeta` (id_estafeta, nome, nr_conducao, nif, data_nascimento, id_armazem, id_veiculo) VALUES
(1,'Andreia Silva','278783989','510175845','1998-05-26',1,1),
(2,'João Gomes','426839741','520823454','2001-03-26',2,2),
(3,'Joana Sá','263892482','272275672','1979-07-15',1,3),
(4,'André Monteiro','944195133','456860710','2003-04-18',2,4),
(5,'Maria João','457896234','123456789','1990-11-01',1,5),
(6,'Carlos Silva','987654321','234567890','1995-06-12',2,6),
(7,'Ana Santos','874653921','345678901','1988-09-22',1,7),
(8,'Rui Oliveira','763548219','456789021','1993-01-31',2,8),
(9,'Sofia Martins','654387210','567890234','1996-07-07',1,9);

# Estado
INSERT INTO `Estado` (id_estado, estado, descricao_estado) VALUES
(1,'Confirmada',' A encomenda foi confirmada pelo fornecedor'),
(2,'Recusada','A encomenda foi recusada pelo fornecedor'),
(3,'Cancelada','A encomenda foi cancelada pelo cliente'),
(4,'Expedida','A encomenda foi expedida pelo fornecedor'),
(5,'Recebida','A encomenda foi recebida pelo cliente');

# Encomenda
INSERT INTO `Encomenda` (id_encomenda, distancia, data_pedido, data_entrega, custo, id_metodo_pagamento, estado, id_cliente, id_funcionario_armazem, id_estafeta, id_armazem) VALUES
(1,7,'2021-12-20 13:45:44',NULL,0,1,1,1,1,1,1),
(2,12,'2022-08-04 12:04:36',NULL,0,3,2,2,2,2,2),
(3,13,'2022-03-17 08:59:24',NULL,0,2,3,3,3,3,1),
(4,16,'2022-02-01 06:48:53',NULL,0,1,4,4,4,4,2),
(5,23,'2022-01-20 03:20:05',NULL,0,3,1,5,1,1,1),
(6,24,'2022-01-05 06:28:57',NULL,0,3,2,6,2,2,2),
(7,42,'2022-10-16 20:05:54',NULL,0,2,3,7,3,3,1),
(8,32,'2022-05-09 01:46:06',NULL,0,1,4,8,4,4,2),
(9,43,'2022-01-12 08:12:21',NULL,0,2,1,1,1,1,1),
(10,41,'2022-03-09 15:15:31',NULL,0,3,2,2,2,2,2),
(11,5,'2022-04-18 13:02:14',NULL,0,1,3,3,3,3,1),
(12,23,'2022-06-26 10:36:50',NULL,0,3,4,4,4,4,2),
(13,16,'2022-11-11 21:41:40',NULL,0,2,1,5,1,1,1),
(14,41,'2022-05-24 00:06:15',NULL,0,2,2,6,2,2,2),
(15,25,'2022-07-15 03:57:39',NULL,0,3,3,7,3,3,1),
(16,50,'2022-09-20 12:30:00',NULL,0,1,4,9,5,1,1),
(17,15,'2022-10-01 06:00:00','2022-10-15 19:00:00',0,3,5,10,6,3,2),
(18,20,'2022-11-05 09:15:00',NULL,0,2,1,11,7,2,1),
(19,30,'2022-12-15 14:45:00',NULL,0,1,2,12,8,4,2),
(20,35,'2022-12-31 23:59:59',NULL,0,3,3,13,9,1,1),
(21,40,'2023-01-10 09:00:00',NULL,0,2,4,14,10,2,2),
(22,45,'2023-02-01 12:00:00','2023-02-17 13:00:00',0,1,5,15,11,3,1),
(23,50,'2023-03-15 15:00:00',NULL,0,3,1,16,12,4,2),
(24,55,'2023-04-01 18:00:00',NULL,0,2,2,17,13,1,1),
(25,60,'2023-05-05 21:00:00',NULL,0,1,3,18,14,2,2);

# Marca
INSERT INTO `Marca` (id_marca, nome, contacto) VALUES
(1,'Letra','253698254'),
(2,'Alma','915325996'),
(3,'Amphora','965355688'),
(4,'SuperBock', '234958376'),
(5, 'Sagres', '234958112');

# Categoria
INSERT INTO `Categoria` (id_categoria, nome, categoria_mae) VALUES
(1,'Cerveja',NULL),
(2,'Sidra',NULL),
(100, 'Ale', 1),
(200, 'Lager', 1),
(101, 'Barley wine', 100),
(102, 'Bitter', 100),
(103, 'Brown ale', 100),
(104, 'Blonde ale', 100),
(105, 'Red ale', 100),
(106, 'Mild ale', 100),
(107, 'Stout', 100),
(108, 'Scotch ale', 100),
(109, 'Porter', 100),
(110, 'India pale ale', 100),
(111, 'Trappist', 100),
(112, 'Tripel', 100),
(113, 'Burton', 100),
(114, 'Belgian Dark Strong Ale', 100),
(115, 'Special Ale', 100),
(201, 'Bock', 200),
(202, 'Dortmunder', 200),
(203, 'Ice beer', 200),
(204, 'Munchener', 200),
(205, 'Pilsner', 200),
(206, 'Vienna', 200),
(207, 'Marzen', 200),
(208, 'Rauchbie', 200),
(209, 'Pale lager', 200),
(300,'Maça',2),
(301,'Frutos Vermelhos',2);

# Item
INSERT INTO `Item` (id_item, item_descricao, nome, percentagem_alcool, preco, id_categoria, id_marca) VALUES
(1, 'A Letra A apresenta cor clara resultante dos maltes selecionados. O seu ligeiro amargor confere-lhe elevada frescura tornando-a uma cerveja de paladar suave e fácil de beber. Ingredientes: água, maltes de TRIGO e CEVADA, AVEIA, lúpulo e levedura. Conservar na verticar em local seco e fresco. Preço por Litro: 6,81€/L','Letra A',
 4.6,2.19,104,1),
(2, 'A Letra B é uma Lager de cor dourada e paladar que transita do doce ao amargo. O lúpulo Saaz, da região de Boémia (Rep. Checa), confere-lhe uma frescura aroma único. Ingredientes: água, malte de CEVADA, lúpulo e levedura. Conservar na vertical, em local seco e fresco. Preço por litro: 6,81€/L','Letra B',
 5,2.69,205,1),
(3, 'A Letra C apresenta uma espuma castanha e cremosa, com aromas e sabores a café, caramelo e chocolate negro, consequência da seleção cuidadosa dos maltes de cevada em equilibrado com a doçura da aveia. Ingredientes: água, malte de CEVADA e TRIGO, lúpulo e levedura. Conservar na vertical, em local seco e fresco. Preço por Litro:6,81€/L','Letra C',
 5.5,2.69,107,1),
(4, 'A Letra D apresenta uma cor avermelhada, com sabor e aroma caramelizado, em equilíbrio a frescura frutada do lúpulo Americano da variedade Cascade. Ingredientes: água, malte de CEVADA, lúpulo e levedura. Conservar na vertical, em local seco e fresco. Preço por Litro:6,81€/L','Letra D',
 6,2.69,105,1),
(5, 'A Letra E tem cor rubi escuro e com espuma cremosa devido aos maltes utilizados. É uma cerveja complexa de sabores, predominando o caramelo, especiarias e uvas passas. Ingredientes: água, malte de CEVADA e TRIGO, açucar, lúpulo e levedura. Conservar na vertical, em local seco e fresco. Preço por Litro: 7,42€/L','Letra E',
 9,2.99,114,1),
(6, 'A Letra F combina a doçura do malte com o amargor dos lúpulos Americanos Cascade, Citra e Mosaic adicionados ao longo do processo, resultando em sabores e aromas tropicais e cítricos. Ingredientes: água, malte de CEVADA e TRIGO, AVEIA, lúpulo e levedura. Conservar na vertical, em local seco e fresco. Não envelhecer. Preço por Litro:7,42€/L','Letra F',
 6.5,2.99,110,1),
(7, 'A Letra G é uma cerveja muito intensa e apresenta espuma cremosa, aroma e sabor a maltes torrados com notas de chocolate preto e café. Ingredientes: água, malte de CEVADA, AVEIA, lúpulo e levedura','Letra G',
 10.5,3.5,107,1),
(8, 'Super Bock Original é a única cerveja portuguesa com 37 medalhas de ouro consecutivas. Produzida a partir de ingredientes 100% naturais, é a cerveja autêntica de excelência para os teus momentos de convívio com os amigos.', 'SuperBock Original',
 5.2, 1.2, 209, 4),
(9, 'Uma surpreendente combinação de maltes especiais, que resulta numa cerveja preta única, com um aroma e um sabor distintos, coroada por uma espuma cremosa e duradoura.', 'SuperBock Stout',
 5.2, 1.2, 107, 4),
(10, 'Super Bock Original é a única cerveja portuguesa com 37 medalhas de ouro consecutivas. Produzida a partir de ingredientes 100% naturais, é a cerveja autêntica de excelência para os teus momentos de convívio com os amigos.', 'SuperBock Abadia',
 6.4, 2, 111, 4),
(11, 'Cerveja Pilsner levemente encorpada, com palato limpo e seco e carácter ligeiramente amargo, complementado com subtis notas aromáticas. A Sagres de sempre, produzida segundo métodos tradicionais, com ingredientes de origem natural: a partir de água, malte, cereais não-maltados e uma rigorosa seleção de lúpulos.','Sagres Original',
 5, 1.2, 205, 5),
(12, 'Cerveja Preta, de sabor intenso, com espuma densa cor de areia e inconfundíveis notas de malte torrado que lembram café, chocolate preto e pão torrado.', 'Sagres Preta',
 4.1, 1.3, 107, 5),
(13, 'Cerveja artesanal do estilo IPA em garrafa especial de 75cl. com vários tipos de lúpulos selecionados, grande intensidade aromática, com notas florais que traduzem o espírito da região Minhota. Cerveja encorpada, com uma textura macia, com um equilíbrio entre o amargor do lúpulo e o do malte, termina com um toque amargo, num final profundo e persistente. De tom alaranjado, carbonatação média e uma turbidez natural. India Pale Ale Inglesa.', 'Alma Minhota 75cl',
 6.5, 8.8, 110, 2),
(14, 'Cerveja artesanal especial, uma English Barleywine com estágio de 11 meses em pipas de Vinho do Porto. Coloração cobre muito escuro, com intensidade de nariz, onde se destaca o Vinho do Porto, ameixa, uva passa, caramelo e o malte. No paladar, tem um início doce, licoroso e uma complexidade onde predominam os frutos secos, vinho do Porto, madeira e a pujança do álcool. Pouca carbonatação e espuma. Corpo intenso e aveludado.', 'Alma D’ouro 33cl',
 12, 3.75, 101, 2),
(15, 'Uma Belgian Dark Strong Ale com a adição de castanhas de Trás dos Montes. Acompanha bem com comidas condimentadas e ricas, sobremesas de café e chocolate. Do tipo belga de abadia. Caraterizada pelo alto teor alcoólico, os sabores dos maltes e do caramelo e a maciez do corpo proporcionada pela castanha. Uma cerveja forte e de contrastes a lembrar as terras transmontanas, de coloração cobre escuro, aroma suave a frutos secos, biscoito e tostado. Paladar com ataque doce, encorpado, generoso/alcoólico , harmónico e no final de boca aparecem subtilmente as notas do caramelo, biscoito e um leve fumado das castanhas assadas. Sem dúvida uma referência a degustar, sempre com Alma.', 'Alma Transmontana 33cl',
 10, 2.59, 114, 2),
(16, 'Uma cerveja do estilo IPA, caracterizada pelo seu forte aroma e sabor, de características frutadas e florais. Amargor prolongado final, refrescante.', 'Amphora Gladiator 33cl',
 7, 2.49, 110, 3),
(17, 'Uma cerveja especial, que só sai em alguns anos. Fortemente alcoólica, com nuances de baunilha e madeira o digestivo perfeito para aquelas noites. Premiada com medalha de Prata no Concours International de Lyon.', 'Amphora Nemesis 33cl',
 13, 3.69, 115, 3),
(18, 'Sabores torrados intensos com notas de café e chocolate. Aromas frutados e corpo intenso. Premiada com medalha de Ouro no Ibeerian Awards 2019.', 'Amphora Centurium 33cl',
10, 2.49, 107, 3);


# Encomenda_Item
INSERT INTO `Encomenda_Item` (id_ecomenda, id_item, quantidade) VALUES
(1,1,7),
(1,7,4),
(1,2,2),
(2,2,5),
(3,3,6),
(3,4,7),
(4,4,2),
(5,5,5),
(6,6,8),
(7,7,1),
(8,1,7),
(9,2,9),
(10,3,3),
(11,4,7),
(12,5,7),
(13,6,10),
(14,7,6),
(15,1,5),
(16,8,3),
(17,9,5),
(18,10,2),
(19,11,3),
(20,12,4),
(21,13,2),
(22,14,6),
(23,15,5),
(24,16,7),
(25,17,3),
(1,18,2),
(2,8,4),
(3,9,3),
(4,10,2),
(5,11,6),
(6,12,5),
(7,13,7),
(8,14,3),
(9,15,2),
(10,16,6),
(11,17,4),
(12,18,3),
(13,8,2);

# Item_Armazem
INSERT INTO `Item_Armazem` (id_item, id_armazem, stock) VALUES
(1,1,37),
(1,2,45),
(2,1,35),
(2,2,18),
(3,1,26),
(3,2,1),
(4,1,25),
(4,2,5),
(5,1,50),
(5,2,8),
(6,2,49),
(7,1,22),
(8,1,10),
(8,2,5),
(9,1,15),
(9,2,20),
(10,1,5),
(10,2,15),
(11,1,20),
(11,2,10),
(12,1,5),
(12,2,5),
(13,1,10),
(13,2,15),
(14,1,15),
(14,2,10),
(15,1,5),
(15,2,5),
(16,1,10),
(16,2,15),
(17,1,15),
(17,2,10),
(18,1,5),
(18,2,5);