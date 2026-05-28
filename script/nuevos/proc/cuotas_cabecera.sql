DELIMITER $$
DROP PROCEDURE IF EXISTS cuotas_cabecera$$
CREATE PROCEDURE cuotas_cabecera(
    IN p_fecha DATE,
    IN p_nrofactura VARCHAR(45),
    IN p_cantidad_cuota INT,
    IN p_primera_fecha_vto DATE,
    IN p_total_venta DECIMAL(10,2),
    IN p_saldo_actual DECIMAL(10,2),
    IN p_idVenta INT,
    IN p_idcliente INT
)
BEGIN
    DECLARE v_idcuotas INT;
    
    
    INSERT INTO cuotas (
        fecha,
        nrofactura,
        cantidad_cuota,
        primera_fecha_vto,
        total_venta,
        saldo_actual,
        estado,
        idVenta,
        idcliente,
        anulado
    ) VALUES (
        p_fecha,
        p_nrofactura,
        p_cantidad_cuota,
        p_primera_fecha_vto,
        p_total_venta,
        p_saldo_actual,
        'PEN',
        p_idVenta,
        p_idcliente,
        'NO'
    );
    
    SET v_idcuotas = LAST_INSERT_ID();
    
    SELECT v_idcuotas AS idcuotas;
END$$