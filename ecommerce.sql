CREATE TABLE IF NOT EXISTS `cliente` (
	`cliente_id` int AUTO_INCREMENT NOT NULL,
	`email` varchar(255) NOT NULL UNIQUE,
	`telefone` varchar(20) NOT NULL,
	`data_cadastro` datetime NOT NULL DEFAULT 'current_timestamp',
	PRIMARY KEY (`cliente_id`)
);

CREATE TABLE IF NOT EXISTS `clientepf` (
	`cliente_id` int NOT NULL,
	`nome` varchar(255) NOT NULL,
	`cpf` char(11) NOT NULL UNIQUE,
	`data_nascimento` date NOT NULL,
	PRIMARY KEY (`cliente_id`)
);

CREATE TABLE IF NOT EXISTS `clientepj` (
	`cliente_id` int NOT NULL,
	`razao_social` varchar(255) NOT NULL,
	`cnpj` char(14) NOT NULL UNIQUE,
	`inscricao_estadual` varchar(20) NOT NULL,
	PRIMARY KEY (`cliente_id`)
);

CREATE TABLE IF NOT EXISTS `fornecedor` (
	`fornecedor_id` int AUTO_INCREMENT NOT NULL,
	`nome` varchar(255) NOT NULL,
	`contato` varchar(255) NOT NULL,
	PRIMARY KEY (`fornecedor_id`)
);

CREATE TABLE IF NOT EXISTS `produto` (
	`produto_id` int AUTO_INCREMENT NOT NULL,
	`fornecedor_id` int NOT NULL,
	`sku` varchar(50) NOT NULL UNIQUE,
	`nome` varchar(255) NOT NULL,
	`descricao` text NOT NULL,
	`preco` decimal(10,2) NOT NULL,
	`peso` decimal(8) NOT NULL,
	PRIMARY KEY (`produto_id`)
);

CREATE TABLE IF NOT EXISTS `deposito` (
	`deposito_id` int AUTO_INCREMENT NOT NULL,
	`nome` varchar(100) NOT NULL,
	PRIMARY KEY (`deposito_id`)
);

CREATE TABLE IF NOT EXISTS `estoque` (
	`produto_id` int NOT NULL,
	`deposito_id` int NOT NULL,
	`quantidade` int NOT NULL DEFAULT '0',
	`data_ultima_atualizacao` datetime NOT NULL DEFAULT 'current_timestamp',
	PRIMARY KEY (`produto_id`)
);

CREATE TABLE IF NOT EXISTS `vendedor` (
	`vendedor_id` int AUTO_INCREMENT NOT NULL,
	`nome` varchar(255) NOT NULL,
	`contato` varchar(255) NOT NULL,
	PRIMARY KEY (`vendedor_id`)
);

CREATE TABLE IF NOT EXISTS `pagamento` (
	`pagamento_id` int AUTO_INCREMENT NOT NULL,
	`cliente_id` int NOT NULL,
	`tipo_pagamento` varchar(50) NOT NULL,
	`dados_pagamento` text NOT NULL,
	PRIMARY KEY (`pagamento_id`)
);

CREATE TABLE IF NOT EXISTS `pedido` (
	`pedido_id` int AUTO_INCREMENT NOT NULL,
	`cliente_id` int NOT NULL,
	`vendedor_id` int NOT NULL,
	`pagamento_id` int NOT NULL,
	`data_pedido` datetime NOT NULL,
	`valor_total` decimal(12,2) NOT NULL,
	PRIMARY KEY (`pedido_id`)
);

CREATE TABLE IF NOT EXISTS `pedidoproduto` (
	`pedido_id` int NOT NULL,
	`produto_id` int NOT NULL,
	`deposito_id` int NOT NULL,
	`quantidade` int NOT NULL,
	`preco_unitario` decimal(10,2) NOT NULL,
	`desconto` decimal(10,2) NOT NULL,
	PRIMARY KEY (`pedido_id`, `produto_id`)
);

CREATE TABLE IF NOT EXISTS `entrega` (
	`entrega_id` int AUTO_INCREMENT NOT NULL,
	`pedido_id` int NOT NULL UNIQUE,
	`transportadora` varchar(100) NOT NULL,
	`status` varchar(50) NOT NULL,
	`codigo_rastreio` varchar(100) NOT NULL,
	`data_envio` datetime NOT NULL,
	`data_entrega` datetime NOT NULL,
	PRIMARY KEY (`entrega_id`)
);


ALTER TABLE `clientepf` ADD CONSTRAINT `clientepf_fk0` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`cliente_id`);
ALTER TABLE `clientepj` ADD CONSTRAINT `clientepj_fk0` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`cliente_id`);

ALTER TABLE `produto` ADD CONSTRAINT `produto_fk1` FOREIGN KEY (`fornecedor_id`) REFERENCES `fornecedor`(`fornecedor_id`);

ALTER TABLE `estoque` ADD CONSTRAINT `estoque_fk0` FOREIGN KEY (`produto_id`) REFERENCES `produto`(`produto_id`);

ALTER TABLE `estoque` ADD CONSTRAINT `estoque_fk1` FOREIGN KEY (`deposito_id`) REFERENCES `deposito`(`deposito_id`);

ALTER TABLE `pagamento` ADD CONSTRAINT `pagamento_fk1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`cliente_id`);
ALTER TABLE `pedido` ADD CONSTRAINT `pedido_fk1` FOREIGN KEY (`cliente_id`) REFERENCES `cliente`(`cliente_id`);

ALTER TABLE `pedido` ADD CONSTRAINT `pedido_fk2` FOREIGN KEY (`vendedor_id`) REFERENCES `vendedor`(`vendedor_id`);
ALTER TABLE `pedidoproduto` ADD CONSTRAINT `pedidoproduto_fk0` FOREIGN KEY (`pedido_id`) REFERENCES `pedido`(`pedido_id`);

ALTER TABLE `pedidoproduto` ADD CONSTRAINT `pedidoproduto_fk1` FOREIGN KEY (`produto_id`) REFERENCES `produto`(`produto_id`);

ALTER TABLE `pedidoproduto` ADD CONSTRAINT `pedidoproduto_fk2` FOREIGN KEY (`deposito_id`) REFERENCES `deposito`(`deposito_id`);
ALTER TABLE `entrega` ADD CONSTRAINT `entrega_fk1` FOREIGN KEY (`pedido_id`) REFERENCES `pedido`(`pedido_id`);