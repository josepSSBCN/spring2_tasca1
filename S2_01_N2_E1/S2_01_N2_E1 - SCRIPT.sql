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
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`sexe` (
  `Id_sexe` TINYINT UNSIGNED NOT NULL,
  `Nom_sexe` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`Id_sexe`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`usuaris`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`usuaris` (
  `Id_usuari` INT UNSIGNED NOT NULL AUTO_INCREMENT,
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
  CONSTRAINT `fk_usuaris_sexe`
    FOREIGN KEY (`idsexe_usuari`)
    REFERENCES `S201N2E1_YOUTUBE`.`sexe` (`Id_sexe`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`videos` (
  `Id_videos` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUsari_videos` INT UNSIGNED NOT NULL,
  `titol_videos` VARCHAR(30) NOT NULL,
  `descripcio_videos` VARCHAR(256) NULL,
  `mida_videos` SMALLINT UNSIGNED NOT NULL,
  `nom_arxiu_videos` VARCHAR(30) NOT NULL,
  `temps_videos` SMALLINT UNSIGNED NOT NULL,
  `thumbnail_videos` VARCHAR(20) NOT NULL,
  `reproduccions_videos` INT UNSIGNED NOT NULL,
  `likes_videos` INT UNSIGNED NOT NULL,
  `dislikes_videos` INT UNSIGNED NOT NULL,
  `estat_videos` ENUM('public', 'ocult', 'privat') NOT NULL,
  `datetime_videos` DATETIME NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Id_videos`),
  UNIQUE INDEX `Id_videos_UNIQUE` (`Id_videos` ASC) INVISIBLE,
  INDEX `fk_videos_usuaris_idx` (`idUsari_videos` ASC) VISIBLE,
  INDEX `idUsari_videos_idx` (`idUsari_videos` ASC) INVISIBLE,
  INDEX `titol_videos_idx` (`titol_videos` ASC) VISIBLE,
  CONSTRAINT `fk_videos_usuaris`
    FOREIGN KEY (`idUsari_videos`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`etiquetes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`etiquetes` (
  `Id_etiquetes` MEDIUMINT UNSIGNED NOT NULL AUTO_INCREMENT COMMENT 'Suposem que mai arribarem a les 16M d\'etiquetes',
  `nom_etiquetes` VARCHAR(45) NULL,
  PRIMARY KEY (`Id_etiquetes`),
  UNIQUE INDEX `Id_etiquetes_UNIQUE` (`Id_etiquetes` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`canals`
-- -----------------------------------------------------
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
-- Table `S201N2E1_YOUTUBE`.`playlist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`playlist` (
  `Id_playlist` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `idUsuari_playlist` INT UNSIGNED NOT NULL,
  `nom_playlist` VARCHAR(30) NOT NULL,
  `data_playlist` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estat_playlist` ENUM('privada', 'publica') NOT NULL,
  PRIMARY KEY (`Id_playlist`),
  UNIQUE INDEX `Id_playlist_UNIQUE` (`Id_playlist` ASC) VISIBLE,
  INDEX `fk_playlist_usuari_idx` (`idUsuari_playlist` ASC) VISIBLE,
  CONSTRAINT `fk_playlist_usuari`
    FOREIGN KEY (`idUsuari_playlist`)
    REFERENCES `S201N2E1_YOUTUBE`.`usuaris` (`Id_usuari`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `S201N2E1_YOUTUBE`.`videosPlayList`
-- -----------------------------------------------------
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
CREATE TABLE IF NOT EXISTS `S201N2E1_YOUTUBE`.`like_comentaris` (
  `idComentari_like_comentaris` BIGINT UNSIGNED NOT NULL,
  `idUsuari_like_comentaris` INT UNSIGNED NOT NULL,
  `like_dislike_comentaris` TINYINT NOT NULL COMMENT '0 = no m\'agrada;\n1 = m\'agrada',
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

