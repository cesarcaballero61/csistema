DROP PROCEDURE IF EXISTS curOperacionesCaja;
DELIMITER $
CREATE PROCEDURE curOperacionesCaja(desde DATE, hasta DATE, codConcepto INT)
BEGIN
 IF codConcepto=0 THEN
 
	SELECT
	     mov_operacion.idMov
	    , mov_operacion.fecha
	    , mov_operacion.idEmpresa
	    , empresa.empresa
	    , mov_operacion.idsucursal
	    , sucursal.sucursal
	    , mov_operacion.idconcepto
	    , concepto_caja.concepto
	    , mov_operacion.descripcion
	    , mov_operacion.monto
	    , mov_operacion.tipo
	FROM
	    mov_operacion
	    INNER JOIN concepto_caja 
		ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
	    INNER JOIN empresa 
		ON (mov_operacion.idEmpresa = empresa.idEmpresa)
	    INNER JOIN sucursal 
		ON (sucursal.idEmpresa = empresa.idEmpresa) AND (mov_operacion.idsucursal = sucursal.idsucursal) 
	WHERE mov_operacion.fecha>=desde AND mov_operacion.fecha<=hasta;
 
 ELSE
 	SELECT
	     mov_operacion.idMov
	    , mov_operacion.fecha
	    , mov_operacion.idEmpresa
	    , empresa.empresa
	    , mov_operacion.idsucursal
	    , sucursal.sucursal
	    , mov_operacion.idconcepto
	    , concepto_caja.concepto
	    , mov_operacion.descripcion
	    , mov_operacion.monto
	    , mov_operacion.tipo
	FROM
	    mov_operacion
	    INNER JOIN concepto_caja 
		ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
	    INNER JOIN empresa 
		ON (mov_operacion.idEmpresa = empresa.idEmpresa)
	    INNER JOIN sucursal 
		ON (sucursal.idEmpresa = empresa.idEmpresa) AND (mov_operacion.idsucursal = sucursal.idsucursal)
	WHERE mov_operacion.fecha>=desde AND mov_operacion.fecha<=hasta AND mov_operacion.idconcepto=codConcepto;
 
 END IF;

END
