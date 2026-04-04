-- EXPERIMENT – 10
/*
CURSORS
Aim
Declare a cursor that defines a result set.
Open the cursor to establish the result set.
Fetch the data into local variables one row at a time.
Close the cursor when finished.

MySQL Cursor Steps
Declare Cursor – Define the SELECT query
Open Cursor – Start the cursor
Fetch Cursor – Retrieve rows one by one
Close Cursor – Release cursor resources
*/

-- 1. Cursor to Display Employee Name and Salary Procedure with Cursor
DELIMITER $$
CREATE PROCEDURE display_emp_salary()
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE v_name VARCHAR(50);
DECLARE v_salary INT;
DECLARE emp_cursor CURSOR FOR
SELECT EMPLOYEENAME, SALARY FROM EMPINFO;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN emp_cursor;
read_loop: LOOP
FETCH emp_cursor INTO v_name, v_salary;
IF done = 1 THEN
LEAVE read_loop;
END IF;
SELECT v_name AS EMPNAME, v_salary AS SALARY;
END LOOP;
CLOSE emp_cursor;
END$$
DELIMITER ;

-- Execute Procedure
CALL display_emp_salary();

-- 2. Cursor to Accept DeptNo and Display Employee Names Create Procedure

DELIMITER $$
CREATE PROCEDURE emp_by_dept(IN dno INT)
BEGIN
DECLARE done INT DEFAULT 0;
DECLARE v_name VARCHAR(50);

DECLARE dept_cursor CURSOR FOR
SELECT EMPLOYEENAME FROM EMPINFO WHERE DEPTNO = dno;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN dept_cursor;

read_loop: LOOP

FETCH dept_cursor INTO v_name;

IF done = 1 THEN
LEAVE read_loop;
END IF;

SELECT v_name AS EMPLOYEE_NAME;

END LOOP;

CLOSE dept_cursor;

END$$

DELIMITER ;

-- Execute Procedure
CALL emp_by_dept(10);

-- 3. Cursor to Copy EMPINFO Data into EMPBACKUP 

-- Step 1: Create Backup Table
CREATE TABLE EMPBACKUP LIKE EMPINFO;
-- Step 2: Create Procedure with Cursor
DELIMITER $$

CREATE PROCEDURE copy_empinfo()
BEGIN

DECLARE done INT DEFAULT 0;

DECLARE v_eid INT;
DECLARE v_name VARCHAR(50);
DECLARE v_job VARCHAR(20);
DECLARE v_mgr INT;
DECLARE v_hiredate DATE;
DECLARE v_salary INT;
DECLARE v_comm INT;
DECLARE v_dept INT;

DECLARE emp_cursor CURSOR FOR
SELECT * FROM EMPINFO;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN emp_cursor;

read_loop: LOOP

FETCH emp_cursor INTO
v_eid,v_name,v_job,v_mgr,v_hiredate,v_salary,v_comm,v_dept;

IF done = 1 THEN
LEAVE read_loop;
END IF;

INSERT INTO EMPBACKUP
VALUES(v_eid,v_name,v_job,v_mgr,v_hiredate,v_salary,v_comm,v_dept);

END LOOP;

CLOSE emp_cursor;

END$$

DELIMITER ;

-- Execute Procedure
CALL copy_empinfo();
-- Check Table
SELECT * FROM EMPBACKUP;

-- 4. Cursor to Increment Salary Based on Job
-- JOB	Salary Increment
-- MANAGER	+20000
-- CLERK	+10000
-- SALES	+5000
-- Procedure

DELIMITER $$
CREATE PROCEDURE increment_salary()
BEGIN

DECLARE done INT DEFAULT 0;
DECLARE v_eid INT;
DECLARE v_job VARCHAR(20);

DECLARE emp_cursor CURSOR FOR
SELECT EID, JOB FROM EMPINFO;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN emp_cursor;

read_loop: LOOP

FETCH emp_cursor INTO v_eid, v_job;

IF done = 1 THEN
LEAVE read_loop;
END IF;

IF v_job = 'MANAGER' THEN
UPDATE EMPINFO SET SALARY = SALARY + 20000 WHERE EID = v_eid;

ELSEIF v_job = 'CLERK' THEN
UPDATE EMPINFO SET SALARY = SALARY + 10000 WHERE EID = v_eid;

ELSEIF v_job = 'SALES' THEN
UPDATE EMPINFO SET SALARY = SALARY + 5000 WHERE EID = v_eid;

END IF;

END LOOP;

CLOSE emp_cursor;

END$$

DELIMITER ;
-- Execute Procedure
CALL increment_salary();
-- Check Table
SELECT * FROM EMPINFO;


-- 5. Cursor to Accept DeptNo and Display Employee List Create Procedure
DELIMITER $$

CREATE PROCEDURE emp_list_dept(IN dno INT)
BEGIN

DECLARE done INT DEFAULT 0;
DECLARE v_name VARCHAR(50);

DECLARE emp_cursor CURSOR FOR
SELECT EMPLOYEENAME FROM EMPINFO WHERE DEPTNO = dno;

DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

OPEN emp_cursor;

read_loop: LOOP

FETCH emp_cursor INTO v_name;

IF done = 1 THEN
LEAVE read_loop;
END IF;

SELECT v_name;

END LOOP;

CLOSE emp_cursor;

END$$

DELIMITER ;

-- Execute Procedure
CALL emp_list_dept(20);


-- Result
-- Cursors were successfully declared, opened, fetched, and closed in MySQL procedures.