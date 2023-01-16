-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema s0201n1e1_culampolla
-- -----------------------------------------------------
-- S2_01_N1_E1

-- -----------------------------------------------------
-- Schema s0201n1e1_culampolla
--
-- S2_01_N1_E1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `s0201n1e1_culampolla` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
USE `s0201n1e1_culampolla` ;

-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`pais` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`pais` (
  `Id_pais` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_pais` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_pais`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`ciutats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`ciutats` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`ciutats` (
  `Id_ciutats` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pais_ciutats` TINYINT UNSIGNED NOT NULL,
  `nom_ciutats` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_ciutats`),
  UNIQUE INDEX `Id_ciutats_UNIQUE` (`Id_ciutats` ASC) VISIBLE,
  INDEX `fk_ciutats_pais_idx` (`id_pais_ciutats` ASC) VISIBLE,
  INDEX `nom_ciutats_idx` (`nom_ciutats` ASC) VISIBLE,
  CONSTRAINT `fk_ciutats_pais`
    FOREIGN KEY (`id_pais_ciutats`)
    REFERENCES `s0201n1e1_culampolla`.`pais` (`Id_pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`adreca`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`adreca` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`adreca` (
  `Id_adreca` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pais_adreca` TINYINT UNSIGNED NOT NULL,
  `id_ciutat_adreca` INT UNSIGNED NOT NULL,
  `carrer_adreca` VARCHAR(45) NULL,
  `numero_adreca` SMALLINT UNSIGNED NULL,
  `pis_adreca` VARCHAR(45) NULL,
  `porta_adreca` VARCHAR(2) NULL,
  `codi_postal_adreca` SMALLINT(5) UNSIGNED NULL,
  PRIMARY KEY (`Id_adreca`),
  UNIQUE INDEX `Id_adreca_UNIQUE` (`Id_adreca` ASC) VISIBLE,
  INDEX `fk_adreca_pais_idx` (`id_pais_adreca` ASC) VISIBLE,
  INDEX `fk_adreca_ciutat_idx` (`id_ciutat_adreca` ASC) VISIBLE,
  CONSTRAINT `fk_adreca_pais`
    FOREIGN KEY (`id_pais_adreca`)
    REFERENCES `s0201n1e1_culampolla`.`pais` (`Id_pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_adreca_ciutat`
    FOREIGN KEY (`id_ciutat_adreca`)
    REFERENCES `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`proveidors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`proveidors` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`proveidors` (
  `Id_proveidors` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_adreca_proveidors` INT UNSIGNED NOT NULL,
  `telefon_proveidors` VARCHAR(13) NULL,
  `fax_proveidors` VARCHAR(13) NULL,
  `nif_proveidors` VARCHAR(9) NOT NULL COMMENT 'Format del NIF sense guió, sols els números i les lletres.\n11111111A\n',
  `nom_proveidors` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_proveidors`),
  UNIQUE INDEX `NIF_Proveidors_UNIQUE` (`nif_proveidors` ASC) VISIBLE,
  INDEX `fk_proveidors_adreca_idx` (`id_adreca_proveidors` ASC) VISIBLE,
  UNIQUE INDEX `Id_proveidors_UNIQUE` (`Id_proveidors` ASC) VISIBLE,
  UNIQUE INDEX `telefon_proveidors_UNIQUE` (`telefon_proveidors` ASC) VISIBLE,
  INDEX `telefon_proveidors_idx` (`telefon_proveidors` ASC) INVISIBLE,
  INDEX `nif_proveidors_idx` (`nif_proveidors` ASC) INVISIBLE,
  UNIQUE INDEX `fax_proveidors_UNIQUE` (`fax_proveidors` ASC) VISIBLE,
  CONSTRAINT `fk_proveidors_adreca`
    FOREIGN KEY (`id_adreca_proveidors`)
    REFERENCES `s0201n1e1_culampolla`.`adreca` (`Id_adreca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`color_muntura`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`color_muntura` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`color_muntura` (
  `Id_color_muntura` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `color_color_muntura` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_color_muntura`),
  UNIQUE INDEX `Id_ColorMuntura_UNIQUE` (`Id_color_muntura` ASC) VISIBLE,
  UNIQUE INDEX `Color_ColorMuntura_UNIQUE` (`color_color_muntura` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`graduacions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`graduacions` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`graduacions` (
  `Id_graduacions` TINYINT UNSIGNED NOT NULL,
  `valor_graduacions` FLOAT(5) NOT NULL,
  PRIMARY KEY (`Id_graduacions`),
  UNIQUE INDEX `Id_Graduacio_UNIQUE` (`Id_graduacions` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`muntures`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`muntures` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`muntures` (
  `Id_muntures` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `tipus_muntures` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_muntures`),
  UNIQUE INDEX `tipus_muntures_UNIQUE` (`tipus_muntures` ASC) VISIBLE,
  INDEX `tipus_muntures` (`tipus_muntures` ASC) VISIBLE,
  UNIQUE INDEX `Id_muntures_UNIQUE` (`Id_muntures` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`marques`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`marques` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`marques` (
  `Id_marques` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_proveidor_marques` INT UNSIGNED NOT NULL,
  `nom_marques` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_marques`),
  UNIQUE INDEX `Nom_Marques_UNIQUE` (`nom_marques` ASC) VISIBLE,
  INDEX `nom_marques_idx` (`nom_marques` ASC) VISIBLE,
  UNIQUE INDEX `Id_marques_UNIQUE` (`Id_marques` ASC) VISIBLE,
  CONSTRAINT `id_marques_proveidors`
    FOREIGN KEY (`id_proveidor_marques`)
    REFERENCES `s0201n1e1_culampolla`.`proveidors` (`Id_proveidors`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`ulleres`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`ulleres` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`ulleres` (
  `Id_ulleres` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `Id_marques_ulleres` SMALLINT UNSIGNED NOT NULL,
  `id_muntures_ulleres` TINYINT UNSIGNED NOT NULL,
  `id_color_muntura_ulleres` SMALLINT UNSIGNED NOT NULL,
  `id_graduacions_ulleres` TINYINT UNSIGNED NOT NULL,
  `preu_ulleres` FLOAT(6) UNSIGNED NOT NULL COMMENT 'Preus de més de 9999,99€ no crec que hi hagi',
  PRIMARY KEY (`Id_ulleres`),
  UNIQUE INDEX `Id_Ullera_UNIQUE` (`Id_ulleres` ASC) VISIBLE,
  INDEX `fk_Ullera_ColorMuntura_idx` (`id_color_muntura_ulleres` ASC) VISIBLE,
  INDEX `fk_ulleres_graduacions_idx` (`id_graduacions_ulleres` ASC) VISIBLE,
  INDEX `fk_ulleres_muntures_idx` (`id_muntures_ulleres` ASC) VISIBLE,
  INDEX `fk_ulleres_marques1_idx` (`Id_marques_ulleres` ASC) VISIBLE,
  CONSTRAINT `fk_ullerwa_colormuntura`
    FOREIGN KEY (`id_color_muntura_ulleres`)
    REFERENCES `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ulleres_graduacions`
    FOREIGN KEY (`id_graduacions_ulleres`)
    REFERENCES `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ulleres_muntures`
    FOREIGN KEY (`id_muntures_ulleres`)
    REFERENCES `s0201n1e1_culampolla`.`muntures` (`Id_muntures`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ulleres_marques1`
    FOREIGN KEY (`Id_marques_ulleres`)
    REFERENCES `s0201n1e1_culampolla`.`marques` (`Id_marques`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`clients` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`clients` (
  `Id_clients` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_adreca_clients` INT UNSIGNED NOT NULL,
  `id_client_recomanador_clients` INT UNSIGNED NULL COMMENT 'El ID del client que ha recomanat l\'optica',
  `nom_clients` VARCHAR(30) NOT NULL,
  `telefon_clients` VARCHAR(13) NOT NULL,
  `email_clients` VARCHAR(30) NOT NULL,
  `data_registre_clients` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_clients`),
  UNIQUE INDEX `Id_Clients_UNIQUE` (`Id_clients` ASC) VISIBLE,
  INDEX `fk_Clients_Clients_idx` (`id_client_recomanador_clients` ASC) VISIBLE,
  INDEX `email_clients_idx` (`email_clients` ASC) INVISIBLE,
  INDEX `telefon_clients_idx` (`email_clients` ASC) VISIBLE,
  INDEX `fk_clients_adreca1_idx` (`id_adreca_clients` ASC) VISIBLE,
  CONSTRAINT `fk_clients_clients`
    FOREIGN KEY (`id_client_recomanador_clients`)
    REFERENCES `s0201n1e1_culampolla`.`clients` (`Id_clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_clients_adreca1`
    FOREIGN KEY (`id_adreca_clients`)
    REFERENCES `s0201n1e1_culampolla`.`adreca` (`Id_adreca`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`empleats`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`empleats` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`empleats` (
  `Id_empleats` SMALLINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Suposo que més de 999 empleats no hi harribarà',
  `nom_empleats` VARCHAR(30) NOT NULL,
  `cognom_empleats` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_empleats`),
  UNIQUE INDEX `Id_empleats_UNIQUE` (`Id_empleats` ASC) VISIBLE,
  INDEX `nom_empleats_idx` (`nom_empleats` ASC) INVISIBLE,
  INDEX `cognom_empleats_idx` (`cognom_empleats` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`vendes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`vendes` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`vendes` (
  `Id_vendes` INT UNSIGNED NOT NULL,
  `id_clients_vendes` INT UNSIGNED NOT NULL,
  `id_empleats_vendes` SMALLINT UNSIGNED NOT NULL,
  `data_venda_vendes` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_vendes`),
  UNIQUE INDEX `Id_vendes_UNIQUE` (`Id_vendes` ASC) VISIBLE,
  INDEX `fk_vendes_empleats1_idx` (`id_empleats_vendes` ASC) VISIBLE,
  INDEX `fk_vendes_clients1_idx` (`id_clients_vendes` ASC) VISIBLE,
  CONSTRAINT `fk_vendes_empleats1`
    FOREIGN KEY (`id_empleats_vendes`)
    REFERENCES `s0201n1e1_culampolla`.`empleats` (`Id_empleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_vendes_clients1`
    FOREIGN KEY (`id_clients_vendes`)
    REFERENCES `s0201n1e1_culampolla`.`clients` (`Id_clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `s0201n1e1_culampolla`.`productes_vendes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`productes_vendes` ;

CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`productes_vendes` (
  `Id_productes_vendes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_vendes_productes_vendes` INT UNSIGNED NOT NULL,
  `id_ullera_vendes` INT UNSIGNED NOT NULL,
  `entregat_productes_vendes` BIT NOT NULL COMMENT '0 = ulleres entregades\n1= ulleres no entregades',
  `data_entregat_productes_vendes` DATETIME NULL COMMENT 'data que s\'han entregat les ulleres\nsi és NULL vol dir que les ulleres no s\'han entregat',
  PRIMARY KEY (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`),
  UNIQUE INDEX `Id_productes_vendes_UNIQUE` (`Id_productes_vendes` ASC) VISIBLE,
  INDEX `fk_productes_vendes_vendes_idx` (`id_vendes_productes_vendes` ASC) VISIBLE,
  INDEX `fk_productes_vendes_ulleres_idx` (`id_ullera_vendes` ASC) VISIBLE,
  CONSTRAINT `fk_productes_vendes_vendes`
    FOREIGN KEY (`id_vendes_productes_vendes`)
    REFERENCES `s0201n1e1_culampolla`.`vendes` (`Id_vendes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_productes_vendes_ulleres`
    FOREIGN KEY (`id_ullera_vendes`)
    REFERENCES `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `s0201n1e1_culampolla` ;

-- -----------------------------------------------------
-- Placeholder table for view `s0201n1e1_culampolla`.`ullera_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`ullera_complet_vw` (`Id_ulleres` INT, `id_color_muntura_ulleres` INT, `preu_ulleres` INT, `Id_muntures` INT, `tipus_muntures` INT, `Id_marques` INT, `id_proveidor_marques` INT, `nom_marques` INT, `Id_proveidors` INT, `nom_proveidors` INT, `UNITATS VENUDES` INT, `VENDES TOTALS EN €` INT, `id_graduacions_ulleres` INT);

-- -----------------------------------------------------
-- Placeholder table for view `s0201n1e1_culampolla`.`proveidor_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`proveidor_complet_vw` (`Id_proveidors` INT, `nom_proveidors` INT, `telefon_proveidors` INT, `fax_proveidors` INT, `nif_proveidors` INT, `Id_adreca` INT, `carrer_adreca` INT, `numero_adreca` INT, `pis_adreca` INT, `porta_adreca` INT, `codi_postal_adreca` INT, `Id_pais` INT, `nom_pais` INT, `Id_ciutats` INT, `nom_ciutats` INT);

-- -----------------------------------------------------
-- Placeholder table for view `s0201n1e1_culampolla`.`client_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`client_complet_vw` (`Id_clients` INT, `id_client_recomanador_clients` INT, `nom_clients` INT, `telefon_clients` INT, `email_clients` INT, `data_registre_clients` INT, `Id_adreca` INT, `carrer_adreca` INT, `numero_adreca` INT, `pis_adreca` INT, `porta_adreca` INT, `codi_postal_adreca` INT, `Id_pais` INT, `nom_pais` INT, `nom_ciutats` INT, `VENDES REALITZADES AL CLIENT` INT, `Id_ciutats` INT);

-- -----------------------------------------------------
-- Placeholder table for view `s0201n1e1_culampolla`.`estat_global_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `s0201n1e1_culampolla`.`estat_global_vw` (`'Nº TOTAL DE CLIENTS'` INT, `'Nº TOTAL DE CIUTATS'` INT, `'Nº TOTAL DE PAISOS'` INT, `'Nº TOTAL DE MARQUES'` INT, `'NºTOTAL D\'ULLERES'` INT, `'Nº TOTAL DE VENDES'` INT, `'€ VENDES TOTALS'` INT);

-- -----------------------------------------------------
-- View `s0201n1e1_culampolla`.`ullera_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`ullera_complet_vw`;
DROP VIEW IF EXISTS `s0201n1e1_culampolla`.`ullera_complet_vw` ;
USE `s0201n1e1_culampolla`;
-- MOSTRA TOTA LA INFO D'UNA ULLERA: el proveidor, el color, muntura, etc...
CREATE  OR REPLACE VIEW `ullera_complet_vw` AS
    SELECT 
        `ull`.`Id_ulleres` AS `Id_ulleres`,
        `ull`.`id_color_muntura_ulleres` AS `id_color_muntura_ulleres`,        
        `ull`.`preu_ulleres` AS `preu_ulleres`,
        `mun`.`Id_muntures` AS `Id_muntures`,
        `mun`.`tipus_muntures` AS `tipus_muntures`,
        `marq`.`Id_marques` AS `Id_marques`,
        `marq`.`id_proveidor_marques` AS `id_proveidor_marques`,
        `marq`.`nom_marques` AS `nom_marques`,
		`prvd`.`Id_proveidors` AS `Id_proveidors`,
        `prvd`.`nom_proveidors` AS `nom_proveidors`,        
        COUNT(`proven`.`Id_productes_vendes`) AS `UNITATS VENUDES`,
        (COUNT(`proven`.`Id_productes_vendes`) * `ull`.`preu_ulleres`) AS `VENDES TOTALS EN €`,
        `ull`.`id_graduacions_ulleres` AS `id_graduacions_ulleres`
    FROM
        `s0201n1e1_culampolla`.`ulleres` `ull`
        LEFT JOIN `s0201n1e1_culampolla`.`muntures` `mun` ON `mun`.`Id_muntures` = `ull`.`id_muntures_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`marques` `marq` ON `marq`.`Id_marques` = `ull`.`Id_marques_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`color_muntura` `col` ON `col`.`Id_color_muntura` = `ull`.`id_color_muntura_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`productes_vendes` `proven` ON `proven`.`id_ullera_vendes` = `ull`.`Id_ulleres`
		LEFT JOIN `s0201n1e1_culampolla`.`proveidors` `prvd` ON `prvd`.`Id_proveidors` = `marq`.`id_proveidor_marques`
    GROUP BY `ull`.`Id_ulleres`;

-- -----------------------------------------------------
-- View `s0201n1e1_culampolla`.`proveidor_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`proveidor_complet_vw`;
DROP VIEW IF EXISTS `s0201n1e1_culampolla`.`proveidor_complet_vw` ;
USE `s0201n1e1_culampolla`;
-- MOSTRA TOTA LA INFO D'UN PROVEÏDOR
CREATE  OR REPLACE VIEW `proveidor_complet_vw` AS
    SELECT 
        `prov`.`Id_proveidors` AS `Id_proveidors`,
        `prov`.`nom_proveidors` AS `nom_proveidors`,
        `prov`.`telefon_proveidors` AS `telefon_proveidors`,
        `prov`.`fax_proveidors` AS `fax_proveidors`,
        `prov`.`nif_proveidors` AS `nif_proveidors`,
        `adr`.`Id_adreca` AS `Id_adreca`,
        `adr`.`carrer_adreca` AS `carrer_adreca`,
        `adr`.`numero_adreca` AS `numero_adreca`,
        `adr`.`pis_adreca` AS `pis_adreca`,
        `adr`.`porta_adreca` AS `porta_adreca`,
        `adr`.`codi_postal_adreca` AS `codi_postal_adreca`,
        `pais`.`Id_pais` AS `Id_pais`,
        `pais`.`nom_pais` AS `nom_pais`,
        `ciu`.`Id_ciutats` AS `Id_ciutats`,
        `ciu`.`nom_ciutats` AS `nom_ciutats`
    FROM
        `s0201n1e1_culampolla`.`proveidors` `prov`
        LEFT JOIN `s0201n1e1_culampolla`.`adreca` `adr` ON `adr`.`Id_adreca` = `prov`.`id_adreca_proveidors`
        LEFT JOIN `s0201n1e1_culampolla`.`pais` `pais` ON `pais`.`Id_pais` = `adr`.`id_pais_adreca`
        LEFT JOIN `s0201n1e1_culampolla`.`ciutats` `ciu` ON `ciu`.`Id_ciutats` = `adr`.`id_ciutat_adreca`
    GROUP BY `prov`.`Id_proveidors`
    ORDER BY `prov`.`nom_proveidors`;

-- -----------------------------------------------------
-- View `s0201n1e1_culampolla`.`client_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`client_complet_vw`;
DROP VIEW IF EXISTS `s0201n1e1_culampolla`.`client_complet_vw` ;
USE `s0201n1e1_culampolla`;
CREATE  OR REPLACE VIEW `client_complet_vw` AS
SELECT 
	`cli`.`Id_clients` AS `Id_clients`,
	`cli`.`id_client_recomanador_clients` AS `id_client_recomanador_clients`,
	`cli`.`nom_clients` AS `nom_clients`,
	`cli`.`telefon_clients` AS `telefon_clients`,
	`cli`.`email_clients` AS `email_clients`,
	`cli`.`data_registre_clients` AS `data_registre_clients`,
	`adr`.`Id_adreca` AS `Id_adreca`,
	`adr`.`carrer_adreca` AS `carrer_adreca`,
	`adr`.`numero_adreca` AS `numero_adreca`,
	`adr`.`pis_adreca` AS `pis_adreca`,
	`adr`.`porta_adreca` AS `porta_adreca`,
	`adr`.`codi_postal_adreca` AS `codi_postal_adreca`,
	`ps`.`Id_pais` AS `Id_pais`,
	`ps`.`nom_pais` AS `nom_pais`,
	`ciu`.`nom_ciutats` AS `nom_ciutats`,        
	COUNT(`vnds`.`Id_vendes`) AS `VENDES REALITZADES AL CLIENT`,
	`ciu`.`Id_ciutats` AS `Id_ciutats`
FROM `s0201n1e1_culampolla`.`clients` `cli`
	LEFT JOIN `s0201n1e1_culampolla`.`adreca` `adr` ON `adr`.`Id_adreca` = `cli`.`id_adreca_clients`
	LEFT JOIN `s0201n1e1_culampolla`.`pais` `ps` ON `ps`.`Id_pais` = `adr`.`id_pais_adreca`
	LEFT JOIN `s0201n1e1_culampolla`.`ciutats` `ciu` ON `ciu`.`Id_ciutats` = `adr`.`id_ciutat_adreca`
	LEFT JOIN `s0201n1e1_culampolla`.`vendes` `vnds` ON `vnds`.`id_clients_vendes` = `cli`.`Id_clients`
	LEFT JOIN `s0201n1e1_culampolla`.`productes_vendes` `proven` ON `proven`.`Id_productes_vendes` = `vnds`.`Id_vendes`
GROUP BY `cli`.`Id_clients`
ORDER BY `cli`.`nom_clients`;

-- -----------------------------------------------------
-- View `s0201n1e1_culampolla`.`estat_global_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `s0201n1e1_culampolla`.`estat_global_vw`;
DROP VIEW IF EXISTS `s0201n1e1_culampolla`.`estat_global_vw` ;
USE `s0201n1e1_culampolla`;
CREATE  OR REPLACE VIEW `estat_global_vw` AS
select
		(select count(*) from clients) AS 'Nº TOTAL DE CLIENTS',
        (select count(*) from ciutats) as 'Nº TOTAL DE CIUTATS',
        (select count(*) from pais) as 'Nº TOTAL DE PAISOS',
        (select count(*) from marques) as 'Nº TOTAL DE MARQUES',
        (select count(*) from ulleres) as 'NºTOTAL D\'ULLERES',
        (select count(*) from vendes) as 'Nº TOTAL DE VENDES',
        (select sum(ull.preu_ulleres) 
			from ulleres ull
			left join productes_vendes prvn on prvn.Id_productes_vendes = ull.Id_ulleres) 
            as '€ VENDES TOTALS';
		(select sum(*) from vendes);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`pais` (`Id_pais`, `nom_pais`) VALUES (1, 'pais 1');
INSERT INTO `s0201n1e1_culampolla`.`pais` (`Id_pais`, `nom_pais`) VALUES (2, 'pais 2');
INSERT INTO `s0201n1e1_culampolla`.`pais` (`Id_pais`, `nom_pais`) VALUES (3, 'pais 3');
INSERT INTO `s0201n1e1_culampolla`.`pais` (`Id_pais`, `nom_pais`) VALUES (4, 'pais 4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`ciutats`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (1, 1, 'ciutat 11');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (2, 1, 'ciutat 12');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (3, 1, 'ciutat 13');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (4, 2, 'ciutat 21');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (5, 2, 'ciutat 22');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (6, 2, 'ciutat 23');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (7, 3, 'ciutat 31');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (8, 3, 'ciutat 32');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (9, 3, 'ciutat 33');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (10, 4, 'ciutat 41');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (11, 4, 'ciutat 42');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (12, 4, 'ciutat 43');
INSERT INTO `s0201n1e1_culampolla`.`ciutats` (`Id_ciutats`, `id_pais_ciutats`, `nom_ciutats`) VALUES (13, 4, 'ciutat 44');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`adreca`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (1, 1, 1, 'carer 11 1', 1, '1', '1', 11111);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (2, 1, 2, 'carrer 12 2', 22, '2', '2', 22222);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (3, 1, 3, 'carrer 13 3', 33, '3', '3', 33333);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (4, 2, 4, 'carrer 21 1', 45, '10', '22', 44444);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (5, 2, 5, 'carrer 22 2', 76, '11', '4', 55555);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (7, 3, 7, 'carrer 31 1', 435, '8', '9', 55556);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (8, 3, 8, 'carrer 32 2', 34, '3', '3', 55557);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (9, 3, 9, 'carrer 33 3', 99, '9', '1', 55558);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (10, 4, 10, 'carrer 41 1', 10, '45', '10', 11112);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (11, 4, 11, 'carrer 42 2', 124, '2', '1', 11113);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (12, 4, 12, 'carrer 43 3', 3, '1', '1', 11114);
INSERT INTO `s0201n1e1_culampolla`.`adreca` (`Id_adreca`, `id_pais_adreca`, `id_ciutat_adreca`, `carrer_adreca`, `numero_adreca`, `pis_adreca`, `porta_adreca`, `codi_postal_adreca`) VALUES (6, 2, 6, 'carrer 23 3', 2, '5', '7', 55559);

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`proveidors`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`proveidors` (`Id_proveidors`, `id_adreca_proveidors`, `telefon_proveidors`, `fax_proveidors`, `nif_proveidors`, `nom_proveidors`) VALUES (1, 1, '666666660', '666666670', '44444440A', 'PROVEIDOR 1');
INSERT INTO `s0201n1e1_culampolla`.`proveidors` (`Id_proveidors`, `id_adreca_proveidors`, `telefon_proveidors`, `fax_proveidors`, `nif_proveidors`, `nom_proveidors`) VALUES (2, 2, '666666661', '666666671', '44444441B', 'PROVEIDOR 2');
INSERT INTO `s0201n1e1_culampolla`.`proveidors` (`Id_proveidors`, `id_adreca_proveidors`, `telefon_proveidors`, `fax_proveidors`, `nif_proveidors`, `nom_proveidors`) VALUES (3, 3, '666666662', '666666672', '44444442C', 'PROVEIDOR 3');
INSERT INTO `s0201n1e1_culampolla`.`proveidors` (`Id_proveidors`, `id_adreca_proveidors`, `telefon_proveidors`, `fax_proveidors`, `nif_proveidors`, `nom_proveidors`) VALUES (4, 4, '666666663', '666666673', '44444443C', 'PROVEIDOR 4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`color_muntura`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (1, 'Verd');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (2, 'Vermell');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (3, 'Groc');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (4, 'BLau');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (5, 'Blanc');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (6, 'Negre');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (7, 'Gris');
INSERT INTO `s0201n1e1_culampolla`.`color_muntura` (`Id_color_muntura`, `color_color_muntura`) VALUES (8, 'Blanc Perla');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`graduacions`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (1, 0.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (2, 0.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (3, 0.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (4, 0.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (5, 1.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (6, 1.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (7, 1.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (8, 1.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (9, 2.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (10, 2.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (11, 2.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (12, 2.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (13, 3.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (14, 3.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (15, 3.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (16, 3.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (17, 4.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (18, 4.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (19, 4.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (20, 4.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (21, 5.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (22, 5.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (23, 5.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (24, 5.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (25, 6.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (26, 6.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (27, 6.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (28, 6.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (29, 7.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (30, 7.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (31, 7.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (32, 7.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (33, 8.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (34, 8.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (35, 8.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (36, 8.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (37, 9.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (38, -0.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (39, -0.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (40, -0.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (41, -1.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (42, -1.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (43, -1.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (44, -1.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (45, -2.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (46, -2.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (47, -2.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (48, -2.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (49, -3.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (50, -3.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (51, -3.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (52, -3.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (53, -4.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (54, -4.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (55, -4.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (56, -4.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (57, -5.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (58, -5.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (59, -5.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (60, -5.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (61, -6.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (62, -6.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (63, -6.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (64, -6.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (65, -7.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (66, -7.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (67, -7.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (68, -7.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (69, -8.00);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (70, -8.25);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (71, -8.50);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (72, -8.75);
INSERT INTO `s0201n1e1_culampolla`.`graduacions` (`Id_graduacions`, `valor_graduacions`) VALUES (73, -9.00);

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`muntures`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`muntures` (`Id_muntures`, `tipus_muntures`) VALUES (1, 'Flotant');
INSERT INTO `s0201n1e1_culampolla`.`muntures` (`Id_muntures`, `tipus_muntures`) VALUES (2, 'Pasta');
INSERT INTO `s0201n1e1_culampolla`.`muntures` (`Id_muntures`, `tipus_muntures`) VALUES (3, 'Metàl·lica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`marques`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`marques` (`Id_marques`, `id_proveidor_marques`, `nom_marques`) VALUES (1, 1, 'marca 1');
INSERT INTO `s0201n1e1_culampolla`.`marques` (`Id_marques`, `id_proveidor_marques`, `nom_marques`) VALUES (2, 2, 'marca 2');
INSERT INTO `s0201n1e1_culampolla`.`marques` (`Id_marques`, `id_proveidor_marques`, `nom_marques`) VALUES (3, 3, 'marca 3');
INSERT INTO `s0201n1e1_culampolla`.`marques` (`Id_marques`, `id_proveidor_marques`, `nom_marques`) VALUES (4, 4, 'marca 4');
INSERT INTO `s0201n1e1_culampolla`.`marques` (`Id_marques`, `id_proveidor_marques`, `nom_marques`) VALUES (5, 1, 'marca 5');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`ulleres`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (1, 1, 1, 1, 1, 125);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (2, 1, 2, 2, 2, 126);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (3, 1, 3, 2, 1, 150);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (4, 2, 1, 7, 5, 140);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (5, 2, 2, 4, 10, 160);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (6, 2, 3, 3, 1, 190);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (7, 3, 1, 5, 6, 225);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (8, 3, 2, 6, 1, 230);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (9, 3, 3, 7, 2, 210);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (10, 4, 1, 1, 11, 90);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (11, 4, 2, 8, 20, 100);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (12, 4, 3, 7, 15, 95);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (13, 5, 1, 6, 11, 150);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (14, 5, 2, 6, 5, 140);
INSERT INTO `s0201n1e1_culampolla`.`ulleres` (`Id_ulleres`, `Id_marques_ulleres`, `id_muntures_ulleres`, `id_color_muntura_ulleres`, `id_graduacions_ulleres`, `preu_ulleres`) VALUES (15, 5, 3, 1, 6, 130);

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (1, 6, NULL, 'client 1', '666777700', 'client1@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (2, 7, 1, 'client 2', '666777701', 'client2@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (3, 8, NULL, 'client 3', '666777702', 'client3@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (4, 9, NULL, 'client 4', '666777703', 'client4@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (5, 10, 4, 'client 5', '666777704', 'client5@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (6, 11, NULL, 'client 6', '666777705', 'client6@itacademy.com', '2022-01-10 00:00:10');
INSERT INTO `s0201n1e1_culampolla`.`clients` (`Id_clients`, `id_adreca_clients`, `id_client_recomanador_clients`, `nom_clients`, `telefon_clients`, `email_clients`, `data_registre_clients`) VALUES (7, 12, 1, 'client 7', '666777706', 'client7@itacademy.com', '2022-01-10 00:00:10');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`empleats`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`empleats` (`Id_empleats`, `nom_empleats`, `cognom_empleats`) VALUES (1, 'empleat 1', 'cognom empleat 1');
INSERT INTO `s0201n1e1_culampolla`.`empleats` (`Id_empleats`, `nom_empleats`, `cognom_empleats`) VALUES (2, 'empleat 2', 'cognom empleat 2');
INSERT INTO `s0201n1e1_culampolla`.`empleats` (`Id_empleats`, `nom_empleats`, `cognom_empleats`) VALUES (3, 'empleat 3', 'cognom empleat 3');
INSERT INTO `s0201n1e1_culampolla`.`empleats` (`Id_empleats`, `nom_empleats`, `cognom_empleats`) VALUES (4, 'empleat 4', 'cognom empleat 4');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`vendes`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (1, 1, 1, '2022-01-01 00:00:11');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (2, 2, 2, '2022-01-01 00:00:12');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (3, 3, 3, '2022-01-01 00:00:13');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (4, 4, 4, '2022-01-01 00:00:14');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (5, 5, 1, '2022-01-01 00:00:15');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (6, 6, 2, '2022-01-01 00:00:16');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (7, 7, 3, '2022-01-01 00:01:17');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (8, 1, 4, '2022-01-01 00:00:18');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (9, 2, 1, '2022-01-01 00:00:19');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (10, 3, 2, '2022-01-01 00:00:20');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (11, 4, 3, '2022-01-01 00:00:21');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (12, 5, 4, '2022-01-01 00:00:22');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (13, 6, 1, '2022-01-01 00:00:23');
INSERT INTO `s0201n1e1_culampolla`.`vendes` (`Id_vendes`, `id_clients_vendes`, `id_empleats_vendes`, `data_venda_vendes`) VALUES (14, 7, 2, '2022-01-01 00:00:24');

COMMIT;


-- -----------------------------------------------------
-- Data for table `s0201n1e1_culampolla`.`productes_vendes`
-- -----------------------------------------------------
START TRANSACTION;
USE `s0201n1e1_culampolla`;
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (1, 1, 1, 1, '2022-10-01 00:00:11');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (2, 1, 2, 1, '2022-10-01 00:00:31');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (3, 2, 3, 1, '2022-10-01 00:00:33');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (4, 3, 4, 1, '2022-10-01 00:00:34');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (5, 4, 5, 1, '2022-10-01 00:00:35');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (6, 5, 6, 1, '2022-10-01 00:00:36');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (7, 6, 7, 1, '2022-10-01 00:00:37');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (8, 6, 8, 1, '2022-10-01 00:00:38');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (9, 7, 9, 1, '2022-10-01 00:00:39');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (10, 8, 10, 1, '2022-10-01 00:00:40');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (11, 8, 11, 1, '2022-10-01 00:00:42');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (12, 9, 12, 1, '2022-10-01 00:00:43');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (13, 9, 13, 1, '2022-10-01 00:00:44');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (14, 10, 14, 0, NULL);
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (15, 10, 15, 1, '2022-10-01 00:00:45');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (16, 10, 1, 1, '2022-10-01 00:00:46');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (17, 11, 2, 1, '2022-10-01 00:00:47');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (18, 12, 3, 1, '2022-10-01 00:00:48');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (19, 13, 4, 0, NULL);
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (20, 13, 5, 1, '2022-10-01 00:00:49');
INSERT INTO `s0201n1e1_culampolla`.`productes_vendes` (`Id_productes_vendes`, `id_vendes_productes_vendes`, `id_ullera_vendes`, `entregat_productes_vendes`, `data_entregat_productes_vendes`) VALUES (21, 14, 6, 1, '2022-10-01 00:00:50');

COMMIT;

