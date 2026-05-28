DELIMITER $$
DROP VIEW IF EXISTS v_barrio_zona$$
CREATE VIEW v_barrio_zona AS
SELECT 
    b.idbarrio,
    b.barrio,
    b.idzona,
    z.zona
FROM 
    barrio b
INNER JOIN 
    zona z ON b.idzona = z.idzona ORDER BY b.idbarrio;