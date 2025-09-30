-- =============================================
-- Student Management System Database Setup
-- =============================================

-- Create the database
CREATE DATABASE StudentDB;
GO

-- Use the database
USE StudentDB;
GO

-- Create Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY IDENTITY(1,1),
    username NVARCHAR(50) UNIQUE NOT NULL,
    password NVARCHAR(255) NOT NULL,
    name NVARCHAR(100) NOT NULL,
);

-- Create Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY IDENTITY(1,1),
    course_name NVARCHAR(100) NOT NULL
);

-- Create Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id)
);

-- Create Attendance table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY IDENTITY(1,1),
    student_id INT FOREIGN KEY REFERENCES Students(student_id),
    course_id INT FOREIGN KEY REFERENCES Courses(course_id),
    attendance_percentage DECIMAL(5,2)
);

-- =============================================
-- Insert Sample Data
-- =============================================

-- Insert sample students
INSERT INTO Students (username, password, name, email) VALUES 
('rey', 'rey1916', 'Shrey Patel'),
('kaus', 'kaus6545', 'Kaustubh Umrao'),
('kallu', 'atisbaaj0803', 'Abhishek Sharma'),
('kumari', 'kumari06', 'Himanshu Kumar');

-- Insert sample courses
INSERT INTO Courses (course_name) VALUES 
('Python Programming'),
('Database Management Systems'),
('Web Development'),
('Data Structures'),
('Computer Networks'),
('Software Engineering');

-- Insert sample enrollments
-- Shrey Patel enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES 
(1, 1), -- Python Programming
(1, 2), -- Database Management Systems
(1, 3); -- Web Development

-- Kaustubh Umrao enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES 
(2, 1), -- Python Programming
(2, 4), -- Data Structures
(2, 5); -- Computer Networks

-- Abhishek Sharma enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES 
(3, 2), -- Database Management Systems
(3, 3), -- Web Development
(3, 6); -- Software Engineering

-- Himanshu Kumar enrollments
INSERT INTO Enrollments (student_id, course_id) VALUES 
(4, 1), -- Python Programming
(4, 4), -- Data Structures
(4, 5), -- Computer Networks
(4, 6); -- Software Engineering

-- Insert sample attendance data
INSERT INTO Attendance (student_id, course_id, attendance_percentage) VALUES 
-- Shrey Patel attendance
(1, 1, 95.50),  -- Python Programming
(1, 2, 87.20),  -- Database Management Systems
(1, 3, 92.80),  -- Web Development

-- Kaustubh Umrao attendance
(2, 1, 88.90),  -- Python Programming
(2, 4, 91.30),  -- Data Structures
(2, 5, 85.70),  -- Computer Networks

-- Abhishek Sharma attendance
(3, 2, 79.40),  -- Database Management Systems
(3, 3, 94.10),  -- Web Development
(3, 6, 82.60),  -- Software Engineering

-- Himanshu Kumar attendance
(4, 1, 96.80),  -- Python Programming
(4, 4, 89.20),  -- Data Structures
(4, 5, 93.50),  -- Computer Networks
(4, 6, 86.40);  -- Software Engineering
