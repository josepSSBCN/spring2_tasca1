-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema S201N1E2_PIZZERIA
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema S201N1E2_PIZZERIA
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `S201N1E2_PIZZERIA` DEFAULT CHARACTER SET utf8 ;
USE `S201N1E2_PIZZERIA` ;

-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`provincia`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`provincia` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`provincia` (
  `Id_provincia` TINYINT(2) UNSIGNED NOT NULL,
  `nom_provincia` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`localitat`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`localitat` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`localitat` (
  `Id_localitat` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Suposo que la pizzeria està Espanya, a Espanya no arriben a 9.000 polbacions',
  `id_provincia_localitat` TINYINT(2) UNSIGNED NOT NULL,
  `nom_localitat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_localitat`),
  UNIQUE INDEX `Id_Localitat_UNIQUE` (`Id_localitat` ASC) VISIBLE,
  INDEX `fk_Localitat_Provincia1_idx` (`id_provincia_localitat` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Localitat_UNIQUE` (`nom_localitat` ASC) VISIBLE,
  CONSTRAINT `fk_Localitat_Provincia1`
    FOREIGN KEY (`id_provincia_localitat`)
    REFERENCES `S201N1E2_PIZZERIA`.`provincia` (`Id_provincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`clients` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`clients` (
  `Id_clients` MEDIUMINT(8) UNSIGNED NOT NULL COMMENT 'Si arriba a 16M de clients, podrà pagar una actualització del software',
  `id_localitat_clients` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Si arriba a tenir més de 16M de clients, podrà pagar una petita actualització del software.',
  `nom_clients` VARCHAR(30) NOT NULL,
  `cognoms_clients` VARCHAR(60) NOT NULL,
  `adreca_clients` VARCHAR(45) NOT NULL,
  `codi_postal_clients` SMALLINT(5) UNSIGNED NOT NULL,
  `telefon_clients` VARCHAR(13) NOT NULL COMMENT 'Format màxim 0034666666666',
  PRIMARY KEY (`Id_clients`),
  UNIQUE INDEX `Nom_Clients_UNIQUE` (`nom_clients` ASC) VISIBLE,
  INDEX `fk_Clients_Localitat_idx` (`id_localitat_clients` ASC) VISIBLE,
  UNIQUE INDEX `Id_Clients_UNIQUE` (`Id_clients` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Localitat`
    FOREIGN KEY (`id_localitat_clients`)
    REFERENCES `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`botigues`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`botigues` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`botigues` (
  `Id_botigues` TINYINT(3) UNSIGNED NOT NULL COMMENT 'Si arriba a tenir 255 botigues, podrà pagar una actualització del software',
  `id_localitat_botigues` SMALLINT(4) UNSIGNED NOT NULL,
  `codi_postal_botigues` SMALLINT(4) UNSIGNED NOT NULL,
  `adreça_botigues` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_botigues`),
  UNIQUE INDEX `Id_Botigues_UNIQUE` (`Id_botigues` ASC) VISIBLE,
  INDEX `fk_Botigues_Localitats_idx` (`id_localitat_botigues` ASC) VISIBLE,
  CONSTRAINT `fk_Botigues_Localitats`
    FOREIGN KEY (`id_localitat_botigues`)
    REFERENCES `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`comandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`comandes` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`comandes` (
  `Id_comandes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_clients_comandes` MEDIUMINT UNSIGNED NOT NULL,
  `id_botiga_comandes` TINYINT UNSIGNED NOT NULL COMMENT 'Si arriba a tenir 255 botigues, podrà pagar una actualització del software',
  `data_comandes` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `rec_dom_comandes` BIT(1) NOT NULL COMMENT '0 = Recollir en botiga\n1 = Domicili\n',
  `quantitat_pizzes_comandes` TINYINT(2) UNSIGNED NOT NULL,
  `quantitat_hamburgueses_comandes` TINYINT(2) UNSIGNED NOT NULL COMMENT 'El nº màxim de pizzes en una comanda serand e 99',
  `quantitat_begudes_comandes` TINYINT(2) UNSIGNED NOT NULL,
  `preu_total_comandes` SMALLINT UNSIGNED NOT NULL COMMENT 'Si el preu d\'una pizza pot ser de p.exemple 25€ i dic que el màxim de pizzes en una comanda son 99 això fan un preu màxim de 2.475€',
  PRIMARY KEY (`Id_comandes`),
  INDEX `fk_Comandes_Clients_idx` (`id_clients_comandes` ASC) VISIBLE,
  INDEX `fk_Comandes_Botigues_idx` (`id_botiga_comandes` ASC) VISIBLE,
  CONSTRAINT `fk_Comandes_Clients`
    FOREIGN KEY (`id_clients_comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`clients` (`Id_clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Botigues`
    FOREIGN KEY (`id_botiga_comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`categories` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`categories` (
  `Id_categories` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_categories` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_categories`),
  UNIQUE INDEX `Id_Categories_UNIQUE` (`Id_categories` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Categories_UNIQUE` (`nom_categories` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`productes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`productes` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`productes` (
  `Id_productes` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_categories_productes` SMALLINT UNSIGNED NOT NULL,
  `nom_productes` VARCHAR(45) NOT NULL,
  `descripcio_productes` VARCHAR(256) NULL,
  `imatge_productes` VARCHAR(25) NULL COMMENT 'S\'ha de posar el nom de la imatge, amb l\'extensió.',
  `preu_productes` TINYINT NOT NULL,
  PRIMARY KEY (`Id_productes`),
  UNIQUE INDEX `Nom_Productes_UNIQUE` (`nom_productes` ASC) VISIBLE,
  INDEX `fk_Productes_Categories_idx` (`id_categories_productes` ASC) VISIBLE,
  UNIQUE INDEX `Id_Productes_UNIQUE` (`Id_productes` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_Categories`
    FOREIGN KEY (`id_categories_productes`)
    REFERENCES `S201N1E2_PIZZERIA`.`categories` (`Id_categories`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`productes_comandes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`productes_comandes` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`productes_comandes` (
  `id_comandes_productes_comandes` INT UNSIGNED NOT NULL,
  `id_productes_productes_comandes` SMALLINT UNSIGNED NOT NULL,
  `quantitat_productes_comandes` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_comandes_productes_comandes`, `id_productes_productes_comandes`),
  INDEX `fk_Productes_De_Comandes_Productes1_idx` (`id_productes_productes_comandes` ASC) VISIBLE,
  CONSTRAINT `fk_ProductesComanda_Comandes`
    FOREIGN KEY (`id_comandes_productes_comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productes_De_Comandes_Productes1`
    FOREIGN KEY (`id_productes_productes_comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`productes` (`Id_productes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`lloc_feina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`lloc_feina` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`lloc_feina` (
  `Id_lloc_feina` BIT(1) NOT NULL,
  `nom_lloc_feina` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id_lloc_feina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`empleats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`empleats` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`empleats` (
  `Id_empleats` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_botiga_empleats` TINYINT(3) UNSIGNED NOT NULL,
  `id_lloc_feina_empleats` BIT(1) NOT NULL COMMENT '0 = Cuiner/a\n1 = Repartidor/a\n',
  `nom_empleats` VARCHAR(30) NOT NULL,
  `cognoms_empleats` VARCHAR(60) NOT NULL,
  `nif_empleats` VARCHAR(9) NOT NULL,
  `telefon_empleats` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Id_empleats`),
  INDEX `fk_Empleat_LlocFeina_idx` (`id_lloc_feina_empleats` ASC) VISIBLE,
  INDEX `fk_Empleats_Botiga_idx` (`id_botiga_empleats` ASC) VISIBLE,
  CONSTRAINT `fk_Empleat_LlocFeina`
    FOREIGN KEY (`id_lloc_feina_empleats`)
    REFERENCES `S201N1E2_PIZZERIA`.`lloc_feina` (`Id_lloc_feina`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Empleats_Botiga`
    FOREIGN KEY (`id_botiga_empleats`)
    REFERENCES `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`entregues_domicili`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`entregues_domicili` ;

CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`entregues_domicili` (
  `id_Comanda_entregues_domicili` INT UNSIGNED NOT NULL,
  `id_empleat_entregues_domicili` SMALLINT(5) UNSIGNED NOT NULL,
  `lluirament_entregues_domicili` DATETIME NOT NULL,
  PRIMARY KEY (`id_Comanda_entregues_domicili`, `id_empleat_entregues_domicili`),
  INDEX `fk_EntregaDomicili_Comanda_idx` (`id_Comanda_entregues_domicili` ASC) VISIBLE,
  INDEX `fk_EntregaDomicili_Empleat_idx` (`id_empleat_entregues_domicili` ASC) VISIBLE,
  CONSTRAINT `fk_EntregaDomicili_Comanda`
    FOREIGN KEY (`id_Comanda_entregues_domicili`)
    REFERENCES `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EntregaDomicili_Empleat`
    FOREIGN KEY (`id_empleat_entregues_domicili`)
    REFERENCES `S201N1E2_PIZZERIA`.`empleats` (`Id_empleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `S201N1E2_PIZZERIA` ;

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`botiga_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`botiga_complet_vw` (`Id_Botigues` INT, `codi_postal_botigues` INT, `adreça_botigues` INT, `Id_localitat` INT, `nom_localitat` INT, `Id_provincia` INT, `nom_provincia` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`comanda_info_complet_vw` (`Id_comandes` INT, `data_comandes` INT, `rec_dom_comandes` INT, `quantitat_pizzes_comandes` INT, `quantitat_hamburgueses_comandes` INT, `quantitat_begudes_comandes` INT, `preu_total_comandes` INT, `Id_clients` INT, `nom_clients` INT, `cognoms_clients` INT, `adreca_clients` INT, `codi_postal_clients` INT, `telefon_clients` INT, `Id_localitat` INT, `nom_localitat` INT, `Id_provincia` INT, `nom_provincia` INT, `lluirament_entregues_domicili` INT, `Id_empleats` INT, `nom_empleats` INT, `cognoms_empleats` INT, `nif_empleats` INT, `telefon_empleats` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`client_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`client_complet_vw` (`Id_clients` INT, `nom_clients` INT, `cognoms_clients` INT, `sareca_clients` INT, `codi_postal_clients` INT, `telefon_clients` INT, `Id_localitat` INT, `nom_localitat` INT, `Id_provincia` INT, `nom_provincia` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`comanda_llista_productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`comanda_llista_productes` (`Id_comandes` INT, `quantitat_productes_comandes` INT, `data_comandes` INT, `quantitat_pizzes_comandes` INT, `quantitat_hamburgueses_comandes` INT, `quantitat_begudes_comandes` INT, `preu_total_comandes` INT, `Id_productes` INT, `nom_productes` INT, `descripcio_productes` INT, `imatge_productes` INT, `preu_productes` INT, `Id_categories` INT, `nom_categories` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`estat_global_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`estat_global_vw` (`'Nº TOTAL DE CLIENTS'` INT, `'Nº TOTAL DE COMANDES'` INT, `'€ TOTALS'` INT, `'Nº TOTAL DE BOTIGUES'` INT, `'Nº TOTAL D\'EMPLEATS'` INT, `'Nº TOTAL DE PRODUCTES'` INT, `'Nº TOTAL DE CATEGORIES'` INT);

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`botiga_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`botiga_complet_vw`;
DROP VIEW IF EXISTS `S201N1E2_PIZZERIA`.`botiga_complet_vw` ;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `botiga_complet_vw` AS
SELECT  
`bot`.`Id_botigues` AS `Id_Botigues`,
`bot`.`codi_postal_botigues` AS `codi_postal_botigues`,
`bot`.`adreça_botigues` AS `adreça_botigues`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia`
FROM `botigues` AS `bot`
RIGHT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_localitat` = `bot`.`id_localitat_botigues`
RIGHT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
GROUP BY `s201n1e2_pizzeria`.`bot`.`Id_botigues`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`;
DROP VIEW IF EXISTS `S201N1E2_PIZZERIA`.`comanda_info_complet_vw` ;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `comanda_info_complet_vw` AS 
SELECT `cmd`.`Id_comandes` AS `Id_comandes`,
`cmd`.`data_comandes` AS `data_comandes`,
`cmd`.`rec_dom_comandes` AS `rec_dom_comandes`,
`cmd`.`quantitat_pizzes_comandes` AS `quantitat_pizzes_comandes`,
`cmd`.`quantitat_hamburgueses_comandes` AS `quantitat_hamburgueses_comandes`,
`cmd`.`quantitat_begudes_comandes` AS `quantitat_begudes_comandes`,
`cmd`.`preu_total_comandes` AS `preu_total_comandes`,
`cli`.`Id_clients` AS `Id_clients`,
`cli`.`nom_clients` AS `nom_clients`,
`cli`.`cognoms_clients` AS `cognoms_clients`,
`cli`.`adreca_clients` AS `adreca_clients`,
`cli`.`codi_postal_clients` AS `codi_postal_clients`,
`cli`.`telefon_clients` AS `telefon_clients`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia`,
`endo`.`lluirament_entregues_domicili` AS `lluirament_entregues_domicili`,
`empl`.`Id_empleats` AS `Id_empleats`,
`empl`.`nom_empleats` AS `nom_empleats`,
`empl`.`cognoms_empleats` AS `cognoms_empleats`,
`empl`.`nif_empleats` AS `nif_empleats`,
`empl`.`telefon_empleats` AS `telefon_empleats`
FROM `comandes` `cmd`
LEFT JOIN `clients` `cli` ON `cli`.`Id_clients` = `cmd`.`id_clients_comandes`
LEFT JOIN `localitat` `loc` ON `loc`.`Id_localitat` = `cli`.`id_localitat_clients`
LEFT JOIN `provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
LEFT JOIN `entregues_domicili` `endo` ON `endo`.`id_Comanda_entregues_domicili` = `cmd`.`Id_comandes`
LEFT JOIN `empleats` `empl` ON `empl`.`Id_empleats` = `endo`.`id_empleat_entregues_domicili`
GROUP BY `cmd`.`Id_comandes`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`client_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`client_complet_vw`;
DROP VIEW IF EXISTS `S201N1E2_PIZZERIA`.`client_complet_vw` ;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `client_complet_vw` AS
SELECT `cli`.`Id_clients` AS `Id_clients`,
`cli`.`nom_clients` AS `nom_clients`,
`cli`.`cognoms_clients` AS `cognoms_clients`,
`cli`.`adreca_clients` AS `sareca_clients`,
`cli`.`codi_postal_clients` AS `codi_postal_clients`,
`cli`.`telefon_clients` AS `telefon_clients`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia` 
FROM `s201n1e2_pizzeria`.`clients` `cli`
LEFT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_localitat` = `cli`.`id_localitat_clients`
LEFT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
GROUP BY `cli`.`Id_clients`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`comanda_llista_productes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`comanda_llista_productes`;
DROP VIEW IF EXISTS `S201N1E2_PIZZERIA`.`comanda_llista_productes` ;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `comanda_llista_productes` AS
SELECT 
`cmd`.`Id_comandes` AS `Id_comandes`,
`procom`.`quantitat_productes_comandes` AS `quantitat_productes_comandes`,
`cmd`.`data_comandes` AS `data_comandes`,
`cmd`.`quantitat_pizzes_comandes` AS `quantitat_pizzes_comandes`,
`cmd`.`quantitat_hamburgueses_comandes` AS `quantitat_hamburgueses_comandes`,
`cmd`.`quantitat_begudes_comandes` AS `quantitat_begudes_comandes`,
`cmd`.`preu_total_comandes` AS `preu_total_comandes`,
`pro`.`Id_productes` AS `Id_productes`,
`pro`.`nom_productes` AS `nom_productes`,
`pro`.`descripcio_productes` AS `descripcio_productes`,
`pro`.`imatge_productes` AS `imatge_productes`,
`pro`.`preu_productes` AS `preu_productes`,
`cat`.`Id_categories` AS `Id_categories`,
`cat`.`nom_categories` AS `nom_categories` 
FROM `s201n1e2_pizzeria`.`productes_comandes` `procom`
LEFT JOIN `comandes` `cmd` ON  `cmd`.`Id_comandes` = `procom`.`id_comandes_productes_comandes`
LEFT JOIN `productes` `pro` ON `pro`.`Id_productes` = `procom`.`id_productes_productes_comandes`
LEFT JOIN `categories` `cat` ON `cat`.`Id_categories` = `pro`.`id_categories_productes`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`estat_global_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`estat_global_vw`;
DROP VIEW IF EXISTS `S201N1E2_PIZZERIA`.`estat_global_vw` ;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `estat_global_vw` AS
select
	(select count(*) from clients) as 'Nº TOTAL DE CLIENTS',
    (select count(*) from comandes) as 'Nº TOTAL DE COMANDES',
    (select sum(preu_total_comandes) from comandes) as '€ TOTALS',
    (select count(*) from botigues) as 'Nº TOTAL DE BOTIGUES',
    (select count(*) from empleats) as 'Nº TOTAL D\'EMPLEATS',
    (select count(*) from productes) as 'Nº TOTAL DE PRODUCTES',
    (select count(*) from categories) as 'Nº TOTAL DE CATEGORIES';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`provincia`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`provincia` (`Id_provincia`, `nom_provincia`) VALUES (0, 'Barcelona');
INSERT INTO `S201N1E2_PIZZERIA`.`provincia` (`Id_provincia`, `nom_provincia`) VALUES (1, 'Girona');
INSERT INTO `S201N1E2_PIZZERIA`.`provincia` (`Id_provincia`, `nom_provincia`) VALUES (2, 'Lleida');
INSERT INTO `S201N1E2_PIZZERIA`.`provincia` (`Id_provincia`, `nom_provincia`) VALUES (3, 'Tarragona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`localitat`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`, `id_provincia_localitat`, `nom_localitat`) VALUES (1, 0, 'Sabadell');
INSERT INTO `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`, `id_provincia_localitat`, `nom_localitat`) VALUES (2, 3, 'Mora d\'Ebra');
INSERT INTO `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`, `id_provincia_localitat`, `nom_localitat`) VALUES (3, 1, 'Roses');
INSERT INTO `S201N1E2_PIZZERIA`.`localitat` (`Id_localitat`, `id_provincia_localitat`, `nom_localitat`) VALUES (4, 2, 'El Pont de Suert');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`clients` (`Id_clients`, `id_localitat_clients`, `nom_clients`, `cognoms_clients`, `adreca_clients`, `codi_postal_clients`, `telefon_clients`) VALUES (1, 1, 'Sandra', 'Ardnas', 'pot pot pot pot', 08204, '555555500');
INSERT INTO `S201N1E2_PIZZERIA`.`clients` (`Id_clients`, `id_localitat_clients`, `nom_clients`, `cognoms_clients`, `adreca_clients`, `codi_postal_clients`, `telefon_clients`) VALUES (2, 2, 'Tania', 'Ainat', 'pol pol pol pol', 17480, '555555501');
INSERT INTO `S201N1E2_PIZZERIA`.`clients` (`Id_clients`, `id_localitat_clients`, `nom_clients`, `cognoms_clients`, `adreca_clients`, `codi_postal_clients`, `telefon_clients`) VALUES (3, 3, 'Ramiro', 'Orimar', 'pos pos pos pos', 25520, '555555502');
INSERT INTO `S201N1E2_PIZZERIA`.`clients` (`Id_clients`, `id_localitat_clients`, `nom_clients`, `cognoms_clients`, `adreca_clients`, `codi_postal_clients`, `telefon_clients`) VALUES (4, 4, 'Vera', 'Arev', 'pi poi poi poi', 43740, '555555503');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`botigues`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`, `id_localitat_botigues`, `codi_postal_botigues`, `adreça_botigues`) VALUES (1, 1, 08204, 'bla bla bla bla bla');
INSERT INTO `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`, `id_localitat_botigues`, `codi_postal_botigues`, `adreça_botigues`) VALUES (2, 2, 17480, 'ble ble ble ble ble');
INSERT INTO `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`, `id_localitat_botigues`, `codi_postal_botigues`, `adreça_botigues`) VALUES (3, 3, 25520, 'blo blo blo blo blo');
INSERT INTO `S201N1E2_PIZZERIA`.`botigues` (`Id_botigues`, `id_localitat_botigues`, `codi_postal_botigues`, `adreça_botigues`) VALUES (4, 4, 43740, 'bli bli bli bli bli');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`comandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`, `id_clients_comandes`, `id_botiga_comandes`, `data_comandes`, `rec_dom_comandes`, `quantitat_pizzes_comandes`, `quantitat_hamburgueses_comandes`, `quantitat_begudes_comandes`, `preu_total_comandes`) VALUES (1, 1, 1, DEFAULT, 1, 2, 1, 2, 100);
INSERT INTO `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`, `id_clients_comandes`, `id_botiga_comandes`, `data_comandes`, `rec_dom_comandes`, `quantitat_pizzes_comandes`, `quantitat_hamburgueses_comandes`, `quantitat_begudes_comandes`, `preu_total_comandes`) VALUES (2, 2, 2, DEFAULT, 1, 0, 2, 1, 75);
INSERT INTO `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`, `id_clients_comandes`, `id_botiga_comandes`, `data_comandes`, `rec_dom_comandes`, `quantitat_pizzes_comandes`, `quantitat_hamburgueses_comandes`, `quantitat_begudes_comandes`, `preu_total_comandes`) VALUES (3, 2, 2, DEFAULT, 0, 1, 0, 1, 18);
INSERT INTO `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`, `id_clients_comandes`, `id_botiga_comandes`, `data_comandes`, `rec_dom_comandes`, `quantitat_pizzes_comandes`, `quantitat_hamburgueses_comandes`, `quantitat_begudes_comandes`, `preu_total_comandes`) VALUES (4, 3, 3, DEFAULT, 1, 4, 0, 10, 100);
INSERT INTO `S201N1E2_PIZZERIA`.`comandes` (`Id_comandes`, `id_clients_comandes`, `id_botiga_comandes`, `data_comandes`, `rec_dom_comandes`, `quantitat_pizzes_comandes`, `quantitat_hamburgueses_comandes`, `quantitat_begudes_comandes`, `preu_total_comandes`) VALUES (5, 4, 4, DEFAULT, 1, 0, 3, 5, 74);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (1, 'Pizzes Vegetals');
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (2, 'Pizzes Carn Extres');
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (3, 'Pizzes Sense Gluten');
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (4, 'Pizzes Normals');
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (5, 'Hambugueses');
INSERT INTO `S201N1E2_PIZZERIA`.`categories` (`Id_categories`, `nom_categories`) VALUES (6, 'Begudes');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`productes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (1, 1, 'Pizza 4 herbes', 'Pizza amb 4 herbes espectaculars', NULL, 15);
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (2, 2, 'Pizza Buey', 'Pizza amb un filet de buey a sobre', 'pizzabuey.png', 30);
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (3, 3, 'Pizza Margrita Sense Gluten', 'La clàssica pizza margarita però amb massa sesnse gluten', NULL, 18);
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (4, 4, 'Pizza 6 formatges', 'T\'agrada el formatge?', 'sisformatges-png', 15);
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (5, 5, 'Doble amb fomratge', '2 hamburuesses de 500gr i 100gr de barreja de formatges', 'lahambu.png', 25);
INSERT INTO `S201N1E2_PIZZERIA`.`productes` (`Id_productes`, `id_categories_productes`, `nom_productes`, `descripcio_productes`, `imatge_productes`, `preu_productes`) VALUES (6, 6, 'Coca-Cola Light', 'Que s\'ha de mantenir la línia', 'trabajadorcachas.png', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`productes_comandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (1, 1, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (1, 5, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (1, 6, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (2, 5, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (2, 6, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (3, 2, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (3, 6, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (4, 1, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (4, 2, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (4, 4, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (4, 6, 10);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (5, 5, 3);
INSERT INTO `S201N1E2_PIZZERIA`.`productes_comandes` (`id_comandes_productes_comandes`, `id_productes_productes_comandes`, `quantitat_productes_comandes`) VALUES (5, 6, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`lloc_feina`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`lloc_feina` (`Id_lloc_feina`, `nom_lloc_feina`) VALUES (0, 'Cuiner');
INSERT INTO `S201N1E2_PIZZERIA`.`lloc_feina` (`Id_lloc_feina`, `nom_lloc_feina`) VALUES (1, 'Repartidor');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`empleats`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`empleats` (`Id_empleats`, `id_botiga_empleats`, `id_lloc_feina_empleats`, `nom_empleats`, `cognoms_empleats`, `nif_empleats`, `telefon_empleats`) VALUES (1, 1, 1, 'Marcos', 'Elde Arco', '44444444L', '555555550');
INSERT INTO `S201N1E2_PIZZERIA`.`empleats` (`Id_empleats`, `id_botiga_empleats`, `id_lloc_feina_empleats`, `nom_empleats`, `cognoms_empleats`, `nif_empleats`, `telefon_empleats`) VALUES (2, 2, 1, 'Sandra', 'Aro', '88888888O', '555555551');
INSERT INTO `S201N1E2_PIZZERIA`.`empleats` (`Id_empleats`, `id_botiga_empleats`, `id_lloc_feina_empleats`, `nom_empleats`, `cognoms_empleats`, `nif_empleats`, `telefon_empleats`) VALUES (3, 3, 1, 'Andreu', 'Alo', '77777777N', '555555552');
INSERT INTO `S201N1E2_PIZZERIA`.`empleats` (`Id_empleats`, `id_botiga_empleats`, `id_lloc_feina_empleats`, `nom_empleats`, `cognoms_empleats`, `nif_empleats`, `telefon_empleats`) VALUES (4, 4, 1, 'Laura', 'Palde', '66666666D', '555555553');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`entregues_domicili`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`entregues_domicili` (`id_Comanda_entregues_domicili`, `id_empleat_entregues_domicili`, `lluirament_entregues_domicili`) VALUES (1, 1, '2022-12-20 19:35:00.1');
INSERT INTO `S201N1E2_PIZZERIA`.`entregues_domicili` (`id_Comanda_entregues_domicili`, `id_empleat_entregues_domicili`, `lluirament_entregues_domicili`) VALUES (2, 2, '2022-12-21 9:05:50.47');
INSERT INTO `S201N1E2_PIZZERIA`.`entregues_domicili` (`id_Comanda_entregues_domicili`, `id_empleat_entregues_domicili`, `lluirament_entregues_domicili`) VALUES (4, 3, '2022-12-22 22:14:21.25');
INSERT INTO `S201N1E2_PIZZERIA`.`entregues_domicili` (`id_Comanda_entregues_domicili`, `id_empleat_entregues_domicili`, `lluirament_entregues_domicili`) VALUES (5, 4, '2022-12-23 21:51:00.0');

COMMIT;

