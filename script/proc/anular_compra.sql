DROP PROCEDURE IF EXISTS anular_compra;
DELIMITER $
CREATE PROCEDURE anular_compra(cod_compra INT,cmotivo CHAR(200))
BEGIN
DECLARE codigo INT;
SELECT MAX(anulacion_compra.idanulacion) FROM anulacion_compra INTO codigo;

IF ISNULL(codigo) THEN
	SET codigo=1;
ELSE
	SET codigo=codigo+1;
END IF ;

UPDATE compra SET estado="A" WHERE compra.idcompra=cod_compra;

INSERT INTO anulacion_compra
            (idanulacion,
            fecha,
             motivo,
             idcompra)
VALUES (codigo,
	NOW(),
        cmotivo,
        cod_compra);
END