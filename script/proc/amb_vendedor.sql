DROP PROCEDURE IF EXISTS amb_vendedor;
DELIMITER $$
CREATE PROCEDURE amb_vendedor(
	 IN tipo CHAR(1),
	 IN n_codigo INT, 
	 IN n_cod_personal INT,
	 IN c_tipo VARCHAR(20)
 )
BEGIN
	
	IF tipo ="N" THEN
	
		INSERT INTO vendedor(idpersonal,tipo_vendedor) VALUES(n_cod_personal,c_tipo);
	ELSEIF tipo = "M" THEN
	 
		UPDATE vendedor
		SET idPersonal = n_cod_personal, tipo_vendedor = c_tipo
		WHERE idVendedor = n_codigo;
		
	ELSEIF tipo = "B" THEN
		DELETE FROM vendedor WHERE idVendedor = n_codigo;
	END IF;
END