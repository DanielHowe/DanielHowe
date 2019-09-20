/* 	
	Daniel Howe
	Jason Tse
	CST 363
    Final Project - Views
*/

USE howe_tse_final;

/* displays list of artwork to artist and area for guide. */ 
CREATE VIEW artworkguide AS
    SELECT CONCAT(first_name,' ', last_name) AS artistName, description, title, room
    FROM artworks
        JOIN departments USING (id_departments)
        JOIN the_catalog USING (id_artworks)
        JOIN artists USING (id_artists)