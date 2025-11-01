--1. Use CREATE TABLE statements to create the following tables.--

CREATE TABLE coaches (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE classes (
    id INT PRIMARY KEY,
    session INT,
    level VARCHAR(20),
    time VARCHAR(20),
    coach_id INT,
    FOREIGN KEY (coach_id) REFERENCES coaches(id)
);

CREATE TABLE students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    birth_year INT,
    session INT,
    level VARCHAR(20),
    preferred_time1 VARCHAR(20),
    preferred_time2 VARCHAR(20),
    class_id INT,
    FOREIGN KEY (class_id) REFERENCES classes(id)
);

--2. Use INSERT statements to populate the tables so that each table has at least two records. --

INSERT INTO coaches (id, name) VALUES
(1, 'John'),
(2, 'Mary');

INSERT INTO classes (id, session, level, time, coach_id) VALUES
(1, 1, 'Beginner', '9AM', 1),
(2, 1, 'Intermediate', '10AM', 2);

INSERT INTO students (id, name, birth_year, session, level, preferred_time1, preferred_time2, class_id) VALUES
(1, 'Alice', 2010, 1, 'Beginner', '9AM', '10AM', NULL),
(2, 'Bob', 2009, 1, 'Intermediate', '10AM', '11AM', NULL);

--3. Complete the following queries.--

SELECT 
    id,
    name,
    birth_year,
    (YEAR(CURDATE()) - birth_year) AS age
FROM students
WHERE session = 1;

SELECT s.id, s.name
FROM students s
JOIN classes c ON s.session = c.session
               AND s.level = c.level
               AND (s.preferred_time1 = c.time OR s.preferred_time2 = c.time)
WHERE c.id = 1 AND s.class_id IS NULL;

SELECT c.name AS coach_name, COUNT(s.id) AS num_students
FROM coaches c
JOIN classes cl ON c.id = cl.coach_id
LEFT JOIN students s ON s.class_id = cl.id
WHERE c.name = 'John'
GROUP BY c.name;

SELECT cl.id, cl.session, cl.level, cl.time, COUNT(s.id) AS num_students
FROM classes cl
LEFT JOIN students s ON cl.id = s.class_id
GROUP BY cl.id, cl.session, cl.level, cl.time;

--4. Use an UPDATE statement to change the name and the birth year of the student with id=1.--

UPDATE students
SET name = 'Alicia', birth_year = 2011
WHERE id = 1;

