-- SQL EXPERIMENT: NORMALIZATION (1NF, 2NF, 3NF, BCNF)

-- =========================
-- 1NF
-- =========================

CREATE TABLE Faculty (
    Faculty_Id INT PRIMARY KEY,
    Faculty_Name VARCHAR(50)
);

CREATE TABLE Faculty_Skills (
    Faculty_Id INT,
    Skill VARCHAR(50),
    PRIMARY KEY (Faculty_Id, Skill),
    FOREIGN KEY (Faculty_Id) REFERENCES Faculty(Faculty_Id)
);

-- =========================
-- 2NF
-- =========================

CREATE TABLE Students (
    Student_Id INT PRIMARY KEY,
    Student_Name VARCHAR(50),
    Student_Address VARCHAR(100)
);

CREATE TABLE Courses (
    Student_Id INT,
    Course_Name VARCHAR(50),
    Date_of_Completion DATE,
    PRIMARY KEY (Student_Id, Course_Name),
    FOREIGN KEY (Student_Id) REFERENCES Students(Student_Id)
);

-- =========================
-- 3NF
-- =========================

CREATE TABLE Company (
    Company_Name VARCHAR(50) PRIMARY KEY,
    Location VARCHAR(50)
);

CREATE TABLE Employee (
    Emp_No INT PRIMARY KEY,
    Emp_Name VARCHAR(50),
    Address VARCHAR(50),
    Salary INT,
    Company_Name VARCHAR(50),
    FOREIGN KEY (Company_Name) REFERENCES Company(Company_Name)
);

-- =========================
-- BCNF
-- =========================

CREATE TABLE Teacher (
    Teacher_Name VARCHAR(50) PRIMARY KEY,
    Course VARCHAR(50)
);

CREATE TABLE Student_Teacher (
    Student_Id INT,
    Teacher_Name VARCHAR(50),
    PRIMARY KEY (Student_Id, Teacher_Name),
    FOREIGN KEY (Teacher_Name) REFERENCES Teacher(Teacher_Name)
);
