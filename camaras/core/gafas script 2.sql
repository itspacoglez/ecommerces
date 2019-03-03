-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema gafas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema gafas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `gafas` DEFAULT CHARACTER SET utf8 ;
USE `gafas` ;

-- -----------------------------------------------------
-- Table  `categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `categoria` (
  `idCategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreCategoria` VARCHAR(45) NULL DEFAULT NULL,
  `descripCategoria` LONGTEXT NULL DEFAULT NULL,
  `imgCategoria` LONGBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idCategoria`))
ENGINE = InnoDB
AUTO_INCREMENT = 18
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `cliente` (
  `idCliente` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreCliente` VARCHAR(45) NOT NULL,
  `apPaternoCliente` VARCHAR(45) NOT NULL,
  `apMaternoCliente` VARCHAR(45) NOT NULL,
  `cpCliente` VARCHAR(5) NOT NULL,
  `numInteCliente` VARCHAR(4) NOT NULL,
  `numExtCliente` VARCHAR(4) NULL DEFAULT NULL,
  `estadoCliente` VARCHAR(30) NOT NULL,
  `ciudadCliente` VARCHAR(45) NOT NULL,
  `paisCliente` VARCHAR(45) NOT NULL,
  `coloniaCliente` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `email` (
  `idEmail` INT(11) NOT NULL AUTO_INCREMENT,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idEmail`, `Cliente_idCliente`),
  INDEX `fk_Email_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Email_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES  `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `gafas` (
  `idGafas` INT(11) NOT NULL AUTO_INCREMENT,
  `codGafas` VARCHAR(10) NOT NULL,
  `nombreGafas` VARCHAR(100) NOT NULL,
  `desCGafas` LONGTEXT NOT NULL,
  `extrDesGafas` VARCHAR(150) NOT NULL,
  `colorGafas` VARCHAR(100) NOT NULL,
  `precioGafas` FLOAT NOT NULL,
  `stockGafas` INT(11) NOT NULL,
  `imgGafas` LONGBLOB NULL DEFAULT NULL,
  `Categoria_idCategoria` INT(11) NOT NULL,
  PRIMARY KEY (`idGafas`, `Categoria_idCategoria`),
  INDEX `fk_Gafas_Categoria_idx` (`Categoria_idCategoria` ASC),
  CONSTRAINT `fk_Gafas_Categoria`
    FOREIGN KEY (`Categoria_idCategoria`)
    REFERENCES  `categoria` (`idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 32
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `tipopago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `tipopago` (
  `idTipoPago` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoPago` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idTipoPago`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `pedido` (
  `idPedido` INT(11) NOT NULL AUTO_INCREMENT,
  `fechaPedido` DATE NOT NULL,
  `subTotalPedido` DECIMAL(10,0) NOT NULL,
  `totalPedido` DECIMAL(10,0) NOT NULL,
  `precioEnvioPedido` DECIMAL(10,0) NOT NULL,
  `estadoPedido` VARCHAR(45) NOT NULL,
  `TipoPago_idTipoPago` INT(11) NOT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idPedido`, `TipoPago_idTipoPago`, `Cliente_idCliente`),
  INDEX `fk_Pedido_TipoPago1_idx` (`TipoPago_idTipoPago` ASC),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES  `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_TipoPago1`
    FOREIGN KEY (`TipoPago_idTipoPago`)
    REFERENCES  `tipopago` (`idTipoPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `pedido_gafas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `pedido_gafas` (
  `Pedido_idPedido` INT(11) NOT NULL,
  `Pedido_TipoPago_idTipoPago` INT(11) NOT NULL,
  `Pedido_Cliente_idCliente` INT(11) NOT NULL,
  `Gafas_idGafas` INT(11) NOT NULL,
  `Gafas_Categoria_idCategoria` INT(11) NOT NULL,
  `cantidadGafas` INT(11) NOT NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Pedido_TipoPago_idTipoPago`, `Pedido_Cliente_idCliente`, `Gafas_idGafas`, `Gafas_Categoria_idCategoria`),
  INDEX `fk_Pedido_has_Gafas_Gafas1_idx` (`Gafas_idGafas` ASC, `Gafas_Categoria_idCategoria` ASC),
  INDEX `fk_Pedido_has_Gafas_Pedido1_idx` (`Pedido_idPedido` ASC, `Pedido_TipoPago_idTipoPago` ASC, `Pedido_Cliente_idCliente` ASC),
  CONSTRAINT `fk_Pedido_has_Gafas_Gafas1`
    FOREIGN KEY (`Gafas_idGafas` , `Gafas_Categoria_idCategoria`)
    REFERENCES  `gafas` (`idGafas` , `Categoria_idCategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_has_Gafas_Pedido1`
    FOREIGN KEY (`Pedido_idPedido` , `Pedido_TipoPago_idTipoPago` , `Pedido_Cliente_idCliente`)
    REFERENCES  `pedido` (`idPedido` , `TipoPago_idTipoPago` , `Cliente_idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `telefono`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `telefono` (
  `idTelefono` INT(11) NOT NULL AUTO_INCREMENT,
  `Telefono` VARCHAR(10) NULL DEFAULT NULL,
  `Cliente_idCliente` INT(11) NOT NULL,
  PRIMARY KEY (`idTelefono`, `Cliente_idCliente`),
  INDEX `fk_Telefono_Cliente1_idx` (`Cliente_idCliente` ASC),
  CONSTRAINT `fk_Telefono_Cliente1`
    FOREIGN KEY (`Cliente_idCliente`)
    REFERENCES  `cliente` (`idCliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table  `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS  `usuarios` (
  `idUsuarios` INT(11) NOT NULL AUTO_INCREMENT,
  `nombreUsuario` VARCHAR(30) NOT NULL,
  `passUsuario` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idUsuarios`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

