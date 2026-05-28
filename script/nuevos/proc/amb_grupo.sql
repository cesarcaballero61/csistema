DROP PROCEDURE IF EXISTS amb_grupo;
DELIMITER $$
CREATE PROCEDURE amb_grupo(
IN tipo CHAR(1),
IN n_codgrupo INT, 
IN c_grupo VARCHAR(45))
BEGIN

IF tipo="N" THEN
	INSERT INTO grupo(grupo) VALUES(c_grupo);
ELSEIF tipo ="M" THEN
	UPDATE grupo SET grupo=c_grupo WHERE idgrupo=n_codgrupo;
ELSE
	DELETE FROM grupo WHERE idgrupo = n_codgrupo;
END IF ;

END