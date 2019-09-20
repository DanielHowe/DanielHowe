/* 	
	Daniel Howe
	Jason Tse
	CST 363
    Final Project - Queries 
*/

USE howe_tse_final;

/* DISPLAYS THE MOST EXPENSIVE ARTWORK IN EACH DEPARTMENT */
SELECT room, title, appraised_value
FROM departments
JOIN artworks a USING(id_departments)
JOIN(
	SELECT id_departments, MAX(appraised_value) as appraisal
	FROM artworks
	GROUP BY id_departments
)temp
ON temp.appraisal = appraised_value AND temp.id_departments = a.id_departments;


/* DISPLAYS EMPLOYEES NOT ASSOCIATED WITH DEPARTMENT */
SELECT CONCAT(first_name, ' ', last_name) AS name
FROM employees 
WHERE id_employees NOT IN (SELECT id_employees FROM department_directory);


/* DISPLAYS COUNT OF WORKS IN EACH DEPARTMENT */
SELECT dir.room, COUNT(art.id_artworks) AS totalArtworkDepartment
FROM departments AS dir
JOIN artworks AS art ON art.id_departments = dir.id_departments
GROUP BY dir.id_departments DESC;


/* DISPLAYS COUNT OF WORKS PER ARTIST */
SELECT CONCAT(first_name, ' ', last_name) AS name, COUNT(id_artists) AS worksPerArtist
FROM the_catalog
JOIN artists USING(id_artists)
GROUP BY id_artists DESC;


/* DISPLAYS THE VALUE OF ARTWORKS USED BY CURATORS AND INTERNS */
/* INCLUDES A BREAKDOWN OF SUM OF ARTWORKS PER DEPARTMENT */
SELECT job_position, CONCAT(first_name, ' ', last_name) AS name, room, SUM(appraised_value) 
FROM employees
JOIN department_directory USING(id_employees)
JOIN departments USING(id_departments)
JOIN artworks USING(id_departments)
GROUP BY name, job_position, room WITH ROLLUP
HAVING job_position IN ('intern', 'curator');


/* DISPLAYS ARTWORK MADE BY ARTISTS WHEN THEY WERE 30 YEARS OLD OR YOUNGER */
SELECT title, CONCAT(first_name, ' ', last_name) AS name, TIMESTAMPDIFF(YEAR,dob,creation_date) AS 'age at creation'
FROM artists
JOIN the_catalog USING(id_artists)
JOIN artworks USING(id_artworks)
WHERE TIMESTAMPDIFF(YEAR,dob,creation_date) <= 30
ORDER BY CONCAT(first_name, ' ', last_name), TIMESTAMPDIFF(YEAR,dob,creation_date) ASC;