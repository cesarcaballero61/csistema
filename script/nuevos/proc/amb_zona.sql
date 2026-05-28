DROP PROCEDURE IF EXISTS amb_zona;
DELIMITER $$
CREATE PROCEDURE amb_zona(tipo CHAR(1),n_codzona INT, c_zona CHAR(60))
BEGIN
	IF tipo="N" THEN
		INSERT INTO zona(zona) VALUES(c_zona);
	ELSEIF tipo = "M" THEN
		UPDATE zona SET zona=c_zona WHERE idzona=n_codzona;
	ELSE
		DELETE FROM zona WHERE idzona = n_codzona;
	END IF;

END