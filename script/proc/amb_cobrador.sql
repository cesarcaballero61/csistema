DROP PROCEDURE IF EXISTS amb_cobrador;
DELIMITER $$
CREATE PROCEDURE amb_cobrador(
	IN tipo CHAR(1),
	IN n_codigo INT, 
	IN n_cod_personal INT,
	IN cod_zona INT
	)
BEGIN

	IF tipo ="N" THEN
		INSERT INTO cobrador(idpersonal, idzona) VALUES(n_cod_personal, cod_zona);
	ELSEIF tipo = "M" THEN
	
		UPDATE cobrador 
		SET 
			idPersonal=n_cod_personal, 
			idzona	=cod_zona
		 WHERE idcobrador=n_codigo;
		 
	ELSEIF tipo = "B" THEN
	
		DELETE FROM cobrador  WHERE idcobrador=n_codigo;
		
	END IF;
END