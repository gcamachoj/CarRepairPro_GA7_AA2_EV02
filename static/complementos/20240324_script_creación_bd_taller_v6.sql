-- MySQL Script generated by MySQL Workbench
-- Sun Jun  9 07:56:18 2024
-- Model: New Model    Version: 1.0
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
  PRIMARY KEY (`IdTipoCliente`),
  UNIQUE INDEX `TipoCliente_UNIQUE` (`TipoCliente` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Ciudades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Ciudades` (
  `IdCiudad` INT NOT NULL AUTO_INCREMENT,
  `Ciudad` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdCiudad`),
  UNIQUE INDEX `Ciudad_UNIQUE` (`Ciudad` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Clientes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Clientes` (
  `IdCliente` INT NOT NULL AUTO_INCREMENT,
  `IdTipoCliente` INT NOT NULL,
  `CC_NIT` VARCHAR(50) NOT NULL,
  `Nombre` VARCHAR(100) NOT NULL,
  `IdCiudad` INT NOT NULL,
  `Direccion` VARCHAR(150) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`IdCliente`),
  INDEX `IdTipoCliente__` (`IdTipoCliente` ASC) INVISIBLE,
  UNIQUE INDEX `CC_NIT_UNIQUE` (`CC_NIT` ASC) VISIBLE,
  INDEX `IdCiudad_idx` (`IdCiudad` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `taller`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Roles` (
  `IdRol` INT NOT NULL AUTO_INCREMENT,
  `Rol` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdRol`),
  UNIQUE INDEX `Descripcion_UNIQUE` (`Rol` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Estado_Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Estado_Empleados` (
  `IdEstado` INT NOT NULL AUTO_INCREMENT,
  `Estado` VARCHAR(20) NULL,
  PRIMARY KEY (`IdEstado`),
  UNIQUE INDEX `Estado_UNIQUE` (`Estado` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Cargos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Cargos` (
  `IdCargo` INT NOT NULL AUTO_INCREMENT,
  `Cargo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdCargo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Empleados` (
  `IdEmpleado` INT NOT NULL AUTO_INCREMENT,
  `CC` VARCHAR(45) NOT NULL COMMENT 'Cedula o Nit',
  `Nombres` VARCHAR(100) NOT NULL,
  `Apellidos` VARCHAR(100) NOT NULL,
  `IdCargo` INT NOT NULL,
  `Direccion` VARCHAR(100) NOT NULL,
  `Email` VARCHAR(100) NOT NULL,
  `Telefono` VARCHAR(45) NOT NULL,
  `IdEstado` INT NOT NULL DEFAULT 1,
  `IdCiudad` INT NOT NULL,
  PRIMARY KEY (`IdEmpleado`),
  INDEX `IdCiudad_idx` (`IdCiudad` ASC) VISIBLE,
  INDEX `IdCargo_Empleado_idx` (`IdCargo` ASC) VISIBLE,
  CONSTRAINT `IdCiudad_Empleado`
    FOREIGN KEY (`IdCiudad`)
    REFERENCES `taller`.`Ciudades` (`IdCiudad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdEstado_Empleado`
    FOREIGN KEY (`IdEmpleado`)
    REFERENCES `taller`.`Estado_Empleados` (`IdEstado`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdCargo_Empleado`
    FOREIGN KEY (`IdCargo`)
    REFERENCES `taller`.`Cargos` (`IdCargo`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Tipos_Carroceria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Tipos_Carroceria` (
  `IdTipoCarroceria` INT NOT NULL AUTO_INCREMENT,
  `TipoCarroceria` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTipoCarroceria`),
  UNIQUE INDEX `TipoCarroceria_UNIQUE` (`TipoCarroceria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Marcas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Marcas` (
  `IdMarca` INT NOT NULL AUTO_INCREMENT,
  `Marca` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdMarca`),
  UNIQUE INDEX `Marca_UNIQUE` (`Marca` ASC) VISIBLE)
ENGINE = InnoDB;


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
  INDEX `IdMarca_idx` (`IdMarca` ASC) VISIBLE,
  INDEX `IdTipoCarroceria_idx` (`IdTipoCarroceria` ASC) VISIBLE,
  UNIQUE INDEX `Placa_UNIQUE` (`Placa` ASC) VISIBLE,
  INDEX `IdCiudad_idx` (`IdCiudad` ASC) VISIBLE,
  CONSTRAINT `IdMarca`
    FOREIGN KEY (`IdMarca`)
    REFERENCES `taller`.`Marcas` (`IdMarca`)
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


-- -----------------------------------------------------
-- Table `taller`.`Estado_OS`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Estado_OS` (
  `IdEstadoOS` INT NOT NULL AUTO_INCREMENT,
  `EstadoOS` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`IdEstadoOS`),
  UNIQUE INDEX `EstadoOS_UNIQUE` (`EstadoOS` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Ordenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Ordenes` (
  `IdOrden` INT NOT NULL AUTO_INCREMENT,
  `IdCliente` INT NOT NULL,
  `IdVehiculo` INT NOT NULL,
  `IdMecanico` INT NOT NULL,
  `IdEstadoOS` INT NOT NULL,
  `KM_Entrada` INT NOT NULL,
  `KM_Salida` INT NOT NULL,
  `FechaIngreso` DATE NOT NULL,
  `FechaFinServicio` DATE NOT NULL,
  `Observaciones` VARCHAR(45) NULL,
  PRIMARY KEY (`IdOrden`),
  INDEX `IdCliente_idx` (`IdCliente` ASC) VISIBLE,
  INDEX `IdVehiculo_idx` (`IdVehiculo` ASC) VISIBLE,
  INDEX `IdMecanico_idx` (`IdMecanico` ASC) VISIBLE,
  INDEX `IdEstadoOS_idx` (`IdEstadoOS` ASC) VISIBLE,
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
    REFERENCES `taller`.`Empleados` (`IdEmpleado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdEstadoOS`
    FOREIGN KEY (`IdEstadoOS`)
    REFERENCES `taller`.`Estado_OS` (`IdEstadoOS`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
  INDEX `IdOrdenServicio_idx` (`IdOrdenServicio` ASC) VISIBLE,
  CONSTRAINT `IdOrdenServicio`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Ordenes` (`IdOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


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
  INDEX `IdFactura_idx` (`IdFactura` ASC) VISIBLE,
  INDEX `IdMedioPago_idx` (`IdMedioPago` ASC) VISIBLE,
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


-- -----------------------------------------------------
-- Table `taller`.`Sistemas_Vehicular`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Sistemas_Vehicular` (
  `idSistemasVehicular` INT NOT NULL AUTO_INCREMENT,
  `SistemaVehicular` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idSistemasVehicular`),
  UNIQUE INDEX `SistemaVehicular_UNIQUE` (`SistemaVehicular` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Tipos_Serivicio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Tipos_Serivicio` (
  `IdTipoServicio` INT NOT NULL AUTO_INCREMENT,
  `TipoServicio` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`IdTipoServicio`),
  UNIQUE INDEX `TipoServicio_UNIQUE` (`TipoServicio` ASC) VISIBLE)
ENGINE = InnoDB;


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
  INDEX `IdTipoServicio_idx` (`IdTipoServicio` ASC) VISIBLE,
  INDEX `IdSistemaVehicular_idx` (`IdSistemaVehicular` ASC) VISIBLE,
  UNIQUE INDEX `Descripcion_UNIQUE` (`Descripcion` ASC) VISIBLE,
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
  INDEX `IdOrdenServicio_idx_cotiz` (`IdOrdenServicio` ASC) INVISIBLE,
  CONSTRAINT `IdOrdenServicioCotiz`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Ordenes` (`IdOrden`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


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
  INDEX `IdNombreServicio_idx` (`IdNombreServicio` ASC) VISIBLE,
  CONSTRAINT `IdOS`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Ordenes` (`IdOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdNombreServicio`
    FOREIGN KEY (`IdNombreServicio`)
    REFERENCES `taller`.`Nombres_Servicios` (`IdNombreServicio`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Categoria_Consumibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Categoria_Consumibles` (
  `IdCategoriaConsumible` INT NOT NULL AUTO_INCREMENT,
  `Categoria` VARCHAR(100) NOT NULL,
  `IdEstado` INT NOT NULL DEFAULT 1,
  PRIMARY KEY (`IdCategoriaConsumible`),
  UNIQUE INDEX `Categoria_UNIQUE` (`Categoria` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`PresentacionesConsumibles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`PresentacionesConsumibles` (
  `IdPresentacion` INT NOT NULL AUTO_INCREMENT,
  `Presentacion` VARCHAR(45) NOT NULL,
  `IdEstado` INT NOT NULL,
  PRIMARY KEY (`IdPresentacion`),
  UNIQUE INDEX `Presentacion_UNIQUE` (`Presentacion` ASC) VISIBLE)
ENGINE = InnoDB;


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
  INDEX `IdCategoria_idx` (`IdCategoria` ASC) VISIBLE,
  INDEX `IdPresentacion_idx` (`IdPresentacion` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE,
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
  INDEX `IdConsumible_idx` (`IdConsumible` ASC) VISIBLE,
  CONSTRAINT `IdConsumible`
    FOREIGN KEY (`IdConsumible`)
    REFERENCES `taller`.`Maestro_Consumibles` (`IdConsumible`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `IdOrdenServicioCons`
    FOREIGN KEY (`IdOrdenServicio`)
    REFERENCES `taller`.`Ordenes` (`IdOrden`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `taller`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `taller`.`Usuarios` (
  `IdUsuario` INT NOT NULL AUTO_INCREMENT,
  `Username` VARCHAR(50) NOT NULL,
  `Password` VARCHAR(255) NOT NULL,
  `IdRol` INT NULL,
  `IdEmpleado` INT NULL,
  `IdCliente` INT NULL,
  PRIMARY KEY (`IdUsuario`),
  UNIQUE INDEX `Username_UNIQUE` (`Username` ASC) VISIBLE,
  INDEX `FK_IdRol_idx` (`IdRol` ASC) VISIBLE,
  CONSTRAINT `FK_IdRol`
    FOREIGN KEY (`IdRol`)
    REFERENCES `taller`.`Roles` (`IdRol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
