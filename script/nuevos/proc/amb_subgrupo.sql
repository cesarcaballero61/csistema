DROP PROCEDURE IF EXISTS amb_subgrupo;
DELIMITER $$
CREATE PROCEDURE amb_subgrupo(

	IN tipo VARCHAR(1),
	IN n_codsubgrupo INT, 
	IN c_subgrupo VARCHAR(45),
	IN n_cod_grupo INT
)
BEGIN

	IF tipo="N" THEN
	
		INSERT INTO subgrupo(subgrupo, idgrupo) VALUES(c_subgrupo,n_cod_grupo);
		
	ELSEIF tipo = "M" THEN
	
		UPDATE subgrupo SET subgrupo = c_subgrupo, idgrupo = n_cod_grupo 
		WHERE idsubgrupo = n_codsubgrupo;
	ELSE
		DELETE FROM subgrupo WHERE idsubgrupo = n_codsubgrupo;
	END IF ;

END