DROP VIEW IF EXISTS v_cliente;
DELIMITER $$
CREATE VIEW v_cliente AS(
SELECT 
	cli.*
	,zo.zona
	,ba.barrio
	,pro.profesion
FROM cliente cli
JOIN zona zo ON cli.idzona=zo.idzona
JOIN barrio ba ON cli.idbarrio=ba.idbarrio
JOIN profesion pro ON cli.idprofesion=pro.idprofesion
)