DROP PROCEDURE IF EXISTS cur_extracto_cambio;
DELIMITER $
CREATE PROCEDURE cur_extracto_cambio(cod_cuota INT)
BEGIN
SELECT
	venta.idventa
    ,venta.nrofactura
    , venta.fecha
    , cuotas_detalle.orden_char AS orden
    , cuotas_detalle.fecha_vto AS vto
    , cuotas_detalle.ultimo_atraso
    , cuotas_detalle.cuota 
    , cuotas_detalle.ultimo_nro_recibo 
    , cuotas_detalle.ultimo_importe 
    , cuotas_detalle.ultima_Fecha_pago 
    , cuotas_detalle.saldo_cuota AS saldo
    , cuotas_detalle.ultimo_interes_calcu AS ultimo_interes
    ,@n_atraso:=IF(cuotas_detalle.Estado="CAN",DATEDIFF(cuotas_detalle.ultima_Fecha_pago,cuotas_detalle.fecha_vto),DATEDIFF(NOW(),cuotas_detalle.fecha_vto)) AS  atraso
    , cuotas_detalle.ultimo_descuento
    , calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,1) AS interes
    , cliente.apellido
    , cliente.nombre
    , cliente.ci
    , cliente.ruc
    , cliente.telefono
    , cuotas.obs
    , cliente.celular
    , zona.zona
    , barrio.barrio
    , cuotas_detalle.estado
    , v_cobrador.idcobrador 
    , v_cobrador.nombre AS nombreCobrador
    , v_cobrador.apellido AS apellidoCobrador
FROM cuotas 
		JOIN cuotas_detalle ON cuotas.idcuotas=cuotas_detalle.idcuotas
		JOIN venta ON  cuotas.idventa=venta.idventa
		JOIN v_cobrador  ON v_cobrador.idcobrador=venta.idcobrador
		JOIN cliente ON venta.idcliente=cliente.idcliente
		JOIN zona  ON cliente.idzona=zona.idzona
		JOIN barrio ON cliente.idbarrio=barrio.idbarrio
WHERE cuotas.idcuotas=cod_cuota AND cuotas.estado="PEN" AND venta.estado="F";
END