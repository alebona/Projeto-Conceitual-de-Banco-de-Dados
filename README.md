# 🛒 Banco de Dados Conceitual - E-commerce

Este projeto implementa um **modelo conceitual e relacional** de um sistema de e-commerce, contemplando clientes (PF e PJ), pedidos, produtos, estoque, fornecedores, vendedores, pagamentos e entregas.  
O objetivo é servir como base para estudos, modelagem de sistemas e implantação em SGBDs como MySQL/MariaDB.

---

## 📌 Objetivos do Projeto

- Criar um **DER (Diagrama Entidade-Relacionamento)** para um sistema de e-commerce.
- Garantir **integridade referencial** entre as tabelas.
- Permitir consultas eficientes para gestão de pedidos, produtos e estoque.
- Modelar de forma flexível para suportar diferentes tipos de clientes, formas de pagamento e múltiplos depósitos.

---

## 🗂 Estrutura do Banco de Dados

O banco é composto por **13 tabelas** principais, conforme descrito abaixo.

### 1. **cliente**
Armazena dados comuns de clientes, sejam eles **Pessoa Física (PF)** ou **Pessoa Jurídica (PJ)**.
- `cliente_id` (PK)
- `email`
- `telefone`
- `tipo_cliente` (`PF` ou `PJ`)
- `data_cadastro`
- `status` (`Ativo` ou `Inativo`)

### 2. **clientepf**
Dados específicos de pessoa física.
- `cliente_id` (PK e FK → cliente)
- `nome`
- `cpf`
- `data_nascimento`

### 3. **clientepj**
Dados específicos de pessoa jurídica.
- `cliente_id` (PK e FK → cliente)
- `razao_social`
- `cnpj`
- `inscricao_estadual`

### 4. **fornecedor**
Cadastro de fornecedores de produtos.
- `fornecedor_id` (PK)
- `nome`
- `contato`

### 5. **produto**
Lista de produtos disponíveis para venda.
- `produto_id` (PK)
- `fornecedor_id` (FK → fornecedor)
- `sku` (código único)
- `nome`
- `descricao`
- `preco`
- `peso`

### 6. **deposito**
Localização física de estoque.
- `deposito_id` (PK)
- `nome`

### 7. **estoque**
Controle da quantidade disponível por produto em cada depósito.
- `produto_id` (PK e FK → produto)
- `deposito_id` (FK → deposito)
- `quantidade`
- `data_ultima_atualizacao`

### 8. **vendedor**
Cadastro de vendedores responsáveis pelos pedidos.
- `vendedor_id` (PK)
- `nome`
- `contato`

### 9. **pagamento**
Formas de pagamento cadastradas para clientes.
- `pagamento_id` (PK)
- `cliente_id` (FK → cliente)
- `tipo_pagamento` (ex: cartão, PIX, boleto)
- `dados_pagamento`
- `status_pagamento` (`Aprovado`, `Pendente`, `Cancelado`)

### 10. **pedido**
Registro dos pedidos realizados.
- `pedido_id` (PK)
- `cliente_id` (FK → cliente)
- `vendedor_id` (FK → vendedor)
- `pagamento_id` (FK → pagamento)
- `data_pedido`
- `valor_total`
- `status_pedido` (`Novo`, `Processando`, `Enviado`, `Entregue`, `Cancelado`)

### 11. **pedidoproduto**
Relação N:N entre pedidos e produtos.
- `pedido_id` (FK → pedido)
- `produto_id` (FK → produto)
- `deposito_id` (FK → deposito)
- `quantidade`
- `preco_unitario`

### 12. **entrega**
Informações sobre o envio do pedido.
- `entrega_id` (PK)
- `pedido_id` (FK → pedido)
- `transportadora`
- `status`
- `codigo_rastreio`
- `data_envio`
- `data_entrega`

---

## 🔗 Relacionamentos Principais

- **Cliente** 1:1 **ClientePF** ou **ClientePJ**
- **Cliente** 1:N **Pagamento**
- **Cliente** 1:N **Pedido**
- **Fornecedor** 1:N **Produto**
- **Produto** 1:1 **Estoque**
- **Produto** N:N **Pedido** (via `pedidoproduto`)
- **Pedido** 1:1 **Entrega**
- **Pedido** 1:N **PedidoProduto**
- **Vendedor** 1:N **Pedido**
- **Depósito** 1:N **Estoque** e **PedidoProduto**

---

## ⚖️ Regras de Negócio

1. Um cliente **não pode** ser PF e PJ ao mesmo tempo.
2. Cada cliente pode ter **várias formas de pagamento** cadastradas.
3. Um pedido deve ter **apenas uma forma de pagamento** associada.
4. Estoque é controlado **por depósito**.
5. A entrega está **diretamente vinculada** a um único pedido.

---

## 🚀 Como Utilizar

1. **Importar no DBDesigner**
   - Acesse [https://erd.dbdesigner.net/](https://erd.dbdesigner.net/)
   - Crie um novo projeto
   - Vá em **File > Import SQL**
   - Cole o conteúdo do arquivo `.sql`

2. **Instalar em um SGBD**
   ```bash
   mysql -u usuario -p banco_de_dados < ecommerce.sql
