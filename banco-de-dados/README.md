# Projeto de Banco de Dados — CRM Loja de Discos de Vinil

Modelagem e implementação de um banco de dados relacional em **MySQL** para gerenciamento de clientes, catálogo de discos, controle de estoque e registro de vendas.

## Objetivo e Contexto
Este projeto representa a base de dados de um sistema de CRM desenvolvido ao longo da trilha de Back-end (que evoluirá para aplicações em Python, Django e Django REST Framework). O foco desta etapa foi aplicar os conceitos de modelagem desde o nível conceitual até a execução física com validação de restrições.

## Etapas de Modelagem

1. **Modelo Conceitual (DER):** Identificação das entidades principais (`Usuários`, `Categorias`, `Produtos`, `Vendas`), seus atributos, cardinalidades e uso de **Entidade Associativa** (`Contém`) para representar os itens de cada pedido.
2. **Modelo Lógico (Relacional):** Conversão das entidades em tabelas normalizadas até a **3ª Forma Normal (3FN)**, definindo Chaves Primárias (`PK`), Chaves Estrangeiras (`FK`) e tipagem dos dados.
3. **Modelo Físico (SQL):** Implementação das estruturas e regras de integridade no MySQL.

### Estrutura das Tabelas
- **`usuarios`**: Armazena clientes, vendedores e o proprietário (`DONO`, `VENDEDOR`, `CLIENTE`), preparando o controle de acesso da aplicação.
- **`categorias`**: Classifica os discos por gênero musical (`MPB / Samba`, `Heavy Metal`, `Pop / Soul`).
- **`produtos`**: Catálogo de discos contendo nome, descrição detalhada, preço de venda e saldo em estoque (protegido por constraints `CHECK`).
- **`vendas`**: Registra os pedidos vinculados a um usuário e o valor total da operação.
- **`itens_venda`**: Tabela associativa que resolve o relacionamento `N:N` entre `vendas` e `produtos`, armazenando a quantidade vendida e o preço unitário praticado no momento da compra.

## Organização dos Arquivos
- `schema.sql`: Comandos DDL para criação do banco `crm_vinis`, tabelas e constraints (`PRIMARY KEY`, `FOREIGN KEY`, `UNIQUE`, `CHECK`, `RESTRICT`, `CASCADE`).
- `crud.sql`: Comandos DML e DQL para carga inicial de dados (`INSERT`), movimentação de estoque (`UPDATE`), relatórios com `INNER JOIN` e agregações (`GROUP BY`, `SUM`, `COUNT`), além de testes de bloqueio de exclusão (`DELETE`).

## Como Executar
1. Abra o **MySQL Workbench** (ou outro SGBD compatível com MySQL 8.0+).
2. Execute o arquivo `schema.sql` para criar o banco de dados e toda a estrutura de tabelas.
3. Execute o arquivo `crud.sql` para inserir os registros de exemplo e rodar as consultas e testes de integridade.