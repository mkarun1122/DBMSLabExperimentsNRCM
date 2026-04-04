-- EXPERIMENT – 7
/* 

QUERIES using Aggregate FUNCTIONS, GROUP BY, HAVING and Creation/Dropping of Views
Aim

To practice SQL queries using Aggregate Functions, ORDER BY, GROUP BY, HAVING clauses and Views.

Aggregate Functions in MySQL

MySQL supports the following aggregate functions:

Function	Description
AVG()	Returns the average of the values in a selected column
COUNT()	Returns the number of rows returned for a selection
MAX()	Returns the maximum value of a column
MIN()	Returns the minimum value of a column
SUM()	Returns the sum of the values in a specified column

Table: EMPINFO
EID	EMPLOYEENAME	JOB	MGRID	HIREDATE	SALARY	COMMISSION	DEPTNO
1001	ANIL	MANAGER	NULL	03/03/2010	35000	NULL	10
1002	AKHIL	CLERK	1001	02/04/2015	25000	NULL	10
1003	VINOD	SALES	1001	05/06/2016	18000	1800	10
1004	VIKAS	SALES	1001	06/07/2016	16000	1600	10
1005	SUNIL	MANAGER	NULL	03/04/2011	30000	NULL	20
1006	KIRAN	CLERK	1005	05/06/2016	20000	NULL	20
1007	AREEB	SALES	1005	10/05/2016	15000	1500	20

DROP DATABASE ARUNDBEX7;
CREATE DATABASE ARUNDBEX7;
USE ARUNDBEX7;
CREATE TABLE EMPINFO (
    EID INT PRIMARY KEY,
    EMPLOYEENAME VARCHAR(20),
    JOB VARCHAR(20),
    MGRID INT,
    HIREDATE DATE,
    SALARY INT,
    COMMISSION INT,
    DEPTNO INT
);
INSERT INTO EMPINFO VALUES
(1001,'ANIL','MANAGER',NULL,'2010-03-03',35000,NULL,10),
(1002,'AKHIL','CLERK',1001,'2015-04-02',25000,NULL,10),
(1003,'VINOD','SALES',1001,'2016-06-05',18000,1800,10),
(1004,'VIKAS','SALES',1001,'2016-07-06',16000,1600,10),
(1005,'SUNIL','MANAGER',NULL,'2011-04-03',30000,NULL,20),
(1006,'KIRAN','CLERK',1005,'2016-06-05',20000,NULL,20),
(1007,'AREEB','SALES',1005,'2016-05-10',15000,1500,20);
*/

-- Aggregate Function Queries
-- 1. Total number of employees in the organization


SELECT COUNT(*) 
FROM EMPINFO;

-- 2. Total salary paid to all employees


SELECT SUM(SALARY) 
FROM EMPINFO;

-- 3. Average salary of employees

SELECT AVG(SALARY) 
FROM EMPINFO;

-- 4. Employee with maximum salary

SELECT * 
FROM EMPINFO
WHERE SALARY = (SELECT MAX(SALARY) FROM EMPINFO);

-- 5. Employee with minimum salary

SELECT *
FROM EMPINFO
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPINFO);

-- ORDER BY, GROUP BY and HAVING Clauses
-- ORDER BY
-- 1. Display salary in ascending order

SELECT * 
FROM EMPINFO
ORDER BY SALARY ASC;

-- 2. Display employee names in alphabetical order

SELECT EMPLOYEENAME
FROM EMPINFO
ORDER BY EMPLOYEENAME;

-- 3. Display salary in ascending order for department number 10

SELECT *
FROM EMPINFO
WHERE DEPTNO = 10
ORDER BY SALARY ASC;

-- 4. Create a duplicate table based on salary

CREATE TABLE EMPINFO_COPY AS
SELECT *
FROM EMPINFO
ORDER BY SALARY;

-- GROUP BY and HAVING
-- 1. Count employees in each department

SELECT DEPTNO, COUNT(*)
FROM EMPINFO
GROUP BY DEPTNO;

-- 2. Highest salary in each department

SELECT DEPTNO, MAX(SALARY)
FROM EMPINFO
GROUP BY DEPTNO;

-- 3. Highest salary for each job

SELECT JOB, MAX(SALARY)
FROM EMPINFO
GROUP BY JOB;

-- 4. Count employees in department number 10

SELECT COUNT(*)
FROM EMPINFO
WHERE DEPTNO = 10;

-- 5. Departments having employee count greater than 3

SELECT DEPTNO, COUNT(*)
FROM EMPINFO
GROUP BY DEPTNO
HAVING COUNT(*) > 3;

-- Creation and Dropping of Views
-- Syntax for Creating a View
-- CREATE VIEW view_name AS
-- SELECT column1, column2
-- FROM table_name
-- WHERE condition;
-- Syntax for Dropping a View
-- DROP VIEW view_name;
-- Exercises
/*
CREATE TABLE STUDENTGPA (
    SID INT PRIMARY KEY,
    NAME VARCHAR(50),
    AGE INT,
    GPA INT
);

INSERT INTO STUDENTGPA VALUES
(101, 'ANIL', 20, 8),
(102, 'AKHIL', 21, 7),
(103, 'VINOD', 22, 9),
(104, 'RAVI', 20, 8),
(105, 'SNEHA', 21, 9);

CREATE TABLE COURSEGRADE (
    SID INT,
    CID VARCHAR(10),
    GRADE CHAR(2),
    PRIMARY KEY (SID, CID),
    FOREIGN KEY (SID) REFERENCES STUDENTGPA(SID)
);
INSERT INTO COURSEGRADE VALUES
(101, 'C101', 'A'),
(101, 'C102', 'B'),
(102, 'C101', 'B'),
(103, 'C103', 'A'),
(104, 'C101', 'C'),
(105, 'C104', 'A');


*/
-- 1. Create a view for students whose grade is 'A'

CREATE VIEW GOODSTUDENTS AS
SELECT *
FROM COURSEGRADE
WHERE GRADE = 'A';

-- 2. Create a view for students whose grade is 'B'

CREATE VIEW AVGSTUDENTS AS
SELECT *
FROM COURSEGRADE
WHERE GRADE = 'B';

SELECT * FROM GOODSTUDENTS;
SELECT * FROM AVGSTUDENTS;

-- 3. Drop the created views

DROP VIEW GOODSTUDENTS;
DROP VIEW AVGSTUDENTS;

/* ✅ Result:
Successfully executed SQL queries using Aggregate Functions, ORDER BY, GROUP BY, HAVING clauses and Views.
*/