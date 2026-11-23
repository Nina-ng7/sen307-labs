-- VUA-SEN307 Lab 6: Aggregate Functions, Grouping and Subqueries
-- Name: Nina Vlachos   Matric: VUG/SEN/24/11747

USE sen307_11747;

-- Task 1: Students per course (COUNT with GROUP BY and LEFT JOIN)
SELECT c.course_title, COUNT(DISTINCT e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
ORDER BY total_students DESC;
-- => GROUP BY makes one group per course and COUNT counts the
-- students in each group. LEFT JOIN keeps courses with no students. COUNT
-- on e.student_id ignores NULLs, so an empty course gives 0 (COUNT(*) would
-- give 1 because the NULL row still counts as a row). DISTINCT stops a
-- student being counted twice if enrolled in the same course twice

-- Task 2: Courses with more than N students (HAVING)
-- More than 3 students
SELECT c.course_title, COUNT(DISTINCT e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(DISTINCT e.student_id) > 3;

-- More than 5 students
SELECT c.course_title, COUNT(DISTINCT e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(DISTINCT e.student_id) > 5;

-- More than 7 students
SELECT c.course_title, COUNT(DISTINCT e.student_id) AS total_students
FROM Course c
LEFT JOIN Enrolment e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_title
HAVING COUNT(DISTINCT e.student_id) > 7;
-- => WHERE filters rows before grouping, but HAVING filters the
-- groups after grouping, so only HAVING can use COUNT. The same query is run
-- with thresholds 3, 5 and 7; a higher threshold returns fewer courses

-- Task 3: Average number of courses per student 
SELECT ROUND(AVG(course_count), 2) AS avg_courses_per_student
FROM (
    SELECT s.student_id, COUNT(DISTINCT e.course_id) AS course_count
    FROM Student s
    LEFT JOIN Enrolment e ON s.student_id = e.student_id
    GROUP BY s.student_id
) AS per_student;
-- => The inner query gives one row per student with their number of
-- courses. LEFT JOIN makes students with no courses show 0 instead of being
-- left out. The outer query averages those counts and ROUND gives 2 decimals

-- Task 4: Students not enrolled in any course (non-correlated subquery)
SELECT student_id, matric_no, full_name
FROM Student
WHERE student_id NOT IN (SELECT student_id FROM Enrolment);
-- => The inner query returns every student_id that appears in
-- Enrolment and runs only once. NOT IN keeps the students missing from that
-- list. The result matches Week 7 Task 3 (extra): the two students created
-- in Week 6.

-- Task 5: Student with the most enrolments in each department (correlated subquery)
SELECT d.dept_name, s.full_name,
       (SELECT COUNT(*)
        FROM Enrolment e
        WHERE e.student_id = s.student_id) AS courses
FROM Student s
INNER JOIN Department d ON s.dept_id = d.dept_id
WHERE (SELECT COUNT(*)
       FROM Enrolment e
       WHERE e.student_id = s.student_id)
      >= ALL (
          SELECT COUNT(e2.enrolment_id)
          FROM Student s2
          LEFT JOIN Enrolment e2 ON s2.student_id = e2.student_id
          WHERE s2.dept_id = s.dept_id
          GROUP BY s2.student_id
      )
ORDER BY d.dept_name;
-- => The subqueries refer to s from the outer query, so they run
-- once for every student. The first counts that student's enrolments. The
-- ALL subquery counts the enrolments of every student in the same department.
-- A student is kept only if their count is greater
-- than or equal to all of those counts, so ties are allowed
