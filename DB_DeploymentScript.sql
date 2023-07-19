-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema rentals
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `rentals` ;

-- -----------------------------------------------------
-- Schema rentals
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `rentals` DEFAULT CHARACTER SET utf8 ;
USE `rentals` ;

-- -----------------------------------------------------
-- Table `rentals`.`t_user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rentals`.`t_user` ;

CREATE TABLE IF NOT EXISTS `rentals`.`t_user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL COMMENT 'Will be used as the user name',
  `password` VARCHAR(255) NOT NULL,
  `created` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);


-- -----------------------------------------------------
-- Table `rentals`.`t_property`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rentals`.`t_property` ;

CREATE TABLE IF NOT EXISTS `rentals`.`t_property` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `property_type` VARCHAR(45) NULL COMMENT 'What type of property: house, mobile home, condo, etc...',
  `address_id` TINYINT NULL COMMENT 'Reference id to the address table for the property location.',
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `addressID` (`address_id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentals`.`t_address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rentals`.`t_address` ;

CREATE TABLE IF NOT EXISTS `rentals`.`t_address` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `street_number` VARCHAR(8) NULL COMMENT 'The street number for the property address.',
  `street_name` VARCHAR(45) NULL COMMENT 'The physical name of the street address.',
  `unit` VARCHAR(5) NULL COMMENT 'Unit number or letter if in a multi-family building.',
  `city` VARCHAR(45) NULL,
  `state` VARCHAR(45) NULL,
  `zip` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  CONSTRAINT `address_id`
    FOREIGN KEY (`id`)
    REFERENCES `rentals`.`t_property` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `rentals`.`t_login`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `rentals`.`t_login` ;

CREATE TABLE IF NOT EXISTS `rentals`.`t_login` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `last_login` TIMESTAMP NULL DEFAULT current_timestamp,
  `email` VARCHAR(255) NULL,
  PRIMARY KEY (`id`),
  INDEX `users_idx` (`email` ASC) VISIBLE,
  CONSTRAINT `users`
    FOREIGN KEY (`email`)
    REFERENCES `rentals`.`t_user` (`email`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
