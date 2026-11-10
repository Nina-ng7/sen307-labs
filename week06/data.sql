USE sen307_11747;

-- =====PART 1: Departments and Courses=====
INSERT INTO Department (dept_name) VALUES
('Software Engineering'),
('Computer Science'),
('Artificial Intelligence'),
('Data Science'),
('Cybersecurity');

INSERT INTO Course (course_code, course_title, credit_units, description, dept_id) VALUES
('SEN307', 'Database Systems', 3,
'Relational database design, SQL queries, normalization, transactions and indexing using MySQL.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('SEN301', 'Software Architecture', 3,
'Architectural styles, design patterns, microservices and how to structure large software systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')),
('COS301', 'Operating Systems', 3,
'Processes, threads, CPU scheduling, memory management and file systems.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('COS305', 'Computer Networks', 3,
'TCP/IP, routing, switching, LAN and WAN design and network protocols.',
(SELECT dept_id FROM Department WHERE dept_name = 'Computer Science')),
('AIN301', 'Introduction to Artificial Intelligence', 3,
'Intelligent agents, search algorithms, knowledge representation and reasoning.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN305', 'Machine Learning', 3,
'Supervised and unsupervised learning, neural networks, deep learning and model evaluation.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('AIN307', 'Natural Language Processing', 3,
'Text processing, word embeddings, language models, sentiment analysis and chatbots.',
(SELECT dept_id FROM Department WHERE dept_name = 'Artificial Intelligence')),
('DTS301', 'Data Visualization and Analytics', 2,
'Exploratory data analysis, charts, dashboards and telling stories with data.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('DTS305', 'Big Data Technologies', 3,
'Distributed storage and processing of very large datasets with Hadoop and Spark.',
(SELECT dept_id FROM Department WHERE dept_name = 'Data Science')),
('CYB301', 'Network Security', 3,
'Firewalls, cryptography, intrusion detection and protecting networks from attacks.',
(SELECT dept_id FROM Department WHERE dept_name = 'Cybersecurity'));

SELECT d.dept_name, COUNT(c.course_id) AS courses
FROM Department d LEFT JOIN Course c ON d.dept_id = c.dept_id
GROUP BY d.dept_name;

SELECT dept_id, dept_name FROM Department;
SELECT course_id, course_code FROM Course;

-- =====PART 2: Own data=====
INSERT INTO Lecturer (staff_no, full_name, email, dept_id) VALUES
('VUA/ST/101', 'Dr Amaka Okafor',   'a.okafor@vua.edu.ng',   1),
('VUA/ST/102', 'Dr Musa Bello',     'm.bello@vua.edu.ng',    1),
('VUA/ST/103', 'Dr Chidi Eze',      'c.eze@vua.edu.ng',      2),
('VUA/ST/104', 'Dr Fatima Yusuf',   'f.yusuf@vua.edu.ng',    2),
('VUA/ST/105', 'Dr Emeka Nwosu',    'e.nwosu@vua.edu.ng',    3),
('VUA/ST/106', 'Dr Ngozi Adeyemi',  'n.adeyemi@vua.edu.ng',  3),
('VUA/ST/107', 'Dr Tunde Balogun',  't.balogun@vua.edu.ng',  4),
('VUA/ST/108', 'Dr Hauwa Ibrahim',  'h.ibrahim@vua.edu.ng',  4),
('VUA/ST/109', 'Dr Ifeanyi Obi',    'i.obi@vua.edu.ng',      5),
('VUA/ST/110', 'Dr Zainab Abubakar','z.abubakar@vua.edu.ng', 5);

