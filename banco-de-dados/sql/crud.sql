USE crm_vinis;

-- Visualizando a estrutura das tabelas criadas
SHOW TABLES;
DESCRIBE produtos;

-- Inserindo usuários
INSERT INTO usuarios (nome, email, senha, tipo_perfil) VALUES
('Nycollas Holanda', 'nycollas@crm.com', 'hash_senha_123', 'DONO'),
('Carlos Silva', 'carlos.cliente@email.com', 'hash_senha_456', 'CLIENTE'),
('Jussara Cardoso', 'jussara.vendedor@email.com', 'hash_senha_964', 'VENDEDOR'),
('Mariana Souza', 'mariana.cliente@email.com', 'hash_senha_789', 'CLIENTE');

-- Inserindo categorias musicais
INSERT INTO categorias (nome) VALUES
('MPB / Samba'),
('Heavy Metal'),
('Pop / Soul');

-- Inserindo discos no catálogo com descrição
INSERT INTO produtos (categoria_id, nome, descricao, preco_venda, quantidade_estoque) VALUES
(1, 'Disco LP Cartola (1976)', 'Edição remasterizada em vinil 180g. Clássico da MPB com As Rosas Não Falam.', 249.90, 20),
(2, 'Iron Maiden - Piece of Mind', 'Vinil duplo importado, capa gatefold original com encarte.', 310.10, 35),
(3, 'Michael Jackson - Thriller (Edição Especial)', 'Edição comemorativa picture disc com faixas bônus.', 600.00, 50);

-- Registrando uma venda para o cliente Carlos (id = 2) -> Total: 249.90 + (3 * 310.10) = 1180.20
INSERT INTO vendas (usuario_id, valor_total) VALUES
(2, 1180.20);

-- Registrando os itens da venda 1
INSERT INTO itens_venda (venda_id, produto_id, quantidade, preco_unitario) VALUES
(1, 1, 1, 249.90),
(1, 2, 3, 310.10);

-- Conferindo os registros inseridos
SELECT * FROM usuarios;
SELECT * FROM categorias;
SELECT * FROM produtos;
SELECT * FROM vendas;
SELECT * FROM itens_venda;

-- Simulando a baixa no estoque após a venda 1 (1 LP Cartola e 3 LPs Iron Maiden)
UPDATE produtos SET quantidade_estoque = quantidade_estoque - 1 WHERE id = 1;
UPDATE produtos SET quantidade_estoque = quantidade_estoque - 3 WHERE id = 2;

-- Simulando reposição de estoque após chegada de novo lote
UPDATE produtos SET quantidade_estoque = quantidade_estoque + 10 WHERE id = 2;

-- Conferindo o estoque atualizado
SELECT id, nome, quantidade_estoque FROM produtos;

-- Consulta 01: Listar produtos mostrando o nome da Categoria (INNER JOIN)
SELECT 
    p.id,
    p.nome AS produto,
    p.descricao,
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

-- Testes de exclusão (DELETE) e integridade referencial:

-- TESTE A (Bloqueio proposital por Foreign Key):
-- Tentar apagar o cliente Carlos (id = 2) que possui venda vinculada.
DELETE FROM usuarios WHERE id = 2;

-- TESTE B (Exclusão permitida):
-- Apagar a usuária Jussara Cardoso (id = 3) que não possui registros dependentes.
DELETE FROM usuarios WHERE id = 3;