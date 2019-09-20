/* 	Daniel Howe
	Jason Tse
	CST 363
    Final Project - DDL statements */
    
USE howe_tse_final;

/*---DEPARTMENT DATA---*/
INSERT INTO departments (id_departments, room)
	VALUES	(100, 'warehouse'),
			(201, 'main gallery'),
			(202, 'north gallery'),
            (203, 'east gallery'),
            (204, 'south gallery'),
            (205, 'west gallery'),
            (301, 'northeast gallery'),
            (302, 'northwest gallery'),
            (303, 'southeast gallery'),
            (401, 'north hall'),
            (402, 'east hall'),
            (501, 'reception'),
            (502, 'office');

/*---ARTWORK DATA---*/
ALTER TABLE artworks AUTO_INCREMENT=1000; 
INSERT INTO artworks (title, creation_date, medium, description, appraised_value, id_departments)
	VALUES	('artwork1', '1765-04-13', 'watercolor', 'rubber duck', 560.99, 501),
    
			('artwork2', '1964-06-05', 'acrylic', 'cheshire cat', 45.89, 402),
            ('artwork3', '1881-04-26', 'watercolor', 'apple tree', 120.50, 402),
            
            ('artwork4', '1998-10-30', 'clay', 'treasure chest', 228.90, 401),
			('artwork5', '1943-01-14', 'photo', 'park scenery', 132.50, 401),
            
            ('artwork6', '1849-02-12', 'photo', 'self portrait', 55.65, 303),
            ('artwork7', '1846-07-01', 'acrylic', 'abstract shapes', 99.99, 303),
            ('artwork8', '1943-09-26', 'watercolor', 'insects', 42.99, 303),
            
            ('artwork9', '1763-11-16', 'oil', 'fruit bowl', 2600.19, 302),
            ('artwork10', '1946-01-03', 'acrylic', 'portrait', 84.89, 302),
            
            ('artwork11', '2015-03-11', 'marble', 'abstract sculpture', 559.99, 301),
            ('artwork12', '1994-12-28', 'guache', 'birds', 320.50, 301),
            ('artwork13', '1898-12-05', 'acrylic', 'city scene', 60.99, 301),
            
            ('artwork14', '1904-05-06', 'acrylic', 'dots and lines', 1200.00, 205),
            ('artwork15', '1796-08-18', 'oil', 'seashells', 800.80, 205),
            ('artwork16', '2006-09-23', 'wire', 'robot', 600.25, 205),
            
            ('artwork17', '2005-10-16', 'photo', 'dog portrait', 28.99, 204),
            ('artwork18', '1988-07-04', 'print', 'typography', 64.00, 204),
            ('artwork19', '1854-01-06', 'acrylic', 'woodwind instruments', 305.99, 204),
            
            ('artwork20', '1849-09-21', 'photo', 'lake cabin', 189.30, 203),
            ('artwork21', '1754-12-14', 'acrylic', 'snow mountain', 1560.01, 203),
            ('artwork22', '1941-03-22', 'watercolor', 'cubism', 750.60, 203),
            
            ('artwork23', '1993-08-31', 'sound', 'water drops', 16.50, 202),
            ('artwork24', '1921-12-04', 'crayon', 'potatoes', 150.99, 202),
            ('artwork25', '2000-02-17', 'photo', 'macro shot', 0.47, 202),
            
            ('artwork26', '1846-05-10', 'watercolor', 'toy boat', 908.75, 201),
            ('artwork27', '1984-06-09', 'acrylic', 'space', 1700.00, 201),
            ('artwork28', '1738-11-30', 'oil', 'napoleon', 24614.12, 201),
            
            ('artwork29', '1887-09-29', 'photo', 'airplane', 5646.00, 100),
            ('artwork30', '1987-11-06', 'oil', 'rain forest', 615.94, 100),
            ('artwork31', '1871-03-11', 'photo', 'street lamp', 1298.10, 100),
            ('artwork32', '2014-04-01', 'guache', 'abstract ovals', 165.12, 100),
            ('artwork33', '1968-08-03', 'print', 'butterfly print', 66.54, 100);
            
/*---ARTIST DATA---*/
ALTER TABLE artists AUTO_INCREMENT=1000; 
INSERT INTO artists (last_name, first_name, residence, dob)
	VALUES	('last1', 'first1', 'Italy', '1700-02-15'),
			('last2', 'first2', 'France', '1750-12-26'),
            ('last3', 'first3', 'USA', '1800-06-28'),
            ('last4', 'first4', 'Japan', '1830-09-13'),
            ('last5', 'first5', 'Australia', '1860-05-18'),
            ('last6', 'first6', 'Angola', '1890-05-06'),
            ('last7', 'first7', 'Chile', '1920-01-30'),
            ('last8', 'first8', 'India', '1950-08-19'),
            ('last9', 'first9', 'Siberia', '1980-06-24');

/*---EMPLOYEE DATA---*/
ALTER TABLE employees AUTO_INCREMENT=100; 
INSERT INTO employees (last_name, first_name, address, phone_number, job_position)
	VALUES	('last1', 'first1', 'address1', 6545518644, 'receptionist'),
			('last2', 'first2', 'address2', 6404864088, 'security'),
            ('last3', 'first3', 'address3', 9803480194, 'security'),
            ('last4', 'first4', 'address4', 1803573456, 'curator'),
            ('last5', 'first5', 'address5', 4088480790, 'curator'),
            ('last6', 'first6', 'address6', 9068387048, 'sales and purchasing'),
            ('last7', 'first7', 'address7', 3108480476, 'maintenance'),
            ('last8', 'first8', 'address8', 6065487979, 'maintenance'),
            ('last9', 'first9', 'address9', 3055494678, 'inventory'),
            ('last10', 'first10', 'address10', 6497511054, 'guide'),
            ('last11', 'first11', 'address11', 3184308248, 'intern'),
            ('last12', 'first12', 'address12', 4786412084, 'intern');

/*---CATALOG DATA---*/
INSERT INTO the_catalog (id_artworks, id_artists)
	VALUES	(1000,1001),
			(1001,1006),
            (1002,1004),
            (1003,1008),
            (1004,1006),
            (1005,1002),
            (1006,1002),
            (1007,1006),
            (1008,1000),
            (1009,1006),
            (1010,1008),
            (1011,1007),
            (1012,1004),
            (1013,1004),
            (1014,1001),
            (1015,1008),
            (1016,1008),
            (1017,1007),
            (1018,1002),
            (1019,1003),
            (1020,1000),
            (1021,1006),
            (1022,1008),
            (1023,1005),
            (1024,1007),
            (1025,1002),
            (1026,1007),
            (1027,1000),
            (1028,1003),
            (1029,1007),
            (1030,1003),
            (1031,1008),
            (1032,1006);

/*---DIRECTORY DATA---*/
INSERT INTO department_directory (id_employees, id_departments)
	VALUES	(100,501),
			(102,100),
            (103,201),
            (104,201),
            (103,202),
            (103,203),
            (103,204),
            (103,205),
            (104,301),
            (104,302),
            (104,303),
            (110,401),
            (111,402),
            (108,100),
            (105,502);