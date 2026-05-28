DELIMITER $$

DROP TRIGGER IF EXISTS `trg_cuotas_detalle_after_update`$$

CREATE TRIGGER `trg_cuotas_detalle_after_update` AFTER UPDATE ON `cuotas_detalle` FOR EACH ROW 
BEGIN
    DECLARE v_total_saldo INT;
    DECLARE v_idcuota INT;
    
    -- Obtener el idcuotas de la cuota detalle actualizada
    SET v_idcuota = OLD.idcuotas;
    
    -- Calcular el saldo total sumando todos los saldos_cuota de esta cuota
    SELECT COALESCE(SUM(saldo_cuota), 0) INTO v_total_saldo
    FROM cuotas_detalle 
    WHERE idcuotas = v_idcuota;
    
    -- Actualizar el saldo actual en la cabecera de cuotas
    UPDATE cuotas 
    SET 
        SALDO_ACTUAL = v_total_saldo,
        -- Mantener los últimos valores de pago (estos se actualizan desde pagos_cuotas)
        estado = CASE WHEN v_total_saldo <= 0 THEN 'CAN' ELSE 'PEN' END,
        fecha_cancela = CASE WHEN v_total_saldo <= 0 THEN CURDATE() ELSE fecha_cancela END
    WHERE idcuotas = v_idcuota;

END$$

DELIMITER ;