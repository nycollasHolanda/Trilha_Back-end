USE crm_vinis;

-- Comandos pra visualizar as tabelas e pra visualizar a tabela Produtos
SHOW TABLES;
DESCRIBE produtos;

-- Comandos pra inserir dados em cada uma das tabelas
INSERT INTO usuarios (nome, email, senha, tipo_perfil) VALUES
('Nycollas Holanda', 'nycollas@crm.com', 'hash_senha_123', 'DONO'),
('Carlos Silva', 'carlos.cliente@email.com', 'hash_senha_456', 'CLIENTE'),
('Jussara Cardoso', 'jussara.vendedor@email.com', 'hash_senha_964', 'VENDEDOR'),
('Mariana Souza', 'mariana.cliente@email.com', 'hash_senha_789', 'CLIENTE');

INSERT INTO categorias (nome) VALUES
('Rock'),
('Metal'),
('Jazz');

INSERT INTO produtos (categoria_id, nome, preco_venda, quantidade_estoque) VALUES
(1, 'Disco LP Cartola', 249.90, 20),
(2, 'Iron Maiden - Bury The Hatchet', 310.10, 35),
(3, 'Edição Especial: Michael Jackson - Thriller', 600.00, 50);

INSERT INTO vendas (usuario_id, valor_total) VALUES
(2, 219.80);

INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 129.90),
(1, 2, 1, 89.90);

SELECT * FROM usuarios;
SELECT * FROM categorias;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM itens_venda;
