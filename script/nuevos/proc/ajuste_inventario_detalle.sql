DELIMITER $$
DROP PROCEDURE IF EXISTS ajuste_inventario_detalle$$
CREATE PROCEDURE ajuste_inventario_detalle(
    IN p_idajuste_inventario INT,
    IN p_idarticulo INT,
    IN p_marca VARCHAR(45),
    IN p_grupo_subgrupo VARCHAR(45),
    IN p_precio_costo DECIMAL(10,2),
    IN p_cantidad INT
)
BEGIN
    -- Insertar detalle del ajuste
    INSERT INTO ajuste_inventario_detalle (
        idajuste_inventario,
        idarticulo,
        marca,
        grupo_subgrupo,
        precio_costo,
        cantidad
    ) VALUES (
        p_idajuste_inventario,
        p_idarticulo,
        p_marca,
        p_grupo_subgrupo,
        p_precio_costo,
        p_cantidad
    );


END$$

DELIMITER ;