-- Step 2: Students (20). i'm Student 1
INSERT INTO Student (matric_no, full_name, gender, date_of_birth, dept_id) VALUES
('VUG/SEN/24/11747', 'Nina Vlachos',       'F', '2007-04-02', 1),
('20231235', 'John Musa',          'M', '2004-11-02', 2),
('20231236', 'Ada Obi',            'F', '2005-03-14', 1),
('20231237', 'Ibrahim Sani',       'M', '2003-08-09', 3),
('20231238', 'Chiamaka Eze',       'F', '2006-01-25', 4),
('20231239', 'Tobi Adebayo',       'M', '2005-07-30', 5),
('20231240', 'Aisha Lawal',        'F', '2004-02-17', 2),
('20231241', 'Emeka Okonkwo',      'M', '2003-12-05', 1),
('20231242', 'Blessing Udoh',      'F', '2006-09-12', 3),
('20231243', 'Yusuf Danjuma',      'M', '2005-04-22', 4),
('20231244', 'Funke Ogunleye',     'F', '2007-02-01', 5),
('20231245', 'Samuel Adeleke',     'M', '2004-10-19', 1),
('20231246', 'Halima Garba',       'F', '2003-06-28', 2),
('20231247', 'Kelechi Nnamdi',     'M', '2006-03-03', 3),
('20231248', 'Grace Ekanem',       'F', '2005-11-11', 4),
('20231249', 'Daniel Okoro',       'M', '2004-08-15', 5),
('20231250', 'Mariam Suleiman',    'F', '2007-05-07', 1),
('20231251', 'Chinedu Obiora',     'M', '2005-01-29', 2),
('20231252', 'Patience Akpan',     'F', '2006-12-14', 3),
('20231253', 'Abdullahi Umar',     'M', '2003-09-21', 4);

-- Step 3: Enrolments (40). Students 19 and 20 have none on purpose.
SELECT student_id, matric_no, full_name FROM Student;
SELECT lecturer_id, full_name FROM Lecturer;

INSERT INTO Enrolment (student_id, course_id) VALUES
(1,1),(1,2),
(2,1),(2,3),
(3,1),(3,4),
(4,1),(4,5),(4,6),
(5,1),(5,5),
(6,1),(6,6),
(7,1),(7,7),(7,2),
(8,1),(8,8),
(9,2),(9,9),
(10,3),(10,10),
(11,4),(11,8),(11,5),
(12,5),(12,9),
(13,6),(13,10),
(14,7),(14,3),
(15,8),(15,4),
(16,9),(16,2),(16,6),
(17,10),(17,7),
(18,3),(18,5);

-- Allocations: every course has a lecturer; courses 1 and 10 have two
INSERT INTO CourseAllocation (course_id, lecturer_id) VALUES
(1,1),(1,2),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,6),
(8,7),
(9,8),
(10,9),(10,10);

-- ===== PART 3: UPDATE =====
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'VUG/SEN/24/11747';
UPDATE Student SET dept_id = 2 WHERE matric_no = 'VUG/SEN/24/11747';
SELECT matric_no, full_name, dept_id FROM Student WHERE matric_no = 'VUG/SEN/24/11747';

-- ===== PART 4: Referential integrity =====
SET SQL_SAFE_UPDATES = 0;

-- Step 1
INSERT INTO Department (dept_name) VALUES ('Library and Information Science');
INSERT INTO Student (matric_no, full_name, dept_id)
VALUES ('20239999', 'Transfer Student',
(SELECT dept_id FROM Department WHERE dept_name = 'Library and Information Science'));

-- Step 2:Error 1451
DELETE FROM Department WHERE dept_name = 'Library and Information Science';

-- Step 3: the fix
UPDATE Student
SET dept_id = (SELECT dept_id FROM Department WHERE dept_name = 'Software Engineering')
WHERE matric_no = '20239999';

DELETE FROM Department WHERE dept_name = 'Library and Information Science';
SELECT * FROM Department;

SET SQL_SAFE_UPDATES = 1;

-- ===== FINAL CHECK=====
SELECT 'Departments' AS tbl, COUNT(*) AS total FROM Department
UNION ALL SELECT 'Lecturers', COUNT(*) FROM Lecturer
UNION ALL SELECT 'Students', COUNT(*) FROM Student
UNION ALL SELECT 'Courses', COUNT(*) FROM Course
UNION ALL SELECT 'Enrolments', COUNT(*) FROM Enrolment
UNION ALL SELECT 'Allocations', COUNT(*) FROM CourseAllocation;
