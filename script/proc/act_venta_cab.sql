DROP PROCEDURE IF EXISTS act_venta_cab;
DELIMITER $
CREATE PROCEDURE act_venta_cab(cod_venta INT,cod_cuota INT ,primera_fecha_vtos DATE,dia_entr_pago INT,fecha_ven DATE,cod_vendedor INT,cod_cobrador INT)
BEGIN
		UPDATE venta SET fecha = fecha_ven, idVendedor = cod_vendedor,idcobrador=cod_cobrador WHERE idVenta = cod_venta;		
		UPDATE cuotas SET fecha_alta=fecha_ven,primera_fecha_vto=primera_fecha_vtos,dias_entre_pago=dia_entr_pago WHERE idcuotas=cod_cuota;
END