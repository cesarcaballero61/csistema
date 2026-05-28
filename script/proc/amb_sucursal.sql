DROP PROCEDURE IF EXISTS amb_sucursal;
DELIMITER $$
CREATE PROCEDURE amb_sucursal(
	IN tipo CHAR(1),
	IN n_cod INT,
	IN cod_empresa INT, 
	IN c_sucursal CHAR(45),
	IN c_direccion CHAR(45),
	IN c_telefono CHAR(20)
)
BEGIN

	IF tipo="N" THEN
		INSERT INTO sucursal (
		  idEmpresa,
		  sucursal,
		  direccion,
		  telefono
		)
		VALUES
		  (
		    cod_empresa,
		    c_sucursal,
		    c_direccion,
		    c_telefono
		  );

	ELSEIF tipo = "M" THEN
	
		UPDATE
		  sucursal
		SET
		  idEmpresa = cod_empresa,
		  sucursal = c_sucursal,
		  direccion = c_direccion,
		  telefono = c_telefono
		WHERE idsucursal = n_cod;

	ELSE
		DELETE FROM sucursal WHERE idsucursal = n_cod;
	END IF ;

END