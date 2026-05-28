DROP PROCEDURE IF EXISTS amb_personal;
DELIMITER $$
CREATE PROCEDURE amb_personal(

	IN tipo CHAR(1),
	IN n_codigo INT, 
	IN c_nombre VARCHAR(45),
	IN c_apellido VARCHAR(45),
	IN c_ci VARCHAR(25), 
	IN c_telefono VARCHAR(20),
	IN c_direccion VARCHAR(45),
	IN n_cod_sucursal INT
)
BEGIN

IF tipo="N" THEN

	INSERT INTO personal (
	  nombre,
	  apellido,
	  ci,
	  telefono,
	  Direccion,
	  idsucursal
	)
	VALUES
	  (
	    c_nombre,
	    c_apellido,
	    c_ci,
	    c_telefono,
	    c_direccion,
	    n_cod_sucursal
	  );

ELSEIF tipo = "M" THEN 

	UPDATE
	  personal
	SET
	  nombre = c_nombre,
	  apellido = c_apellido,
	  ci = c_ci,
	  telefono = c_telefono,
	  Direccion = c_direccion,
	  idsucursal = n_cod_sucursal
	WHERE idPersonal = n_codigo;
	
ELSEIF tipo ="B" THEN
	DELETE FROM personal WHERE idPersonal = n_codigo;
END IF ;

END