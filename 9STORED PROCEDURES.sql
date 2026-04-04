-- EXPERIMENT – 9
/*

STORED PROCEDURES
Aim
Creation of Stored Procedures, execution of procedures, 
and modification of procedures.
A Stored Procedure is a precompiled collection of SQL statements
stored in the database
and executed using the CALL command.
*/

DROP DATABASE IF EXISTS EXPERIMENT9DB;
CREATE DATABASE EXPERIMENT9DB;
USE EXPERIMENT9DB;


-- 1. Procedure to Print Sum of Two Values
Create Procedure
DELIMITER $$
CREATE PROCEDURE sum_two_numbers(IN a INT, IN b INT)
BEGIN
DECLARE total INT;
SET total = a + b;
SELECT total AS SUM;
END$$
DELIMITER ;

-- Execute Procedure
CALL sum_two_numbers(10,20);

-- 2. Procedure to Accept EID and Display Employee Info Create Procedure

DELIMITER $$
CREATE PROCEDURE get_employee(IN emp_id INT)
BEGIN
SELECT * FROM EMPINFO
WHERE EID = emp_id;
END$$
DELIMITER ;

-- Execute Procedure
CALL get_employee(1001);

-- 3. Procedure to Add Record in EMPINFO Table Create Procedure
DELIMITER $$
CREATE PROCEDURE add_employee(
IN p_eid INT,
IN p_name VARCHAR(50),
IN p_job VARCHAR(20),
IN p_mgr INT,
IN p_hiredate DATE,
IN p_salary INT,
IN p_commission INT,
IN p_deptno INT
)
BEGIN
INSERT INTO EMPINFO
VALUES(p_eid,p_name,p_job,p_mgr,p_hiredate,p_salary,p_commission,p_deptno);
END$$

DELIMITER ;

-- Execute Procedure
CALL add_employee(1008,'RAJ','CLERK',1001,'2017-01-01',20000,NULL,10);
-- Check Table
SELECT * FROM EMPINFO;

-- 4. Procedure to Update Salary using EID Create Procedure
DELIMITER $$
CREATE PROCEDURE update_salary(
IN emp_id INT,
IN new_salary INT
)
BEGIN
UPDATE EMPINFO
SET SALARY = new_salary
WHERE EID = emp_id;
END$$
DELIMITER ;

-- Execute Procedure
CALL update_salary(1003,25000);

-- Check Table
SELECT * FROM EMPINFO;

-- 5. Procedure to Delete Record using EID Create Procedure
DELIMITER $$
CREATE PROCEDURE delete_employee(IN emp_id INT)
BEGIN
DELETE FROM EMPINFO
WHERE EID = emp_id;
END$$
DELIMITER ;

-- Execute Procedure
CALL delete_employee(1008);
-- Check Table
SELECT * FROM EMPINFO;

-- 6. Procedure to Check Duplicate EID Before Adding Record Create Procedure

DELIMITER $$
CREATE PROCEDURE add_employee_check(
IN p_eid INT,
IN p_name VARCHAR(50),
IN p_job VARCHAR(20),
IN p_mgr INT,
IN p_hiredate DATE,
IN p_salary INT,
IN p_commission INT,
IN p_deptno INT
)
BEGIN
DECLARE count_id INT;
SELECT COUNT(*) INTO count_id
FROM EMPINFO
WHERE EID = p_eid;

IF count_id > 0 THEN
SELECT 'EID ALREADY EXISTS' AS MESSAGE;
ELSE
INSERT INTO EMPINFO
VALUES(p_eid,p_name,p_job,p_mgr,p_hiredate,p_salary,p_commission,p_deptno);
SELECT 'RECORD INSERTED' AS MESSAGE;
END IF;
END$$
DELIMITER ;

-- Execute Procedure
CALL add_employee_check(1009,'KUMAR','SALES',1001,'2018-02-02',22000,2000,20);
-- Drop Procedure (If Needed)
-- DROP PROCEDURE procedure_name;

-- Example:

-- DROP PROCEDURE sum_two_numbers;
-- Result

-- Stored Procedures were created, executed, and modified successfully in MySQL.