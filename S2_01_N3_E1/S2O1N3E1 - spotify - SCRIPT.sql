-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema S201N3E1_SPOTIFY
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema S201N3E1_SPOTIFY
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `S201N3E1_SPOTIFY` DEFAULT CHARACTER SET utf8 ;
USE `S201N3E1_SPOTIFY` ;

-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`sexes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`sexes` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`sexes` (
  `Id_sexes` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_sexes` VARCHAR(10) NULL,
  PRIMARY KEY (`Id_sexes`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`paisos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`paisos` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`paisos` (
  `Id_paisos` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Segons les NU hi ha 194 països al món, fins a 255 que permet un TINYINT...',
  `nom_paisos` VARCHAR(30) NULL,
  PRIMARY KEY (`Id_paisos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`usuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`usuaris` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`usuaris` (
  `Id_usuaris` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_sexe_usuaris` TINYINT UNSIGNED NOT NULL,
  `id_pais_usuaris` TINYINT UNSIGNED NOT NULL,
  `email_usuaris` VARCHAR(20) NOT NULL,
  `nom_usuaris` VARCHAR(30) NOT NULL,
  `date_neixament_usuaris` DATE NOT NULL,
  `cod_postal_usuaris` SMALLINT NOT NULL,
  `premium_usuaris` TINYINT NULL COMMENT '0 = free\n1 = premium',
  PRIMARY KEY (`Id_usuaris`),
  UNIQUE INDEX `Id_usuari_UNIQUE` (`Id_usuaris` ASC) VISIBLE,
  INDEX `fk_usuarsi_sexes_idx` (`id_sexe_usuaris` ASC) VISIBLE,
  INDEX `fk_usuaris_paisos_idx` (`id_pais_usuaris` ASC) VISIBLE,
  INDEX `nom_usuaris_idx` (`nom_usuaris` ASC) INVISIBLE,
  INDEX `email_usuaris` (`email_usuaris` ASC) VISIBLE,
  CONSTRAINT `fk_usuarsi_sexes`
    FOREIGN KEY (`id_sexe_usuaris`)
    REFERENCES `S201N3E1_SPOTIFY`.`sexes` (`Id_sexes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuaris_paisos`
    FOREIGN KEY (`id_pais_usuaris`)
    REFERENCES `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`formas_pagament`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`formas_pagament` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`formas_pagament` (
  `Id_formas_pagament` TINYINT NOT NULL,
  `nom_formas_pagament` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_formas_pagament`),
  UNIQUE INDEX `nom_formas_pagament_UNIQUE` (`nom_formas_pagament` ASC) VISIBLE,
  UNIQUE INDEX `Id_formas_pagament_UNIQUE` (`Id_formas_pagament` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`subscripcions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`subscripcions` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`subscripcions` (
  `Id_subscripcions` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_subscripcions` INT UNSIGNED NOT NULL COMMENT 'Un usuari pot tenir diferents subscripcions, per exemple, donar-se d\'alta de baixa i tonar a donar-se d\'alta',
  `id_forma_pagament_subscripcions` TINYINT NOT NULL,
  `data_inici_subscripcions` DATETIME NOT NULL,
  `data_renovacio_subscripcions` DATETIME NOT NULL,
  PRIMARY KEY (`Id_subscripcions`),
  UNIQUE INDEX `Id_subscripcions_UNIQUE` (`Id_subscripcions` ASC) VISIBLE,
  INDEX `fk_subscripcions_usuaris_idx` (`id_usuari_subscripcions` ASC) VISIBLE,
  INDEX `fk_subscripcions_formas_pagament_idx` (`id_forma_pagament_subscripcions` ASC) VISIBLE,
  CONSTRAINT `fk_subscripcions_usuaris`
    FOREIGN KEY (`id_usuari_subscripcions`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscripcions_formas_pagament`
    FOREIGN KEY (`id_forma_pagament_subscripcions`)
    REFERENCES `S201N3E1_SPOTIFY`.`formas_pagament` (`Id_formas_pagament`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`targetes_credit`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`targetes_credit` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`targetes_credit` (
  `Id_targetes_credit` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_targetes_credit` INT UNSIGNED NOT NULL,
  `numero_targetes_credit` VARCHAR(19) NOT NULL COMMENT 'Segons la normativa \'norma ISO/IEC 7812-1:2006\' el número de les targetes pot arribar a tenir 19 caràcters',
  `mes_targetes_credit` TINYINT(2) UNSIGNED NOT NULL,
  `any_targetes_credit` SMALLINT UNSIGNED NOT NULL,
  `cvc_targetes_credit` TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_targetes_credit`),
  INDEX `fk_targetes_credit_usuaris_idx` (`id_usuari_targetes_credit` ASC) VISIBLE,
  CONSTRAINT `fk_targetes_credit_usuaris`
    FOREIGN KEY (`id_usuari_targetes_credit`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`paypals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`paypals` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`paypals` (
  `Id_paypals` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_paypals` INT UNSIGNED NOT NULL,
  `nom_usuari_paypals` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`Id_paypals`),
  UNIQUE INDEX `Id_paypals_UNIQUE` (`Id_paypals` ASC) VISIBLE,
  INDEX `fk_paypals_usuaris_idx` (`id_usuari_paypals` ASC) VISIBLE,
  CONSTRAINT `fk_paypals_usuaris`
    FOREIGN KEY (`id_usuari_paypals`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`pagaments`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`pagaments` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`pagaments` (
  `Id_pagaments` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_pagaments` INT UNSIGNED NOT NULL,
  `id_subscripcions_pagaments` INT UNSIGNED NOT NULL,
  `data_pagaments` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `num_orde_pagaments` INT UNSIGNED NOT NULL,
  `valor_pagaments` SMALLINT UNSIGNED NOT NULL COMMENT 'Valor del pagament',
  PRIMARY KEY (`Id_pagaments`),
  UNIQUE INDEX `Id_pagaments_UNIQUE` (`Id_pagaments` ASC) VISIBLE,
  UNIQUE INDEX `num_orde_pagaments_UNIQUE` (`num_orde_pagaments` ASC) VISIBLE,
  INDEX `fk_pagaments_usuaris_idx` (`id_usuari_pagaments` ASC) VISIBLE,
  INDEX `fk_pagaments_subscripcions_idx` (`id_subscripcions_pagaments` ASC) VISIBLE,
  INDEX `data_pagaments_idx` (`data_pagaments` ASC) VISIBLE,
  CONSTRAINT `fk_pagaments_usuaris`
    FOREIGN KEY (`id_usuari_pagaments`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_pagaments_subscripcions`
    FOREIGN KEY (`id_subscripcions_pagaments`)
    REFERENCES `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`playlists`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`playlists` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`playlists` (
  `Id_playlists` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_playlists` INT UNSIGNED NOT NULL,
  `titol_playlists` VARCHAR(30) NOT NULL,
  `num_cancons_playlists` SMALLINT UNSIGNED NOT NULL COMMENT 'El límit de cançons de les playlist serà de 64K',
  `data_creacio_playlists` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_playlists`),
  UNIQUE INDEX `Id_playlists_UNIQUE` (`Id_playlists` ASC) VISIBLE,
  INDEX `titol_playlists_idx` (`titol_playlists` ASC) INVISIBLE,
  INDEX `fk_playlists_usuari_idx` (`id_usuari_playlists` ASC) VISIBLE,
  CONSTRAINT `fk_playlists_usuari`
    FOREIGN KEY (`id_usuari_playlists`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`playlist_eliminades`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`playlist_eliminades` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`playlist_eliminades` (
  `Id_playlist_eliminades` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuari_playlist_eliminades` INT UNSIGNED NOT NULL,
  `id_playlist_playlist_eliminades` INT UNSIGNED NOT NULL,
  `data_eliminacio_playlist_eliminades` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_playlist_eliminades`),
  UNIQUE INDEX `Id_playlist_eliminades_UNIQUE` (`Id_playlist_eliminades` ASC) VISIBLE,
  INDEX `fk_playlist_eliminades_ usuari_idx` (`id_usuari_playlist_eliminades` ASC) VISIBLE,
  INDEX `fk_playlist_eliminades_playlists_idx` (`id_playlist_playlist_eliminades` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_eliminades_ usuaris`
    FOREIGN KEY (`id_usuari_playlist_eliminades`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_eliminades_playlists`
    FOREIGN KEY (`id_playlist_playlist_eliminades`)
    REFERENCES `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`artistes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`artistes` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`artistes` (
  `Id_artistes` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_artistes` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_artistes`),
  UNIQUE INDEX `Id_artistes_UNIQUE` (`Id_artistes` ASC) VISIBLE,
  INDEX `nom_artistes_idx` (`nom_artistes` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`albums`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`albums` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`albums` (
  `Id_albums` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_artista_albums` INT UNSIGNED NOT NULL,
  `titol_albums` VARCHAR(30) NOT NULL,
  `any_albums` YEAR NOT NULL,
  `thumbnail_albums` VARCHAR(20) NOT NULL COMMENT 'Nom de la imatge amb l\'extensió, la imatge no es guarda en la BBDD',
  PRIMARY KEY (`Id_albums`),
  UNIQUE INDEX `Id_albums_UNIQUE` (`Id_albums` ASC) VISIBLE,
  INDEX `fk_albums_artistes_idx` (`id_artista_albums` ASC) INVISIBLE,
  INDEX `titol_albums_idx` (`titol_albums` ASC) COMMENT 'Per realitzar les cerques pel títol d\'album més ràpides' INVISIBLE,
  INDEX `any_albums_idx` (`any_albums` ASC) COMMENT 'Per realitzar les cerques per anys més ràpides' VISIBLE,
  UNIQUE INDEX `titol_artista_idx` (`id_artista_albums` ASC, `titol_albums` ASC) COMMENT 'Limitació que el album sols pot ser creat per un únic artiste\n' VISIBLE,
  UNIQUE INDEX `titol_albums_UNIQUE` (`titol_albums` ASC) VISIBLE,
  CONSTRAINT `fk_albums_artistes`
    FOREIGN KEY (`id_artista_albums`)
    REFERENCES `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`cancons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`cancons` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`cancons` (
  `Id_cancons` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_album_cancons` INT UNSIGNED NOT NULL,
  `titol_cancons` VARCHAR(30) NOT NULL,
  `durada_cancons` SMALLINT UNSIGNED NOT NULL COMMENT 'Valor en segons, màxim de 17h',
  `reproduccions_cancons` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_cancons`),
  UNIQUE INDEX `Id_cancons_UNIQUE` (`Id_cancons` ASC) INVISIBLE,
  INDEX `titol_cancons_idx` (`titol_cancons` ASC) VISIBLE,
  INDEX `fk_cancons_albums_idx` (`id_album_cancons` ASC) INVISIBLE,
  UNIQUE INDEX `idalbum_titol` (`id_album_cancons` ASC, `titol_cancons` ASC) COMMENT 'Limitació que una canço sols pot està en un album' VISIBLE,
  UNIQUE INDEX `titol_cancons_UNIQUE` (`titol_cancons` ASC) VISIBLE,
  CONSTRAINT `fk_cancons_albums`
    FOREIGN KEY (`id_album_cancons`)
    REFERENCES `S201N3E1_SPOTIFY`.`albums` (`Id_albums`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`playlist_shared`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`playlist_shared` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`playlist_shared` (
  `Id_playlist_shared` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_usuri_playlist_shared` INT UNSIGNED NOT NULL,
  `id_playlist_playlist_shared` INT UNSIGNED NOT NULL,
  `data_playlist_shared` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_playlist_shared`),
  UNIQUE INDEX `Id_playlist_shared_UNIQUE` (`Id_playlist_shared` ASC) VISIBLE,
  INDEX `fk_playlist_shared_usuari_idx` (`id_usuri_playlist_shared` ASC) VISIBLE,
  INDEX `fk_playlist_shared_playlists_idx` (`id_playlist_playlist_shared` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_shared_usuari`
    FOREIGN KEY (`id_usuri_playlist_shared`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_shared_playlists`
    FOREIGN KEY (`id_playlist_playlist_shared`)
    REFERENCES `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`playlist_cancons`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`playlist_cancons` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`playlist_cancons` (
  `Id_playlist_cancons` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_playlist_playlist_cancons` INT UNSIGNED NOT NULL,
  `id_cancons_playlist_cancons` INT UNSIGNED NOT NULL,
  `id_usuari_add_playlist_cancons` INT UNSIGNED NOT NULL COMMENT 'id de l\'usuari que ha afegit la canço',
  PRIMARY KEY (`Id_playlist_cancons`),
  UNIQUE INDEX `Id_playlist_cancons_UNIQUE` (`Id_playlist_cancons` ASC) VISIBLE,
  INDEX `playlist_cancons_usuaris_idx` (`id_usuari_add_playlist_cancons` ASC) VISIBLE,
  INDEX `fk_playlist_cancons_playlists_idx` (`id_playlist_playlist_cancons` ASC) VISIBLE,
  INDEX `fk_playlist_cancons_cancons_idx` (`id_cancons_playlist_cancons` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_cancons_usuaris`
    FOREIGN KEY (`id_usuari_add_playlist_cancons`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_cancons_playlists`
    FOREIGN KEY (`id_playlist_playlist_cancons`)
    REFERENCES `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_cancons_cancons`
    FOREIGN KEY (`id_cancons_playlist_cancons`)
    REFERENCES `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`seguidors`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`seguidors` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`seguidors` (
  `id_usuari_seguidors` INT UNSIGNED NOT NULL,
  `id_artista_seguidors` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari_seguidors`, `id_artista_seguidors`),
  INDEX `fk_seguidors_artistes_idx` (`id_artista_seguidors` ASC) VISIBLE,
  CONSTRAINT `fk_seguidors_usuaris`
    FOREIGN KEY (`id_usuari_seguidors`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_seguidors_artistes`
    FOREIGN KEY (`id_artista_seguidors`)
    REFERENCES `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`relacio_artistes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`relacio_artistes` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`relacio_artistes` (
  `Id_artista_principal_relacio_artistes` INT UNSIGNED NOT NULL,
  `Id_artista_agradat_relacio_artistes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`),
  INDEX `fk_relacio_artistes_artistes_2_idx` (`Id_artista_agradat_relacio_artistes` ASC) VISIBLE,
  CONSTRAINT `FK_relacio_artistes_artistes_principal`
    FOREIGN KEY (`Id_artista_principal_relacio_artistes`)
    REFERENCES `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_relacio_artistes_artistes_agradat`
    FOREIGN KEY (`Id_artista_agradat_relacio_artistes`)
    REFERENCES `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`cancon_preferides`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`cancon_preferides` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`cancon_preferides` (
  `id_usuari_cancon_preferides` INT UNSIGNED NOT NULL,
  `id_canco_cancon_preferides` INT UNSIGNED NOT NULL,
  INDEX `fk_canco_preferida_usuari_idx` (`id_usuari_cancon_preferides` ASC) VISIBLE,
  INDEX `fk_cancon_preferides_cancons_idx` (`id_canco_cancon_preferides` ASC) VISIBLE,
  PRIMARY KEY (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`),
  CONSTRAINT `fk_canco_preferida_usuari`
    FOREIGN KEY (`id_usuari_cancon_preferides`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_cancon_preferides_cancons`
    FOREIGN KEY (`id_canco_cancon_preferides`)
    REFERENCES `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N3E1_SPOTIFY`.`albums_preferits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`albums_preferits` ;

CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`albums_preferits` (
  `id_usuari_albums_preferits` INT UNSIGNED NOT NULL,
  `id_album_albums_preferits` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_usuari_albums_preferits`, `id_album_albums_preferits`),
  INDEX `fk_albums_preferits_album_idx` (`id_album_albums_preferits` ASC) VISIBLE,
  CONSTRAINT `fk_albums_preferits_usuari`
    FOREIGN KEY (`id_usuari_albums_preferits`)
    REFERENCES `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_albums_preferits_album`
    FOREIGN KEY (`id_album_albums_preferits`)
    REFERENCES `S201N3E1_SPOTIFY`.`albums` (`Id_albums`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `S201N3E1_SPOTIFY` ;

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`pagaments_subscripcio_totals_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`pagaments_subscripcio_totals_vw` (`Nom Usuari` INT, `Id Usuari` INT, `Id Subscripció` INT, `Suma Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`pagaments_totals_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`pagaments_totals_vw` (`Nom Usuari` INT, `Id Usuari` INT, `Suma Total` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`llista_cancons_artista_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`llista_cancons_artista_vw` (`nom_artistes` INT, `titol_albums` INT, `any_albums` INT, `titol_cancons` INT, `durada_cancons` INT, `reproduccions_cancons` INT, `Id_artistes` INT, `Id_albums` INT, `id_artista_albums` INT, `Id_cancons` INT, `id_album_cancons` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`users_complete_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`users_complete_vw` (`Id_usuaris` INT, `email_usuaris` INT, `nom_usuaris` INT, `date_neixament_usuaris` INT, `cod_postal_usuaris` INT, `premium_usuaris` INT, `id_sexe_usuaris` INT, `nom_sexes` INT, `id_pais_usuaris` INT, `nom_paisos` INT, `nom_usuari_paypals` INT, `numero_targetes_credit` INT, `mes_targetes_credit` INT, `any_targetes_credit` INT, `cvc_targetes_credit` INT, `'€ RECAUDATS X USUARI'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`estat_global_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`estat_global_vw` (`'Nº USUARIS'` INT, `'SUBSCRIPCIONS TOTALS'` INT, `'INGRESSOS TOTALS (€)'` INT, `'Nº PLAYLISTS'` INT, `' PLAYLIST ELIMINDADES'` INT, `'Nº ARTISTES'` INT, `'Nº CANÇONS'` INT, `'Nº ALBUMS'` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N3E1_SPOTIFY`.`usuaris_pagaments_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N3E1_SPOTIFY`.`usuaris_pagaments_vw` (`Id_usuaris` INT, `nom_usuaris` INT, `Id_subscripcions` INT, `data_inici_subscripcions` INT, `data_renovacio_subscripcions` INT, `Id_pagaments` INT, `data_pagaments` INT, `num_orde_pagaments` INT, `valor_pagaments` INT);

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`pagaments_subscripcio_totals_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`pagaments_subscripcio_totals_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`pagaments_subscripcio_totals_vw` ;
USE `S201N3E1_SPOTIFY`;
CREATE  OR REPLACE VIEW `pagaments_subscripcio_totals_vw` AS
SELECT 
	`usu`.`nom_usuaris` AS `Nom Usuari`,
    `usu`.`Id_usuaris` AS `Id Usuari`,
    `subs`.`Id_subscripcions` AS `Id Subscripció`,    
	SUM(`paga`.`valor_pagaments`) AS `Suma Total`
FROM (`pagaments` `paga`
    LEFT JOIN `usuaris` `usu` ON ((`usu`.`Id_usuaris` = `paga`.`id_usuari_pagaments`))
    LEFT JOIN `subscripcions` `subs` ON ((`subs`.`Id_subscripcions` = `paga`.`id_subscripcions_pagaments` )))    
GROUP BY `subs`.`Id_subscripcions`
ORDER BY `paga`.`id_usuari_pagaments`;

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`pagaments_totals_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`pagaments_totals_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`pagaments_totals_vw` ;
USE `S201N3E1_SPOTIFY`;
CREATE  OR REPLACE VIEW `pagaments_totals_vw` AS
SELECT 
	`usu`.`nom_usuaris` AS `Nom Usuari`,
    `usu`.`Id_usuaris` AS `Id Usuari`,
	SUM(`paga`.`valor_pagaments`) AS `Suma Total`
FROM (`pagaments` `paga`
    LEFT JOIN `usuaris` `usu` ON (`usu`.`Id_usuaris` = `paga`.`id_usuari_pagaments`))
GROUP BY `paga`.`id_usuari_pagaments`
ORDER BY `paga`.`id_usuari_pagaments`;

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`llista_cancons_artista_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`llista_cancons_artista_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`llista_cancons_artista_vw` ;
USE `S201N3E1_SPOTIFY`;
CREATE  OR REPLACE VIEW `llista_cancons_artista_vw` AS
SELECT 
	`art`.`nom_artistes` AS `nom_artistes`,
	`alb`.`titol_albums` AS `titol_albums`,
	`alb`.`any_albums` AS `any_albums`,
	`canc`.`titol_cancons` AS `titol_cancons`,
	`canc`.`durada_cancons` AS `durada_cancons`,
	`canc`.`reproduccions_cancons` AS `reproduccions_cancons`,
	`art`.`Id_artistes` AS `Id_artistes`,
	`alb`.`Id_albums` AS `Id_albums`,
	`alb`.`id_artista_albums` AS `id_artista_albums`,
	`canc`.`Id_cancons` AS `Id_cancons`,
	`canc`.`id_album_cancons` AS `id_album_cancons`
FROM `artistes` `art`
	LEFT JOIN `albums` `alb` ON `alb`.`id_artista_albums` = `art`.`Id_artistes`
	LEFT JOIN `cancons` `canc` ON `canc`.`id_album_cancons` = `alb`.`Id_albums`
GROUP BY `canc`.`Id_cancons`;

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`users_complete_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`users_complete_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`users_complete_vw` ;
USE `S201N3E1_SPOTIFY`;
CREATE  OR REPLACE VIEW `users_complete_vw` AS
SELECT 
        `usr`.`Id_usuaris` AS `Id_usuaris`,
        `usr`.`email_usuaris` AS `email_usuaris`,
        `usr`.`nom_usuaris` AS `nom_usuaris`,
        `usr`.`date_neixament_usuaris` AS `date_neixament_usuaris`,
        `usr`.`cod_postal_usuaris` AS `cod_postal_usuaris`,
        `usr`.`premium_usuaris` AS `premium_usuaris`,
        `usr`.`id_sexe_usuaris` AS `id_sexe_usuaris`,
        `sx`.`nom_sexes` AS `nom_sexes`,
        `usr`.`id_pais_usuaris` AS `id_pais_usuaris`,
        `pss`.`nom_paisos` AS `nom_paisos`,
        `pyp`.`nom_usuari_paypals` AS `nom_usuari_paypals`,
        `trcr`.`numero_targetes_credit` AS `numero_targetes_credit`,
        `trcr`.`mes_targetes_credit` AS `mes_targetes_credit`,
        `trcr`.`any_targetes_credit` AS `any_targetes_credit`,
        `trcr`.`cvc_targetes_credit` AS `cvc_targetes_credit`,
        (select sum(`pagaments`.`valor_pagaments`) from `pagaments` 
			where `pagaments`.`id_usuari_pagaments` = `usr`.`Id_usuaris`) AS '€ RECAUDATS X USUARI'
    FROM
        usuaris usr
        LEFT JOIN `sexes` `sx` ON `sx`.`Id_sexes` = `usr`.`id_sexe_usuaris`
        LEFT JOIN `paisos` `pss` ON `pss`.`Id_paisos` = `usr`.`id_pais_usuaris`
        LEFT JOIN `paypals` `pyp` ON `pyp`.`id_usuari_paypals` = `usr`.`Id_usuaris`
        LEFT JOIN `targetes_credit` `trcr` ON `trcr`.`id_usuari_targetes_credit` = `usr`.`Id_usuaris`
    GROUP BY `usr`.`Id_usuaris`
    ORDER BY `usr`.`nom_usuaris`;

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`estat_global_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`estat_global_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`estat_global_vw` ;
USE `S201N3E1_SPOTIFY`;
CREATE  OR REPLACE VIEW `estat_global_vw` AS
    SELECT 
        (SELECT 
                COUNT(*)
            FROM
                `usuaris`) AS 'Nº USUARIS',
        (SELECT 
                COUNT(*)
            FROM
                subscripcions) AS 'SUBSCRIPCIONS TOTALS',
        (SELECT 
                SUM(valor_pagaments)
            FROM
                pagaments) AS 'INGRESSOS TOTALS (€)',
        (SELECT 
                COUNT(*)
            FROM
                playlists) AS 'Nº PLAYLISTS',
        (SELECT 
                COUNT(*)
            FROM
                playlist_eliminades) AS ' PLAYLIST ELIMINDADES',
        (SELECT 
                COUNT(*)
            FROM
                artistes) AS 'Nº ARTISTES',
        (SELECT 
                COUNT(*)
            FROM
                cancons) AS 'Nº CANÇONS',
        (SELECT 
                COUNT(*)
            FROM
                albums) AS 'Nº ALBUMS';

-- -----------------------------------------------------
-- View `S201N3E1_SPOTIFY`.`usuaris_pagaments_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N3E1_SPOTIFY`.`usuaris_pagaments_vw`;
DROP VIEW IF EXISTS `S201N3E1_SPOTIFY`.`usuaris_pagaments_vw` ;
USE `S201N3E1_SPOTIFY`;
create  OR REPLACE VIEW `usuaris_pagaments_vw` AS
    SELECT 
        `usr`.`Id_usuaris` AS `Id_usuaris`,
        `usr`.`nom_usuaris` AS `nom_usuaris`,
        `subc`.`Id_subscripcions` AS `Id_subscripcions`,
        `subc`.`data_inici_subscripcions` AS `data_inici_subscripcions`,
        `subc`.`data_renovacio_subscripcions` AS `data_renovacio_subscripcions`,
        `pgm`.`Id_pagaments` AS `Id_pagaments`,
        `pgm`.`data_pagaments` AS `data_pagaments`,
        `pgm`.`num_orde_pagaments` AS `num_orde_pagaments`,
        `pgm`.`valor_pagaments` AS `valor_pagaments`
    FROM
        ((`usuaris` `usr`
        LEFT JOIN `subscripcions` `subc` ON ((`subc`.`id_usuari_subscripcions` = `usr`.`Id_usuaris`)))
        LEFT JOIN `pagaments` `pgm` ON ((`pgm`.`id_subscripcions_pagaments` = `subc`.`Id_subscripcions`)))
    ORDER BY `usr`.`Id_usuaris`;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`sexes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`sexes` (`Id_sexes`, `nom_sexes`) VALUES (1, 'Dona');
INSERT INTO `S201N3E1_SPOTIFY`.`sexes` (`Id_sexes`, `nom_sexes`) VALUES (2, 'Home');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`paisos`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (1, 'Espanya');
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (2, 'França');
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (3, 'Andorra');
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (4, 'Portugal');
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (5, 'Marroc');
INSERT INTO `S201N3E1_SPOTIFY`.`paisos` (`Id_paisos`, `nom_paisos`) VALUES (6, 'Alemanya');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`usuaris`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`, `id_sexe_usuaris`, `id_pais_usuaris`, `email_usuaris`, `nom_usuaris`, `date_neixament_usuaris`, `cod_postal_usuaris`, `premium_usuaris`) VALUES (1, 1, 1, 'usu1@usu1.com', 'Usuari 1', '2002-05-20', 08100, 0);
INSERT INTO `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`, `id_sexe_usuaris`, `id_pais_usuaris`, `email_usuaris`, `nom_usuaris`, `date_neixament_usuaris`, `cod_postal_usuaris`, `premium_usuaris`) VALUES (2, 2, 2, 'usu2@usu2.com', 'Usuari 2', '1995-12-17', 08075, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`, `id_sexe_usuaris`, `id_pais_usuaris`, `email_usuaris`, `nom_usuaris`, `date_neixament_usuaris`, `cod_postal_usuaris`, `premium_usuaris`) VALUES (3, 1, 1, 'usu3@usu3.com', 'Usuari 3', '1977-05-09', 08055, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`, `id_sexe_usuaris`, `id_pais_usuaris`, `email_usuaris`, `nom_usuaris`, `date_neixament_usuaris`, `cod_postal_usuaris`, `premium_usuaris`) VALUES (4, 2, 3, 'usu4@usu4.com', 'Usuari 4', '1980-02-10', 12345, 0);
INSERT INTO `S201N3E1_SPOTIFY`.`usuaris` (`Id_usuaris`, `id_sexe_usuaris`, `id_pais_usuaris`, `email_usuaris`, `nom_usuaris`, `date_neixament_usuaris`, `cod_postal_usuaris`, `premium_usuaris`) VALUES (5, 2, 6, 'usu5@usu5.com', 'Usuari 5', '1988-08-08', 12346, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`formas_pagament`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`formas_pagament` (`Id_formas_pagament`, `nom_formas_pagament`) VALUES (1, 'Targeta de crèdit');
INSERT INTO `S201N3E1_SPOTIFY`.`formas_pagament` (`Id_formas_pagament`, `nom_formas_pagament`) VALUES (2, 'PayPal');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`subscripcions`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`, `id_usuari_subscripcions`, `id_forma_pagament_subscripcions`, `data_inici_subscripcions`, `data_renovacio_subscripcions`) VALUES (1, 2, 1, '2019-10-12 12:12:12', '2020-10-12 12:12:12');
INSERT INTO `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`, `id_usuari_subscripcions`, `id_forma_pagament_subscripcions`, `data_inici_subscripcions`, `data_renovacio_subscripcions`) VALUES (2, 2, 2, '2021-7-20 20:10:11', '2023-7-20 20:10:11');
INSERT INTO `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`, `id_usuari_subscripcions`, `id_forma_pagament_subscripcions`, `data_inici_subscripcions`, `data_renovacio_subscripcions`) VALUES (3, 3, 2, '2018-4-30 22:50:00', '2023-4-30 22:50:50');
INSERT INTO `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`, `id_usuari_subscripcions`, `id_forma_pagament_subscripcions`, `data_inici_subscripcions`, `data_renovacio_subscripcions`) VALUES (4, 5, 1, '2017-12-30 9:15:00', '2018-12-30 9:15:27');
INSERT INTO `S201N3E1_SPOTIFY`.`subscripcions` (`Id_subscripcions`, `id_usuari_subscripcions`, `id_forma_pagament_subscripcions`, `data_inici_subscripcions`, `data_renovacio_subscripcions`) VALUES (5, 5, 1, '2020-11-1 19:15:00', '2023-11-1 19:15:27');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`targetes_credit`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`targetes_credit` (`Id_targetes_credit`, `id_usuari_targetes_credit`, `numero_targetes_credit`, `mes_targetes_credit`, `any_targetes_credit`, `cvc_targetes_credit`) VALUES (1, 3, '1234567890123456', 7, 2031, 000);
INSERT INTO `S201N3E1_SPOTIFY`.`targetes_credit` (`Id_targetes_credit`, `id_usuari_targetes_credit`, `numero_targetes_credit`, `mes_targetes_credit`, `any_targetes_credit`, `cvc_targetes_credit`) VALUES (2, 5, '1234567890123450', 5, 2027, 001);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`paypals`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`paypals` (`Id_paypals`, `id_usuari_paypals`, `nom_usuari_paypals`) VALUES (1, 2, 'usu2@usu2.com');
INSERT INTO `S201N3E1_SPOTIFY`.`paypals` (`Id_paypals`, `id_usuari_paypals`, `nom_usuari_paypals`) VALUES (2, 3, 'usu3@usu3.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`pagaments`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (1, 2, 1, '2019-11-12 00:00:00', 1, 25);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (2, 2, 1, '2019-12-12 00:00:00', 2, 25);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (3, 2, 1, '2020-1-12 00:00:00', 3, 25);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (4, 2, 1, '2020-02-12 00:00:00', 4, 25);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (5, 2, 2, '2021-07-20 00:00:00', 5, 29);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (6, 2, 2, '2021-08-20 00:00:00', 6, 29);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (7, 2, 2, '2021-09-20 00:00:00', 7, 29);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (8, 2, 2, '2021-10-20 00:00:00', 8, 29);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (9, 3, 3, '2018-04-30 00:00:00', 9, 20);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (10, 3, 3, '2018-05-30 00:00:00', 10, 20);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (11, 3, 3, '2018-06-30 00:00:00', 11, 20);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (12, 3, 3, '2018-07-30 00:00:00', 12, 20);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (13, 5, 4, '2017-12-30 00:00:00', 13, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (14, 5, 4, '2018-1-30 00:00:00', 14, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (15, 5, 4, '2019-1-30 00:00:01', 16, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (16, 5, 4, '2018-3-30 00:00:00', 17, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (17, 5, 5, '2020-11-1 00:00:00', 18, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (18, 5, 5, '2020-12-1 00:00:00', 19, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (19, 5, 5, '2021-1-1 00:00:00', 20, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (20, 5, 5, '2021-2-1 00:00:00', 21, 35);
INSERT INTO `S201N3E1_SPOTIFY`.`pagaments` (`Id_pagaments`, `id_usuari_pagaments`, `id_subscripcions_pagaments`, `data_pagaments`, `num_orde_pagaments`, `valor_pagaments`) VALUES (21, 5, 5, '2021-2-1 00:00:00', 22, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`playlists`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`, `id_usuari_playlists`, `titol_playlists`, `num_cancons_playlists`, `data_creacio_playlists`) VALUES (1, 1, 'playlist 1 usu 1', 2, '2022-05-21');
INSERT INTO `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`, `id_usuari_playlists`, `titol_playlists`, `num_cancons_playlists`, `data_creacio_playlists`) VALUES (2, 2, 'playlist 2 usu 2', 3, '2020-12-1');
INSERT INTO `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`, `id_usuari_playlists`, `titol_playlists`, `num_cancons_playlists`, `data_creacio_playlists`) VALUES (3, 3, 'playlist 3 usu 3', 5, '2019-01-1');
INSERT INTO `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`, `id_usuari_playlists`, `titol_playlists`, `num_cancons_playlists`, `data_creacio_playlists`) VALUES (4, 3, 'playlist 4 usu 4', 7, '2022-10-21');
INSERT INTO `S201N3E1_SPOTIFY`.`playlists` (`Id_playlists`, `id_usuari_playlists`, `titol_playlists`, `num_cancons_playlists`, `data_creacio_playlists`) VALUES (5, 1, 'playlist 2 usu 1', 3, '2022-06-20');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`playlist_eliminades`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_eliminades` (`Id_playlist_eliminades`, `id_usuari_playlist_eliminades`, `id_playlist_playlist_eliminades`, `data_eliminacio_playlist_eliminades`) VALUES (1, 1, 5, '2022-06-21');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`artistes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`, `nom_artistes`) VALUES (1, 'Carlos Perez');
INSERT INTO `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`, `nom_artistes`) VALUES (2, 'Antonio Pozco');
INSERT INTO `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`, `nom_artistes`) VALUES (3, 'La vaca paca');
INSERT INTO `S201N3E1_SPOTIFY`.`artistes` (`Id_artistes`, `nom_artistes`) VALUES (4, 'El ojo de Van Gogh');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`albums`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (1, 1, 'En los años buenos', 2002, 'añosbuenos-png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (2, 1, 'La mascara que nos esconde', 2004, 'mascaraesconde.png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (3, 2, 'Pozco a pozco', 2015, 'poscoposco.png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (4, 3, 'El prado verde', 2018, 'prodoverde.png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (5, 3, 'Hasta los huevos de dar leche', 2019, 'huevosleche.png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (6, 4, 'Y si veo la mitad, ¿que?', 2010, 'lamitad.png');
INSERT INTO `S201N3E1_SPOTIFY`.`albums` (`Id_albums`, `id_artista_albums`, `titol_albums`, `any_albums`, `thumbnail_albums`) VALUES (7, 4, 'No era ojo si no oreja', 2012, 'ojooreja.png');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`cancons`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (1, 1, 'canço 1 album 1', 123, 2547854);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (2, 1, 'canço 2 album 1', 90, 874587);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (3, 1, 'canço 3 album 1', 225, 897325);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (4, 1, 'canço 4 album 1', 110, 1234875);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (5, 2, 'canço 1 album 2', 101, 25478);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (6, 2, 'canço 2 album 2', 87, 124578);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (7, 2, 'canço 3 album 2', 65, 58745);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (8, 3, 'canço 1 album 3', 145, 125);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (9, 3, 'canço 2 album 3', 220, 1254);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (10, 3, 'canço 3 album 3', 325, 1400);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (11, 4, 'canço 1 album 4', 100, 1457895);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (12, 4, 'canço 2 album 4', 147, 854789);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (13, 4, 'canço 3 album 4', 120, 4561237);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (14, 4, 'canço 4 album 4', 165, 45874);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (15, 5, 'canço 1 album 5', 60, 5478945);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (16, 5, 'canço 2 album 5', 65, 254781);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (17, 5, 'canço 3 album 5', 75, 321478);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (18, 5, 'canço 4 album 5', 62, 568945);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (19, 6, 'canço 1 album 6', 321, 10025);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (20, 6, 'canço 2 album 6', 300, 125545);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (21, 6, 'canço 3 album 6', 480, 125478965);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (22, 7, 'canço 1 album 7', 168, 25312);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (23, 7, 'canço 2 album 7', 169, 55478);
INSERT INTO `S201N3E1_SPOTIFY`.`cancons` (`Id_cancons`, `id_album_cancons`, `titol_cancons`, `durada_cancons`, `reproduccions_cancons`) VALUES (24, 7, 'canço 3 album 7', 160, 45781);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`playlist_shared`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_shared` (`Id_playlist_shared`, `id_usuri_playlist_shared`, `id_playlist_playlist_shared`, `data_playlist_shared`) VALUES (1, 1, 1, '2022-05-22');
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_shared` (`Id_playlist_shared`, `id_usuri_playlist_shared`, `id_playlist_playlist_shared`, `data_playlist_shared`) VALUES (2, 2, 2, '2020-12-2');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`playlist_cancons`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (1, 1, 1, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (2, 1, 1, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (4, 2, 2, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (5, 2, 2, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (6, 2, 2, 4);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (7, 4, 10, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (8, 4, 11, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (9, 4, 16, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (10, 4, 1, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (11, 4, 4, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (12, 4, 5, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (13, 4, 20, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (14, 3, 21, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (15, 3, 17, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (16, 3, 18, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (17, 3, 15, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (18, 5, 2, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (19, 5, 10, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`playlist_cancons` (`Id_playlist_cancons`, `id_playlist_playlist_cancons`, `id_cancons_playlist_cancons`, `id_usuari_add_playlist_cancons`) VALUES (20, 5, 16, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`seguidors`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (1, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (1, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (1, 4);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (2, 4);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (3, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (3, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (4, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (4, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (5, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`seguidors` (`id_usuari_seguidors`, `id_artista_seguidors`) VALUES (5, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`relacio_artistes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (1, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (1, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (2, 4);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (2, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (3, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (3, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`relacio_artistes` (`Id_artista_principal_relacio_artistes`, `Id_artista_agradat_relacio_artistes`) VALUES (4, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`cancon_preferides`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (1, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (1, 10);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (1, 13);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (2, 12);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (2, 16);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (2, 17);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (3, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (3, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 5);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 7);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 9);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 10);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 22);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 12);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 8);
INSERT INTO `S201N3E1_SPOTIFY`.`cancon_preferides` (`id_usuari_cancon_preferides`, `id_canco_cancon_preferides`) VALUES (4, 11);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N3E1_SPOTIFY`.`albums_preferits`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N3E1_SPOTIFY`;
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (1, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (1, 5);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (2, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (2, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (2, 7);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (3, 6);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 1);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 2);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 3);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 4);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 5);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 6);
INSERT INTO `S201N3E1_SPOTIFY`.`albums_preferits` (`id_usuari_albums_preferits`, `id_album_albums_preferits`) VALUES (4, 7);

COMMIT;

