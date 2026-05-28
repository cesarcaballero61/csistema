DELIMITER $$

DROP TRIGGER IF EXISTS `trg_detalle_pagos_cuotas_after_insert`$$

CREATE TRIGGER `trg_detalle_pagos_cuotas_after_insert` AFTER INSERT ON `detalle_pagos_cuotas` FOR EACH ROW 
BEGIN
    DECLARE v_nro_recibo INT;
    DECLARE v_fecha_pago DATE;
    DECLARE v_total_importe INT;
    DECLARE v_total_interes INT;
    DECLARE v_total_descuento INT;
    DECLARE v_total_ac INT;
    
    -- Obtener datos del pago principal
    SELECT 
        pc.nro_recibo,
        pc.fecha,
        pc.total_importe,
        pc.total_interes,
        pc.total_descuento,
        pc.total_ac
    INTO 
        v_nro_recibo,
        v_fecha_pago,
        v_total_importe,
        v_total_interes,
        v_total_descuento,
        v_total_ac
    FROM pagos_cuotas pc
    WHERE pc.idpago = NEW.idpago;
    
    -- Actualizar cuotas_detalle con los datos del pago
    UPDATE cuotas_detalle 
    SET 
        saldo_cuota 		= saldo_cuota  - NEW.importe,
        ultimo_nro_recibo 	= v_nro_recibo,
        ultimo_atraso 		= NEW.atraso,
        ultimo_importe 		= ultimo_importe + NEW.importe,
        ultima_Fecha_pago 	= v_fecha_pago,
        ultimo_interes_calcu 	= NEW.interes,
        ultimo_descuento 	= NEW.descuento,
        ultimo_totalac 		= NEW.totalac,
        Estado 			= CASE WHEN saldo_cuota <= 0 THEN 'CAN' ELSE 'PEN' END
    WHERE idcuotas_detalle = NEW.idcuotas_detalle;

END$$

DELIMITER ;