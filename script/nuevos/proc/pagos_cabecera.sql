DELIMITER $$
DROP PROCEDURE IF EXISTS pagos_cabecera$$

CREATE PROCEDURE `pagos_cabecera`(
    IN p_nro_recibo VARCHAR(45),
    IN p_fecha DATE,
    IN p_total_importe DECIMAL(10,2),
    IN p_idcliente INT,
    IN p_idTipo_pago INT,
    IN p_idsucursal INT,
    IN p_idEmpresa INT,
    IN p_idcobrador INT,
    IN p_idcuotas INT,
    IN p_idusuario INT,
    OUT p_idpago_generado INT
)
BEGIN
    
    -- Insertar en la cabecera de pagos (idpago es autoincrement)
    INSERT INTO pagos_cuotas (
        fecha,
        nro_recibo,
        total_importe,
        idusuario,
        idcliente,
        idTipo_pago,
        idsucursal,
        idEmpresa,
        idcobrador,
        idcuotas,
        estado
    ) VALUES (
        p_fecha,
        p_nro_recibo,
        p_total_importe,
        p_idusuario,
        p_idcliente,
        p_idTipo_pago,
        p_idsucursal,
        p_idEmpresa,
        p_idcobrador,
        p_idcuotas,
        'COB'  -- COB = Cobrado
    );
    
    -- Obtener el ID generado automáticamente
    SET p_idpago_generado = LAST_INSERT_ID();
    
    
END$$

DELIMITER ;