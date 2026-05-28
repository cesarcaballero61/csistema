DROP PROCEDURE IF EXISTS amb_empresa;
DELIMITER $
CREATE PROCEDURE amb_empresa(
	tipo VARCHAR(1),
	cod_empresa INT,
	c_empresa VARCHAR(45),
	c_ruc VARCHAR(20),
	c_telefono VARCHAR(15))

BEGIN

IF tipo="N" THEN


	INSERT INTO empresa( 
		     empresa,
		     ruc,
		     telefono)
	VALUES (c_empresa,
		c_ruc,
		c_telefono);
        
ELSEIF tipo ='M' THEN 

	UPDATE empresa SET
		empresa = c_empresa,
		ruc = c_ruc,
		telefono = c_telefono
	WHERE idEmpresa = cod_empresa;
ELSE
	-- tipo = "B"
	DELETE FROM empresa WHERE idEmpresa = cod_empresa;

END IF;
END