DROP PROCEDURE IF EXISTS amb_deposito;
DELIMITER $$
CREATE PROCEDURE amb_deposito(tipo CHAR(1),n_cod INT, c_deposito CHAR(45),cod_sucursal INT)
BEGIN
	IF tipo="N" THEN
		INSERT INTO deposito(deposito,idsucursal) 
			VALUES(c_deposito,cod_sucursal);
	ELSEIF tipo ="M" THEN
		UPDATE deposito SET deposito=c_deposito,idsucursal=cod_sucursal WHERE iddeposito=n_cod;
	ELSEIF tipo = "B" THEN
		DELETE FROM DEPOSITO WHERE IDDEPOSITO = n_cod;
	END IF ;
END