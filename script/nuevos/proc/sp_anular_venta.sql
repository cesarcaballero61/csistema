DELIMITER $$

CREATE PROCEDURE sp_anular_venta(
    IN p_idventa INT,
    IN p_motivo VARCHAR(200),
    IN p_idusuario INT
)
BEGIN
    DECLARE v_existe_venta INT DEFAULT 0;
    DECLARE v_estado_actual VARCHAR(1);
    DECLARE v_tipo_venta ENUM('CON','CRE');
    DECLARE v_tiene_cuotas_cobradas INT DEFAULT 0;
    DECLARE v_cant_cuotas_cobradas INT DEFAULT 0;
    
    -- Verificar si la venta existe y obtener su estado y tipo
    SELECT COUNT(*), estado, tipo INTO v_existe_venta, v_estado_actual, v_tipo_venta
    FROM venta 
    WHERE idVenta = p_idventa;
    
    IF v_existe_venta = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La venta no existe';
    ELSEIF v_estado_actual = 'A' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La venta ya está anulada';
    ELSEIF v_estado_actual != 'F' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se pueden anular ventas facturadas';
    END IF;
    
    -- Si es venta a crédito, verificar si tiene cuotas cobradas
    IF v_tipo_venta = 'CRE' THEN
        -- Verificar si existen cuotas cobradas para esta venta
        SELECT COUNT(*) INTO v_tiene_cuotas_cobradas
        FROM cuotas c
        INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'NO'
        AND cd.estado = 'CAN'
        AND cd.saldo_cuota = 0;
        
        -- También contar pagos recibidos para esta venta
        SELECT COUNT(*) INTO v_cant_cuotas_cobradas
        FROM pagos_cuotas pc
        INNER JOIN cuotas c ON pc.idcuotas = c.idcuotas
        WHERE c.idVenta = p_idventa
        AND pc.estado = 'COB';  -- Solo pagos cobrados (no anulados)
        
        IF v_tiene_cuotas_cobradas > 0 OR v_cant_cuotas_cobradas > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR LA VENTA - TIENE CUOTAS COBRADAS';
        END IF;
        
        -- Verificar también si hay alguna cuota con saldo parcialmente pagado
        SELECT COUNT(*) INTO v_tiene_cuotas_cobradas
        FROM cuotas c
        INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'NO'
        AND cd.estado = 'PEN'
        AND cd.saldo_cuota < cd.cuota
        AND cd.saldo_cuota > 0;
        
        IF v_tiene_cuotas_cobradas > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR LA VENTA - TIENE CUOTAS CON PAGOS PARCIALES';
        END IF;
    END IF;
    
    -- Registrar la anulación
    INSERT INTO anulacion_venta (fecha, motivo, idVenta, idusuario)
    VALUES (NOW(), p_motivo, p_idventa, p_idusuario);
    
    -- Actualizar estado de la venta
    UPDATE venta 
    SET estado = 'A'
    WHERE idVenta = p_idventa;
    
    -- Marcar cuotas como anuladas si la venta es a crédito
    IF v_tipo_venta = 'CRE' THEN
        UPDATE cuotas 
        SET anulado = 'SI'
        WHERE idVenta = p_idventa;
        
        -- También marcar todos los detalles de cuotas como cancelados
        UPDATE cuotas_detalle cd
        INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
        SET cd.estado = 'CAN'
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'SI';
    END IF;
END$$

DELIMITER ;