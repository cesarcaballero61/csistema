DELIMITER $$
DROP TRIGGER IF EXISTS tr_after_anulacion_recibo$$
CREATE TRIGGER tr_after_anulacion_recibo
AFTER INSERT ON anulacion_recibo
FOR EACH ROW
BEGIN
    DECLARE v_idcuotas INT;
    DECLARE v_idcliente INT;
    DECLARE v_idsucursal INT;
    DECLARE v_idEmpresa INT;
    DECLARE v_total_importe DECIMAL(10,2);
    DECLARE v_importe_cuotas DECIMAL(10,2);
    DECLARE v_idconcepto INT;
    DECLARE v_nrorecibo VARCHAR(7);
    
    -- Obtener datos básicos del pago anulado
    SELECT 
        pc.idcuotas,
        pc.idcliente,
        pc.idsucursal,
        pc.idEmpresa,
        pc.total_importe,
        pc.nro_recibo
    INTO 
        v_idcuotas,
        v_idcliente,
        v_idsucursal,
        v_idEmpresa,
        v_total_importe,
        v_nrorecibo
    FROM pagos_cuotas pc
    WHERE pc.idpago = NEW.idpago;
    
    -- Obtener el importe total de CUOTAS (excluyendo OTROS)
    SELECT COALESCE(SUM(importe), 0) INTO v_importe_cuotas
    FROM detalle_pagos_cuotas 
    WHERE idpago = NEW.idpago AND tipo_pago = 'CUOTA';
    
    -- Obtener concepto para anulación.
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
	FROM parametros_sistema
	WHERE nombre = 'ANULACION_RECIBO'
	AND tabla ='concepto_caja'
	LIMIT 1;
    
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- Reestablecer SOLO las cuotas_detalle de tipo CUOTA
    UPDATE cuotas_detalle cd
    INNER JOIN detalle_pagos_cuotas dpc ON cd.idcuotas_detalle = dpc.idcuotas_detalle
    SET 
        -- INVERSA: Sumar el importe al saldo (solo para CUOTAS)
        cd.saldo_cuota = cd.saldo_cuota + dpc.importe,
        
        cd.estado = CASE 
                       WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 'PEN'
                       WHEN (cd.saldo_cuota + dpc.importe) > 0 THEN 'PEN'
                       ELSE cd.estado 
                    END,
        
        -- Limpiar datos del último recibo si la cuota queda completamente pendiente
        cd.ultimo_nro_recibo = CASE 
                                  WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN NULL 
                                  ELSE cd.ultimo_nro_recibo 
                               END,
        cd.ultimo_atraso = CASE 
                              WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0 
                              ELSE cd.ultimo_atraso 
                           END,
        
        -- OPERACIÓN INVERSA: Restar el importe del último importe acumulado
        cd.ultimo_importe = CASE 
                               WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0.00 
                               ELSE GREATEST(COALESCE(cd.ultimo_importe, 0) - dpc.importe, 0)
                            END,
        
        cd.ultima_Fecha_pago = CASE 
                                  WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN NULL 
                                  ELSE cd.ultima_Fecha_pago 
                               END,
        
        -- ESTABLECER EN CERO por defecto
        cd.ultimo_interes_calcu = 0.00,
        
        -- ESTABLECER EN CERO por defecto
        cd.ultimo_descuento = 0.00,
        
        -- OPERACIÓN INVERSA: Restar del total acumulado
        cd.ultimo_totalac = CASE 
                               WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0.00 
                               ELSE GREATEST(COALESCE(cd.ultimo_totalac, 0) - dpc.importe, 0)
                            END
    WHERE dpc.idpago = NEW.idpago AND dpc.tipo_pago = 'CUOTA';
    
    -- Recalcular el saldo actual de la cuota principal (solo con importe de CUOTAS)
    UPDATE cuotas 
    SET 
        -- INVERSA: Sumar SOLO el importe de CUOTAS al saldo actual
        saldo_actual = saldo_actual + v_importe_cuotas,
        
        -- OPERACIÓN INVERSA: Restar SOLO de los acumulados de CUOTAS
        ultimo_importe = GREATEST(COALESCE(ultimo_importe, 0) - v_importe_cuotas, 0),
        
        -- ESTABLECER EN CERO por defecto
        ultimo_interes_calc = 0.00,
        
        -- ESTABLECER EN CERO por defecto
        ultimo_descuento = 0.00,
        
        ultimo_totalac = GREATEST(COALESCE(ultimo_totalac, 0) - v_importe_cuotas, 0),
        
        estado = CASE 
                    WHEN (saldo_actual + v_importe_cuotas) = total_venta THEN 'PEN'
                    WHEN (saldo_actual + v_importe_cuotas) > 0 THEN 'PEN'
                    ELSE 'CAN'
                 END
    WHERE idcuotas = v_idcuotas;
    
    
    -- Registrar en mov_operacion (con el TOTAL completo del recibo)
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_op,
        tipo_mov,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idusuario,
        idsucursal,
        idEmpresa
    )
    VALUES (
        NEW.fecha,
        'ANULACION_RECIBO',
        'N/D',
        'EGRESOS',
        v_idconcepto,
        CONCAT('ANU-', v_nrorecibo),
        v_total_importe,  -- Total completo del recibo
        CONCAT('ANULACION RECIBO #', v_nrorecibo, ' - ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idEmpresa
    );
    
END$$

DELIMITER ;