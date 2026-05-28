DROP PROCEDURE IF EXISTS cur_detcuota_act;
DELIMITER $
CREATE PROCEDURE cur_detcuota_act(cod_cuota INT,cod_suc INT)
BEGIN
DECLARE cant_cuota_pen,cant_cuota_cant INT;
SELECT
    cuotas_detalle.idcuotas_detalle AS codigo
    ,cuotas_detalle.orden_cuota AS orden
	,cuotas_detalle.cuota
    ,cuotas_detalle.orden_char
    ,cuotas_detalle.fecha_vto AS vto
    ,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(cuotas.fecha_alta,cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
    ,cuotas_detalle.ultima_Fecha_pago AS fecha_pago
    ,IF(ISNULL(cuotas_detalle.ultimo_importe),0,cuotas_detalle.ultimo_importe) AS importe
    ,cuotas_detalle.saldo_cuota AS saldo
    ,@n_interes:=IF(cuotas_detalle.estado="PEN",IF(ISNULL(calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,cod_suc)),0,calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,cod_suc)),cuotas_detalle.ultimo_interes_calcu)  AS interes
    ,ROUND(cuotas_detalle.saldo_cuota+IF(ISNULL(@n_interes),0,@n_interes),0) AS total_ac
FROM
    cuotas
    INNER JOIN cuotas_detalle ON cuotas.idcuotas=cuotas_detalle.idcuotas
    WHERE cuotas_detalle.idcuotas=cod_cuota;

END