-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema CesarFRR$lab_crud
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema CesarFRR$lab_crud
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `CesarFRR$lab_crud` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `CesarFRR$lab_crud` ;

-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`municipios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`municipios` (
  `id` INT NOT NULL,
  `nombre` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`viviendas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`viviendas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `direccion` VARCHAR(50) NOT NULL,
  `id_municipio` INT NOT NULL,
  `capacidad` INT NOT NULL,
  `niveles` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `municipios` (`id_municipio` ASC) VISIBLE,
  CONSTRAINT `viviendas_ibfk_1`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `CesarFRR$lab_crud`.`municipios` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`personas` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `tipo_doc` TEXT NOT NULL,
  `nombre` TEXT NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `sexo` VARCHAR(10) NOT NULL,
  `telefono` VARCHAR(20) NULL DEFAULT NULL,
  `id_vivienda_actual` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `vivienda_actual` (`id_vivienda_actual` ASC) VISIBLE,
  CONSTRAINT `personas_ibfk_1`
    FOREIGN KEY (`id_vivienda_actual`)
    REFERENCES `CesarFRR$lab_crud`.`viviendas` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 21341413
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`cdf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`cdf` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_cdf` INT NOT NULL,
  `fecha_registro` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_persona` (`id_persona` ASC) VISIBLE,
  INDEX `id_cdf` (`id_cdf` ASC) VISIBLE,
  CONSTRAINT `cdf_ibfk_1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `CesarFRR$lab_crud`.`personas` (`id`),
  CONSTRAINT `cdf_ibfk_2`
    FOREIGN KEY (`id_cdf`)
    REFERENCES `CesarFRR$lab_crud`.`personas` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`posesiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`posesiones` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_vivienda` INT NOT NULL,
  `fecha_posesion` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_persona` (`id_persona` ASC) VISIBLE,
  INDEX `id_vivienda` (`id_vivienda` ASC) VISIBLE,
  CONSTRAINT `posesiones_ibfk_1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `CesarFRR$lab_crud`.`personas` (`id`),
  CONSTRAINT `posesiones_ibfk_2`
    FOREIGN KEY (`id_vivienda`)
    REFERENCES `CesarFRR$lab_crud`.`viviendas` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `CesarFRR$lab_crud`.`gobernadores`
-- -----------------------------------------------------

CREATE TABLE IF NOT EXISTS `CesarFRR$lab_crud`.`gobernadores` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `id_persona` INT NOT NULL,
  `id_municipio` INT NOT NULL,
  `fecha_registro` DATE NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `id_persona` (`id_persona` ASC) VISIBLE,
  INDEX `id_municipio` (`id_municipio` ASC) VISIBLE,
  CONSTRAINT `gobernadores_ibfk_1`
    FOREIGN KEY (`id_persona`)
    REFERENCES `CesarFRR$lab_crud`.`personas` (`id`),
  CONSTRAINT `gobernadores_ibfk_2`
    FOREIGN KEY (`id_municipio`)
    REFERENCES `CesarFRR$lab_crud`.`municipios` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 10
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;




INSERT INTO municipios (id, nombre)
VALUES
    (1, 'Bogotá'),
    (2, 'Soacha'),
    (3, 'Chía'),
    (4, 'Cajicá'),
    (5, 'Girardot'),
    (6, 'Zipaquirá'),
    (7, 'Funza'),
    (8, 'Facatativá'),
    (9, 'Cota'),
    (10, 'Mosquera'),
    (11, 'Sibaté'),
    (12, 'Madrid'),
    (13, 'Subachoque'),
    (14, 'Sopó'),
    (15, 'Tabio'),
    (16, 'Tenjo'),
    (17, 'Tocancipá'),
    (18, 'La Calera'),
    (19, 'Gachancipá'),
    (20, 'Nemocón');

INSERT INTO viviendas(id, direccion, id_municipio, capacidad, niveles)
VALUES
    (1, 'Calle 123', 1, 4, 2),
    (2, 'Avenida Principal', 2, 6, 3),
    (3, 'Carrera 456', 1, 2, 1),
    (4, 'Calle 456', 3, 5, 2),
    (5, 'Avenida 789', 4, 3, 1),
    (6, 'Carrera 789', 5, 8, 3),
    (7, 'Calle 1011', 3, 2, 1),
    (8, 'Avenida 1213', 2, 6, 2),
    (9, 'Carrera 1415', 1, 4, 2),
    (10, 'Calle 1617', 4, 7, 3),
    (11, 'Avenida 1819', 5, 3, 1),
    (12, 'Carrera 2021', 1, 5, 2),
    (13, 'Calle 2223', 2, 4, 2),
    (14, 'Avenida 2425', 3, 6, 3),
    (15, 'Carrera 2627', 4, 2, 1),
    (16, 'Calle 2829', 5, 5, 2),
    (17, 'Avenida 3031', 1, 6, 2),
    (18, 'Carrera 3233', 2, 4, 1),
    (19, 'Calle 3435', 3, 3, 1),
    (20, 'Avenida 3637', 4, 7, 3);


-- Insertar filas en la tabla PERSONAS
INSERT INTO personas(id, tipo_doc, nombre, fecha_nac, sexo, telefono, id_vivienda_actual)
VALUES
    (1, 'DNI', 'Juan Pérez', '1990-05-15', 'Masculino', 123456789, 1),
    (2, 'Cédula', 'María García', '1985-10-20', 'Femenino', NULL, 2),
    (3, 'Cédula', 'Pedro Rodríguez', '2000-03-08', 'Masculino', 987654321, 3),
    (4, 'Pasaporte', 'Luisa Martínez', '1993-12-30', 'Femenino', 876543210, 4),
    (5, 'DNI', 'Carlos González', '1987-07-22', 'Masculino', 234567890, 5),
    (6, 'Cédula', 'Ana López', '1998-09-18', 'Femenino', NULL, 6),
    (7, 'Cédula', 'Mario Sánchez', '2005-02-14', 'Masculino', 345678901, 7),
    (8, 'DNI', 'Laura Fernández', '1991-06-25', 'Femenino', 456789012, 8),
    (9, 'Pasaporte', 'Ricardo Torres', '1984-11-10', 'Masculino', 567890123, 9),
    (10, 'Cédula', 'Isabel Ramírez', '2002-04-03', 'Femenino', NULL, 10),
    (11, 'DNI', 'Daniel Pérez', '1996-08-19', 'Masculino', 678901234, 11),
    (12, 'Cédula', 'Sofía García', '1989-01-05', 'Femenino', 789012345, 12),
    (13, 'Pasaporte', 'Miguel Rodríguez', '2003-07-12', 'Masculino', 890123456, 13),
    (14, 'DNI', 'Elena Martínez', '1995-02-28', 'Femenino', 901234567, 14),
    (15, 'Cédula', 'Diego López', '1999-10-15', 'Masculino', NULL, 15),
    (16, 'Cédula', 'Valentina Sánchez', '1986-04-01', 'Femenino', 123456789, 16),
    (17, 'Pasaporte', 'Andrés Fernández', '2001-11-23', 'Masculino', 234567890, 17),
    (18, 'DNI', 'Camila Torres', '1994-09-07', 'Femenino', 345678901, 18),
    (19, 'Cédula', 'Javier Ramírez', '1988-03-16', 'Masculino', 456789012, 19),
    (20, 'Cédula', 'Carolina Pérez', '2004-06-09', 'Femenino', 567890123, 20);


-- Insertar filas en la tabla CDF
INSERT INTO cdf(id_persona, id_cdf, fecha_registro)
VALUES
    (2, 1, '2023-08-01'),
    (3, 1, '2023-08-02'),
    (4, 2, '2023-08-03'),
    (5, 2, '2023-08-04'),
    (6, 3, '2023-08-05'),
    (7, 3, '2023-08-06'),
    (8, 4, '2023-08-07'),
    (9, 4, '2023-08-08'),
    (10, 5, '2023-08-09'),
    (11, 5, '2023-08-10'),
    (12, 6, '2023-08-11'),
    (13, 6, '2023-08-12'),
    (14, 7, '2023-08-13'),
    (15, 7, '2023-08-14'),
    (16, 8, '2023-08-15'),
    (17, 8, '2023-08-16'),
    (18, 9, '2023-08-17'),
    (19, 9, '2023-08-18'),
    (20, 10, '2023-08-19');


-- Insertar filas en la tabla posesiones
INSERT INTO posesiones (id_persona, id_vivienda, fecha_posesion)
VALUES
    (1, 1, '2023-08-01'),
    (1, 2, '2023-08-02'),
    (2, 3, '2023-08-03'),
    (2, 4, '2023-08-04'),
    (3, 5, '2023-08-05'),
    (3, 6, '2023-08-06'),
    (4, 7, '2023-08-07'),
    (4, 8, '2023-08-08'),
    (5, 9, '2023-08-09'),
    (5, 10, '2023-08-10'),
    (6, 11, '2023-08-11'),
    (6, 12, '2023-08-12'),
    (7, 13, '2023-08-13'),
    (7, 14, '2023-08-14'),
    (8, 15, '2023-08-15'),
    (8, 16, '2023-08-16'),
    (9, 17, '2023-08-17'),
    (9, 18, '2023-08-18'),
    (10, 19, '2023-08-19'),
    (10, 20, '2023-08-20');


-- Insertar filas en la tabla gobernadores
INSERT INTO gobernadores (id_persona, id_municipio, fecha_registro)
VALUES
    (1, 1, '2023-01-01'),
    (2, 2, '2023-02-01'),
    (3, 3, '2023-03-01'),
    (4, 4, '2023-04-01'),
    (5, 5, '2023-05-01'),
    (6, 6, '2023-06-01'),
    (7, 1, '2023-07-01'),
    (8, 2, '2023-08-01'),
    (9, 3, '2023-09-01'),
    (10, 4, '2023-10-01'),
    (11, 5, '2023-11-01'),
    (12, 6, '2023-12-01'),
    (13, 1, '2024-01-01'),
    (14, 2, '2024-02-01'),
    (15, 3, '2024-03-01'),
    (16, 4, '2024-04-01'),
    (17, 5, '2024-05-01'),
    (18, 6, '2024-06-01'),
    (19, 1, '2024-07-01'),
    (20, 2, '2024-08-01');

