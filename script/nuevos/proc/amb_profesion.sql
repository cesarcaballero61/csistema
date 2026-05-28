DROP PROCEDURE IF EXISTS amb_profesion;
DELIMITER $$
CREATE PROCEDURE amb_profesion(
	IN tipo CHAR(1),
	IN n_cod INT, 
	IN c_pro VARCHAR(45)
)
BEGIN

	IF tipo='N' THEN
	
		INSERT INTO profesion(
		profesion
		) 
		VALUES(c_pro);
		
	ELSEIF  tipo ='M' THEN
	
		UPDATE profesion 
		SET profesion=c_pro 
		WHERE idprofesion=n_cod;
		
	ELSEIF tipo = 'B' THEN
	
		DELETE FROM profesion 
		WHERE idprofesion = n_cod;
	ELSE
		signal SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Tipo de operación no válido. Use N (Nuevo), M (Modificar) o B (Borrar).';
	END IF ;

END