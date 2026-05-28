DELIMITER $$
DROP PROCEDURE IF EXISTS cuotas_detalle$$
CREATE PROCEDURE cuotas_detalle(
    IN p_orden_char VARCHAR(10),
    IN p_orden_cuota INT,
    IN p_fecha_vto DATE,
    IN p_cuota DECIMAL(10,2),
    IN p_saldo_cuota DECIMAL(10,2),
    IN p_idcuotas INT
)
BEGIN

    
    INSERT INTO cuotas_detalle (
        orden_char,
        orden_cuota,
        fecha_vto,
        cuota,
        saldo_cuota,
        estado,
        idcuotas
    ) VALUES (
        p_orden_char,
        p_orden_cuota,
        p_fecha_vto,
        p_cuota,
        p_saldo_cuota,
        'PEN',
        p_idcuotas
    );
    
END$$