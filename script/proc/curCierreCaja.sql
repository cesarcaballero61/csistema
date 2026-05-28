DROP PROCEDURE IF EXISTS curCierreCaja;
DELIMITER $
CREATE PROCEDURE curCierreCaja(tnIdpersonal INT,tDFechaApe DATE)
BEGIN

	SELECT
	    apecierrecaja.fechaape
	    , apecierrecaja.fechacierre
	    , apecierrecaja.horaape
	    , apecierrecaja.horacierre
	    , apecierrecaja.montoape
	    , apecierrecaja.montocierre
	    , apecierrecaja.ingreso
	    , apecierrecaja.egreso
	    , apecierrecaja.diferencia AS saldo
	    , personal.apellido
	    , personal.nombre
	    , personal.ci
	    , mov_operacion.Nro_comprobante
	    , concepto_caja.concepto
	    , mov_operacion.fecha
	    , mov_operacion.descripcion
	    , mov_operacion.monto
	    , mov_operacion.tipo
	    , mov_operacion.tipo_venta
	    , tipo_pago.tipo
	FROM
	    apecierrecaja
	    INNER JOIN personal 
		ON (apecierrecaja.idpersonal = personal.idPersonal)
	    INNER JOIN mov_operacion 
		ON (mov_operacion.idpersonal = personal.idPersonal)
	    INNER JOIN concepto_caja 
		ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
	    INNER JOIN tipo_pago 
		ON (mov_operacion.idformapago = tipo_pago.idTipo_pago)
	WHERE mov_operacion.idpersonal=tnIdpersonal
		AND mov_operacion.fecha = tDFechaApe;
END