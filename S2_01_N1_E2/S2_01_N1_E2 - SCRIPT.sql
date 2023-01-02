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
-- Table `S201N1E2_PIZZERIA`.`Provincia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Provincia` (
  `Id_Provincia` TINYINT(2) UNSIGNED NOT NULL,
  `Nom_Provincia` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_Provincia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Localitat`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Localitat` (
  `Id_Localitat` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Suposo que la pizzeria està Espanya, a Espanya no arriben a 9.000 polbacions',
  `idProvincia_Localitat` TINYINT(2) UNSIGNED NOT NULL,
  `Nom_Localitat` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Localitat`),
  UNIQUE INDEX `Id_Localitat_UNIQUE` (`Id_Localitat` ASC) VISIBLE,
  INDEX `fk_Localitat_Provincia1_idx` (`idProvincia_Localitat` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Localitat_UNIQUE` (`Nom_Localitat` ASC) VISIBLE,
  CONSTRAINT `fk_Localitat_Provincia1`
    FOREIGN KEY (`idProvincia_Localitat`)
    REFERENCES `S201N1E2_PIZZERIA`.`Provincia` (`Id_Provincia`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Clients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Clients` (
  `Id_Clients` MEDIUMINT(8) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Si arriba a 16M de clients, podrà pagar una actualització del software',
  `idLocalitat_Clients` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Si arriba a tenir més de 16M de clients, podrà pagar una petita actualització del software.',
  `Nom_Clients` VARCHAR(30) NOT NULL,
  `Cognoms_Clients` VARCHAR(60) NOT NULL,
  `Adreca_Clients` VARCHAR(45) NOT NULL,
  `CodiPostal_Clients` SMALLINT(5) UNSIGNED NOT NULL,
  `NumeroTelefon_Clients` VARCHAR(13) NOT NULL COMMENT 'Format màxim 0034666666666',
  PRIMARY KEY (`Id_Clients`),
  UNIQUE INDEX `Nom_Clients_UNIQUE` (`Nom_Clients` ASC) VISIBLE,
  INDEX `fk_Clients_Localitat_idx` (`idLocalitat_Clients` ASC) VISIBLE,
  UNIQUE INDEX `Id_Clients_UNIQUE` (`Id_Clients` ASC) VISIBLE,
  CONSTRAINT `fk_Clients_Localitat`
    FOREIGN KEY (`idLocalitat_Clients`)
    REFERENCES `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Botigues`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Botigues` (
  `Id_Botigues` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Si arriba a tenir 255 botigues, podrà pagar una actualització del software',
  `idLocalitat_Botigues` SMALLINT(4) UNSIGNED NOT NULL,
  `CodiPostal_Botigues` SMALLINT(4) UNSIGNED NOT NULL,
  `Adreça_Botigues` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_Botigues`),
  UNIQUE INDEX `Id_Botigues_UNIQUE` (`Id_Botigues` ASC) VISIBLE,
  INDEX `fk_Botigues_Localitats_idx` (`idLocalitat_Botigues` ASC) VISIBLE,
  CONSTRAINT `fk_Botigues_Localitats`
    FOREIGN KEY (`idLocalitat_Botigues`)
    REFERENCES `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Comandes` (
  `Id_Comandes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idClients_Comandes` MEDIUMINT(8) UNSIGNED NOT NULL,
  `idBotiga_Comandes` TINYINT(3) UNSIGNED NOT NULL COMMENT 'Si arriba a tenir 255 botigues, podrà pagar una actualització del software',
  `DataHora_Comandes` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RecDom_Comandes` BIT(1) NOT NULL COMMENT '0 = Recollir en botiga\n1 = Domicili\n',
  `QuantitatPizzes_Comandes` TINYINT(2) UNSIGNED NOT NULL,
  `QuantitatHamburgueses_Comandes` TINYINT(2) UNSIGNED NOT NULL COMMENT 'El nº màxim de pizzes en una comanda serand e 99',
  `QuantitatBegudes_Comandes` TINYINT(2) UNSIGNED NOT NULL,
  `PreuTotal_Comandes` SMALLINT(4) UNSIGNED NOT NULL COMMENT 'Si el preu d\'una pizza pot ser de p.exemple 25€ i dic que el màxim de pizzes en una comanda son 99 això fan un preu màxim de 2.475€',
  PRIMARY KEY (`Id_Comandes`),
  INDEX `fk_Comandes_Clients_idx` (`idClients_Comandes` ASC) VISIBLE,
  INDEX `fk_Comandes_Botigues_idx` (`idBotiga_Comandes` ASC) VISIBLE,
  CONSTRAINT `fk_Comandes_Clients`
    FOREIGN KEY (`idClients_Comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`Clients` (`Id_Clients`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Comandes_Botigues`
    FOREIGN KEY (`idBotiga_Comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Categories` (
  `Id_Categories` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `Nom_Categories` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_Categories`),
  UNIQUE INDEX `Id_Categories_UNIQUE` (`Id_Categories` ASC) VISIBLE,
  UNIQUE INDEX `Nom_Categories_UNIQUE` (`Nom_Categories` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Productes` (
  `Id_Productes` SMALLINT(4) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idCategories_Productes` SMALLINT(4) UNSIGNED NOT NULL,
  `Nom_Productes` VARCHAR(45) NOT NULL,
  `Descripcio_Productes` VARCHAR(256) NULL,
  `Imatge_Productes` VARCHAR(25) NULL COMMENT 'S\'ha de posar el nom de la imatge, amb l\'extensió.',
  `Preu_Productes` TINYINT(2) NOT NULL,
  PRIMARY KEY (`Id_Productes`),
  UNIQUE INDEX `Nom_Productes_UNIQUE` (`Nom_Productes` ASC) VISIBLE,
  INDEX `fk_Productes_Categories_idx` (`idCategories_Productes` ASC) VISIBLE,
  UNIQUE INDEX `Id_Productes_UNIQUE` (`Id_Productes` ASC) VISIBLE,
  CONSTRAINT `fk_Productes_Categories`
    FOREIGN KEY (`idCategories_Productes`)
    REFERENCES `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Productes_De_Comandes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (
  `idComandes_Productes_De_Comandes` INT UNSIGNED NOT NULL,
  `idProductes_Productes_De_Comandes` SMALLINT(4) UNSIGNED NOT NULL,
  `Quantitat_Productes_De_Comandes` TINYINT(2) UNSIGNED NOT NULL,
  PRIMARY KEY (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`),
  INDEX `fk_Productes_De_Comandes_Productes1_idx` (`idProductes_Productes_De_Comandes` ASC) VISIBLE,
  CONSTRAINT `fk_ProductesComanda_Comandes`
    FOREIGN KEY (`idComandes_Productes_De_Comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Productes_De_Comandes_Productes1`
    FOREIGN KEY (`idProductes_Productes_De_Comandes`)
    REFERENCES `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`LlocFeina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`LlocFeina` (
  `Id_LlocFeina` BIT(1) NOT NULL,
  `Nom_LlocFeina` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`Id_LlocFeina`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`Empleats`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`Empleats` (
  `Id_Empleats` SMALLINT(5) UNSIGNED NOT NULL AUTO_INCREMENT,
  `idBotiga_Empleats` TINYINT(3) UNSIGNED NOT NULL,
  `idLlocFeina_Empleats` BIT(1) NOT NULL COMMENT '0 = Cuiner/a\n1 = Repartidor/a\n',
  `Nom_Empleats` VARCHAR(30) NOT NULL,
  `Cognoms_Empleats` VARCHAR(60) NOT NULL,
  `NIF_Empleats` VARCHAR(9) NOT NULL,
  `Telefon_Empleats` VARCHAR(13) NOT NULL,
  PRIMARY KEY (`Id_Empleats`),
  INDEX `fk_Empleat_LlocFeina_idx` (`idLlocFeina_Empleats` ASC) VISIBLE,
  INDEX `fk_Empleats_Botiga_idx` (`idBotiga_Empleats` ASC) VISIBLE,
  CONSTRAINT `fk_Empleat_LlocFeina`
    FOREIGN KEY (`idLlocFeina_Empleats`)
    REFERENCES `S201N1E2_PIZZERIA`.`LlocFeina` (`Id_LlocFeina`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Empleats_Botiga`
    FOREIGN KEY (`idBotiga_Empleats`)
    REFERENCES `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N1E2_PIZZERIA`.`EntreguesDomicili`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`EntreguesDomicili` (
  `Comanda_Id_Comanda` INT UNSIGNED NOT NULL,
  `Empleat_Id_Empleat` SMALLINT(5) UNSIGNED NOT NULL,
  `Lluirament_EntreguesDomicili` DATETIME NOT NULL,
  PRIMARY KEY (`Comanda_Id_Comanda`, `Empleat_Id_Empleat`),
  INDEX `fk_EntregaDomicili_Comanda_idx` (`Comanda_Id_Comanda` ASC) VISIBLE,
  INDEX `fk_EntregaDomicili_Empleat_idx` (`Empleat_Id_Empleat` ASC) VISIBLE,
  CONSTRAINT `fk_EntregaDomicili_Comanda`
    FOREIGN KEY (`Comanda_Id_Comanda`)
    REFERENCES `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_EntregaDomicili_Empleat`
    FOREIGN KEY (`Empleat_Id_Empleat`)
    REFERENCES `S201N1E2_PIZZERIA`.`Empleats` (`Id_Empleats`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `S201N1E2_PIZZERIA` ;

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`botiga_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`botiga_complet_vw` (`Id_Botigues` INT, `CodiPostal_Botigues` INT, `Adreça_Botigues` INT, `Id_Localitat` INT, `Nom_Localitat` INT, `Id_Provincia` INT, `Nom_Provincia` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`comanda_info_complet_vw` (`Id_Comandes` INT, `DataHora_Comandes` INT, `RecDom_Comandes` INT, `QuantitatPizzes_Comandes` INT, `QuantitatHamburgueses_Comandes` INT, `QuantitatBegudes_Comandes` INT, `PreuTotal_Comandes` INT, `Id_Clients` INT, `Nom_Clients` INT, `Cognoms_Clients` INT, `Adreca_Clients` INT, `CodiPostal_Clients` INT, `NumeroTelefon_Clients` INT, `Id_Localitat` INT, `Nom_Localitat` INT, `Id_Provincia` INT, `Nom_Provincia` INT, `Lluirament_EntreguesDomicili` INT, `Id_Empleats` INT, `Nom_Empleats` INT, `Cognoms_Empleats` INT, `NIF_Empleats` INT, `Telefon_Empleats` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`client_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`client_complet_vw` (`Id_Clients` INT, `Nom_Clients` INT, `Cognoms_Clients` INT, `Adreca_Clients` INT, `CodiPostal_Clients` INT, `NumeroTelefon_Clients` INT, `Id_Localitat` INT, `Nom_Localitat` INT, `Id_Provincia` INT, `Nom_Provincia` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N1E2_PIZZERIA`.`comanda_llista_productes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N1E2_PIZZERIA`.`comanda_llista_productes` (`Id_Comandes` INT, `Quantitat_Productes_De_Comandes` INT, `DataHora_Comandes` INT, `QuantitatPizzes_Comandes` INT, `QuantitatHamburgueses_Comandes` INT, `QuantitatBegudes_Comandes` INT, `PreuTotal_Comandes` INT, `Id_Productes` INT, `Nom_Productes` INT, `Descripcio_Productes` INT, `Imatge_Productes` INT, `Preu_Productes` INT, `Id_Categories` INT, `Nom_Categories` INT);

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`botiga_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`botiga_complet_vw`;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `botiga_complet_vw` AS
SELECT  
`bot`.`Id_Botigues` AS `Id_Botigues`,
`bot`.`CodiPostal_Botigues` AS `CodiPostal_Botigues`,
`bot`.`Adreça_Botigues` AS `Adreça_Botigues`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia`
FROM `botigues` AS `bot`
RIGHT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_Localitat` = `bot`.`idLocalitat_Botigues`
RIGHT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
GROUP BY `s201n1e2_pizzeria`.`bot`.`Id_Botigues`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`comanda_info_complet_vw`;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `comanda_info_complet_vw` AS 
SELECT `cmd`.`Id_Comandes` AS `Id_Comandes`,
`cmd`.`DataHora_Comandes` AS `DataHora_Comandes`,
`cmd`.`RecDom_Comandes` AS `RecDom_Comandes`,
`cmd`.`QuantitatPizzes_Comandes` AS `QuantitatPizzes_Comandes`,
`cmd`.`QuantitatHamburgueses_Comandes` AS `QuantitatHamburgueses_Comandes`,
`cmd`.`QuantitatBegudes_Comandes` AS `QuantitatBegudes_Comandes`,
`cmd`.`PreuTotal_Comandes` AS `PreuTotal_Comandes`,
`cli`.`Id_Clients` AS `Id_Clients`,
`cli`.`Nom_Clients` AS `Nom_Clients`,
`cli`.`Cognoms_Clients` AS `Cognoms_Clients`,
`cli`.`Adreca_Clients` AS `Adreca_Clients`,
`cli`.`CodiPostal_Clients` AS `CodiPostal_Clients`,
`cli`.`NumeroTelefon_Clients` AS `NumeroTelefon_Clients`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia`,
`endo`.`Lluirament_EntreguesDomicili` AS `Lluirament_EntreguesDomicili`,
`empl`.`Id_Empleats` AS `Id_Empleats`,
`empl`.`Nom_Empleats` AS `Nom_Empleats`,
`empl`.`Cognoms_Empleats` AS `Cognoms_Empleats`,
`empl`.`NIF_Empleats` AS `NIF_Empleats`,
`empl`.`Telefon_Empleats` AS `Telefon_Empleats`
FROM `Comandes` `cmd`
LEFT JOIN `Clients` `cli` ON `cli`.`Id_Clients` = `cmd`.`idClients_Comandes`
LEFT JOIN `Localitat` `loc` ON `loc`.`Id_Localitat` = `cli`.`idLocalitat_Clients`
LEFT JOIN `Provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
LEFT JOIN `EntreguesDomicili` `endo` ON `endo`.`Comanda_Id_Comanda` = `cmd`.`Id_Comandes`
LEFT JOIN `Empleats` `empl` ON `empl`.`Id_Empleats` = `endo`.`Empleat_Id_Empleat`
GROUP BY `cmd`.`Id_Comandes`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`client_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`client_complet_vw`;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `client_complet_vw` AS
SELECT `cli`.`Id_Clients` AS `Id_Clients`,
`cli`.`Nom_Clients` AS `Nom_Clients`,
`cli`.`Cognoms_Clients` AS `Cognoms_Clients`,
`cli`.`Adreca_Clients` AS `Adreca_Clients`,
`cli`.`CodiPostal_Clients` AS `CodiPostal_Clients`,
`cli`.`NumeroTelefon_Clients` AS `NumeroTelefon_Clients`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia` 
FROM `s201n1e2_pizzeria`.`Clients` `cli`
LEFT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_Localitat` = `cli`.`idLocalitat_Clients`
LEFT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
GROUP BY `cli`.`Id_Clients`;

-- -----------------------------------------------------
-- View `S201N1E2_PIZZERIA`.`comanda_llista_productes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N1E2_PIZZERIA`.`comanda_llista_productes`;
USE `S201N1E2_PIZZERIA`;
CREATE  OR REPLACE VIEW `comanda_llista_productes` AS
SELECT 
`cmd`.`Id_Comandes` AS `Id_Comandes`,
`procom`.`Quantitat_Productes_De_Comandes` AS `Quantitat_Productes_De_Comandes`,
`cmd`.`DataHora_Comandes` AS `DataHora_Comandes`,
`cmd`.`QuantitatPizzes_Comandes` AS `QuantitatPizzes_Comandes`,
`cmd`.`QuantitatHamburgueses_Comandes` AS `QuantitatHamburgueses_Comandes`,
`cmd`.`QuantitatBegudes_Comandes` AS `QuantitatBegudes_Comandes`,
`cmd`.`PreuTotal_Comandes` AS `PreuTotal_Comandes`,
`pro`.`Id_Productes` AS `Id_Productes`,
`pro`.`Nom_Productes` AS `Nom_Productes`,
`pro`.`Descripcio_Productes` AS `Descripcio_Productes`,
`pro`.`Imatge_Productes` AS `Imatge_Productes`,
`pro`.`Preu_Productes` AS `Preu_Productes`,
`cat`.`Id_Categories` AS `Id_Categories`,
`cat`.`Nom_Categories` AS `Nom_Categories` 
FROM `s201n1e2_pizzeria`.`productes_de_comandes` `procom`
LEFT JOIN `comandes` `cmd` ON  `cmd`.`Id_Comandes` = `procom`.`idComandes_Productes_De_Comandes`
LEFT JOIN `productes` `pro` ON `pro`.`Id_Productes` = `procom`.`idProductes_Productes_De_Comandes`
LEFT JOIN `categories` `cat` ON `cat`.`Id_Categories` = `pro`.`idCategories_Productes`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Provincia`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Provincia` (`Id_Provincia`, `Nom_Provincia`) VALUES (0, 'Barcelona');
INSERT INTO `S201N1E2_PIZZERIA`.`Provincia` (`Id_Provincia`, `Nom_Provincia`) VALUES (1, 'Girona');
INSERT INTO `S201N1E2_PIZZERIA`.`Provincia` (`Id_Provincia`, `Nom_Provincia`) VALUES (2, 'Lleida');
INSERT INTO `S201N1E2_PIZZERIA`.`Provincia` (`Id_Provincia`, `Nom_Provincia`) VALUES (3, 'Tarragona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Localitat`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`, `idProvincia_Localitat`, `Nom_Localitat`) VALUES (1, 0, 'Sabadell');
INSERT INTO `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`, `idProvincia_Localitat`, `Nom_Localitat`) VALUES (2, 3, 'Mora d\'Ebra');
INSERT INTO `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`, `idProvincia_Localitat`, `Nom_Localitat`) VALUES (3, 1, 'Roses');
INSERT INTO `S201N1E2_PIZZERIA`.`Localitat` (`Id_Localitat`, `idProvincia_Localitat`, `Nom_Localitat`) VALUES (4, 2, 'El Pont de Suert');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Clients`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Clients` (`Id_Clients`, `idLocalitat_Clients`, `Nom_Clients`, `Cognoms_Clients`, `Adreca_Clients`, `CodiPostal_Clients`, `NumeroTelefon_Clients`) VALUES (1, 1, 'Sandra', 'Ardnas', 'pot pot pot pot', 08204, '555555500');
INSERT INTO `S201N1E2_PIZZERIA`.`Clients` (`Id_Clients`, `idLocalitat_Clients`, `Nom_Clients`, `Cognoms_Clients`, `Adreca_Clients`, `CodiPostal_Clients`, `NumeroTelefon_Clients`) VALUES (2, 2, 'Tania', 'Ainat', 'pol pol pol pol', 17480, '555555501');
INSERT INTO `S201N1E2_PIZZERIA`.`Clients` (`Id_Clients`, `idLocalitat_Clients`, `Nom_Clients`, `Cognoms_Clients`, `Adreca_Clients`, `CodiPostal_Clients`, `NumeroTelefon_Clients`) VALUES (3, 3, 'Ramiro', 'Orimar', 'pos pos pos pos', 25520, '555555502');
INSERT INTO `S201N1E2_PIZZERIA`.`Clients` (`Id_Clients`, `idLocalitat_Clients`, `Nom_Clients`, `Cognoms_Clients`, `Adreca_Clients`, `CodiPostal_Clients`, `NumeroTelefon_Clients`) VALUES (4, 4, 'Vera', 'Arev', 'pi poi poi poi', 43740, '555555503');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Botigues`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`, `idLocalitat_Botigues`, `CodiPostal_Botigues`, `Adreça_Botigues`) VALUES (1, 1, 08204, 'bla bla bla bla bla');
INSERT INTO `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`, `idLocalitat_Botigues`, `CodiPostal_Botigues`, `Adreça_Botigues`) VALUES (2, 2, 17480, 'ble ble ble ble ble');
INSERT INTO `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`, `idLocalitat_Botigues`, `CodiPostal_Botigues`, `Adreça_Botigues`) VALUES (3, 3, 25520, 'blo blo blo blo blo');
INSERT INTO `S201N1E2_PIZZERIA`.`Botigues` (`Id_Botigues`, `idLocalitat_Botigues`, `CodiPostal_Botigues`, `Adreça_Botigues`) VALUES (4, 4, 43740, 'bli bli bli bli bli');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Comandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`, `idClients_Comandes`, `idBotiga_Comandes`, `DataHora_Comandes`, `RecDom_Comandes`, `QuantitatPizzes_Comandes`, `QuantitatHamburgueses_Comandes`, `QuantitatBegudes_Comandes`, `PreuTotal_Comandes`) VALUES (1, 1, 1, DEFAULT, 1, 2, 1, 2, 100);
INSERT INTO `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`, `idClients_Comandes`, `idBotiga_Comandes`, `DataHora_Comandes`, `RecDom_Comandes`, `QuantitatPizzes_Comandes`, `QuantitatHamburgueses_Comandes`, `QuantitatBegudes_Comandes`, `PreuTotal_Comandes`) VALUES (2, 2, 2, DEFAULT, 1, 0, 2, 1, 75);
INSERT INTO `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`, `idClients_Comandes`, `idBotiga_Comandes`, `DataHora_Comandes`, `RecDom_Comandes`, `QuantitatPizzes_Comandes`, `QuantitatHamburgueses_Comandes`, `QuantitatBegudes_Comandes`, `PreuTotal_Comandes`) VALUES (3, 2, 2, DEFAULT, 0, 1, 0, 1, 18);
INSERT INTO `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`, `idClients_Comandes`, `idBotiga_Comandes`, `DataHora_Comandes`, `RecDom_Comandes`, `QuantitatPizzes_Comandes`, `QuantitatHamburgueses_Comandes`, `QuantitatBegudes_Comandes`, `PreuTotal_Comandes`) VALUES (4, 3, 3, DEFAULT, 1, 4, 0, 10, 100);
INSERT INTO `S201N1E2_PIZZERIA`.`Comandes` (`Id_Comandes`, `idClients_Comandes`, `idBotiga_Comandes`, `DataHora_Comandes`, `RecDom_Comandes`, `QuantitatPizzes_Comandes`, `QuantitatHamburgueses_Comandes`, `QuantitatBegudes_Comandes`, `PreuTotal_Comandes`) VALUES (5, 4, 4, DEFAULT, 1, 0, 3, 5, 74);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Categories`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (1, 'Pizzes Vegetals');
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (2, 'Pizzes Carn Extres');
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (3, 'Pizzes Sense Gluten');
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (4, 'Pizzes Normals');
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (5, 'Hambugueses');
INSERT INTO `S201N1E2_PIZZERIA`.`Categories` (`Id_Categories`, `Nom_Categories`) VALUES (6, 'Begudes');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Productes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (1, 1, 'Pizza 4 herbes', 'Pizza amb 4 herbes espectaculars', NULL, 15);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (2, 2, 'Pizza Buey', 'Pizza amb un filet de buey a sobre', 'pizzabuey.png', 30);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (3, 3, 'Pizza Margrita Sense Gluten', 'La clàssica pizza margarita però amb massa sesnse gluten', NULL, 18);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (4, 4, 'Pizza 6 formatges', 'T\'agrada el formatge?', 'sisformatges-png', 15);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (5, 5, 'Doble amb fomratge', '2 hamburuesses de 500gr i 100gr de barreja de formatges', 'lahambu.png', 25);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes` (`Id_Productes`, `idCategories_Productes`, `Nom_Productes`, `Descripcio_Productes`, `Imatge_Productes`, `Preu_Productes`) VALUES (6, 6, 'Coca-Cola Light', 'Que s\'ha de mantenir la línia', 'trabajadorcachas.png', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Productes_De_Comandes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (1, 1, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (1, 5, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (1, 6, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (2, 5, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (2, 6, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (3, 2, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (3, 6, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (4, 1, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (4, 2, 1);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (4, 4, 2);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (4, 6, 10);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (5, 5, 3);
INSERT INTO `S201N1E2_PIZZERIA`.`Productes_De_Comandes` (`idComandes_Productes_De_Comandes`, `idProductes_Productes_De_Comandes`, `Quantitat_Productes_De_Comandes`) VALUES (5, 6, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`LlocFeina`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`LlocFeina` (`Id_LlocFeina`, `Nom_LlocFeina`) VALUES (0, 'Cuiner');
INSERT INTO `S201N1E2_PIZZERIA`.`LlocFeina` (`Id_LlocFeina`, `Nom_LlocFeina`) VALUES (1, 'Repartidor');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`Empleats`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`Empleats` (`Id_Empleats`, `idBotiga_Empleats`, `idLlocFeina_Empleats`, `Nom_Empleats`, `Cognoms_Empleats`, `NIF_Empleats`, `Telefon_Empleats`) VALUES (1, 1, 1, 'Marcos', 'Elde Arco', '44444444L', '555555550');
INSERT INTO `S201N1E2_PIZZERIA`.`Empleats` (`Id_Empleats`, `idBotiga_Empleats`, `idLlocFeina_Empleats`, `Nom_Empleats`, `Cognoms_Empleats`, `NIF_Empleats`, `Telefon_Empleats`) VALUES (2, 2, 1, 'Sandra', 'Aro', '88888888O', '555555551');
INSERT INTO `S201N1E2_PIZZERIA`.`Empleats` (`Id_Empleats`, `idBotiga_Empleats`, `idLlocFeina_Empleats`, `Nom_Empleats`, `Cognoms_Empleats`, `NIF_Empleats`, `Telefon_Empleats`) VALUES (3, 3, 1, 'Andreu', 'Alo', '77777777N', '555555552');
INSERT INTO `S201N1E2_PIZZERIA`.`Empleats` (`Id_Empleats`, `idBotiga_Empleats`, `idLlocFeina_Empleats`, `Nom_Empleats`, `Cognoms_Empleats`, `NIF_Empleats`, `Telefon_Empleats`) VALUES (4, 4, 1, 'Laura', 'Palde', '66666666D', '555555553');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N1E2_PIZZERIA`.`EntreguesDomicili`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N1E2_PIZZERIA`;
INSERT INTO `S201N1E2_PIZZERIA`.`EntreguesDomicili` (`Comanda_Id_Comanda`, `Empleat_Id_Empleat`, `Lluirament_EntreguesDomicili`) VALUES (1, 1, '2022-12-20 19:35:00.1');
INSERT INTO `S201N1E2_PIZZERIA`.`EntreguesDomicili` (`Comanda_Id_Comanda`, `Empleat_Id_Empleat`, `Lluirament_EntreguesDomicili`) VALUES (2, 2, '2022-12-21 9:05:50.47');
INSERT INTO `S201N1E2_PIZZERIA`.`EntreguesDomicili` (`Comanda_Id_Comanda`, `Empleat_Id_Empleat`, `Lluirament_EntreguesDomicili`) VALUES (4, 3, '2022-12-22 22:14:21.25');
INSERT INTO `S201N1E2_PIZZERIA`.`EntreguesDomicili` (`Comanda_Id_Comanda`, `Empleat_Id_Empleat`, `Lluirament_EntreguesDomicili`) VALUES (5, 4, '2022-12-23 21:51:00.0');

COMMIT;

