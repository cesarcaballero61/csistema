DELIMITER $$

DROP TRIGGER IF EXISTS `trg_apecierrecaja_after_insert`$$

CREATE TRIGGER `trg_apecierrecaja_after_insert` AFTER INSERT ON `apecierrecaja` FOR EACH ROW 
BEGIN
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_personal_nombre VARCHAR(90);
    DECLARE v_concepto_id INT;
    
    -- Solo procesar si es una apertura (estado = 'A')
    IF NEW.estado = 'A' THEN
        -- Obtener nombre del personal
        SELECT COALESCE(CONCAT(nombre, ' ', apellido), 'PERSONAL NO ENCONTRADO')
        INTO v_personal_nombre
        FROM personal 
        WHERE idPersonal = NEW.idpersonal;
        
        -- Construir descripción detallada
        SET v_descripcion_mov = CONCAT(
            'APERTURA DE CAJA - ',
            v_personal_nombre,
            ' - Monto: Gs. ', FORMAT(NEW.montoape, 0),
            ' - Fecha: ', NEW.fechaape,
            ' - Hora: ', NEW.horaape
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
            idpersonal,
            idsucursal,
            idEmpresa,
            idformapago,
            tipo_venta,
            idapecierre
        ) VALUES (
            CURDATE(),
            'APERTURA.CAJA',
            CONCAT('APETURA -', NEW.idapecierre),
            NEW.montoape,
            'I',  -- Ingreso (apertura de caja)
            v_descripcion_mov,
            12,   -- concepto_caja para APERTURA.CAJA
            NEW.idpersonal,
            1,    -- idsucursal (ajustar según tu sistema)
            1,    -- idEmpresa (ajustar según tu sistema)
            1,    -- idformapago (efectivo)
            NULL  -- No aplica para aperturas
            ,new.idapecierre
        );
    END IF;
    
END$$

DELIMITER ;