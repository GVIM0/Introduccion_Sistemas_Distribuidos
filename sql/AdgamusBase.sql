-- MySQL Script generated by MySQL Workbench
-- Sat Oct 28 18:45:24 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering
DROP DATABASE IF EXISTS AdgamusBase;
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Adgamus` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Adgamus` DEFAULT CHARACTER SET utf8 ;
USE `Adgamus` ;

-- -----------------------------------------------------
-- Table `Adgamus`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Usuario` (
    `idUsuario` INT NOT NULL AUTO_INCREMENT,
    `NombreUsuario` VARCHAR(45) DEFAULT NULL,
    `CorreoUsuario` VARCHAR(45) DEFAULT NULL,
    `Contraseña` VARCHAR(255) DEFAULT NULL,
    `Nombre` VARCHAR(45) DEFAULT NULL,
    `Apellido` VARCHAR(45) DEFAULT NULL,
    `Descripcion` VARCHAR(45) DEFAULT NULL,
    `Foto_Perfil` TINYBLOB,
    `Preferencias` VARCHAR(45) DEFAULT NULL,
    `Administrador` BOOLEAN default false,
    PRIMARY KEY (`idUsuario`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Insert `Admin` como `Usuario`
-- -----------------------------------------------------

INSERT INTO Usuario (NombreUsuario, CorreoUsuario, Contraseña, Nombre, Apellido, Descripcion, Administrador)
VALUES
  ("0M1N", "salinas.aquino.omarivan@gmail.com", "$2b$12$KX6NWIf1SkB4zyGleiJQ7esUajj5VeWu2Q9WSmwRPxqQJZpYKOmBS",
   "Omar Ivan", "Salinas Aquino", "Hola soy Omar.", true),
   
  ("AbsorbedSun", "garcia.ambrosio.aldo@gmail.com", "$2b$12$SI5pLnHpwiwiZIt4bDpOHOm3I/gA1KQmGewIQDb3Uf4c6QMmfqPfe",
   "Aldo", "Garcia Ambrosio", "Hola soy Aldo", true),
   
  ("MAPE", "ponce.espino.miguelangel@gmail.com", "$2b$12$uo0HTPL7h1Voq8ONcj7/HutZLvuwhXBNfBs4hHTKm28D.SdKY7Fay",
   "Miguel Angel", "Ponce Espino", "Hola soy Ponce", true),
   
  ("GARVEN092", "hernadez.vera.gabriel09@gmail.com", "$2b$12$whbNQgWnEWIogfQBDR2Zu.xtOPv/6SeCai3oNJm3vgS5GuwPqNbwW",
   "Gabriel", "Hernandez Vera", "Hola soy Gabo", true);

-- -----------------------------------------------------
-- Table `Adgamus`.`Catalogo_Taxonomia_C`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Catalogo_Taxonomia_C` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Catalogo_Taxonomia_C` (
    `idCatalogo_Taxonomia` INT NOT NULL,
    `Reino` VARCHAR(45),
    `Filo` VARCHAR(45),
    `Clase` VARCHAR(45),
    `Orden` VARCHAR(45),
    `Familia` VARCHAR(45),
    `Genero` VARCHAR(45),
    `Especie` VARCHAR(45),
    PRIMARY KEY (`idCatalogo_Taxonomia`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Cultivo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Cultivo` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Cultivo` (
    `idCultivo` INT NOT NULL AUTO_INCREMENT,
    `Tipo` VARCHAR(45),
    `RegionGeografica` VARCHAR(45),
    `Foto` BLOB,
    `Nombre_Comun` VARCHAR(45),
    `Nombre_Especie` VARCHAR(45),
    `Nombre_Genero` VARCHAR(45),
    `Rasgos_Especificos` VARCHAR(255),
    `Informacion_Cuidado` VARCHAR(255),
    `Catalogo_Taxonomia_idCatalogo_Taxonomia` INT NOT NULL,
    PRIMARY KEY (`idCultivo`),
    INDEX `fk_Cultivo_Catalogo_Taxonomia1_idx` (`Catalogo_Taxonomia_idCatalogo_Taxonomia`),
    CONSTRAINT `fk_Cultivo_Catalogo_Taxonomia1`
        FOREIGN KEY (`Catalogo_Taxonomia_idCatalogo_Taxonomia`)
        REFERENCES `Adgamus`.`Catalogo_Taxonomia_C` (`idCatalogo_Taxonomia`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Busqueda`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Busqueda` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Busqueda` (
    `idBusqueda` INT NOT NULL AUTO_INCREMENT,
    `idUsuario` INT NOT NULL,
    `idCultivo` INT NOT NULL,
    `Usuario_idUsuario` INT NOT NULL,
    `Cultivo_idCultivo` INT NOT NULL,
    PRIMARY KEY (`idBusqueda`),
    INDEX `fk_Busqueda_Usuario1_idx` (`Usuario_idUsuario`),
    INDEX `fk_Busqueda_Cultivo1_idx` (`Cultivo_idCultivo`),
    CONSTRAINT `fk_Busqueda_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_Busqueda_Cultivo1`
        FOREIGN KEY (`Cultivo_idCultivo`)
        REFERENCES `Adgamus`.`Cultivo` (`idCultivo`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Seguimiento`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Seguimiento` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Seguimiento` (
    `idSeguimiento` INT NOT NULL AUTO_INCREMENT,
    `Tipo_Seg` VARCHAR(45),
    `Descripcion` VARCHAR(45),
    `Nombre` VARCHAR(45),
    `Usuario_idUsuario` INT NOT NULL,
    PRIMARY KEY (`idSeguimiento`),
    INDEX `fk_Seguimiento_Usuario1_idx` (`Usuario_idUsuario`),
    CONSTRAINT `fk_Seguimiento_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Catalogo_Taxonomia_A`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Catalogo_Taxonomia_A` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Catalogo_Taxonomia_A` (
    `idCatalogo_Taxonomia` INT NOT NULL,
    `Reino` VARCHAR(45),
    `Filo` VARCHAR(45),
    `Clase` VARCHAR(45),
    `Orden` VARCHAR(45),
    `Familia` VARCHAR(45),
    `Genero` VARCHAR(45),
    `Especie` VARCHAR(45),
    PRIMARY KEY (`idCatalogo_Taxonomia`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Especia_Animal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Especia_Animal` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Especia_Animal` (
    `idAnimal` INT NOT NULL AUTO_INCREMENT,
    `Nombre_Especie` VARCHAR(45),
    `Nombre_Genero` VARCHAR(45),
    `Nombre_Comun_E` VARCHAR(45),
    `Descripcion_General` VARCHAR(45),
    `Descripcion_Fisica` VARCHAR(45),
    `Promedio_Vida` VARCHAR(45),
    `Foto` BLOB,
    `Catalogo_Taxonomia_A_idCatalogo_Taxonomia` INT NOT NULL,
    PRIMARY KEY (`idAnimal`),
    INDEX `fk_Especia_Animal_Catalogo_Taxonomia_A1_idx` (`Catalogo_Taxonomia_A_idCatalogo_Taxonomia`),
    CONSTRAINT `fk_Especia_Animal_Catalogo_Taxonomia_A1`
        FOREIGN KEY (`Catalogo_Taxonomia_A_idCatalogo_Taxonomia`)
        REFERENCES `Adgamus`.`Catalogo_Taxonomia_A` (`idCatalogo_Taxonomia`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Cria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Cria` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Cria` (
    `idCria` INT NOT NULL AUTO_INCREMENT,
    `idUsuario` INT NOT NULL,
    `idAnimal` INT NOT NULL,
    `Usuario_idUsuario` INT NOT NULL,
    `Especia_Animal_idAnimal` INT NOT NULL,
    PRIMARY KEY (`idCria`),
    INDEX `fk_Cria_Usuario1_idx` (`Usuario_idUsuario`),
    INDEX `fk_Cria_Especia_Animal1_idx` (`Especia_Animal_idAnimal`),
    CONSTRAINT `fk_Cria_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_Cria_Especia_Animal1`
        FOREIGN KEY (`Especia_Animal_idAnimal`)
        REFERENCES `Adgamus`.`Especia_Animal` (`idAnimal`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Post`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Post` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Post` (
    `idPost` INT NOT NULL AUTO_INCREMENT,
    `Fecha` DATE,
    `Titulo` VARCHAR(45),
    `Descripcion` VARCHAR(45),
    `Etiquetas` VARCHAR(45),
    `Foto` BLOB,
    `Hora` TIME,
    `Usuario_idUsuario` INT NOT NULL,
    PRIMARY KEY (`idPost`),
    INDEX `fk_Post_Usuario1_idx` (`Usuario_idUsuario`),
    CONSTRAINT `fk_Post_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`CatalogoEtiquetas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`CatalogoEtiquetas` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`CatalogoEtiquetas` (
    `idCatalogoEtiquetas` INT NOT NULL AUTO_INCREMENT,
    `Descripcion` VARCHAR(45),
    PRIMARY KEY (`idCatalogoEtiquetas`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`CatalogoRespuesta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`CatalogoRespuesta` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`CatalogoRespuesta` (
    `idCatalogoRespuesta` INT NOT NULL AUTO_INCREMENT,
    `Descripcion` VARCHAR(45),
    PRIMARY KEY (`idCatalogoRespuesta`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Respuetas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Respuetas` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Respuetas` (
    `idRespuesta` INT NOT NULL AUTO_INCREMENT,
    `CatalogoEtiquetas_idCatalogoEtiquetas` INT NOT NULL,
    `CatalogoRespuesta_idCatalogoRespuesta` INT NOT NULL,
    `Usuario_idUsuario` INT NOT NULL,
    PRIMARY KEY (`idRespuesta`),
    INDEX `fk_ChatBot_CatalogoEtiquetas1_idx` (`CatalogoEtiquetas_idCatalogoEtiquetas`),
    INDEX `fk_ChatBot_CatalogoRespuesta1_idx` (`CatalogoRespuesta_idCatalogoRespuesta`),
    INDEX `fk_Respuetas_Usuario1_idx` (`Usuario_idUsuario`),
    CONSTRAINT `fk_ChatBot_CatalogoEtiquetas1`
        FOREIGN KEY (`CatalogoEtiquetas_idCatalogoEtiquetas`)
        REFERENCES `Adgamus`.`CatalogoEtiquetas` (`idCatalogoEtiquetas`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_ChatBot_CatalogoRespuesta1`
        FOREIGN KEY (`CatalogoRespuesta_idCatalogoRespuesta`)
        REFERENCES `Adgamus`.`CatalogoRespuesta` (`idCatalogoRespuesta`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_Respuetas_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Recurso`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Recurso` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Recurso` (
    `idRecurso` INT NOT NULL AUTO_INCREMENT,
    `Unidad_Medida` REAL,
    `Nombre` VARCHAR(45),
    `Tarifa` INT,
    `Descripcion` VARCHAR(45),
    PRIMARY KEY (`idRecurso`)
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Cotiza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Cotiza` ;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Cotiza` (
    `idCosto` INT NOT NULL AUTO_INCREMENT,
    `idUsuario` INT NOT NULL,
    `idRecurso` INT NOT NULL,
    `Periodo_Facturacion` DATE,
    `Costo_Total` INT,
    `Recurso_idRecurso` INT NOT NULL,
    `Usuario_idUsuario` INT NOT NULL,
    PRIMARY KEY (`idCosto`),
    INDEX `fk_Cotiza_Recurso1_idx` (`Recurso_idRecurso`),
    INDEX `fk_Cotiza_Usuario1_idx` (`Usuario_idUsuario`),
    CONSTRAINT `fk_Cotiza_Recurso1`
        FOREIGN KEY (`Recurso_idRecurso`)
        REFERENCES `Adgamus`.`Recurso` (`idRecurso`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    CONSTRAINT `fk_Cotiza_Usuario1`
        FOREIGN KEY (`Usuario_idUsuario`)
        REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `Adgamus`.`Consume`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Adgamus`.`Consume`;

CREATE TABLE IF NOT EXISTS `Adgamus`.`Consume` (
  `idConsumo` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `idRecurso` INT NOT NULL,
  `Fecha` DATE,
  `Hora` TIME,
  `Cantidad` INT,
  `Recurso_idRecurso` INT NOT NULL,
  `Usuario_idUsuario` INT NOT NULL,
  PRIMARY KEY (`idConsumo`, `Recurso_idRecurso`, `Usuario_idUsuario`),
  INDEX `fk_Consume_Recurso1_idx` (`Recurso_idRecurso` ASC),
  INDEX `fk_Consume_Usuario1_idx` (`Usuario_idUsuario` ASC),
  CONSTRAINT `fk_Consume_Recurso1`
    FOREIGN KEY (`Recurso_idRecurso`)
    REFERENCES `Adgamus`.`Recurso` (`idRecurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Consume_Usuario1`
    FOREIGN KEY (`Usuario_idUsuario`)
    REFERENCES `Adgamus`.`Usuario` (`idUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

select * from Usuario;