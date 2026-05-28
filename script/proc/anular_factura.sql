DROP PROCEDURE IF EXISTS anular_factura;
DELIMITER $
CREATE PROCEDURE anular_factura(cod_venta INT,cmotivo CHAR(200))

BEGIN
DECLARE codigo INT;
SELECT MAX(idanulacion) FROM anulacion_venta INTO codigo;
IF ISNULL(codigo) THEN
	SET codigo=1;
ELSE
	SET codigo= codigo+1;
END IF;
	UPDATE venta SET estado="A" WHERE idventa=cod_venta;
	
	
INSERT INTO anulacion_venta
            (idanulacion,
             fecha,
             motivo,
             idVenta)
VALUES (codigo,
        NOW(),
        cmotivo,
        cod_venta);
END