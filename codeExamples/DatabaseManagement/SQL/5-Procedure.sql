/* 	Daniel Howe
	Jason Tse
	CST 363
    Final Project - Prodecure */
    
USE howe_tse_final;


/* A SIMPLIFIED QUERY TO DETERMINE WHO CURATED A GIVEN GALLERY */
/* USE: CALL who_curated("[name of department]") */
DELIMITER //

CREATE PROCEDURE who_curated
(
	department_name		VARCHAR(45)
)

BEGIN
	IF (SELECT COUNT(room) FROM departments 
        WHERE room = department_name) = 0
		THEN SELECT 'ERROR: that is not a valid department!';
        
	ELSEIF (SELECT COUNT(*) FROM employees
			WHERE id_employees IN (SELECT id_employees
								   FROM department_directory
							       JOIN departments USING(id_departments)
								   WHERE room = department_name)
			AND job_position IN ('curator', 'intern')) = 0
		THEN SELECT 'There is no curator for this area';
              
	ELSE
		SELECT first_name, last_name, job_position
		FROM employees
		WHERE id_employees IN (SELECT id_employees
							   FROM department_directory
							   JOIN departments USING(id_departments)
							   WHERE room = department_name)
			  AND job_position IN ('curator', 'intern');
	END IF;
END//



/* EXAMPLE CALLS */
CALL who_curated("porch");
CALL who_curated("warehouse");
CALL who_curated("main gallery");
CALL who_curated("east HALL");