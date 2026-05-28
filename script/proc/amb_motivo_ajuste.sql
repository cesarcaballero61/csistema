DROP PROCEDURE IF EXISTS amb_motivo_ajuste;
DELIMITER $$
CREATE PROCEDURE amb_motivo_ajuste(
	IN tipo VARCHAR(1),
	IN n_cod INT,
	IN c_ajuste VARCHAR(45),
	IN c_tipo ENUM('E','S')
 )
BEGIN
	IF tipo="N" THEN
		INSERT INTO motivo_ajuste(motivo,tipo) VALUES(c_ajuste,c_tipo);
	ELSEIF tipo ="M" THEN
		UPDATE motivo_ajuste SET motivo=c_ajuste,tipo=c_tipo WHERE idmotivo=n_cod;
	ELSEIF tipo ="B" THEN
		DELETE FROM motivo_ajuste WHERE idmotivo = n_cod;
	END IF ;

END