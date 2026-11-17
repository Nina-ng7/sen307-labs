-- ============================================
-- VUA-SEN307 Lab 5: SELECT, Filtering and Joins
-- Name: Nina Vlachos   Matric: VUG/SEN/24/11747
-- ============================================

USE sen307_11747;

-- Task 1: Students in one department, sorted A-Z
SELECT s.student_id, s.full_name, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE d.dept_name = 'Software Engineering'
ORDER BY s.full_name ASC;
-- Explanation: Student is joined to Department using dept_id so we can filter
-- by department name. WHERE keeps only Software Engineering students and
-- ORDER BY s.full_name ASC sorts them alphabetically.

-- Task 2: Courses with their lecturers (INNER JOIN)
SELECT c.course_title, l.full_name AS lecturer_name
FROM Course c
INNER JOIN CourseAllocation ca ON c.course_id = ca.course_id
INNER JOIN Lecturer l ON ca.lecturer_id = l.lecturer_id
ORDER BY c.course_title;
-- Explanation: Course and Lecturer are not linked directly, so we go
-- Course -> CourseAllocation -> Lecturer. INNER JOIN returns only rows with a
-- match in every table, so the course with two lecturers appears twice.

-- Task 3: Students and their courses (LEFT JOIN)
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
ORDER BY s.full_name;
-- Explanation: LEFT JOIN keeps every student, even those with no enrolment.
-- For those students course_title is NULL.

-- Task 3 (extra): only students with no courses
SELECT s.full_name, c.course_title
FROM Student s
LEFT JOIN Enrolment e ON s.student_id = e.student_id
LEFT JOIN Course c ON e.course_id = c.course_id
WHERE c.course_title IS NULL
ORDER BY s.full_name;
-- Explanation: Adding WHERE c.course_title IS NULL keeps only the students
-- who have no match on the right, i.e. the two students created in Week 6.

-- Task 4: Filtering with AND / OR / IN / BETWEEN
SELECT s.full_name, s.gender, s.date_of_birth, d.dept_name
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE s.gender = 'F'
  AND d.dept_name IN ('Software Engineering', 'Artificial Intelligence')
  AND s.date_of_birth BETWEEN '2004-01-01' AND '2005-12-31'
ORDER BY s.full_name;
-- Explanation: Uses AND, IN and BETWEEN together. It returns female students
-- in Software Engineering or Artificial Intelligence who were born between
-- 1 Jan 2004 and 31 Dec 2005 (BETWEEN includes both end dates).

-- Task 5: Paginating enrolments with LIMIT and OFFSET
-- Page 1 (rows 1-10)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 0;
-- Page 2 (rows 11-20)
SELECT * FROM Enrolment ORDER BY enrolment_id LIMIT 10 OFFSET 10;
-- Explanation: LIMIT 10 returns 10 rows; OFFSET skips rows before starting.
-- ORDER BY is always needed with LIMIT because without it MySQL does not
-- guarantee any row order, so the pages could overlap or miss rows.

-- Challenge: Task 3 rewritten with RIGHT JOIN (same result)
SELECT s.full_name, c.course_title
FROM Course c
RIGHT JOIN Enrolment e ON c.course_id = e.course_id
RIGHT JOIN Student s ON e.student_id = s.student_id
ORDER BY s.full_name;
-- Explanation: Same result, but the tables are written in reverse order so
-- Student is on the right. The LEFT JOIN version is easier to read because
-- it starts from Student, the table we want all rows from, and reads
-- left to right.
