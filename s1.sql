-- task 1
CREATE DATABASE IF NOT EXISTS techmac_db;

USE techmac_db;

-- task 2
CREATE TABLE techhyve_employees (
    employee_id varchar(20)  PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE techcloud_employees (
    employee_id varchar(20) PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

CREATE TABLE techsoft_employees (
    employee_id varchar(20)  PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    age INT NOT NULL
);

-- task 3
INSERT INTO techhyve_employees (employee_id, first_name, last_name, gender, age) VALUES
('TH0001', 'Eli', 'Evans', 'Male', 26),
('TH0002', 'Carlos', 'Simmons', 'Male', 32),
('TH0003', 'Kathie', 'Bryant', 'Female', 25),
('TH0004', 'Joey', 'Hughes', 'Male', 41),
('TH0005', 'Alice', 'Matthews', 'Female', 52);

INSERT INTO techcloud_employees (employee_id, first_name, last_name, gender, age) VALUES
('TC0001', 'Teresa', 'Bryant', 'Female', 39),
('TC0002', 'Alexis', 'Patterson', 'Male', 48),
('TC0003', 'Rose', 'Bell', 'Female', 42),
('TC0004', 'Gemma', 'Watkins', 'Female', 44),
('TC0005', 'Kingston', 'Martinez', 'Male', 29);

INSERT INTO techsoft_employees (employee_id, first_name, last_name, gender, age) VALUES
('TS0001', 'Peter', 'Burtler', 'Male', 44),
('TS0002', 'Harold', 'Simmons', 'Male', 54),
('TS0003', 'Juliana', 'Sanders', 'Female', 36),
('TS0004', 'Paul', 'Ward', 'Male', 29),
('TS0005', 'Nicole', 'Bryant', 'Female', 30);

-- task4
create database techmac_db_backup;
use techmac_db_backup;
create table if not exists 
techhyve_employees_bkp like techmac_db.techhyve_employees ;
insert techhyve_employees_bkp select * from techmac_db.techhyve_employees ;

create table if not exists 
techcloud_employees_bkp like techmac_db.techcloud_employees ;
insert techcloud_employees_bkp select * from techmac_db.techcloud_employees ;

create table if not exists 
techsoft_employees_bkp like techmac_db.techsoft_employees ;
insert techsoft_employees_bkp select * from techmac_db.techsoft_employees ;
use techmac_db ;
-- task5
delete from techcloud_employees 
where employee_id in ( 'TC0001', 'TC0004' ) ;

delete from techhyve_employees 
where employee_id in ( 'TH0003', 'TH0005' ) ;

-- complited