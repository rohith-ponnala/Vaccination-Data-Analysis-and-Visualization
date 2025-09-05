
CREATE DATABASE VaccinationDB;
USE VaccinationDB;

CREATE TABLE Coverage (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_type VARCHAR(50),
    code CHAR(3),
    name VARCHAR(100),
    year INT,
    antigen VARCHAR(50),
    antigen_description VARCHAR(255),
    coverage_category VARCHAR(50),
    coverage_category_description VARCHAR(255),
    target_number BIGINT,
    doses BIGINT,
    coverage DECIMAL(5,2)
);

CREATE TABLE Incidence (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_type VARCHAR(50),
    code CHAR(3),
    name VARCHAR(100),
    year INT,
    disease VARCHAR(50),
    disease_description VARCHAR(255),
    denominator VARCHAR(100),
    incidence_rate DECIMAL(10,4)
);

CREATE TABLE ReportedCases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    group_type VARCHAR(50),
    code CHAR(3),
    name VARCHAR(100),
    year INT,
    disease VARCHAR(50),
    disease_description VARCHAR(255),
    cases BIGINT
);


CREATE TABLE VaccineIntroduction (
    id INT AUTO_INCREMENT PRIMARY KEY,
    iso_3_code CHAR(3),
    countryname VARCHAR(100),
    who_region VARCHAR(50),
    year INT,
    description VARCHAR(255),
    intro VARCHAR(10)  -- Yes/No
);

CREATE TABLE VaccineSchedule (
    id INT AUTO_INCREMENT PRIMARY KEY,
    iso_3_code CHAR(3),
    countryname VARCHAR(100),
    who_region VARCHAR(50),
    year INT,
    vaccinecode VARCHAR(50),
    vaccine_description VARCHAR(255),
    schedulerounds INT,
    targetpop VARCHAR(100),
    targetpop_description VARCHAR(255),
    geoarea VARCHAR(100),
    ageadministered VARCHAR(50),
    sourcecomment TEXT
);

SHOW VARIABLES LIKE 'local_infile';

SET GLOBAL local_infile = 1;

LOAD DATA LOCAL INFILE 'C:/Users/rohit/Downloads/vaccination/cleaned_incidence.csv'
INTO TABLE Incidence
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(group_type, code, name, year, disease, disease_description, denominator, incidence_rate);

ALTER TABLE Incidence MODIFY code VARCHAR(10);
ALTER TABLE Coverage MODIFY code VARCHAR(10);
ALTER TABLE ReportedCases MODIFY code VARCHAR(10);
ALTER TABLE VaccineIntroduction MODIFY iso_3_code VARCHAR(10);
ALTER TABLE VaccineSchedule MODIFY iso_3_code VARCHAR(10);

LOAD DATA LOCAL INFILE 'C:/Users/Rohit/Downloads/vaccination/cleaned_reported_cases.csv'
INTO TABLE ReportedCases
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(group_type, code, name, year, disease, disease_description, cases);

LOAD DATA LOCAL INFILE 'C:/Users/Rohit/Downloads/vaccination/cleaned_vaccine_intro.csv'
INTO TABLE VaccineIntroduction
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(iso_3_code, countryname, who_region, year, description, intro);

ALTER TABLE VaccineIntroduction 
    MODIFY iso_3_code VARCHAR(10),
    MODIFY intro VARCHAR(50),
    MODIFY year INT NULL;
    
ALTER TABLE VaccineSchedule 
    MODIFY iso_3_code VARCHAR(10),
    MODIFY year INT NULL,
    MODIFY schedulerounds INT NULL;

    
LOAD DATA LOCAL INFILE 'C:/Users/Rohit/Downloads/vaccination/cleaned_vaccine_schedule.csv'
INTO TABLE VaccineSchedule
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(iso_3_code, countryname, who_region, year, vaccinecode, vaccine_description, schedulerounds, targetpop, targetpop_description, geoarea, ageadministered, sourcecomment);

LOAD DATA LOCAL INFILE 'C:/Users/rohit/Downloads/vaccination/cleaned_coverage.csv'
INTO TABLE Coverage
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(group_type, code, name, year, antigen, antigen_description, coverage_category, coverage_category_description, target_number, doses, coverage);

ALTER TABLE Coverage 
    MODIFY code VARCHAR(10),
    MODIFY coverage FLOAT NULL;
    







