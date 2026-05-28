DROP PROCEDURE IF EXISTS amb_concepto;
DELIMITER $
CREATE PROCEDURE amb_concepto(
IN tipo CHAR(1),
IN n_codigo INT,
IN c_concepto VARCHAR(45),
IN c_tipo CHAR(1)
)
BEGIN	
	IF tipo="N" THEN
		INSERT INTO concepto_caja (concepto, tipo)
			VALUES (c_concepto, c_tipo);
	ELSEIF tipo ="M" THEN
			UPDATE concepto_caja 
			SET 
				concepto = c_concepto,
				tipo = c_tipo 
			WHERE idconcepto = n_codigo;
	ELSEIF tipo = "B" THEN
		DELETE FROM concepto_caja 
		WHERE idconcepto = n_codigo;
	END IF; 
END