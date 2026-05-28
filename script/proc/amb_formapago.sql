DROP PROCEDURE IF EXISTS amb_formapago;
DELIMITER $
CREATE PROCEDURE amb_formapago(
	IN tipo CHAR(1),
	IN cap_cod INT, 
	IN cap_forma VARCHAR(45)
	)
BEGIN

IF tipo ="N" THEN

	INSERT INTO tipo_pago(tipo) VALUES(cap_forma);
ELSEIF tipo = "M" THEN

	UPDATE tipo_pago SET tipo=cap_forma WHERE  idtipo_pago = cap_cod;

ELSEIF tipo = "B" THEN 

	DELETE FROM tipo_pago WHERE idTipo_pago = cap_cod;
 
END IF;

END