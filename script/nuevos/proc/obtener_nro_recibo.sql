DELIMITER $$
DROP PROCEDURE IF EXISTS obtener_nro_recibo$$
CREATE PROCEDURE obtener_nro_recibo(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT,
    OUT p_nro_recibo VARCHAR(7)
)
BEGIN
    DECLARE v_contador_actual INT;
    
    -- Obtener el contador actual
    SELECT contador INTO v_contador_actual
    FROM control_numeracion_timbrado
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'RECIBO'
        AND idsucursal = p_idsucursal
        AND activo = 1;
    
    -- Calcular próximo número y formatear
    SET v_contador_actual = v_contador_actual + 1;
    SET p_nro_recibo = LPAD(v_contador_actual, 7, '0');
    
END$$