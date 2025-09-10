-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema dashboard
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema dashboard
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `dashboard` DEFAULT CHARACTER SET utf8mb3 ;
USE `dashboard` ;

-- -----------------------------------------------------
-- Table `dashboard`.`aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`aluno` (
  `matricula` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `foto` VARCHAR(255) NULL DEFAULT NULL,
  PRIMARY KEY (`matricula`),
  UNIQUE INDEX `Matricula_UNIQUE` (`matricula` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`curso` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`serie` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`turno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`turno` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`turma` (
  `id` INT NOT NULL,
  `ano` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `curso_id` INT NOT NULL,
  `serie_id` INT NOT NULL,
  `turma_id` INT NOT NULL,
  `turma_ano` INT NOT NULL,
  `turno_id` INT NOT NULL,
  PRIMARY KEY (`id`, `ano`),
  INDEX `fk_turma_curso1_idx` (`curso_id` ASC) VISIBLE,
  INDEX `fk_turma_serie1_idx` (`serie_id` ASC) VISIBLE,
  INDEX `fk_turma_turma1_idx` (`turma_id` ASC, `turma_ano` ASC) VISIBLE,
  INDEX `fk_turma_turno1_idx` (`turno_id` ASC) VISIBLE,
  CONSTRAINT `fk_turma_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `dashboard`.`curso` (`id`),
  CONSTRAINT `fk_turma_serie1`
    FOREIGN KEY (`serie_id`)
    REFERENCES `dashboard`.`serie` (`id`),
  CONSTRAINT `fk_turma_turma1`
    FOREIGN KEY (`turma_id` , `turma_ano`)
    REFERENCES `dashboard`.`turma` (`id` , `ano`),
  CONSTRAINT `fk_turma_turno1`
    FOREIGN KEY (`turno_id`)
    REFERENCES `dashboard`.`turno` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`aluno_turma`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`aluno_turma` (
  `aluno_matricula` VARCHAR(20) NOT NULL,
  `turma_id` INT NOT NULL,
  `turma_ano` INT NOT NULL,
  PRIMARY KEY (`aluno_matricula`, `turma_id`, `turma_ano`),
  INDEX `fk_aluno_has_turma_aluno_idx` (`aluno_matricula` ASC) VISIBLE,
  INDEX `fk_aluno_turma_turma1_idx` (`turma_id` ASC, `turma_ano` ASC) VISIBLE,
  CONSTRAINT `fk_aluno_has_turma_aluno`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `dashboard`.`aluno` (`matricula`),
  CONSTRAINT `fk_aluno_turma_turma1`
    FOREIGN KEY (`turma_id` , `turma_ano`)
    REFERENCES `dashboard`.`turma` (`id` , `ano`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`area_do_conhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`area_do_conhecimento` (
  `id` INT NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`disciplina` (
  `id` INT NOT NULL,
  `sigla` VARCHAR(15) NOT NULL,
  `descricao` VARCHAR(45) NOT NULL,
  `horas` INT NULL DEFAULT NULL,
  `area_do_conhecimento_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `descricao_UNIQUE` (`descricao` ASC) VISIBLE,
  UNIQUE INDEX `sigla_UNIQUE` (`sigla` ASC) VISIBLE,
  INDEX `fk_disciplina_area_do_conhecimento1_idx` (`area_do_conhecimento_id` ASC) VISIBLE,
  CONSTRAINT `fk_disciplina_area_do_conhecimento1`
    FOREIGN KEY (`area_do_conhecimento_id`)
    REFERENCES `dashboard`.`area_do_conhecimento` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`boletim`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`boletim` (
  `aluno_matricula` VARCHAR(20) NOT NULL,
  `disciplina_id` INT NOT NULL,
  `turma_id` INT NOT NULL,
  `turma_ano` INT NOT NULL,
  `bimestre1` DECIMAL(4,2) NULL DEFAULT NULL,
  `bimestre2` DECIMAL(4,2) NULL DEFAULT NULL,
  `recusem1` DECIMAL(4,2) NULL DEFAULT NULL,
  `bimestre3` DECIMAL(4,2) NULL DEFAULT NULL,
  `bimestre4` DECIMAL(4,2) NULL DEFAULT NULL,
  `recusem2` DECIMAL(4,2) NULL DEFAULT NULL,
  `recfinal` DECIMAL(4,2) NULL DEFAULT NULL,
  `final` DECIMAL(4,2) NULL DEFAULT NULL,
  `faltas` INT NULL DEFAULT NULL,
  `faltaspercent` INT NULL DEFAULT NULL,
  `status` VARCHAR(15) NULL DEFAULT NULL,
  PRIMARY KEY (`aluno_matricula`, `disciplina_id`, `turma_id`, `turma_ano`),
  INDEX `fk_boletim_aluno1_idx` (`aluno_matricula` ASC) VISIBLE,
  INDEX `fk_boletim_disciplina1_idx` (`disciplina_id` ASC) VISIBLE,
  INDEX `fk_boletim_turma1_idx` (`turma_id` ASC, `turma_ano` ASC) VISIBLE,
  CONSTRAINT `fk_boletim_aluno1`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `dashboard`.`aluno` (`matricula`),
  CONSTRAINT `fk_boletim_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `dashboard`.`disciplina` (`id`),
  CONSTRAINT `fk_boletim_turma1`
    FOREIGN KEY (`turma_id` , `turma_ano`)
    REFERENCES `dashboard`.`turma` (`id` , `ano`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `dashboard`.`disciplina_curso_serie`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `dashboard`.`disciplina_curso_serie` (
  `disciplina_id` INT NOT NULL,
  `curso_id` INT NOT NULL,
  `serie_id` INT NOT NULL,
  PRIMARY KEY (`disciplina_id`, `curso_id`, `serie_id`),
  INDEX `fk_disciplina_has_curso_curso1_idx` (`curso_id` ASC) VISIBLE,
  INDEX `fk_disciplina_has_curso_disciplina1_idx` (`disciplina_id` ASC) VISIBLE,
  INDEX `fk_disciplina_has_curso_serie1_idx` (`serie_id` ASC) VISIBLE,
  CONSTRAINT `fk_disciplina_has_curso_curso1`
    FOREIGN KEY (`curso_id`)
    REFERENCES `dashboard`.`curso` (`id`),
  CONSTRAINT `fk_disciplina_has_curso_disciplina1`
    FOREIGN KEY (`disciplina_id`)
    REFERENCES `dashboard`.`disciplina` (`id`),
  CONSTRAINT `fk_disciplina_has_curso_serie1`
    FOREIGN KEY (`serie_id`)
    REFERENCES `dashboard`.`serie` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
