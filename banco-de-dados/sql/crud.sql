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
(1, 1, 1, 249.90),
(1, 2, 3, 310.10);

SELECT * FROM usuarios;
SELECT * FROM categorias;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM itens_venda;

-- Simulando a baixa e almento no estoque após a venda 1 (tirou 1 Disco LP Cartola e 3 Discos do Iron Maiden)
UPDATE produtos SET quantidade_estoque = quantidade_estoque - 1 WHERE id = 1;
UPDATE produtos SET quantidade_estoque = quantidade_estoque - 3 WHERE id = 2;

-- Simulando Reposição de estoque após venda 
UPDATE produtos SET quantidade_estoque = quantidade_estoque + 10 WHERE id = 2;

-- Conferindo o estoque atualizado
SELECT id, nome, quantidade_estoque FROM produtos;

-- Consulta 01: Listar produtos mostrando o nome da Categoria (INNER JOIN)
SELECT 
    p.id,
    p.nome AS produto,
    c.nome AS categoria,
    p.preco_venda,
    p.quantidade_estoque
FROM produtos p
INNER JOIN categorias c ON p.categoria_id = c.id;

-- Consulta 02: Detalhar os itens de uma venda com nome do cliente e do produto
SELECT 
    v.id AS numero_venda,
    u.nome AS cliente,
    v.data_venda,
    p.nome AS produto,
    iv.quantidade,
    iv.preco_unitario,
    (iv.quantidade * iv.preco_unitario) AS subtotal
FROM itens_venda iv
INNER JOIN vendas v ON iv.venda_id = v.id
INNER JOIN usuarios u ON v.usuario_id = u.id
INNER JOIN produtos p ON iv.produto_id = p.id;

-- Consulta 03: Faturamento total agrupado por cliente (GROUP BY + SUM)
SELECT 
    u.nome AS cliente,
    COUNT(v.id) AS total_pedidos,
    SUM(v.valor_total) AS total_gasto
FROM usuarios u
INNER JOIN vendas v ON u.id = v.usuario_id
GROUP BY u.id, u.nome;

-- Teste de usando comandos DELETE:

-- TESTE A (Deve dar ERRO proposital):
-- Tentar apagar o cliente Carlos (id = 2) que já possui uma venda registrada.
-- O MySQL vai bloquear com erro de Foreign Key (Cannot delete or update a parent row).
DELETE FROM usuarios WHERE id = 2;

-- TESTE B (Deve FUNCIONAR):
-- Apagar a cliente Jussara Cardoso (id = 3) que ainda não fez nenhuma compra.
DELETE FROM usuarios WHERE id = 3;