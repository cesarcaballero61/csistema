DELIMITER $$

DROP TRIGGER IF EXISTS trg_pagos_cuotas_after_insert$$

CREATE TRIGGER `trg_pagos_cuotas_after_insert` 
AFTER INSERT ON `pagos_cuotas` 
FOR EACH ROW 
BEGIN
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_cliente_nombre VARCHAR(120) DEFAULT 'CLIENTE NO ENCONTRADO';
    DECLARE v_cliente_ci VARCHAR(20) DEFAULT 'N/D';
    DECLARE v_tipo_venta_str VARCHAR(20);
    DECLARE v_nrofactura VARCHAR(20) DEFAULT 'N/D';
    DECLARE v_tipo_pago_desc VARCHAR(45) DEFAULT 'EFECTIVO';
    DECLARE v_idpersonal_cobrador INT;
    DECLARE v_idapecierre INT;
    
    -- Solo procesar si el estado es COB (`Cobrado)
    IF NEW.estado = 'COB' THEN
        -- Obtener datos del cliente
        SELECT 
            COALESCE(CONCAT(c.nombre, ' ', c.apellido), 'CLIENTE NO ENCONTRADO'),
            COALESCE(c.ci, 'N/D'),
            COALESCE(cu.nrofactura, 'N/D'),
            COALESCE(tp.tipo, 'EFECTIVO')
        INTO 
            v_cliente_nombre,
            v_cliente_ci,
            v_nrofactura,
            v_tipo_pago_desc
        FROM cliente c
        INNER JOIN cuotas cu ON cu.idcliente = c.idcliente AND cu.idcuotas = NEW.idcuotas
        INNER JOIN tipo_pago tp ON tp.idTipo_pago = NEW.idTipo_pago
        WHERE c.idcliente = NEW.idcliente
        LIMIT 1;
        
        -- Obtener personal del cobrador y apertura activa
        SELECT cb.idPersonal INTO v_idpersonal_cobrador 
        FROM cobrador cb WHERE cb.idcobrador = NEW.idcobrador;
        
        SET v_idapecierre = f_get_apertura_activa(v_idpersonal_cobrador);
        
        -- Determinar el tipo para el concepto
        IF NEW.idTipo_pago IN (1, 2, 3) THEN  -- EFECTIVO, TARJETA, CHEQUE
            SET v_tipo_venta_str = 'CONT';
        ELSE
            SET v_tipo_venta_str = 'CRE';
        END IF;
        
        -- Construir descripción detallada
        SET v_descripcion_mov = CONCAT(
            'RECIBO CUOTA - ',
            v_cliente_nombre,
            ' CI. ', v_cliente_ci,
            ' - Factura: ', v_nrofactura,
            ' - Recibo.Nº ', NEW.nro_recibo,
            ' - Forma Pago: ', v_tipo_pago_desc,
            ' - Monto: Gs. ', FORMAT(NEW.total_importe, 0)
        );
        
        -- Insertar en mov_operacion
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
            'RECIBO.CUOTA',
            CONCAT('REC-', NEW.nro_recibo),
            NEW.total_importe,
            'I',  -- Ingreso
            v_descripcion_mov,
            CASE 
                WHEN v_tipo_venta_str = 'CONT' THEN 5  -- RECIBO.CONTADO
                ELSE 6                                 -- RECIBO.CREDITO
            END,
            NEW.idcliente,
            NEW.idsucursal,
            NEW.idEmpresa,
            v_idpersonal_cobrador,
            NEW.idTipo_pago,
            v_tipo_venta_str,
            v_idapecierre
        );
        
    END IF;
    
END$$

DELIMITER ;