CREATE DATABASE IF NOT EXISTS crm_suplementos
DEFAULT CHARACTER SET utf8mb4
DEFAULT COLLATE utf8mb4_unicode_ci;

USE crm_suplementos;

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE, 
    senha VARCHAR(255) NOT NULL,
    tipo_perfil ENUM('DONO', 'VENDEDOR', 'CLIENTE') NOT NULL DEFAULT 'CLIENTE'
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(80) NOT NULL UNIQUE
);

CREATE TABLE produtos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    categoria_id INT NOT NULL,
    nome VARCHAR(120) NOT NULL,
    preco_venda DECIMAL(10, 2) NOT NULL,
    quantidade_estoque INT NOT NULL DEFAULT 0,

    CONSTRAINT chk_preco_positivo CHECK (preco_venda >= 0),
    CONSTRAINT chk_estoque_positivo CHECK (quantidade_estoque >= 0),

    CONSTRAINT fk_produto_categoria
        FOREIGN KEY (categoria_id) REFERENCES categorias(id)
        ON DELETE RESTRICT
);

CREATE TABLE vendas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    data_venda DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    valor_total DECIMAL(10, 2) NOT NULL DEFAULT 0.00,
    
    CONSTRAINT fk_venda_usuario 
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id)
        ON DELETE RESTRICT
);

CREATE TABLE itens_venda (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venda_id INT NOT NULL,
    produto_id INT NOT NULL,
    quantidade INT NOT NULL,
    preco_unitario DECIMAL(10, 2) NOT NULL,
    
    CONSTRAINT chk_qtd_positiva CHECK (quantidade > 0),
    
    CONSTRAINT fk_item_venda 
        FOREIGN KEY (venda_id) REFERENCES vendas(id)
        ON DELETE CASCADE,
        
    CONSTRAINT fk_item_produto 
        FOREIGN KEY (produto_id) REFERENCES produtos(id)
        ON DELETE RESTRICT
);