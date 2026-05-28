DROP VIEW IF EXISTS v_cobrador;
CREATE VIEW v_cobrador 
    AS
SELECT
    cobrador.*
    , personal.nombre
    , personal.apellido
    , personal.ci
    , personal.Direccion
	,zona.zona
FROM
    cobrador
    JOIN personal ON cobrador.idPersonal = personal.idPersonal
	JOIN zona ON zona.idzona=cobrador.idzona;