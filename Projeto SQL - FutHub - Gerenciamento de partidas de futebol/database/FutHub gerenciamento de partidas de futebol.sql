SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS `A3_10OU2` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
USE `A3_10OU2`;

-- -----------------------------------------------------
-- ESTRUTURA DAS TABELAS (DDL)
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `GatewayPagamento` (
  `id_gateway` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_gateway`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Usuario` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(80) NOT NULL,
  `email` VARCHAR(90) NOT NULL,
  `telefone` VARCHAR(20) NULL DEFAULT NULL,
  `dataNasc` DATE NOT NULL,
  `senha_hash` VARCHAR(65) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email` (`email` ASC) VISIBLE
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Jogador` (
  `id_jogador` INT NOT NULL AUTO_INCREMENT,
  `notaMedia` DECIMAL(3,1) NOT NULL,
  `posicao` VARCHAR(45) NULL DEFAULT NULL,
  `apelido` VARCHAR(70) NULL DEFAULT NULL,
  `id_usuario` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_jogador`),
  INDEX `fk_jogador_usuario` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_jogador_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `Usuario` (`id_usuario`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `StatusPartida` (
  `id_status` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_status`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `TipoSolo` (
  `id_tipoSolo` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_tipoSolo`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Partida` (
  `id_partida` INT NOT NULL AUTO_INCREMENT,
  `dataHora` DATETIME NOT NULL,
  `endereco` VARCHAR(120) NULL DEFAULT NULL,
  `valorPorJogador` DECIMAL(5,2) NULL DEFAULT NULL,
  `limiteJogadores` INT NULL DEFAULT NULL,
  `id_organizador` INT NOT NULL,
  `StatusPartida_id_status` INT NOT NULL,
  `TipoSolo_id_tipoSolo` INT NOT NULL,
  PRIMARY KEY (`id_partida`),
  INDEX `fk_partida_usuario` (`id_organizador` ASC) VISIBLE,
  INDEX `fk_partida_statusPartida` (`StatusPartida_id_status` ASC) VISIBLE,
  INDEX `fk_partida_tipoSolo` (`TipoSolo_id_tipoSolo` ASC) VISIBLE,
  CONSTRAINT `fk_partida_statusPartida`
    FOREIGN KEY (`StatusPartida_id_status`)
    REFERENCES `StatusPartida` (`id_status`),
  CONSTRAINT `fk_partida_tipoSolo`
    FOREIGN KEY (`TipoSolo_id_tipoSolo`)
    REFERENCES `TipoSolo` (`id_tipoSolo`),
  CONSTRAINT `fk_partida_usuario`
    FOREIGN KEY (`id_organizador`)
    REFERENCES `Usuario` (`id_usuario`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Joga_em` (
  `Jogador_id_jogador` INT NOT NULL,
  `Partida_id_partida` INT NOT NULL,
  `presenca` TINYINT NOT NULL,
  `gols` INT NULL DEFAULT NULL,
  `assistencias` INT NULL DEFAULT NULL,
  `cartaoAmarelo` INT NULL DEFAULT NULL,
  `cartaoVermelho` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Jogador_id_jogador`, `Partida_id_partida`),
  INDEX `fk_jogaem_partida` (`Partida_id_partida` ASC) VISIBLE,
  CONSTRAINT `fk_jogaem_jogador`
    FOREIGN KEY (`Jogador_id_jogador`)
    REFERENCES `Jogador` (`id_jogador`),
  CONSTRAINT `fk_jogaem_partida`
    FOREIGN KEY (`Partida_id_partida`)
    REFERENCES `Partida` (`id_partida`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `MetodoPagamento` (
  `id_metodoPagamento` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `GatewayPagamento_id_Gateway` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_metodoPagamento`),
  INDEX `fk_metodoPagamento_gatewayPagamento` (`GatewayPagamento_id_Gateway` ASC) VISIBLE,
  CONSTRAINT `fk_metodoPagamento_gatewayPagamento`
    FOREIGN KEY (`GatewayPagamento_id_Gateway`)
    REFERENCES `GatewayPagamento` (`id_gateway`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `Pagamento` (
  `id_pagamento` INT NOT NULL AUTO_INCREMENT,
  `valor` DECIMAL(6,2) NOT NULL,
  `dataHora` DATETIME NOT NULL,
  `Usuario_id_usuario` INT NULL DEFAULT NULL,
  `Partida_id_partida` INT NULL DEFAULT NULL,
  `MetodoPagamento_id_MetodoPagamento` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_pagamento`),
  INDEX `fk_pagamento_usuario` (`Usuario_id_usuario` ASC) VISIBLE,
  INDEX `fk_pagamento_partida` (`Partida_id_partida` ASC) VISIBLE,
  INDEX `fk_pagamento_metodoPagamento` (`MetodoPagamento_id_MetodoPagamento` ASC) VISIBLE,
  CONSTRAINT `fk_pagamento_metodoPagamento`
    FOREIGN KEY (`MetodoPagamento_id_MetodoPagamento`)
    REFERENCES `MetodoPagamento` (`id_metodoPagamento`),
  CONSTRAINT `fk_pagamento_partida`
    FOREIGN KEY (`Partida_id_partida`)
    REFERENCES `Partida` (`id_partida`),
  CONSTRAINT `fk_pagamento_usuario`
    FOREIGN KEY (`Usuario_id_usuario`)
    REFERENCES `Usuario` (`id_usuario`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

CREATE TABLE IF NOT EXISTS `StatusPagamento` (
  `id_statusPagamento` INT NOT NULL,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `Pagamento_id_pagamento` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id_statusPagamento`),
  INDEX `fk_statusPagamento_pagamento` (`Pagamento_id_pagamento` ASC) VISIBLE,
  CONSTRAINT `fk_statusPagamento_pagamento`
    FOREIGN KEY (`Pagamento_id_pagamento`)
    REFERENCES `Pagamento` (`id_pagamento`)
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4;

-- -----------------------------------------------------
-- INSERÇÃO DE DADOS
-- -----------------------------------------------------
INSERT INTO Usuario (nome, email, telefone, dataNasc, senha_hash) VALUES 
('Dalila Soares', 'dalila@email.com', '71666666666', '1995-12-19', SHA2('adf567', 256)),
('Jessica Silva', 'jessica@email.com', '7177777777', '1998-03-16', SHA2('adf567', 256)),
('Marcio Duarte', 'marcio@email.com', '71555555555', '1973-09-09', SHA2('adf567', 256));

INSERT INTO Jogador (id_jogador, notaMedia, posicao, apelido, id_usuario) VALUES 
(1, 3.5, 'fixo', 'moqueca', 1),
(2, 4.5, 'ala', 'cleiton', 2),
(3, 4.2, 'ala', 'bruxona', 3),
(4, 4.0, 'goleiro', 'paredão', 2),
(5, 3.1, 'pivo', 'kinho', 1);

INSERT INTO StatusPartida (id_status, nome) VALUES 
(1, 'Confirmada'),
(2, 'Em andamento'),
(3, 'Cancelada'),
(4, 'Finalizada');

INSERT INTO TipoSolo (id_tipoSolo, nome) VALUES 
(1, 'Society'),
(2, 'Salão'),
(3, 'Grama'),
(4, 'Areia'),
(5, 'Terra'),
(6, 'Rua');

INSERT INTO Partida (dataHora, endereco, valorPorJogador, limiteJogadores, id_organizador, StatusPartida_id_status, TipoSolo_id_tipoSolo) VALUES 
('2025-06-12 14:30:00', 'Silveira Martins 65- Cabula', 5.0, 15, 3, 1, 3),
('2025-05-04 18:00:00', 'Bernadete dias 525- Boca do rio', 0.0, 10, 1, 2, 6),
('2025-03-06 08:30:00', 'rua das flores 91-Concreto', 10.0, 15, 1, 4, 4),
('2025-05-15 19:30:00', 'Silveira Martins 65- Cabula', 10.0, 20, 3, 2, 3);

INSERT INTO Joga_em (Jogador_id_jogador, Partida_id_partida, presenca, gols, assistencias, cartaoAmarelo, cartaoVermelho) VALUES 
(1, 2, 1, 2, 0, 1, 0),
(2, 2, 1, 0, 1, 2, 1),
(3, 4, 0, 0, 0, 0, 0),
(4, 1, 1, 5, 0, 1, 0),
(5, 3, 1, 0, 2, 0, 0);

INSERT INTO GatewayPagamento (id_gateway, nome) VALUES 
(1, 'PayPal'), 
(2, 'Mercado Pago');

INSERT INTO MetodoPagamento (id_metodoPagamento, nome, GatewayPagamento_id_Gateway) VALUES 
(1, 'Crédito', 1), 
(2, 'Pix', 2),
(3, 'Débito', 1),
(4, 'Pix', 1);

INSERT INTO Pagamento (valor, dataHora, Usuario_id_usuario, Partida_id_partida, MetodoPagamento_id_MetodoPagamento) VALUES 
(10.0, '2025-03-05 13:00:00', 3, 3, 2), 
(5.0, '2025-06-12 13:00:00', 2, 1, 4),
(10.0, '2025-05-13 18:45:00', 3, 4, 1);

INSERT INTO StatusPagamento (id_statusPagamento, nome, Pagamento_id_pagamento) VALUES 
(1, 'Efetuado', 1),
(2, 'Pendente', 2),
(3, 'Recusado', 3);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;