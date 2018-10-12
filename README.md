SQL
===

This file is basic command as in SQL.

* Create table

CREATE TABLE table_name (id INTEGER PRIMARY KEY, name TEXT, quantity INTEGER, aisle INTEGER);

INSERT INTO table_name VALUES(1,’Chocolate Syrup',1,4); 

SELECT * FROM table_name;

* Query table

SELECT * FROM GroceriesT WHERE aisle > 5 ORDER BY aisle;

SELECT * FROM GroceriesT ORDER BY aisle;

SELECT name FROM GroceriesT;

* Aggregating data

SELECT SUM(quantity) FROM GroceriesT;

SELECT MAX(quantity) FROM GroceriesT;

SELECT aisle, MAX(quantity) FROM GroceriesT GROUP BY aisle;

* Queries with AND OR

CREATE TABLE exercise_logs (id serial PRIMARY KEY, type TEXT, minutes INTEGER, calories INTEGER, heart_rate INTEGER);

INSERT INTO exercise_logs (type, minutes, calories, heart_rate) VALUES ('biking',30,100,110);

SELECT * FROM exercise_logs WHERE calories > 50 ORDER BY calories;

SELECT * FROM exercise_logs WHERE calories > 50 AND minutes < 30;

SELECT * FROM exercise_logs WHERE calories > 50 or heart_rate > 100;

* Query IN subqueries

SELECT * FROM exercise_logs WHERE type ='biking' OR type ='tree climbing';

SELECT * FROM exercise_logs WHERE type IN ('biking','tree climbing');

SELECT * FROM exercise_logs WHERE type NOT IN ('biking','tree climbing');

CREATE TABLE drs_favorites (id serial PRIMARY KEY, type TEXT, reason TEXT);

INSERT INTO drs_favorites(type, reason) VALUES ('biking','improves endurance and flexibility.');

INSERT INTO drs_favorites(type, reason) VALUES ('hiking','increase cardiovascular health.');

SELECT * FROM exercise_logs WHERE type IN (SELECT type FROM drs_favorites);

SELECT * FROM exercise_logs WHERE type IN (SELECT type FROM drs_favorites WHERE reason = 'increase cardiovascular health.');

SELECT * FROM exercise_logs WHERE type IN (SELECT type FROM drs_favorites WHERE reason LIKE '%cardiovascular%');

* Restricting Grouped Results with HAVING

SELECT type, SUM(calories) AS total_calories FROM exercise_logs GROUP BY type;

SELECT type, SUM(calories) AS total_calories FROM exercise_logs GROUP BY type HAVING SUM(calories) > 150;

SELECT type FROM exercise_logs GROUP BY type HAVING COUNT(*)>=2;

SELECT type, AVG(calories) AS avg_calories FROM exercise_logs GROUP BY type HAVING AVG(calories) > 70;

* Calculating results with CASE

SELECT type FROM exercise_logs GROUP BY type HAVING COUNT(*)>=2;

SELECT COUNT(*) FROM exercise_logs WHERE heart_rate >= ROUND(0.5*(220-33)) AND heart_rate <= ROUND(0.9*(220-33));

SELECT type, heart_rate, CASE WHEN heart_rate > 220-33 Then 'above max' WHEN heart_rate > ROUND(0.9*(220-33)) THEN 'above target' WHEN heart_rate >  ROUND(0.5*(220-33)) THEN 'within target' ELSE 'below target' END as "hr_zone" FROM exercise_logs;

SELECT COUNT(*), CASE WHEN heart_rate > 220-33 Then 'above max' WHEN heart_rate > ROUND(0.9*(220-33)) THEN 'above target' WHEN heart_rate >  ROUND(0.5*(220-33)) THEN 'within target' ELSE 'below target' END as "hr_zone" FROM exercise_logs GROUP BY hr_zone;

* JOINing tables

SELECT * FROM student_grades, students_info WHERE student_grades.student_id = students_info.id;

SELECT * FROM student_grades JOIN students_info on student_grades.student_id = students_info.id;

SELECT first_name, last_name, email, test, grade FROM student_grades JOIN students_info on student_grades.student_id = students_info.id;

SELECT first_name, last_name, email, test, grade FROM student_grades JOIN students_info on student_grades.student_id = students_info.id WHERE grade >90;

SELECT students_info.first_name, students_info.last_name, students_info.email, student_grades.test, student_grades.grade FROM student_grades JOIN students_info on student_grades.student_id = students_info.id WHERE grade >90;

* Joining related tables with LEFT OUTER JOIN

CREATE TABLE student_projects(id serial PRIMARY KEY, student_id INTEGER, title TEXT);

INSERT INTO student_projects (student_id, title) VALUES (1,'Carrotpault');

SELECT students_info.first_name, students_info.last_name, student_projects.title FROM students_info JOIN student_projects ON students_info.id = student_projects.student_id;

SELECT students_info.first_name, students_info.last_name, student_projects.title FROM students_info LEFT OUTER JOIN student_projects ON students_info.id = student_projects.student_id;

* Changing Rows with UPDATE and DELETE

*hit: “We’re” does not work; but “We are ” works.

UPDATE diary_logs SET content ='I have a horrible fight with OhNoesGuy' WHERE id =1;

SELECT * FROM diary_logs;

DELETE FROM diary_logs WHERE id =1;

SELECT * FROM diary_logs;

* ALTERing tables after creation

ALTER TABLE diary_logs ADD emotion TEXT;

ALTER TABLE diary_logs DROP emotion;

ALTER TABLE diary_logs ADD emotion TEXT default 'unknown';

INSERT INTO diary_logs (user_id, date, content, emotion) VALUES (1,'2016-05-03','We went to disneyland','happy');

* Joining tables to themselves with self joins

SELECT students_info.first_name, students_info.last_name, buddies.email as budies_email FROM students_info JOIN students_info buddies on students_info.buddy_id=buddies.id;

* Combining multiple joins

SELECT a.title, b.title FROM project_pairs JOIN student_projects a on project_pairs.project1_id =a.id JOIN student_projects b on project_pairs.project2_id = b.id;
