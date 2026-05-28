DROP PROCEDURE IF EXISTS act_det_cuota;
DELIMITER $
CREATE PROCEDURE act_det_cuota(cod_det_cuota INT,vto_cuota DATE,fecha_pg DATE)
BEGIN
	UPDATE cuotas_detalle 
		SET fecha_vto=vto_cuota,ultima_Fecha_pago=fecha_pg 
	WHERE idcuotas_detalle=cod_det_cuota;
END