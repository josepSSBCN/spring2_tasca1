-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema CulAmpolla
-- -----------------------------------------------------
-- S2_01_N1_E1

-- -----------------------------------------------------
-- Schema CulAmpolla
--
-- S2_01_N1_E1
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CulAmpolla` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ;
-- -----------------------------------------------------
-- Schema culampolla
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema culampolla
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `culampolla` ;
USE `CulAmpolla` ;

-- -----------------------------------------------------
-- Table `CulAmpolla`.`Adreca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Adreca` (
  `Id_Adreça` INT NOT NULL AUTO_INCREMENT,
  `Carrer_Adreca` VARCHAR(45) NULL,
  `Numero_Adreca` SMALLINT(4) NULL,
  `Pis_Adreca` VARCHAR(45) NULL,
  `Porta_Adreca` VARCHAR(2) NULL,
  `Ciutat_Adreca` VARCHAR(45) NULL,
  `CoidPostal_Adreca` SMALLINT(5) NULL,
  `Pais_Adreca` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Adreça`),
  UNIQUE INDEX `Id_Adreça_UNIQUE` (`Id_Adreça` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Proveidors` (
  `Id_Proveidors` INT NOT NULL AUTO_INCREMENT,
  `Adreça_Id_Adreca` INT NOT NULL,
  `Telefon_Proveidors` VARCHAR(45) NULL,
  `Fax_Proveidors` VARCHAR(45) NULL,
  `NIF_Proveidors` VARCHAR(9) NULL COMMENT 'Format del NIF sense guió, sols els números i les lletres.\n11111111A\n',
  PRIMARY KEY (`Id_Proveidors`),
  UNIQUE INDEX `NIF_Proveidors_UNIQUE` (`NIF_Proveidors` ASC) VISIBLE,
  INDEX `fk_Proveidors_Adreça_idx` (`Adreça_Id_Adreca` ASC) VISIBLE,
  UNIQUE INDEX `Id_Proveidors_UNIQUE` (`Id_Proveidors` ASC) VISIBLE,
  CONSTRAINT `fk_Proveidors_Adreça`
    FOREIGN KEY (`Adreça_Id_Adreca`)
    REFERENCES `CulAmpolla`.`Adreca` (`Id_Adreça`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Muntura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Muntura` (
  `Id_Muntura` TINYINT(1) NOT NULL AUTO_INCREMENT,
  `Tipus_Muntura` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Muntura`),
  UNIQUE INDEX `Tipus_Muntura_UNIQUE` (`Tipus_Muntura` ASC) VISIBLE,
  UNIQUE INDEX `Id_Muntura_UNIQUE` (`Id_Muntura` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`ColorMuntura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`ColorMuntura` (
  `Id_ColorMuntura` SMALLINT(3) NOT NULL AUTO_INCREMENT,
  `Color_ColorMuntura` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_ColorMuntura`),
  UNIQUE INDEX `Id_ColorMuntura_UNIQUE` (`Id_ColorMuntura` ASC) VISIBLE,
  UNIQUE INDEX `Color_ColorMuntura_UNIQUE` (`Color_ColorMuntura` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Marques` (
  `Id_Marques` SMALLINT(4) NOT NULL COMMENT 'Més de 9.999 marques diferents, no crec que arribi',
  `Nom_Marques` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_Marques`),
  UNIQUE INDEX `Id_Marques_UNIQUE` (`Id_Marques` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Marques_UNIQUE` (`Nom_Marques` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Graduacio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Graduacio` (
  `Id_Graduacio` TINYINT(2) NOT NULL,
  `Valor_Graduacio` FLOAT(5) NOT NULL,
  PRIMARY KEY (`Id_Graduacio`),
  UNIQUE INDEX `Id_Graduacio_UNIQUE` (`Id_Graduacio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Ullera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Ullera` (
  `Id_Ullera` INT NOT NULL AUTO_INCREMENT,
  `Muntura_Id_Muntura` TINYINT(1) NOT NULL,
  `ColorMuntur_Id_ColorMuntura` SMALLINT(3) NOT NULL,
  `Marques_Id_Marques` SMALLINT(4) NOT NULL,
  `Graduacio_Ullera` TINYINT(2) NOT NULL,
  `Preu_Ullera` FLOAT(6) NOT NULL COMMENT 'Preus de més de 9999,99€ no crec que hi hagi',
  PRIMARY KEY (`Id_Ullera`),
  UNIQUE INDEX `Id_Ullera_UNIQUE` (`Id_Ullera` ASC) VISIBLE,
  INDEX `fk_Ullera_Muntura1_idx` (`Muntura_Id_Muntura` ASC) VISIBLE,
  INDEX `fk_Ullera_ColorMuntura_idx` (`ColorMuntur_Id_ColorMuntura` ASC) VISIBLE,
  INDEX `fk_Ulleres_Graduacio_idx` (`Graduacio_Ullera` ASC) VISIBLE,
  INDEX `fk_Ulleres_Marques_idx` (`Marques_Id_Marques` ASC) VISIBLE,
  CONSTRAINT `fk_Ullera_Muntura1`
    FOREIGN KEY (`Muntura_Id_Muntura`)
    REFERENCES `CulAmpolla`.`Muntura` (`Id_Muntura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ullera_ColorMuntura`
    FOREIGN KEY (`ColorMuntur_Id_ColorMuntura`)
    REFERENCES `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Marques`
    FOREIGN KEY (`Marques_Id_Marques`)
    REFERENCES `CulAmpolla`.`Marques` (`Id_Marques`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Graduacio`
    FOREIGN KEY (`Graduacio_Ullera`)
    REFERENCES `CulAmpolla`.`Graduacio` (`Id_Graduacio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Empleats` (
  `Id_Empleats` SMALLINT(3) NOT NULL COMMENT 'Suposo que més de 999 empleats no hi harribarà',
  `Nom_Empleats` VARCHAR(45) NOT NULL,
  `Cognom_Empleats` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Empleats`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `CulAmpolla`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CulAmpolla`.`Clients` (
  `Id_Clients` INT NOT NULL AUTO_INCREMENT,
  `Adreca_Id_Adreça` INT NOT NULL,
  `Empleats_Id_Empleats` SMALLINT(3) NOT NULL,
  `ClientRecomanador_Clients` INT NOT NULL COMMENT 'El ID del client que ha recomanat l\'optica',
  `Telefon_Clients` VARCHAR(45) NOT NULL,
  `Email_Clients` VARCHAR(45) NOT NULL,
  `DataRegistre_Clients` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Clients`),
  UNIQUE INDEX `Id_Clients_UNIQUE` (`Id_Clients` ASC) VISIBLE,
  INDEX `fk_Clients_Adreca1_idx` (`Adreca_Id_Adreça` ASC) VISIBLE,
  INDEX `fk_Clients_Empleats_idx` (`Empleats_Id_Empleats` ASC) VISIBLE,
  INDEX `fk_Clients_Clients_idx` (`ClientRecomanador_Clients` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Adreca1`
    FOREIGN KEY (`Adreca_Id_Adreça`)
    REFERENCES `CulAmpolla`.`Adreca` (`Id_Adreça`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clients_Empleats`
    FOREIGN KEY (`Empleats_Id_Empleats`)
    REFERENCES `CulAmpolla`.`Empleats` (`Id_Empleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clients_Clients`
    FOREIGN KEY (`ClientRecomanador_Clients`)
    REFERENCES `CulAmpolla`.`Clients` (`Id_Clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `culampolla` ;

-- -----------------------------------------------------
-- Table `culampolla`.`adreca`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`adreca` (
  `Id_Adreça` INT NOT NULL AUTO_INCREMENT,
  `Carrer_Adreca` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `Numero_Adreca` SMALLINT NULL DEFAULT NULL,
  `Pis_Adreca` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `Porta_Adreca` VARCHAR(2) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `Ciutat_Adreca` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `CoidPostal_Adreca` SMALLINT NULL DEFAULT NULL,
  `Pais_Adreca` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Adreça`),
  UNIQUE INDEX `Id_Adreça_UNIQUE` (`Id_Adreça` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`empleats` (
  `Id_Empleats` SMALLINT NOT NULL COMMENT 'Suposo que més de 999 empleats no hi harribarà',
  `Nom_Empleats` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `Cognom_Empleats` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  PRIMARY KEY (`Id_Empleats`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`clients` (
  `Id_Clients` INT NOT NULL AUTO_INCREMENT,
  `Adreca_Id_Adreça` INT NOT NULL,
  `Empleats_Id_Empleats` SMALLINT NOT NULL,
  `ClientRecomanador_Clients` INT NOT NULL COMMENT 'El ID del client que ha recomanat l\'optica',
  `Telefon_Clients` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `Email_Clients` VARCHAR(45) COLLATE 'utf8mb3_bin' NOT NULL,
  `DataRegistre_Clients` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_Clients`),
  UNIQUE INDEX `Id_Clients_UNIQUE` (`Id_Clients` ASC) VISIBLE,
  INDEX `fk_Clients_Adreca1_idx` (`Adreca_Id_Adreça` ASC) VISIBLE,
  INDEX `fk_Clients_Empleats_idx` (`Empleats_Id_Empleats` ASC) VISIBLE,
  INDEX `fk_Clients_Clients_idx` (`ClientRecomanador_Clients` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Adreca1`
    FOREIGN KEY (`Adreca_Id_Adreça`)
    REFERENCES `culampolla`.`adreca` (`Id_Adreça`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clients_Clients`
    FOREIGN KEY (`ClientRecomanador_Clients`)
    REFERENCES `culampolla`.`clients` (`Id_Clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Clients_Empleats`
    FOREIGN KEY (`Empleats_Id_Empleats`)
    REFERENCES `culampolla`.`empleats` (`Id_Empleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`colormuntura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`colormuntura` (
  `Id_ColorMuntura` SMALLINT NOT NULL AUTO_INCREMENT,
  `Color_ColorMuntura` VARCHAR(20) COLLATE 'utf8mb3_bin' NOT NULL,
  PRIMARY KEY (`Id_ColorMuntura`),
  UNIQUE INDEX `Id_ColorMuntura_UNIQUE` (`Id_ColorMuntura` ASC) VISIBLE,
  UNIQUE INDEX `Color_ColorMuntura_UNIQUE` (`Color_ColorMuntura` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`graduacio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`graduacio` (
  `Id_Graduacio` TINYINT NOT NULL,
  `Valor_Graduacio` FLOAT NOT NULL,
  PRIMARY KEY (`Id_Graduacio`),
  UNIQUE INDEX `Id_Graduacio_UNIQUE` (`Id_Graduacio` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`marques`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`marques` (
  `Id_Marques` SMALLINT NOT NULL COMMENT 'Més de 9.999 marques diferents, no crec que arribi',
  `Nom_Marques` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  PRIMARY KEY (`Id_Marques`),
  UNIQUE INDEX `Id_Marques_UNIQUE` (`Id_Marques` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Marques_UNIQUE` (`Nom_Marques` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`muntura`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`muntura` (
  `Id_Muntura` TINYINT(1) NOT NULL AUTO_INCREMENT,
  `Tipus_Muntura` VARCHAR(20) COLLATE 'utf8mb3_bin' NOT NULL,
  PRIMARY KEY (`Id_Muntura`),
  UNIQUE INDEX `Tipus_Muntura_UNIQUE` (`Tipus_Muntura` ASC) VISIBLE,
  UNIQUE INDEX `Id_Muntura_UNIQUE` (`Id_Muntura` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`proveidors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`proveidors` (
  `Id_Proveidors` INT NOT NULL AUTO_INCREMENT,
  `Adreça_Id_Adreca` INT NOT NULL,
  `Telefon_Proveidors` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `Fax_Proveidors` VARCHAR(45) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL,
  `NIF_Proveidors` VARCHAR(9) COLLATE 'utf8mb3_bin' NULL DEFAULT NULL COMMENT 'Format del NIF sense guió, sols els números i les lletres.\\n11111111A\\n',
  PRIMARY KEY (`Id_Proveidors`),
  UNIQUE INDEX `Id_Proveidors_UNIQUE` (`Id_Proveidors` ASC) VISIBLE,
  UNIQUE INDEX `NIF_Proveidors_UNIQUE` (`NIF_Proveidors` ASC) VISIBLE,
  INDEX `fk_Proveidors_Adreça_idx` (`Adreça_Id_Adreca` ASC) VISIBLE,
  CONSTRAINT `fk_Proveidors_Adreça`
    FOREIGN KEY (`Adreça_Id_Adreca`)
    REFERENCES `culampolla`.`adreca` (`Id_Adreça`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `culampolla`.`ullera`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `culampolla`.`ullera` (
  `Id_Ullera` INT NOT NULL AUTO_INCREMENT,
  `Muntura_Id_Muntura` TINYINT(1) NOT NULL,
  `ColorMuntur_Id_ColorMuntura` SMALLINT NOT NULL,
  `Marques_Id_Marques` SMALLINT NOT NULL,
  `Graduacio_Ullera` TINYINT NOT NULL,
  `Preu_Ullera` FLOAT NOT NULL COMMENT 'Preus de més de 9999,99€ no crec que hi hagi',
  PRIMARY KEY (`Id_Ullera`),
  UNIQUE INDEX `Id_Ullera_UNIQUE` (`Id_Ullera` ASC) VISIBLE,
  INDEX `fk_Ullera_Muntura1_idx` (`Muntura_Id_Muntura` ASC) VISIBLE,
  INDEX `fk_Ullera_ColorMuntura_idx` (`ColorMuntur_Id_ColorMuntura` ASC) VISIBLE,
  INDEX `fk_Ulleres_Graduacio_idx` (`Graduacio_Ullera` ASC) VISIBLE,
  INDEX `fk_Ulleres_Marques_idx` (`Marques_Id_Marques` ASC) VISIBLE,
  CONSTRAINT `fk_Ullera_ColorMuntura`
    FOREIGN KEY (`ColorMuntur_Id_ColorMuntura`)
    REFERENCES `culampolla`.`colormuntura` (`Id_ColorMuntura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ullera_Muntura1`
    FOREIGN KEY (`Muntura_Id_Muntura`)
    REFERENCES `culampolla`.`muntura` (`Id_Muntura`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Graduacio`
    FOREIGN KEY (`Graduacio_Ullera`)
    REFERENCES `culampolla`.`graduacio` (`Id_Graduacio`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ulleres_Marques`
    FOREIGN KEY (`Marques_Id_Marques`)
    REFERENCES `culampolla`.`marques` (`Id_Marques`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `CulAmpolla`.`Muntura`
-- -----------------------------------------------------
START TRANSACTION;
USE `CulAmpolla`;
INSERT INTO `CulAmpolla`.`Muntura` (`Id_Muntura`, `Tipus_Muntura`) VALUES (1, 'Flotant');
INSERT INTO `CulAmpolla`.`Muntura` (`Id_Muntura`, `Tipus_Muntura`) VALUES (2, 'Pasta');
INSERT INTO `CulAmpolla`.`Muntura` (`Id_Muntura`, `Tipus_Muntura`) VALUES (3, 'Metàl·lica');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CulAmpolla`.`ColorMuntura`
-- -----------------------------------------------------
START TRANSACTION;
USE `CulAmpolla`;
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (1, 'Verd');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (2, 'Vermell');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (3, 'Groc');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (4, 'BLau');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (5, 'Blanc');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (6, 'Negre');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (7, 'Gris');
INSERT INTO `CulAmpolla`.`ColorMuntura` (`Id_ColorMuntura`, `Color_ColorMuntura`) VALUES (8, 'Blanc Perla');

COMMIT;


-- -----------------------------------------------------
-- Data for table `CulAmpolla`.`Graduacio`
-- -----------------------------------------------------
START TRANSACTION;
USE `CulAmpolla`;
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (1, 0.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (2, 0.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (3, 0.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (4, 0.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (5, 1.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (6, 1.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (7, 1.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (8, 1.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (9, 2.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (10, 2.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (11, 2.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (12, 2.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (13, 3.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (14, 3.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (15, 3.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (16, 3.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (17, 4.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (18, 4.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (19, 4.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (20, 4.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (21, 5.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (22, 5.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (23, 5.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (24, 5.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (25, 6.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (26, 6.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (27, 6.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (28, 6.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (29, 7.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (30, 7.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (31, 7.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (32, 7.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (33, 8.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (34, 8.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (35, 8.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (36, 8.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (37, 9.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (38, -0.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (39, -0.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (40, -0.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (41, -1.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (42, -1.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (43, -1.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (44, -1.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (45, -2.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (46, -2.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (47, -2.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (48, -2.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (49, -3.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (50, -3.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (51, -3.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (52, -3.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (53, -4.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (54, -4.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (55, -4.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (56, -4.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (57, -5.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (58, -5.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (59, -5.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (60, -5.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (61, -6.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (62, -6.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (63, -6.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (64, -6.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (65, -7.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (66, -7.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (67, -7.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (68, -7.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (69, -8.00);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (70, -8.25);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (71, -8.50);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (72, -8.75);
INSERT INTO `CulAmpolla`.`Graduacio` (`Id_Graduacio`, `Valor_Graduacio`) VALUES (73, -9.00);

COMMIT;

