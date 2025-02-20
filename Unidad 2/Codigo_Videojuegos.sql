-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TiendaVideojuegos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TiendaVideojuegos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TiendaVideojuegos` DEFAULT CHARACTER SET utf8 ;
USE `TiendaVideojuegos` ;

-- -----------------------------------------------------
-- Table `TiendaVideojuegos`.`Distribuidor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TiendaVideojuegos`.`Distribuidor` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Marca` NVARCHAR(50) NOT NULL,
  `Descripcion` NVARCHAR(200) NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TiendaVideojuegos`.`Genero`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TiendaVideojuegos`.`Genero` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(50) NOT NULL,
  `CompId` INT NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TiendaVideojuegos`.`Plataforma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TiendaVideojuegos`.`Plataforma` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(50) NOT NULL,
  PRIMARY KEY (`Id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TiendaVideojuegos`.`VideoJuego`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TiendaVideojuegos`.`VideoJuego` (
  `Id` INT NOT NULL AUTO_INCREMENT,
  `Nombre` NVARCHAR(30) NOT NULL,
  `FechaLanzamiento` DATE NOT NULL,
  `UnidadesDisponibles` INT NOT NULL,
  `Descripcion` NVARCHAR(200) NULL,
  `DistribuidorId` INT NOT NULL,
  `GeneroId` INT NOT NULL,
  `PlataformaId` INT NOT NULL,
  PRIMARY KEY (`Id`),
  INDEX `fk_Videojuego_Distribuidor_idx` (`DistribuidorId` ASC) VISIBLE,
  INDEX `fk_videojuegos_Genero_idx` (`GeneroId` ASC) VISIBLE,
  INDEX `fk_videojuegos_plataforma_idx` (`PlataformaId` ASC) VISIBLE,
  CONSTRAINT `fk_Videojuego_Distribuidor`
    FOREIGN KEY (`DistribuidorId`)
    REFERENCES `TiendaVideojuegos`.`Distribuidor` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videojuegos_Genero`
    FOREIGN KEY (`GeneroId`)
    REFERENCES `TiendaVideojuegos`.`Genero` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_videojuegos_plataforma`
    FOREIGN KEY (`PlataformaId`)
    REFERENCES `TiendaVideojuegos`.`Plataforma` (`Id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
