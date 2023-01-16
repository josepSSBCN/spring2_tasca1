-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema S201N2E1_YOUTUBE
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema S201N2E1_YOUTUBE
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `S201N2E1_YOUTUBE` DEFAULT CHARACTER SET utf8 ;
USE `S201N2E1_YOUTUBE` ;

-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`sexe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`sexe` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`sexe` (
  `Id_sexe` TINYINT UNSIGNED NOT NULL,
  `Nom_sexe` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`Id_sexe`),
  UNIQUE INDEX `Nom_sexe_UNIQUE` (`Nom_sexe` ASC) VISIBLE,
  UNIQUE INDEX `Id_sexe_UNIQUE` (`Id_sexe` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`pais`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`pais` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`pais` (
  `Id_pais` TINYINT UNSIGNED NOT NULL,
  `nom_pais` VARCHAR(30) NULL,
  PRIMARY KEY (`Id_pais`),
  UNIQUE INDEX `Id_pais_UNIQUE` (`Id_pais` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`usuaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`usuaris` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`usuaris` (
  `Id_usuari` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_pais_usuaris` TINYINT UNSIGNED NOT NULL,
  `idsexe_usuari` TINYINT UNSIGNED NOT NULL,
  `email_usuari` VARCHAR(50) NOT NULL,
  `nom_usuari` VARCHAR(30) NOT NULL,
  `password_usuari` VARCHAR(30) NOT NULL,
  `DateNeixament_usuari` DATE NOT NULL,
  `cp_usuari` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_usuari`),
  UNIQUE INDEX `email_UNIQUE` (`email_usuari` ASC) VISIBLE,
  UNIQUE INDEX `Id_usuari_UNIQUE` (`Id_usuari` ASC) VISIBLE,
  INDEX `fk_usuari_sexe_idx` (`idsexe_usuari` ASC) VISIBLE,
  INDEX `fk_usuaris_pais1_idx` (`id_pais_usuaris` ASC) VISIBLE,
  CONSTRAINT `fk_usuaris_sexe`
    FOREIGN KEY (`idsexe_usuari`)
    REFERENCES `S201N2E1_YOUTUBE`.`sexe` (`Id_sexe`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_usuaris_pais1`
    FOREIGN KEY (`id_pais_usuaris`)
    REFERENCES `S201N2E1_YOUTUBE`.`pais` (`Id_pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`estat_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`estat_video` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`estat_video` (
  `Id_estat_video` TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nom_estat_video` VARCHAR(10) NULL,
  PRIMARY KEY (`Id_estat_video`),
  UNIQUE INDEX `Id_estat_video_UNIQUE` (`Id_estat_video` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`videos` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`videos` (
  `Id_videos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUsari_videos` INT UNSIGNED NOT NULL,
  `id_estat_video_videos` TINYINT UNSIGNED NOT NULL,
  `titol_videos` VARCHAR(30) NOT NULL,
  `descripcio_videos` VARCHAR(256) NULL,
  `mida_videos` SMALLINT UNSIGNED NOT NULL,
  `nom_arxiu_videos` VARCHAR(30) NOT NULL,
  `temps_videos` SMALLINT UNSIGNED NOT NULL,
  `thumbnail_videos` VARCHAR(20) NOT NULL,
  `reproduccions_videos` INT UNSIGNED NOT NULL,
  `likes_videos` INT UNSIGNED NOT NULL,
  `dislikes_videos` INT UNSIGNED NOT NULL,
  `datetime_videos` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_videos`),
  UNIQUE INDEX `Id_videos_UNIQUE` (`Id_videos` ASC) INVISIBLE,
  INDEX `fk_videos_usuaris_idx` (`idUsari_videos` ASC) VISIBLE,
  INDEX `idUsari_videos_idx` (`idUsari_videos` ASC) INVISIBLE,
  INDEX `titol_videos_idx` (`titol_videos` ASC) VISIBLE,
  INDEX `fk_videos_estat_video1_idx` (`id_estat_video_videos` ASC) VISIBLE,
  CONSTRAINT `fk_videos_usuaris`
    FOREIGN KEY (`idUsari_videos`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videos_estat_video1`
    FOREIGN KEY (`id_estat_video_videos`)
    REFERENCES `S201N2E1_YOUTUBE`.`estat_video` (`Id_estat_video`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`etiquetes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`etiquetes` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`etiquetes` (
  `Id_etiquetes` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Suposem que mai arribarem a les 16M d\'etiquetes',
  `nom_etiquetes` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_etiquetes`),
  UNIQUE INDEX `Id_etiquetes_UNIQUE` (`Id_etiquetes` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`canals`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`canals` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`canals` (
  `Id_canals` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUsuari_canals` INT UNSIGNED NOT NULL,
  `nom_canals` VARCHAR(30) NOT NULL,
  `descripcio_canals` VARCHAR(255) NULL,
  `data_creacio_canals` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_canals`),
  UNIQUE INDEX `Id_canals_UNIQUE` (`Id_canals` ASC) VISIBLE,
  INDEX `fk_canals_usuaris_idx` (`idUsuari_canals` ASC) VISIBLE,
  CONSTRAINT `fk_canals_usuaris`
    FOREIGN KEY (`idUsuari_canals`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`subscripcions`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`subscripcions` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`subscripcions` (
  `Id_subscripcions` BIGINT UNSIGNED NOT NULL,
  `idUsuari_subscripcions` INT UNSIGNED NOT NULL,
  `idCanal_subscripcions` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Id_subscripcions`),
  UNIQUE INDEX `Id_subscripcions_UNIQUE` (`Id_subscripcions` ASC) VISIBLE,
  INDEX `fk_subscripcions_usuari_idx` (`idUsuari_subscripcions` ASC) VISIBLE,
  INDEX `fk_subscripcions_canal_idx` (`idCanal_subscripcions` ASC) VISIBLE,
  CONSTRAINT `fk_subscripcions_usuari`
    FOREIGN KEY (`idUsuari_subscripcions`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_subscripcions_canal`
    FOREIGN KEY (`idCanal_subscripcions`)
    REFERENCES `S201N2E1_YOUTUBE`.`canals` (`Id_canals`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`likes_video`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`likes_video` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`likes_video` (
  `idUsuari_likes` INT UNSIGNED NOT NULL,
  `idVideo_likes` INT UNSIGNED NOT NULL,
  `datetime_likes` DATETIME NOT NULL,
  `likesdislike_likes` BIT NOT NULL,
  PRIMARY KEY (`idUsuari_likes`, `idVideo_likes`),
  INDEX `fk_likes_video_idx` (`idVideo_likes` ASC) VISIBLE,
  CONSTRAINT `fk_likes_usuaris`
    FOREIGN KEY (`idUsuari_likes`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_likes_video`
    FOREIGN KEY (`idVideo_likes`)
    REFERENCES `S201N2E1_YOUTUBE`.`videos` (`Id_videos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`estat_playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`estat_playlist` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`estat_playlist` (
  `Id_estat_playlist` TINYINT NOT NULL,
  `nom_estat_playlist` VARCHAR(10) NULL,
  PRIMARY KEY (`Id_estat_playlist`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`playlist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`playlist` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`playlist` (
  `Id_playlist` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUsuari_playlist` INT UNSIGNED NOT NULL,
  `id_estat_playlist_playlist` TINYINT NOT NULL,
  `nom_playlist` VARCHAR(30) NOT NULL,
  `data_playlist` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_playlist`),
  UNIQUE INDEX `Id_playlist_UNIQUE` (`Id_playlist` ASC) VISIBLE,
  INDEX `fk_playlist_usuari_idx` (`idUsuari_playlist` ASC) VISIBLE,
  INDEX `fk_playlist_estat_playlist1_idx` (`id_estat_playlist_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuari`
    FOREIGN KEY (`idUsuari_playlist`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_playlist_estat_playlist1`
    FOREIGN KEY (`id_estat_playlist_playlist`)
    REFERENCES `S201N2E1_YOUTUBE`.`estat_playlist` (`Id_estat_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`videosPlayList`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`videosPlayList` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`videosPlayList` (
  `Idplaylist_videosPlayList` INT UNSIGNED NOT NULL,
  `idVideo_videosPlayList` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`),
  INDEX `fk_videosPlayList_videos_idx` (`idVideo_videosPlayList` ASC) VISIBLE,
  CONSTRAINT `fk_videosPlayList_playlist`
    FOREIGN KEY (`Idplaylist_videosPlayList`)
    REFERENCES `S201N2E1_YOUTUBE`.`playlist` (`Id_playlist`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_videosPlayList_videos`
    FOREIGN KEY (`idVideo_videosPlayList`)
    REFERENCES `S201N2E1_YOUTUBE`.`videos` (`Id_videos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`comentaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`comentaris` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`comentaris` (
  `Id_comentaris` BIGINT UNSIGNED NOT NULL,
  `idUsuari_comentaris` INT UNSIGNED NOT NULL,
  `idVideo_comentaris` INT UNSIGNED NOT NULL,
  `text_comentaris` VARCHAR(255) NOT NULL,
  `datahora_comentaris` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  INDEX `fk_comentaris_videos_idx` (`idVideo_comentaris` ASC) VISIBLE,
  PRIMARY KEY (`Id_comentaris`),
  INDEX `idVideo_comentaris_idx` (`idVideo_comentaris` ASC) VISIBLE,
  INDEX `fk_comentaris_usuaris_idx` (`idUsuari_comentaris` ASC) VISIBLE,
  CONSTRAINT `fk_comentaris_usuaris`
    FOREIGN KEY (`idUsuari_comentaris`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_comentaris_videos`
    FOREIGN KEY (`idVideo_comentaris`)
    REFERENCES `S201N2E1_YOUTUBE`.`videos` (`Id_videos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`like_comentaris`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`like_comentaris` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`like_comentaris` (
  `idComentari_like_comentaris` BIGINT UNSIGNED NOT NULL,
  `idUsuari_like_comentaris` INT UNSIGNED NOT NULL,
  `like_dislike_comentaris` BIT NOT NULL COMMENT '0 = no m\'agrada;\n1 = m\'agrada',
  `datahora_comentaris` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idComentari_like_comentaris`, `idUsuari_like_comentaris`),
  INDEX `fk_like_comentaris_usuari_idx` (`idUsuari_like_comentaris` ASC) VISIBLE,
  CONSTRAINT `fk_like_comentaris_comentari`
    FOREIGN KEY (`idComentari_like_comentaris`)
    REFERENCES `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_like_comentaris_usuari`
    FOREIGN KEY (`idUsuari_like_comentaris`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`etiquetes_videos`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`etiquetes_videos` ;

CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`etiquetes_videos` (
  `idEtiquetes_videos` MEDIUMINT UNSIGNED NOT NULL,
  `idVideo` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idEtiquetes_videos`, `idVideo`),
  INDEX `fk_etiquetesvideos_videos_idx` (`idVideo` ASC) VISIBLE,
  CONSTRAINT `fk_etiquetesvideos_etiquetes`
    FOREIGN KEY (`idEtiquetes_videos`)
    REFERENCES `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_etiquetesvideos_videos`
    FOREIGN KEY (`idVideo`)
    REFERENCES `S201N2E1_YOUTUBE`.`videos` (`Id_videos`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;

USE `S201N2E1_YOUTUBE` ;

-- -----------------------------------------------------
-- Placeholder table for view `S201N2E1_YOUTUBE`.`usuari_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`usuari_complet_vw` (`Id_usuari` INT, `email_usuari` INT, `nom_usuari` INT, `password_usuari` INT, `DateNeixament_usuari` INT, `cp_usuari` INT, `Id_sexe` INT, `Nom_sexe` INT, `Id_pais` INT, `nom_pais` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N2E1_YOUTUBE`.`playlist_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`playlist_complet_vw` (`Id_playlist` INT, `nom_playlist` INT, `data_playlist` INT, `Id_estat_playlist` INT, `nom_estat_playlist` INT, `Id_usuari` INT, `nom_usuari` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N2E1_YOUTUBE`.`video_complet_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`video_complet_vw` (`Id_videos` INT, `titol_videos` INT, `descripcio_videos` INT, `mida_videos` INT, `nom_arxiu_videos` INT, `temps_videos` INT, `thumbnail_videos` INT, `reproduccions_videos` INT, `likes_videos` INT, `dislikes_videos` INT, `datetime_videos` INT, `Id_estat_video` INT, `nom_estat_video` INT, `Id_usuari` INT, `nom_usuari` INT);

-- -----------------------------------------------------
-- Placeholder table for view `S201N2E1_YOUTUBE`.`estat_global_vw`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`estat_global_vw` (`'Nº TOTAL USUARIS'` INT, `'Nº TOTAL HOMES'` INT, `'Nº TOTAL DONES'` INT, `'Nº TOTAL SUBSCRIPCIONS'` INT, `'Nº TOTAL CANALS'` INT, `'Nº TOTAL DE VIDEOS'` INT, `'Nº TOTAL DE LIKES A videos'` INT, `'Nº TOTAL D\'ETIQUETES'` INT, `' Nº TOTAL DE COMENTARIS'` INT, `'Nº TOTAL DE LIKES A COMENTARIS'` INT, `'Nº TOTAL DE PLAYLISTS'` INT);

-- -----------------------------------------------------
-- View `S201N2E1_YOUTUBE`.`usuari_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`usuari_complet_vw`;
DROP VIEW IF EXISTS `S201N2E1_YOUTUBE`.`usuari_complet_vw` ;
USE `S201N2E1_YOUTUBE`;
CREATE  OR REPLACE VIEW `usuari_complet_vw` AS
    SELECT 
        `usu`.`Id_usuari` AS `Id_usuari`,
        `usu`.`email_usuari` AS `email_usuari`,
        `usu`.`nom_usuari` AS `nom_usuari`,
        `usu`.`password_usuari` AS `password_usuari`,
        `usu`.`DateNeixament_usuari` AS `DateNeixament_usuari`,
        `usu`.`cp_usuari` AS `cp_usuari`,
        `sx`.`Id_sexe` AS `Id_sexe`,
        `sx`.`Nom_sexe` AS `Nom_sexe`,
        `ps`.`Id_pais` AS `Id_pais`,
        `ps`.`nom_pais` AS `nom_pais`
    FROM `usuaris` `usu`
        LEFT JOIN `sexe` `sx` ON `sx`.`Id_sexe` = `usu`.`idsexe_usuari`
        LEFT JOIN `pais` `ps` ON `ps`.`Id_pais` = `usu`.`id_pais_usuaris`
    GROUP BY `usu`.`Id_usuari`
    ORDER BY `usu`.`nom_usuari`;

-- -----------------------------------------------------
-- View `S201N2E1_YOUTUBE`.`playlist_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`playlist_complet_vw`;
DROP VIEW IF EXISTS `S201N2E1_YOUTUBE`.`playlist_complet_vw` ;
USE `S201N2E1_YOUTUBE`;
CREATE  OR REPLACE VIEW `playlist_complet_vw` AS
SELECT 
	`ply`.`Id_playlist` AS `Id_playlist`,
	`ply`.`nom_playlist` AS `nom_playlist`,
	`ply`.`data_playlist` AS `data_playlist`,
	`estply`.`Id_estat_playlist` AS `Id_estat_playlist`,
	`estply`.`nom_estat_playlist` AS `nom_estat_playlist`,
	`usu`.`Id_usuari` AS `Id_usuari`,
	`usu`.`nom_usuari` AS `nom_usuari`
FROM `playlist` `ply`
	LEFT JOIN `estat_playlist` `estply` ON `estply`.`Id_estat_playlist` = `ply`.`id_estat_playlist_playlist`
	LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuari` = `ply`.`idUsuari_playlist`
GROUP BY `ply`.`Id_playlist`
ORDER BY `ply`.`nom_playlist`;

-- -----------------------------------------------------
-- View `S201N2E1_YOUTUBE`.`video_complet_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`video_complet_vw`;
DROP VIEW IF EXISTS `S201N2E1_YOUTUBE`.`video_complet_vw` ;
USE `S201N2E1_YOUTUBE`;
CREATE  OR REPLACE VIEW `video_complet_vw` AS
SELECT 
	`vds`.`Id_videos` AS `Id_videos`,
	`vds`.`titol_videos` AS `titol_videos`,
	`vds`.`descripcio_videos` AS `descripcio_videos`,
	`vds`.`mida_videos` AS `mida_videos`,
	`vds`.`nom_arxiu_videos` AS `nom_arxiu_videos`,
	`vds`.`temps_videos` AS `temps_videos`,
	`vds`.`thumbnail_videos` AS `thumbnail_videos`,
	`vds`.`reproduccions_videos` AS `reproduccions_videos`,
	`vds`.`likes_videos` AS `likes_videos`,
	`vds`.`dislikes_videos` AS `dislikes_videos`,
	`vds`.`datetime_videos` AS `datetime_videos`,
	`estvd`.`Id_estat_video` AS `Id_estat_video`,
	`estvd`.`nom_estat_video` AS `nom_estat_video`,
	`usu`.`Id_usuari` AS `Id_usuari`,
	`usu`.`nom_usuari` AS `nom_usuari`
FROM `videos` `vds`
	LEFT JOIN `estat_video` `estvd` ON `estvd`.`Id_estat_video` = `vds`.`id_estat_video_videos`
	LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuari` = `vds`.`idUsari_videos`
GROUP BY `vds`.`Id_videos`
ORDER BY `vds`.`titol_videos`;

-- -----------------------------------------------------
-- View `S201N2E1_YOUTUBE`.`estat_global_vw`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `S201N2E1_YOUTUBE`.`estat_global_vw`;
DROP VIEW IF EXISTS `S201N2E1_YOUTUBE`.`estat_global_vw` ;
USE `S201N2E1_YOUTUBE`;
CREATE  OR REPLACE VIEW `estat_global_vw` AS
SELECT
(select count(*) from usuaris) as 'Nº TOTAL USUARIS',
(select count(*) from usuaris where idsexe_usuari = 1) as 'Nº TOTAL HOMES',
(select count(*) from usuaris where idsexe_usuari = 2) as 'Nº TOTAL DONES',
(select  count(*) from subscripcions) as 'Nº TOTAL SUBSCRIPCIONS',
(select count(*) from canals) as 'Nº TOTAL CANALS',
(select count(*) from videos) as 'Nº TOTAL DE VIDEOS',
(select count(*) from likes_video) as 'Nº TOTAL DE LIKES A videos',
(select count(*) from etiquetes) as 'Nº TOTAL D\'ETIQUETES',
(select count(*) from comentaris) as ' Nº TOTAL DE COMENTARIS',
(select count(*) from like_comentaris) as 'Nº TOTAL DE LIKES A COMENTARIS',
(select count(*) from playlist) as 'Nº TOTAL DE PLAYLISTS';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`sexe`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`sexe` (`Id_sexe`, `Nom_sexe`) VALUES (1, 'Home');
INSERT INTO `S201N2E1_YOUTUBE`.`sexe` (`Id_sexe`, `Nom_sexe`) VALUES (2, 'Dona');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`pais`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`pais` (`Id_pais`, `nom_pais`) VALUES (1, 'Espanya');
INSERT INTO `S201N2E1_YOUTUBE`.`pais` (`Id_pais`, `nom_pais`) VALUES (2, 'França');
INSERT INTO `S201N2E1_YOUTUBE`.`pais` (`Id_pais`, `nom_pais`) VALUES (3, 'Andorra');
INSERT INTO `S201N2E1_YOUTUBE`.`pais` (`Id_pais`, `nom_pais`) VALUES (4, 'Portugla');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`usuaris`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (1, 1, 2, 'usuari1@gmail.com', 'usuari 1', 'pass 1', '1990-12-01', '08100');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (2, 2, 1, 'usuari2@gmail.com', 'usuari 2', 'pass 2', '1989-11-02', '08101');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (3, 3, 2, 'usuari3@gmail.com', 'usuari 3', 'pass 3', '1988-10-03', '08102');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (4, 4, 1, 'usuari4@gmail.com', 'usuari 4', 'pass 4', '1987-09-04', '08103');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (5, 1, 2, 'usuari5@gmail.com', 'usuari 5', 'pass 5', '1986-08-05', '08104');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (6, 2, 1, 'usuari6@gmail.com', 'usuari 6', 'pass 6', '1985-07-06', '08105');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (7, 3, 2, 'usuari7@gmail.com', 'usuari 7', 'pass 7', '1984-06-07', '08106');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (8, 4, 1, 'usuari8@gmail.com', 'usuari 8', 'pass 8', '1983-05-08', '08107');
INSERT INTO `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`, `id_pais_usuaris`, `idsexe_usuari`, `email_usuari`, `nom_usuari`, `password_usuari`, `DateNeixament_usuari`, `cp_usuari`) VALUES (9, 1, 2, 'usuari9@gmail.com', 'usuari 9', 'pass 9', '1982-04-09', '08108');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`estat_video`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`estat_video` (`Id_estat_video`, `nom_estat_video`) VALUES (1, 'public');
INSERT INTO `S201N2E1_YOUTUBE`.`estat_video` (`Id_estat_video`, `nom_estat_video`) VALUES (2, 'ocult');
INSERT INTO `S201N2E1_YOUTUBE`.`estat_video` (`Id_estat_video`, `nom_estat_video`) VALUES (3, 'privat');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (1, 1, 1, 'Vídeo 1', 'Descripció del vídeo 1', 1, 'video1.jpg', 10, 'thumbnail_video_1', 1001, 2001, 1, '2021-12-01 00:00:01');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (2, 1, 1, 'Vídeo 2', 'Descripció del vídeo 2', 2, 'video2.jpg', 11, 'thumbnail_video_2', 1002, 2002, 2, '2021-12-01 00:00:02');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (3, 1, 1, 'Vídeo 3', 'Descripció del vídeo 3', 3, 'video3.jpg', 12, 'thumbnail_video_3', 1003, 2003, 3, '2021-12-01 00:00:03');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (4, 1, 1, 'Vídeo 4', 'Descripció del vídeo 4', 4, 'video4.jpg', 13, 'thumbnail_video_4', 1004, 2004, 4, '2021-12-01 00:00:04');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (5, 2, 1, 'Vídeo 5', 'Descripció del vídeo 5', 5, 'video5.jpg', 14, 'thumbnail_video_5', 1005, 2005, 5, '2021-12-01 00:00:05');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (6, 2, 1, 'Vídeo 6', 'Descripció del vídeo 6', 6, 'video6.jpg', 15, 'thumbnail_video_6', 1006, 2006, 6, '2021-12-01 00:00:06');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (7, 4, 1, 'Vídeo 7', 'Descripció del vídeo 7', 7, 'video7.jpg', 16, 'thumbnail_video_7', 1007, 2007, 7, '2021-12-01 00:00:07');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (8, 4, 1, 'Vídeo 8', 'Descripció del vídeo 8', 8, 'video8.jpg', 17, 'thumbnail_video_8', 1008, 2008, 8, '2021-12-01 00:00:08');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (9, 4, 1, 'Vídeo 9', 'Descripció del vídeo 9', 9, 'video9.jpg', 18, 'thumbnail_video_9', 1009, 2009, 9, '2021-12-01 00:00:09');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (10, 5, 1, 'Vídeo 10', 'Descripció del vídeo 10', 10, 'video10.jpg', 19, 'thumbnail_video_10', 1010, 2010, 10, '2021-12-01 00:00:10');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (11, 5, 1, 'Vídeo 11', 'Descripció del vídeo 11', 11, 'video11.jpg', 20, 'thumbnail_video_11', 1011, 2011, 11, '2021-12-01 00:00:11');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (12, 5, 1, 'Vídeo 12', 'Descripció del vídeo 12', 12, 'video12.jpg', 21, 'thumbnail_video_12', 1012, 2012, 12, '2021-12-01 00:00:12');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (13, 6, 1, 'Vídeo 13', 'Descripció del vídeo 13', 13, 'video13.jpg', 22, 'thumbnail_video_13', 1013, 2013, 13, '2021-12-01 00:00:13');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (14, 7, 2, 'Vídeo 14', 'Descripció del vídeo 14', 14, 'video14.jpg', 23, 'thumbnail_video_14', 1014, 2014, 14, '2021-12-01 00:00:14');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (15, 8, 2, 'Vídeo 15', 'Descripció del vídeo 15', 15, 'video15.jpg', 24, 'thumbnail_video_15', 1015, 2015, 15, '2021-12-01 00:00:15');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (16, 9, 3, 'Vídeo 16', 'Descripció del vídeo 16', 16, 'video16.jpg', 25, 'thumbnail_video_16', 1016, 2016, 16, '2021-12-01 00:00:16');
INSERT INTO `S201N2E1_YOUTUBE`.`videos` (`Id_videos`, `idUsari_videos`, `id_estat_video_videos`, `titol_videos`, `descripcio_videos`, `mida_videos`, `nom_arxiu_videos`, `temps_videos`, `thumbnail_videos`, `reproduccions_videos`, `likes_videos`, `dislikes_videos`, `datetime_videos`) VALUES (17, 3, 3, 'Vídeo 17', 'Descripció del vídeo 17', 17, 'video17.jpg', 26, 'thumbnail_video_17', 1017, 2017, 17, '2021-12-01 00:00:17');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`etiquetes`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (1, 'Etiqueta 1');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (2, 'Etiqueta 2');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (3, 'Etiqueta 3');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (4, 'Etiqueta 4');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (5, 'Etiqueta 5');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (6, 'Etiqueta 6');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (7, 'Etiqueta 7');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (8, 'Etiqueta 8');
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes` (`Id_etiquetes`, `nom_etiquetes`) VALUES (9, 'Etiqueta 9');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`canals`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (1, 1, 'canal 1', 'Doncs és el canal 1', '2020-10-01 00:00:01');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (2, 4, 'canal 2', 'Doncs és el canal 2', '2020-10-01 00:00:02');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (3, 1, 'canal 3', 'Doncs és el canal 3', '2020-10-01 00:00:03');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (4, 2, 'canal 4', 'Doncs és el canal 4', '2020-10-01 00:00:04');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (5, 2, 'canal 5', 'Doncs és el canal 5', '2020-10-01 00:00:05');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (6, 4, 'canal 6', 'Doncs és el canal 6', '2020-10-01 00:00:06');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (7, 1, 'canal 7', 'Doncs és el canal 7', '2020-10-01 00:00:07');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (8, 5, 'canal 8', 'Doncs és el canal 8', '2020-10-01 00:00:08');
INSERT INTO `S201N2E1_YOUTUBE`.`canals` (`Id_canals`, `idUsuari_canals`, `nom_canals`, `descripcio_canals`, `data_creacio_canals`) VALUES (9, 1, 'canal 9', 'Doncs és el canal 9', '2020-10-01 00:00:09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`subscripcions`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (1, 3, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (2, 3, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (3, 3, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (4, 6, 4);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (5, 6, 5);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (6, 7, 6);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (7, 7, 7);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (8, 8, 8);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (9, 8, 9);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (10, 9, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (11, 9, 4);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (12, 1, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (13, 2, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (14, 4, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`subscripcions` (`Id_subscripcions`, `idUsuari_subscripcions`, `idCanal_subscripcions`) VALUES (15, 5, 6);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`estat_playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`estat_playlist` (`Id_estat_playlist`, `nom_estat_playlist`) VALUES (1, 'publica');
INSERT INTO `S201N2E1_YOUTUBE`.`estat_playlist` (`Id_estat_playlist`, `nom_estat_playlist`) VALUES (2, 'privada');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`playlist`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`playlist` (`Id_playlist`, `idUsuari_playlist`, `id_estat_playlist_playlist`, `nom_playlist`, `data_playlist`) VALUES (1, 1, 1, 'playlist 1', '2021-09-01 00:00:01');
INSERT INTO `S201N2E1_YOUTUBE`.`playlist` (`Id_playlist`, `idUsuari_playlist`, `id_estat_playlist_playlist`, `nom_playlist`, `data_playlist`) VALUES (2, 2, 1, 'playlist 2', '2021-09-01 00:00:02');
INSERT INTO `S201N2E1_YOUTUBE`.`playlist` (`Id_playlist`, `idUsuari_playlist`, `id_estat_playlist_playlist`, `nom_playlist`, `data_playlist`) VALUES (3, 4, 1, 'playlist 3', '2021-09-01 00:00:03');
INSERT INTO `S201N2E1_YOUTUBE`.`playlist` (`Id_playlist`, `idUsuari_playlist`, `id_estat_playlist_playlist`, `nom_playlist`, `data_playlist`) VALUES (4, 5, 2, 'playlist 4', '2021-09-01 00:00:04');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`videosPlayList`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (1, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (1, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (1, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (1, 4);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (2, 5);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (2, 6);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (3, 7);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (3, 8);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (3, 9);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (4, 10);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (4, 11);
INSERT INTO `S201N2E1_YOUTUBE`.`videosPlayList` (`Idplaylist_videosPlayList`, `idVideo_videosPlayList`) VALUES (4, 12);

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`comentaris`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (1, 5, 1, 'Comwentari del vídeo 1', '2022-01-10 00:00:01');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (2, 5, 2, 'Comwentari del vídeo 2', '2022-01-10 00:00:02');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (3, 5, 3, 'Comwentari del vídeo 3', '2022-01-10 00:00:03');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (4, 6, 4, 'Comwentari del vídeo 4', '2022-01-10 00:00:04');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (5, 6, 5, 'Comwentari del vídeo 5', '2022-01-10 00:00:05');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (6, 7, 6, 'Comwentari del vídeo 6', '2022-01-10 00:00:06');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (7, 7, 7, 'Comwentari del vídeo 7', '2022-01-10 00:00:07');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (8, 8, 8, 'Comwentari del vídeo 8', '2022-01-10 00:00:08');
INSERT INTO `S201N2E1_YOUTUBE`.`comentaris` (`Id_comentaris`, `idUsuari_comentaris`, `idVideo_comentaris`, `text_comentaris`, `datahora_comentaris`) VALUES (9, 9, 9, 'Comwentari del vídeo 9', '2022-01-10 00:00:09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`like_comentaris`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (1, 1, 1, '2022-02-10 11:11:01');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (2, 2, 1, '2022-02-10 11:11:02');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (3, 3, 0, '2022-02-10 11:11:03');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (4, 4, 1, '2022-02-10 11:11:04');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (5, 1, 1, '2022-02-10 11:11:05');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (6, 2, 0, '2022-02-10 11:11:06');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (7, 3, 1, '2022-02-10 11:11:07');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (8, 4, 1, '2022-02-10 11:11:08');
INSERT INTO `S201N2E1_YOUTUBE`.`like_comentaris` (`idComentari_like_comentaris`, `idUsuari_like_comentaris`, `like_dislike_comentaris`, `datahora_comentaris`) VALUES (9, 1, 0, '2022-02-10 11:11:09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `S201N2E1_YOUTUBE`.`etiquetes_videos`
-- -----------------------------------------------------
START TRANSACTION;
USE `S201N2E1_YOUTUBE`;
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (1, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (2, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (3, 1);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (4, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (5, 2);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (6, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (7, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (8, 3);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (9, 4);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (1, 4);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (2, 5);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (3, 5);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (4, 6);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (5, 6);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (6, 7);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (7, 7);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (8, 8);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (9, 8);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (1, 9);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (2, 9);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (3, 10);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (4, 10);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (5, 11);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (6, 11);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (7, 12);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (8, 12);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (9, 13);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (1, 13);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (2, 14);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (3, 15);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (4, 16);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (5, 16);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (1, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (2, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (3, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (4, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (5, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (6, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (7, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (8, 17);
INSERT INTO `S201N2E1_YOUTUBE`.`etiquetes_videos` (`idEtiquetes_videos`, `idVideo`) VALUES (9, 17);

COMMIT;

