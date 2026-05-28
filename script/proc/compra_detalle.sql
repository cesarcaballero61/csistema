DELIMITER $$
DROP PROCEDURE IF EXISTS compra_detalle$$
CREATE PROCEDURE compra_detalle(
    IN p_idcompra INT,
    IN p_idarticulo INT,
    IN p_iva ENUM('0','10','5'),
    IN p_precio_costo DECIMAL(10,0),
    IN p_cantidad INT,
    IN p_gravada_excenta DECIMAL(10,0),
    IN p_gravada_cinco DECIMAL(10,0),
    IN p_gravada_diez DECIMAL(10,0),
    IN p_subtotal DECIMAL(10,0)
)
BEGIN
    -- Insertar en la tabla compra_detalle
    INSERT INTO compra_detalle (
        idcompra, idarticulo, iva, precio_costo, cantidad,
        gravada_excenta, gravada_cinco, gravada_diez, subtotal
    ) VALUES (
        p_idcompra, p_idarticulo, p_iva, p_precio_costo, p_cantidad,
        p_gravada_excenta, p_gravada_cinco, p_gravada_diez, p_subtotal
    );
END$$

DELIMITER ;