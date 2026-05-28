DROP PROCEDURE IF EXISTS cur_cuota_extracto;
DELIMITER $
CREATE PROCEDURE cur_cuota_extracto(cod_cliente INT)
BEGIN

SELECT
	venta.nrofactura
	,venta.fecha
	,cuotas.total_venta AS monto
	, cuotas.entrega_inicial AS entrega
	, cuotas.SALDO_ACTUAL AS saldo
	, cuotas.cantidad_cuota AS cantidad
	, cuotas.ultimo_fecha_pago AS ult_fecha_pago
	, cuotas.idcuotas AS codcuota
	, venta.idVenta AS codventa
	,cuotas.obs
FROM venta
     JOIN cliente ON venta.idcliente = cliente.idcliente
     JOIN cuotas ON cuotas.idVenta = venta.idVenta WHERE venta.tipo=2 AND cliente.idcliente=cod_cliente AND CUOTAS.estado="PEN" AND venta.estado="F";

END
