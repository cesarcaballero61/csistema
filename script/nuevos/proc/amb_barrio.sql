DROP PROCEDURE IF EXISTS amb_barrio;
DELIMITER $$
CREATE PROCEDURE amb_barrio(
	IN tipo CHAR(1),
	IN n_cod INT, 
	IN n_cod_zona INT,
	IN c_barrio VARCHAR(45)
)
BEGIN


	IF tipo="N" THEN
		INSERT INTO barrio(barrio,idzona) VALUES(c_barrio,n_cod_zona);
	ELSEIF tipo = "M" THEN
		UPDATE barrio SET barrio = c_barrio, idzona = n_cod_zona WHERE idbarrio=n_cod;
	ELSE
		DELETE FROM barrio WHERE idbarrio = n_cod;
	END IF ;

END