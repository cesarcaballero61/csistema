DELIMITER $$
DROP PROCEDURE IF EXISTS compra$$
CREATE PROCEDURE compra(
    IN p_idproveedor INT,
    IN p_iddeposito INT,
    IN p_idsucursal INT,
    IN p_idEmpresa INT,
    IN p_idusuario INT,
    IN p_fecha DATE,
    IN p_nro_est VARCHAR(3),
    IN p_nro_exp VARCHAR(3),
    IN p_nro_factura VARCHAR(7),
    IN p_plazo INT,
    IN p_fecha_vto DATE,
    IN p_tipo ENUM('CONTADO','CREDITO'),
    IN p_estado ENUM('PENDIENTE','FACTURADO','ANULADO'),
    IN p_total_gravadas_excenta DECIMAL(10,0),
    IN p_total_gravadas_cinco DECIMAL(10,0),
    IN p_total_gravadas_diez DECIMAL(10,0),
    IN p_liqui_iva_cinco DECIMAL(10,0),
    IN p_liqui_iva_diez DECIMAL(10,0),
    IN p_total_liqui_iva DECIMAL(10,0),
    IN p_total DECIMAL(10,0)
)
BEGIN
    DECLARE v_idcompra INT;
    
    -- Insertar en la tabla compra
    INSERT INTO compra (
        idproveedor, iddeposito, idsucursal, idEmpresa, idusuario,
        fecha, nro_est, nro_exp, nro_factura, plazo, fecha_vto,
        tipo, estado, total_gravadas_excenta, total_gravadas_cinco,
        total_gravadas_diez, liqui_iva_cinco, liqui_iva_diez,
        total_liqui_iva, total
    ) VALUES (
        p_idproveedor, p_iddeposito, p_idsucursal, p_idEmpresa, p_idusuario,
        p_fecha, p_nro_est, p_nro_exp, p_nro_factura, p_plazo, p_fecha_vto,
        p_tipo, p_estado, p_total_gravadas_excenta, p_total_gravadas_cinco,
        p_total_gravadas_diez, p_liqui_iva_cinco, p_liqui_iva_diez,
        p_total_liqui_iva, p_total
    );
    
    -- Obtener el ID de la compra insertada
    SET v_idcompra = LAST_INSERT_ID();
    
    -- Devolver el ID de la compra
    SELECT v_idcompra AS id_compra;
    
END$$

DELIMITER ;