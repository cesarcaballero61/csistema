DROP PROCEDURE IF EXISTS amb_marca;
DELIMITER $$
CREATE PROCEDURE amb_marca(
	IN tipo CHAR(1),
	IN n_codmarca INT, 
	IN c_marca VARCHAR(45)
)
BEGIN
	IF tipo="N" THEN
		INSERT INTO marca(marca) VALUES(c_marca);
	ELSEIF tipo = "M" THEN
		UPDATE marca SET marca=c_marca WHERE idmarca=n_codmarca;
	ELSE
		DELETE FROM marca WHERE idmarca = n_codmarca;
	END IF ;

END