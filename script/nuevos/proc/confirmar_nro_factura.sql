DELIMITER $$
DROP PROCEDURE IF EXISTS confirmar_nro_factura$$
CREATE PROCEDURE confirmar_nro_factura(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT
)
BEGIN
    -- Actualizar el contador incrementándolo en 1
    UPDATE control_numeracion_timbrado 
    SET contador = contador + 1,
        fecha_ultima_actualizacion = NOW()
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'FACTURA'
        AND idsucursal = p_idsucursal;
END$$