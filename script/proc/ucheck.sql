DROP PROCEDURE IF EXISTS ucheck;
DELIMITER $
CREATE PROCEDURE ucheck(c_user CHAR(50),c_clave CHAR(8))
BEGIN
	SELECT 
		idusuario
		,nick
		,idPersonal
	 FROM usuario WHERE  nick  COLLATE utf8_bin = c_user AND  clave COLLATE utf8_bin = c_clave;

END 