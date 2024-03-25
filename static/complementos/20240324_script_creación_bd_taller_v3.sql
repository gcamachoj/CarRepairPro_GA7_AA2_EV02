-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema taller
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema taller
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `taller` DEFAULT CHARACTER SET utf8 ;
USE `taller` ;

-- -----------------------------------------------------
-- Table `taller`.`Tipo_Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Tipo_Cliente` (
  `IdTipoCliente` INT NOT NULL AUTO_INCREMENT,
  `TipoCliente` VARCHAR(45) NOT NULL,
  `IdEstado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdTipoCliente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `TipoCliente_UNIQUE` ON `taller`.`Tipo_Cliente` (`TipoCliente` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Ciudades` (
  `IdCiudad` INT NOT NULL AUTO_INCREMENT,
  `Ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdCiudad`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Ciudad_UNIQUE` ON `taller`.`Ciudades` (`Ciudad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Clientes` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT,
  `IdTipoCliente` INT NOT NULL,
  `CC_NIT` VARCHAR(50) NOT NULL,
  `Nombres` VARCHAR(100) NOT NULL,
  `IdCiudad` INT NOT NULL,
  `Direccion` VARCHAR(150) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IdCliente`),
  CONSTRAINT `IdTipoCLiente`
    FOREIGN KEY (`IdTipoCliente`)
    REFERENCES `taller`.`Tipo_Cliente` (`IdTipoCliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdCiudad_Cliente`
    FOREIGN KEY (`IdCiudad`)
    REFERENCES `taller`.`Ciudades` (`IdCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdTipoCliente__` ON `taller`.`Clientes` (`IdTipoCliente` ASC) INVISIBLE;

CREATE UNIQUE INDEX `CC_NIT_UNIQUE` ON `taller`.`Clientes` (`CC_NIT` ASC) VISIBLE;

CREATE INDEX `IdCiudad_idx` ON `taller`.`Clientes` (`IdCiudad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Roles` (
  `IdRol` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdRol`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Descripcion_UNIQUE` ON `taller`.`Roles` (`Descripcion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Empleados` (
  `IdEmpleados` INT NOT NULL AUTO_INCREMENT,
  `IdRol` INT NOT NULL,
  `IdStatus` INT NOT NULL DEFAULT 1,
  `CC_Nit` VARCHAR(45) NOT NULL COMMENT 'Cedula o Nit',
  `Nombre` VARCHAR(100) NOT NULL,
  `Apellidos` VARCHAR(100) NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `IdEstado` INT NOT NULL DEFAULT 1,
  `IdCiudad` INT NOT NULL,
  PRIMARY KEY (`IdEmpleados`),
  CONSTRAINT `IdRol`
    FOREIGN KEY (`IdRol`)
    REFERENCES `taller`.`Roles` (`IdRol`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdCiuda_Empleado`
    FOREIGN KEY (`IdCiudad`)
    REFERENCES `taller`.`Ciudades` (`IdCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdRol_idx` ON `taller`.`Empleados` (`IdRol` ASC) VISIBLE;

CREATE INDEX `IdCiudad_idx` ON `taller`.`Empleados` (`IdCiudad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Tipos_Carroceria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Tipos_Carroceria` (
  `IdTipoCarroceria` INT NOT NULL AUTO_INCREMENT,
  `TipoCarroceria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTipoCarroceria`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `TipoCarroceria_UNIQUE` ON `taller`.`Tipos_Carroceria` (`TipoCarroceria` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Marcas` (
  `IdMarcas` INT NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdMarcas`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Marca_UNIQUE` ON `taller`.`Marcas` (`Marca` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Vehiculos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Vehiculos` (
  `IdVehiculo` INT NOT NULL AUTO_INCREMENT,
  `Placa` VARCHAR(10) NOT NULL,
  `IdMarca` INT NOT NULL,
  `Linea` VARCHAR(45) NOT NULL,
  `Modelo` INT NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  `IdTipoCarroceria` INT NOT NULL,
  `IdCiudad` INT NOT NULL,
  PRIMARY KEY (`IdVehiculo`),
  CONSTRAINT `IdMarca`
    FOREIGN KEY (`IdMarca`)
    REFERENCES `taller`.`Marcas` (`IdMarcas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdTipoCarroceria`
    FOREIGN KEY (`IdTipoCarroceria`)
    REFERENCES `taller`.`Tipos_Carroceria` (`IdTipoCarroceria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdCiudad_Vehiculo`
    FOREIGN KEY (`IdCiudad`)
    REFERENCES `taller`.`Ciudades` (`IdCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdMarca_idx` ON `taller`.`Vehiculos` (`IdMarca` ASC) VISIBLE;

CREATE INDEX `IdTipoCarroceria_idx` ON `taller`.`Vehiculos` (`IdTipoCarroceria` ASC) VISIBLE;

CREATE UNIQUE INDEX `Placa_UNIQUE` ON `taller`.`Vehiculos` (`Placa` ASC) VISIBLE;

CREATE INDEX `IdCiudad_idx` ON `taller`.`Vehiculos` (`IdCiudad` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Estado_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Estado_OS` (
  `IdEstadoOS` INT NOT NULL AUTO_INCREMENT,
  `EstadoOS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IdEstadoOS`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `EstadoOS_UNIQUE` ON `taller`.`Estado_OS` (`EstadoOS` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Encab_Ordenes_Servicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Encab_Ordenes_Servicio` (
  `IdOrdenServicio` INT NOT NULL AUTO_INCREMENT,
  `IdCliente` INT NOT NULL,
  `IdVehiculo` INT NOT NULL,
  `IdMecanico` INT NOT NULL,
  `IdEstadoOS` INT NOT NULL,
  `KM_Entrada` VARCHAR(45) NOT NULL,
  `KMSalida` VARCHAR(45) NOT NULL,
  `FechaIngreso` DATETIME NOT NULL,
  `FechaFinServicio` DATETIME NOT NULL,
  `Observaciones` VARCHAR(45) NULL,
  PRIMARY KEY (`IdOrdenServicio`),
  CONSTRAINT `IdCliente`
    FOREIGN KEY (`IdCliente`)
    REFERENCES `taller`.`Clientes` (`IdCliente`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdVehiculo`
    FOREIGN KEY (`IdVehiculo`)
    REFERENCES `taller`.`Vehiculos` (`IdVehiculo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdMecanico`
    FOREIGN KEY (`IdMecanico`)
    REFERENCES `taller`.`Empleados` (`IdEmpleados`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdEstadoOS`
    FOREIGN KEY (`IdEstadoOS`)
    REFERENCES `taller`.`Estado_OS` (`IdEstadoOS`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `IdCliente_idx` ON `taller`.`Encab_Ordenes_Servicio` (`IdCliente` ASC) VISIBLE;

CREATE INDEX `IdVehiculo_idx` ON `taller`.`Encab_Ordenes_Servicio` (`IdVehiculo` ASC) VISIBLE;

CREATE INDEX `IdMecanico_idx` ON `taller`.`Encab_Ordenes_Servicio` (`IdMecanico` ASC) VISIBLE;

CREATE INDEX `IdEstadoOS_idx` ON `taller`.`Encab_Ordenes_Servicio` (`IdEstadoOS` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Facturas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Facturas` (
  `IdFactura` INT NOT NULL AUTO_INCREMENT,
  `IdOrdenServicio` INT NOT NULL,
  `NumFactura` INT NULL,
  `FechaFactura` DATE NOT NULL,
  `PrecioTotal` DOUBLE NULL,
  `Impuesto` VARCHAR(45) NOT NULL,
  `Descuento` DOUBLE NULL,
  PRIMARY KEY (`IdFactura`),
  CONSTRAINT `IdOrdenServicio`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Encab_Ordenes_Servicio` (`IdOrdenServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdOrdenServicio_idx` ON `taller`.`Facturas` (`IdOrdenServicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Medios_Pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Medios_Pago` (
  `IdmedioPago` INT NOT NULL AUTO_INCREMENT,
  `MedioPago` INT NOT NULL,
  `IdStatusMedioPago` INT NOT NULL,
  PRIMARY KEY (`IdmedioPago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Pagos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Pagos` (
  `idPagos` INT NOT NULL AUTO_INCREMENT,
  `IdFactura` INT NOT NULL,
  `FechaPago` DATETIME NOT NULL,
  `IdMedioPago` INT NOT NULL,
  `Valor` DOUBLE NOT NULL,
  PRIMARY KEY (`idPagos`),
  CONSTRAINT `IdFactura`
    FOREIGN KEY (`IdFactura`)
    REFERENCES `taller`.`Facturas` (`IdFactura`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdMedioPago`
    FOREIGN KEY (`IdMedioPago`)
    REFERENCES `taller`.`Medios_Pago` (`IdmedioPago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdFactura_idx` ON `taller`.`Pagos` (`IdFactura` ASC) VISIBLE;

CREATE INDEX `IdMedioPago_idx` ON `taller`.`Pagos` (`IdMedioPago` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Sistemas_Vehicular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Sistemas_Vehicular` (
  `idSistemasVehicular` INT NOT NULL AUTO_INCREMENT,
  `SistemaVehicular` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSistemasVehicular`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `SistemaVehicular_UNIQUE` ON `taller`.`Sistemas_Vehicular` (`SistemaVehicular` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Tipos_Serivicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Tipos_Serivicio` (
  `IdTipoServicio` INT NOT NULL AUTO_INCREMENT,
  `TipoServicio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTipoServicio`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `TipoServicio_UNIQUE` ON `taller`.`Tipos_Serivicio` (`TipoServicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Nombres_Servicios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Nombres_Servicios` (
  `IdNombreServicio` INT NOT NULL AUTO_INCREMENT,
  `Descripcion` VARCHAR(200) NOT NULL,
  `DuracionHoras` DOUBLE NOT NULL,
  `IdTipoServicio` INT NOT NULL,
  `IdSistemaVehicular` INT NOT NULL,
  `IdStatus` INT NOT NULL DEFAULT 1,
  `Especificaciones` LONGTEXT NULL,
  PRIMARY KEY (`IdNombreServicio`),
  CONSTRAINT `IdTipoServicio`
    FOREIGN KEY (`IdTipoServicio`)
    REFERENCES `taller`.`Tipos_Serivicio` (`IdTipoServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdSistemaVehicular`
    FOREIGN KEY (`IdSistemaVehicular`)
    REFERENCES `taller`.`Sistemas_Vehicular` (`idSistemasVehicular`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdTipoServicio_idx` ON `taller`.`Nombres_Servicios` (`IdTipoServicio` ASC) VISIBLE;

CREATE INDEX `IdSistemaVehicular_idx` ON `taller`.`Nombres_Servicios` (`IdSistemaVehicular` ASC) VISIBLE;

CREATE UNIQUE INDEX `Descripcion_UNIQUE` ON `taller`.`Nombres_Servicios` (`Descripcion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Cotizaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Cotizaciones` (
  `IdCotizacion` INT NOT NULL AUTO_INCREMENT,
  `IdOrdenServicio` INT NOT NULL,
  `FechaCotizacion` DATE NOT NULL,
  `Precio` DOUBLE NOT NULL,
  `Impuesto` DOUBLE NOT NULL,
  `Descuento` DOUBLE NOT NULL,
  PRIMARY KEY (`IdCotizacion`),
  CONSTRAINT `IdOrdenServicioCotiz`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Encab_Ordenes_Servicio` (`IdOrdenServicio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `IdOrdenServicio_idx_cotiz` ON `taller`.`Cotizaciones` (`IdOrdenServicio` ASC) INVISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Detalle_Servicios_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Detalle_Servicios_OS` (
  `IdOrdenServicio` INT NOT NULL,
  `IdNombreServicio` INT NOT NULL,
  `NumLinea` INT NOT NULL,
  `Cantidad` INT NOT NULL DEFAULT 1,
  `Precio` DOUBLE NOT NULL DEFAULT 0,
  `Impuesto` FLOAT NOT NULL DEFAULT 0,
  `Descuento` FLOAT NOT NULL,
  PRIMARY KEY (`IdOrdenServicio`, `IdNombreServicio`),
  CONSTRAINT `IdOS`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Encab_Ordenes_Servicio` (`IdOrdenServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdNombreServicio`
    FOREIGN KEY (`IdNombreServicio`)
    REFERENCES `taller`.`Nombres_Servicios` (`IdNombreServicio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE INDEX `IdNombreServicio_idx` ON `taller`.`Detalle_Servicios_OS` (`IdNombreServicio` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Categoria_Consumibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Categoria_Consumibles` (
  `IdCategoriaConsumible` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(100) NOT NULL,
  `IdEstado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdCategoriaConsumible`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Categoria_UNIQUE` ON `taller`.`Categoria_Consumibles` (`Categoria` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`PresentacionesConsumibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`PresentacionesConsumibles` (
  `IdPresentacion` INT NOT NULL AUTO_INCREMENT,
  `Presentacion` VARCHAR(45) NOT NULL,
  `IdEstado` INT NOT NULL,
  PRIMARY KEY (`IdPresentacion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `Presentacion_UNIQUE` ON `taller`.`PresentacionesConsumibles` (`Presentacion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`Maestro_Consumibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Maestro_Consumibles` (
  `IdConsumible` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(200) NOT NULL,
  `IdCategoria` INT NOT NULL,
  `IdPresentacion` INT NOT NULL,
  `Especificaciones` LONGTEXT NOT NULL,
  `IdEstado` INT NOT NULL,
  PRIMARY KEY (`IdConsumible`),
  CONSTRAINT `IdCategoria`
    FOREIGN KEY (`IdCategoria`)
    REFERENCES `taller`.`Categoria_Consumibles` (`IdCategoriaConsumible`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdPresentacion`
    FOREIGN KEY (`IdPresentacion`)
    REFERENCES `taller`.`PresentacionesConsumibles` (`IdPresentacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdCategoria_idx` ON `taller`.`Maestro_Consumibles` (`IdCategoria` ASC) VISIBLE;

CREATE INDEX `IdPresentacion_idx` ON `taller`.`Maestro_Consumibles` (`IdPresentacion` ASC) VISIBLE;

CREATE UNIQUE INDEX `Nombre_UNIQUE` ON `taller`.`Maestro_Consumibles` (`Nombre` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `taller`.`detalle_Consumibles_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`detalle_Consumibles_OS` (
  `IdOrdenServicio` INT NOT NULL,
  `IdConsumible` INT NOT NULL,
  `NumLinea` INT NOT NULL,
  `Cantidad` INT NOT NULL DEFAULT 1,
  `Precio` DOUBLE NOT NULL DEFAULT 0,
  `Impuesto` FLOAT NOT NULL DEFAULT 0,
  `Descuento` FLOAT NOT NULL,
  PRIMARY KEY (`IdOrdenServicio`, `IdConsumible`),
  CONSTRAINT `IdConsumible`
    FOREIGN KEY (`IdConsumible`)
    REFERENCES `taller`.`Maestro_Consumibles` (`IdConsumible`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdOrdenServicioCons`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Encab_Ordenes_Servicio` (`IdOrdenServicio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `IdConsumible_idx` ON `taller`.`detalle_Consumibles_OS` (`IdConsumible` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
