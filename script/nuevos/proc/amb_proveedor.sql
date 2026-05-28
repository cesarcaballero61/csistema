DROP PROCEDURE IF EXISTS amb_proveedor;
DELIMITER $$
CREATE PROCEDURE amb_proveedor(
	tipo CHAR(1)
	,IN n_cod INT
	,IN c_proveedor VARCHAR(45)
	,IN c_propietario VARCHAR(45)
	,IN c_direccion VARCHAR(45)
	,IN c_telefono VARCHAR(45)
	,IN c_ruc VARCHAR(45)
	,IN n_ci INT
	,IN c_obs VARCHAR(100))

BEGIN

	IF tipo="N" THEN
		INSERT INTO proveedor(proveedor, direccion, propietario, telefono,ruc,ci,observacion)
				VALUES(c_proveedor,c_direccion,c_propietario,c_telefono,c_ruc,n_ci,c_obs);
	ELSEIF tipo="M" THEN
				UPDATE proveedor SET proveedor=c_proveedor
					,direccion=c_direccion
					,propietario=c_propietario
					,telefono=c_telefono
					,ruc=c_ruc
					,ci=n_ci
					,observacion=c_obs 
					WHERE idproveedor=n_cod;
	ELSE
		DELETE FROM proveedor WHERE idproveedor = n_cod;
	END IF ;

END