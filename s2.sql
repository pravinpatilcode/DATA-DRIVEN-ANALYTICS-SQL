use techmac_db ;
-- TASK1 i
ALTER TABLE techhyve_employees
    MODIFY first_name VARCHAR(50) NOT NULL,
    MODIFY last_name VARCHAR(50) NOT NULL;
    
ALTER TABLE techcloud_employees 
    MODIFY first_name VARCHAR(50) NOT NULL,
    MODIFY last_name VARCHAR(50) NOT NULL;

ALTER TABLE techsoft_employees 
    MODIFY first_name VARCHAR(50) NOT NULL,
    MODIFY last_name VARCHAR(50) NOT NULL;
    
-- TASK1 ii

ALTER TABLE techhyve_employees 
 modify age INT default 21 NOT NULL ;
 
ALTER TABLE techcloud_employees 
    MODIFY age int DEFAULT 21 NOT NULL;

ALTER TABLE techsoft_employees 
    MODIFY age INT DEFAULT 21 NOT NULL;
    
    -- TASK1 iii
    
    ALTER TABLE techhyve_employees  
    add constraint chk_age check ( age between 21 and 55);

ALTER TABLE techcloud_employees 
    ADD CONSTRAINT chk_age CHECK (age BETWEEN 21 AND 55);

ALTER TABLE techsoft_employees 
    ADD CONSTRAINT chk_age CHECK (age BETWEEN 21 AND 55);

    -- TASK1 iv
    
    ALTER TABLE techhyve_employees 
    ADD COLUMN username VARCHAR(50) NOT NULL UNIQUE,
    ADD COLUMN password VARCHAR(50) NOT NULL UNIQUE;

ALTER TABLE techcloud_employees 
    ADD COLUMN username VARCHAR(50) NOT NULL UNIQUE,
    ADD COLUMN password VARCHAR(50) NOT NULL UNIQUE;

ALTER TABLE techsoft_employees 
    ADD COLUMN username VARCHAR(50) NOT NULL UNIQUE,
    ADD COLUMN password VARCHAR(50) NOT NULL UNIQUE;
    
      -- TASK1 v
      
      ALTER TABLE techhyve_employees 
    ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female'));

ALTER TABLE techcloud_employees 
    ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female'));

ALTER TABLE techsoft_employees 
    ADD CONSTRAINT chk_gender CHECK (gender IN ('Male', 'Female'));
    
     -- TASK2
     
     ALTER TABLE techhyve_employees
    ADD COLUMN communication_proficiency INT DEFAULT 1 NOT NULL,
    ADD CONSTRAINT chk_communication_proficiency_techhyve CHECK 
    (communication_proficiency BETWEEN 1 AND 5);

ALTER TABLE techcloud_employees
    ADD COLUMN communication_proficiency INT DEFAULT 1 NOT NULL,
    ADD CONSTRAINT chk_communication_proficiency_techcloud CHECK (communication_proficiency BETWEEN 1 AND 5);

ALTER TABLE techsoft_employees
    ADD COLUMN communication_proficiency INT DEFAULT 1 NOT NULL,
    ADD CONSTRAINT chk_communication_proficiency_techsoft CHECK (communication_proficiency BETWEEN 1 AND 5);
    
    -- task3
CREATE TABLE IF NOT EXISTS techhyve_employees_backup LIKE techhyve_employees;
INSERT INTO techhyve_employees_backup SELECT * FROM techhyve_employees;
CREATE TABLE IF NOT EXISTS techcloud_employees_backup LIKE techcloud_employees;
INSERT INTO techcloud_employees_backup SELECT * FROM techcloud_employees;
CREATE TABLE IF NOT EXISTS techhyvecloud_employees_backup LIKE techhyve_employees;
INSERT INTO techhyvecloud_employees_backup SELECT * FROM techhyve_employees;

DELETE FROM techhyve_employees;
DELETE FROM techcloud_employees;
DELETE FROM techsoft_employees;