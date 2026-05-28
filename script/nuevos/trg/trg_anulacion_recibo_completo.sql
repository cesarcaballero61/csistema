DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_anulacion_recibo_completo`$$

CREATE TRIGGER `trg_anulacion_recibo_completo` 
AFTER INSERT ON `anulacion_recibo`
FOR EACH ROW
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_pago_fecha DATE;
    DECLARE v_pago_nro_recibo VARCHAR(45);
    DECLARE v_pago_total_ac INT;
    DECLARE v_pago_total_importe INT;
    DECLARE v_pago_total_interes INT;
    DECLARE v_pago_total_descuento INT;
    DECLARE v_pago_idcliente INT;
    DECLARE v_pago_idsucursal INT;
    DECLARE v_pago_idEmpresa INT;
    DECLARE v_pago_idcuotas INT;
    DECLARE v_pago_idcobrador INT;
    DECLARE v_idmov INT;
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_cliente_ci INT;
    DECLARE v_cuota_detalle_id INT;
    DECLARE v_cuota_detalle_importe INT;
    DECLARE v_cuota_detalle_interes INT;
    DECLARE v_cuota_detalle_descuento INT;
    DECLARE v_cuota_detalle_totalac INT;
    DECLARE v_idpersonal_cobrador INT;
    DECLARE v_idapecierre INT;
    
    -- Cursor para recorrer los detalles del pago anulado
    DECLARE cur_detalles CURSOR FOR 
        SELECT 
            dp.idcuotas_detalle,
            dp.importe,
            dp.interes,
            dp.descuento,
            dp.totalac
        FROM detalle_pagos_cuotas dp
        WHERE dp.idpago = NEW.idpago;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    
    -- Obtener datos del pago anulado
    SELECT 
        pc.fecha,
        pc.nro_recibo,
        pc.total_ac,
        pc.total_importe,
        pc.total_interes,
        pc.total_descuento,
        pc.idcliente,
        pc.idsucursal,
        pc.idEmpresa,
        pc.idcuotas,
        pc.idcobrador
    INTO 
        v_pago_fecha,
        v_pago_nro_recibo,
        v_pago_total_ac,
        v_pago_total_importe,
        v_pago_total_interes,
        v_pago_total_descuento,
        v_pago_idcliente,
        v_pago_idsucursal,
        v_pago_idEmpresa,
        v_pago_idcuotas,
        v_pago_idcobrador
    FROM pagos_cuotas pc
    WHERE pc.idpago = NEW.idpago;
    
    --  Obtener personal del cobrador y apertura activa
    SELECT cb.idPersonal INTO v_idpersonal_cobrador 
    FROM cobrador cb WHERE cb.idcobrador = v_pago_idcobrador;
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_cobrador);
    
    -- Obtener datos del cliente
    SELECT 
        CONCAT(nombre, ' ', apellido),
        ci
    INTO 
        v_cliente_nombre,
        v_cliente_ci
    FROM cliente 
    WHERE idcliente = v_pago_idcliente;
    
    
    SET v_descripcion_mov = CONCAT(
        'Anulación recibo - ',
        v_cliente_nombre,
        ' CI. ', v_cliente_ci,
        ' Recibo.Nº ', v_pago_nro_recibo,
        ' - Motivo: ', NEW.motivo
    );
    
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        Nro_comprobante,
        monto,
        tipo,
        descripcion,
        idconcepto,
        idcliente,
        idsucursal,
        idEmpresa,
        idpersonal,
        idformapago,
        tipo_venta,
        idapecierre
    ) VALUES (
        NEW.fecha,
        'ANULACION.RECIBO',
        CONCAT('REC-', v_pago_nro_recibo),
        v_pago_total_ac,
        'E',  -- Egreso (por anulación de ingreso)
        v_descripcion_mov,
        10,   -- ANUL.RECIBO
        v_pago_idcliente,
        v_pago_idsucursal,
        v_pago_idEmpresa,
        v_idpersonal_cobrador,  -- Usar el cobrador como personal
        0,    -- Sin forma de pago específica
        NULL,
        v_idapecierre
    );
    
    -- ✅ 2. REVERTIR DETALLES DE CUOTAS
    OPEN cur_detalles;
    
    read_loop: LOOP
        FETCH cur_detalles INTO v_cuota_detalle_id, v_cuota_detalle_importe, 
                              v_cuota_detalle_interes, v_cuota_detalle_descuento, 
                              v_cuota_detalle_totalac;
        IF v_done THEN
            LEAVE read_loop;
        END IF;
        
        -- Revertir el pago en cuotas_detalle
        UPDATE cuotas_detalle 
        SET 
            saldo_cuota = saldo_cuota + v_cuota_detalle_importe,
            ultimo_nro_recibo = NULL,
            ultimo_atraso = NULL,
            ultimo_importe = NULL,
            ultima_Fecha_pago = NULL,
            ultimo_interes_calcu = NULL,
            ultimo_descuento = NULL,
            ultimo_totalac = NULL,
            ESTADO = 'PEN'  -- Volver a pendiente
        WHERE idcuotas_detalle = v_cuota_detalle_id;
        
    END LOOP;
    
    CLOSE cur_detalles;
    
    -- ✅ 3. ACTUALIZAR CABECERA DE CUOTAS
    UPDATE cuotas 
    SET 
        SALDO_ACTUAL = SALDO_ACTUAL + v_pago_total_importe,
        ultimo_fecha_pago = NULL,
        ultimo_importe = NULL,
        ultimo_interes_calc = NULL,
        ultimo_descuento = NULL,
        ultimo_totalac = NULL,
        ESTADO = 'PEN'  -- Volver a pendiente si estaba cancelado
    WHERE idcuotas = v_pago_idcuotas;
    
    -- ✅ 4. MARCAR EL PAGO COMO ANULADO
    UPDATE pagos_cuotas 
    SET estado = 'ANU'  -- Anulado
    WHERE idpago = NEW.idpago;
    
END$$

DELIMITER ;