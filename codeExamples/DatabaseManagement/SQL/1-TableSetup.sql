/* 	Daniel Howe
	Jason Tse
	CST 363
    Final Project - Table Setup*/


DROP SCHEMA IF EXISTS howe_tse_final;
CREATE SCHEMA howe_tse_final;
USE howe_tse_final;


/*---DEPARTMENT TABLE---*/
CREATE TABLE departments(
	id_departments 		INT 			NOT NULL,
	room 				VARCHAR(45) 	NOT NULL,
  
	PRIMARY KEY (id_departments)
);


/*---ARTWORK TABLE---*/
CREATE TABLE artworks(
	id_artworks	 		INT 			NOT NULL AUTO_INCREMENT,
	title 				VARCHAR(45),
	creation_date		DATE,
	medium				VARCHAR(45),
	description			VARCHAR(45) 	NOT NULL,
	appraised_value		DECIMAL(10,2),
	id_departments		INT 			NOT NULL,
  
	PRIMARY KEY (id_artworks),
	CONSTRAINT fk_artworks_departments FOREIGN KEY (id_departments)
		REFERENCES departments (id_departments)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


/*---ARTISTS TABLE---*/
CREATE TABLE artists(
	id_artists 			INT 			NOT NULL AUTO_INCREMENT,
	last_name 			VARCHAR(45) 	NOT NULL,
	first_name 			VARCHAR(45),
	residence 			VARCHAR(45),
	dob 				DATE,
  
  PRIMARY KEY (id_artists)
);


/*---THE_CATALOG TABLE---*/
CREATE TABLE the_catalog(
	id_artists 			INT 			NOT NULL,
	id_artworks			INT 			NOT NULL,
    
	PRIMARY KEY (id_artists, id_artworks),
	CONSTRAINT fk_the_catalog_artists FOREIGN KEY (id_artists)
		REFERENCES artists (id_artists)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_the_catalog_artworks FOREIGN KEY (id_artworks)
		REFERENCES artworks (id_artworks)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);


/*---EMPLOYEES TABLE---*/
CREATE TABLE employees(
	id_employees 		INT 			NOT NULL AUTO_INCREMENT,
	last_name 			VARCHAR(45) 	NOT NULL,
	first_name 			VARCHAR(45) 	NOT NULL,
	address 			VARCHAR(45),
	phone_number 		VARCHAR(45),
	job_position 		VARCHAR(45),
    
	PRIMARY KEY (id_employees)
);


/*---DEPARTMENT_DIRECTORY TABLE---*/
CREATE TABLE department_directory(
	id_departments		INT 			NOT NULL,
	id_employees		INT 			NOT NULL,
    
	CONSTRAINT fk_department_directory_departments FOREIGN KEY (id_departments)
		REFERENCES departments (id_departments)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION,
	CONSTRAINT fk_department_directory_employees FOREIGN KEY (id_employees)
		REFERENCES employees (id_employees)
		ON DELETE NO ACTION
		ON UPDATE NO ACTION
);