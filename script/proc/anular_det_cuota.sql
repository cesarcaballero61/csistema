DROP PROCEDURE IF EXISTS anular_det_cuota;
DELIMITER $
CREATE PROCEDURE anular_det_cuota(
n_importe INT
,cod_cuota INT
,cod_cuota_detalle INT)


BEGIN


UPDATE cuotas_detalle SET
  saldo_cuota = cuota, 
  ultimo_nro_recibo = NULL,
  ultimo_atraso = NULL,
  ultimo_importe =NULL,
  ultima_Fecha_pago = NULL,
  ultimo_interes_calcu = NULL,
  ultimo_descuento = NULL,
  ultimo_totalac = NULL,
  ESTADO ="PEN" 
WHERE idcuotas_detalle = cod_cuota_detalle AND idcuotas = cod_cuota;

UPDATE cuotas SET saldo_actual=(SELECT SUM(saldo_cuota) AS saldo 
FROM cuotas_detalle WHERE idcuotas=cod_cuota)
WHERE idcuotas=cod_cuota;

END