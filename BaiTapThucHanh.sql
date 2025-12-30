CREATE DATABASE IF NOT EXISTS OnlineLearning;
USE OnlineLearning;

DROP TABLE IF EXISTS Result;
DROP TABLE IF EXISTS Enrollment;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS Student;

CREATE TABLE Student (
	student_id INT PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	date_of_birth DATE,
	email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Instructor (
	instructor_id INT PRIMARY KEY,
	full_name VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Course (
	course_id INT PRIMARY KEY,
	course_name VARCHAR(120) NOT NULL,
	short_description VARCHAR(255),
	number_of_sessions INT NOT NULL,
	instructor_id INT NOT NULL,
	CHECK (number_of_sessions > 0),
	FOREIGN KEY (instructor_id) REFERENCES Instructor(instructor_id)
);

CREATE TABLE Enrollment (
	enrollment_id INT PRIMARY KEY,
	student_id INT NOT NULL,
	course_id INT NOT NULL,
	enroll_date DATE NOT NULL,
	UNIQUE (student_id, course_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

CREATE TABLE Result (
	result_id INT PRIMARY KEY,
	student_id INT NOT NULL,
	course_id INT NOT NULL,
	midterm_score DECIMAL(4,2) NOT NULL,
	final_score DECIMAL(4,2) NOT NULL,
	UNIQUE (student_id, course_id),
	CHECK (midterm_score >= 0 AND midterm_score <= 10),
	CHECK (final_score >= 0 AND final_score <= 10),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (course_id) REFERENCES Course(course_id)
);

INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES
	(1,'Hoang Cuong Cat','2006-01-10','Cat06@gmail.com'),
	(2,'Nguyen Quang Vinh','2006-03-22','vinh06@gmail.com'),
	(3,'Nguyen Son Minh','2006-06-01','minh06@gmail.com'),
	(4,'Pham Viet Quan','2006-09-12','quan06@gmail.com'),
	(5,'Hoang Van Luong','2006-11-05','luong06@gmail.com');

INSERT INTO Instructor (instructor_id, full_name, email)
VALUES
	(1,'Nguyen Van A','kiet@uni.edu'),
	(2,'Tran Van B','ha@uni.edu'),
	(3,'Hoang Thi C','nam@uni.edu'),
	(4,'Ngo Thi D','huy@uni.edu'),
	(5,'To Van E','anh@uni.edu');

INSERT INTO Course (course_id, course_name, short_description, number_of_sessions, instructor_id)
VALUES
	(101,'SQL Co Ban','Hoc DDL va DML',12,1),
	(102,'Lap Trinh C','Bien va cau truc dieu khien',15,2),
	(103,'Cau Truc Du Lieu','Mang, stack, queue',18,3),
	(104,'Web Co Ban','HTML, CSS, JS',14,4),
	(105,'OOP Java','Class va object',16,5);

INSERT INTO Enrollment (enrollment_id, student_id, course_id, enroll_date)
VALUES
	(1,1,101,'2025-12-01'),
	(2,1,104,'2025-12-02'),
	(3,2,101,'2025-12-03'),
	(4,2,102,'2025-12-03'),
	(5,3,103,'2025-12-04'),
	(6,4,104,'2025-12-05'),
	(7,4,105,'2025-12-05'),
	(8,5,105,'2025-12-06');

INSERT INTO Result (result_id, student_id, course_id, midterm_score, final_score)
VALUES
	(1,1,101,7.50,8.00),
	(2,1,104,6.00,7.00),
	(3,2,101,8.00,8.50),
	(4,2,102,5.50,6.50),
	(5,3,103,7.00,7.50),
	(6,4,104,9.00,9.20),
	(7,4,105,6.50,7.30),
	(8,5,105,4.00,4.50);

UPDATE Student
SET email = 'bich2006@gmail.com'
WHERE student_id = 2;

UPDATE Course
SET short_description = 'Mang, stack, queue, linked list'
WHERE course_id = 103;

UPDATE Result
SET final_score = 9.50
WHERE student_id = 1 AND course_id = 101;

DELETE FROM Result
WHERE student_id = 5 AND course_id = 105;

DELETE FROM Enrollment
WHERE enrollment_id = 8;

SELECT * FROM Student;

SELECT * FROM Instructor;

SELECT * FROM Course;

SELECT * FROM Enrollment;

SELECT * FROM Result;

SELECT
	e.enrollment_id,
	s.student_id,
	s.full_name,
	c.course_id,
	c.course_name,
	e.enroll_date
FROM Enrollment e
JOIN Student s ON s.student_id = e.student_id
JOIN Course c ON c.course_id = e.course_id;

SELECT
	r.result_id,
	s.student_id,
	s.full_name,
	c.course_id,
	c.course_name,
	r.midterm_score,
	r.final_score
FROM Result r

JOIN Student s ON s.student_id = r.student_id
JOIN Course c ON c.course_id = r.course_id;
