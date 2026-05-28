DELIMITER $$

DROP PROCEDURE IF EXISTS pagos_detalle$$

CREATE PROCEDURE `pagos_detalle`(
    IN p_idpago INT,
    IN p_idcuotas_detalle INT,
    IN p_tipo_pago ENUM('CUOTA','OTRO'),
    IN p_idconcepto INT,
    IN p_concepto VARCHAR(45),
    IN p_orden INT,
    IN p_orden_char VARCHAR(10),
    IN p_fecha_vto DATE,
    IN p_atraso INT,
    IN p_cuota DECIMAL(10,2),
    IN p_importe DECIMAL(10,2),
    IN p_saldo DECIMAL(10,2)
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_nro_recibo VARCHAR(45);
    DECLARE v_fecha_pago DATE;
    DECLARE v_idcuotas INT;
    DECLARE v_total_saldo DECIMAL(10,2);
    DECLARE v_saldo_cabecera DECIMAL(10,2);
    
    -- Obtener datos del pago principal
    SELECT nro_recibo, fecha INTO v_nro_recibo, v_fecha_pago
    FROM pagos_cuotas 
    WHERE idpago = p_idpago;
    
    -- Insertar el detalle del pago
    INSERT INTO detalle_pagos_cuotas (
        idpago,
        idcuotas_detalle,
        tipo_pago,
        idconcepto,
        concepto,
        orden,
        orden_char,
        fecha_vto,
        atraso,
        cuota,
        importe,
        saldo
    ) VALUES (
        p_idpago,
        p_idcuotas_detalle,
        p_tipo_pago,
        p_idconcepto,
        p_concepto,
        p_orden,
        p_orden_char,
        p_fecha_vto,
        p_atraso,
        p_cuota,
        p_importe,
        p_saldo
    );
    
    IF p_tipo_pago = 'CUOTA' THEN
        -- Obtener el idcuotas para actualizar la cabecera
        SELECT idcuotas INTO v_idcuotas
        FROM cuotas_detalle 
        WHERE idcuotas_detalle = p_idcuotas_detalle;
        
        -- Actualizar el detalle de la cuota
        UPDATE cuotas_detalle 
        SET 
            saldo_cuota = saldo_cuota - p_importe,
            ultimo_nro_recibo = v_nro_recibo,
            ultimo_atraso = p_atraso,
            ultimo_importe = COALESCE(ultimo_importe, 0) + p_importe,
            ultima_Fecha_pago = v_fecha_pago,
            ultimo_interes_calcu = COALESCE(ultimo_interes_calcu, 0) + (p_importe - (p_cuota - p_saldo)), -- Cálculo del interés
            ultimo_descuento = COALESCE(ultimo_descuento, 0) + (p_cuota - p_saldo - p_importe), -- Cálculo del descuento
            ultimo_totalac = COALESCE(ultimo_totalac, 0) + p_importe,
            estado = CASE WHEN saldo_cuota  <= 0 THEN 'CAN' ELSE 'PEN' END
        WHERE idcuotas_detalle = p_idcuotas_detalle;
       
        
        -- LÓGICA PARA ACTUALIZAR CABECERA DE CUOTAS
        -- Calcular el saldo total sumando todos los saldos_cuota de esta cuota.
        
        SELECT COALESCE(SUM(saldo_cuota), 0) INTO v_total_saldo
        FROM cuotas_detalle 
        WHERE idcuotas = v_idcuotas;
        
        -- Obtener el saldo actual de la cabecera
        SELECT saldo_actual INTO v_saldo_cabecera
        FROM cuotas 
        WHERE idcuotas = v_idcuotas;
        
        -- Actualizar la cabecera de cuotas
        UPDATE cuotas 
        SET 
            saldo_actual = v_total_saldo,
            -- Mantener los últimos valores de pago (estos se actualizan desde pagos_cuotas)
            estado = CASE WHEN v_total_saldo <= 0 THEN 'CAN' ELSE 'PEN' END,
            fecha_cancela = CASE WHEN v_total_saldo <= 0 THEN v_fecha_pago ELSE fecha_cancela END,
            -- Actualizar campos de último pago si este pago es más reciente
            ultimo_fecha_pago = CASE WHEN v_fecha_pago > COALESCE(ultimo_fecha_pago, '1900-01-01') THEN v_fecha_pago ELSE ultimo_fecha_pago END,
            ultimo_importe = CASE WHEN v_fecha_pago > COALESCE(ultimo_fecha_pago, '1900-01-01') THEN p_importe ELSE ultimo_importe END
        WHERE idcuotas = v_idcuotas;
        
    END IF;
    
END$$

DELIMITER ;