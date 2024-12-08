CREATE DATABASE ORG;
SHOW DATABASES;
USE ORG;

CREATE TABLE Worker(
	WORKER_ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    FIRST_NAME CHAR(35),
    LAST_NAME CHAR(35),
    SALARY INT(5),
    JOINING_DATE DATETIME,
    DEPARTMENT CHAR(35)
);

INSERT INTO Worker
	(WORKER_ID, FIRST_NAME, LAST_NAME, SALARY, JOINING_DATE, DEPARTMENT) VALUES
		(001, 'David', 'Doe', 950000, '2014-02-20 09:00:00', 'Finance'),
		(002, 'Michael', 'Smith', 90000, '2014-02-20 09:00:00', 'Executive'),
		(003, 'Tom', 'Lee', 90000, '2014-02-20 09:00:00', 'Sales'),
		(004, 'James', 'Johnson', 85000, '2014-02-20 09:00:00', 'Supply Chain'),
		(005, 'Ivan', 'Watson', 80000, '2014-02-20 09:00:00', 'Operations'),
		(006, 'John', 'Kim', 80000, '2014-02-20 09:00:00', 'Engineering'),
		(007, 'John', 'Chen', 80000, '2014-02-20 09:00:00', 'Engineering'),
		(008, 'Kevin', 'White', 80000, '2014-02-20 09:00:00', 'Sales'),
		(009, 'Jane', 'Brown', 75000, '2014-02-20 09:00:00', 'Executive'),
		(010, 'Lisa', 'Johnson', 75000, '2014-02-20 09:00:00', 'Finance'),
		(011, 'Charles', 'Nguyen', 72000, '2014-02-20 09:00:00', 'IT'),
		(012, 'Zachary', 'Harris', 72000, '2014-02-20 09:00:00', 'Marketing'),
		(013, 'Lily', 'Tran', 70000, '2014-02-20 09:00:00', 'Operations'),
		(014, 'Emma', 'Lopez', 68000, '2014-02-20 09:00:00', 'Human Resources'),
		(015, 'Samantha', 'Gonzalez', 68000, '2014-02-20 09:00:00', 'Sales'),
		(016, 'Melissa', 'Perez', 65000, '2014-02-20 09:00:00', 'Customer Service'),
		(017, 'Jessica', 'Madercod', 60000, '2014-02-20 09:00:00', 'Executive'),
		(018, 'Frank', 'Wong', 33000, '2014-02-20 09:00:00', 'Sales');

CREATE TABLE Bonus (
	WORKER_REF_ID INT,
	BONUS_AMOUNT INT(10),
	BONUS_DATE DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Bonus
	(WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE) VALUES
		(001, 5000, '16-02-20'),
		(002, 3000, '16-06-11'),
		(003, 4000, '16-02-20'),
		(001, 4500, '16-02-20'),
		(002, 3500, '16-06-11');

CREATE TABLE Title (
	WORKER_REF_ID INT,
	WORKER_TITLE CHAR(35),
	AFFECTED_FROM DATETIME,
	FOREIGN KEY (WORKER_REF_ID)
		REFERENCES Worker(WORKER_ID)
        ON DELETE CASCADE
);

INSERT INTO Title
	(WORKER_REF_ID, WORKER_TITLE, AFFECTED_FROM) VALUES
		(001, 'Accountant', '2014-02-20 00:00:00'),
		(002, 'Assistant Manager', '2014-02-20 00:00:00'),
		(003, 'Sales Manager', '2014-02-20 00:00:00'),
		(004, 'Supply Chain Manager', '2014-02-20 00:00:00'),
		(005, 'Operations Manager', '2014-02-20 00:00:00'),
		(006, 'Lead Engineer', '2014-02-20 00:00:00'),
		(007, 'Senior Engineer', '2014-02-20 00:00:00'),
		(008, 'Salesperson', '2014-02-20 00:00:00'),
		(009, 'Manager', '2014-02-20 00:00:00'),
		(010, 'Financial Analyst', '2014-02-20 00:00:00'),
		(011, 'Software Developer', '2014-02-20 00:00:00'),
		(012, 'Marketing Associate', '2014-02-20 00:00:00'),
		(013, 'Operations Supervisor', '2014-02-20 00:00:00'),
		(014, 'Marketing Specialist', '2014-02-20 00:00:00'),
		(015, 'Sales Manager', '2014-02-20 00:00:00'),
		(016, 'Customer Service Representative', '2014-02-20 00:00:00'),
		(017, 'CEO', '2014-02-20 00:00:00'),
		(018, 'Salesperson', '2014-02-20 00:00:00');


SELECT Title.WORKER_TITLE, Worker.FIRST_NAME, Worker.SALARY
FROM Worker
JOIN Title ON WORKER.WORKER_ID = Title.WORKER_REF_ID
ORDER BY Worker.SALARY desc, Worker.FIRST_NAME asc;

SELECT Worker.FIRST_NAME, ( SELECT SUM(Bonus.BONUS_AMOUNT) FROM Bonus Group By Bonus.WORKER_REF_ID)
FROM Bonus
INNER JOIN Worker ON Worker.WORKER_ID = Bonus.WORKER_REF_ID
WHERE Worker.DEPARTMENT = 'HR';


SELECT Bonus.WORKER_REF_ID,SUM(Bonus.BONUS_AMOUNT)
FROM Bonus
Group By Bonus.WORKER_REF_ID;
