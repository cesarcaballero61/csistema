DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_compra_after_insert`$$

CREATE TRIGGER `trg_compra_after_insert` 
AFTER INSERT ON `compra`
FOR EACH ROW
BEGIN
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion VARCHAR(250);
    DECLARE v_idmov INT;
    DECLARE v_tipo_compra_str VARCHAR(20);
    DECLARE v_idapecierre INT;
    
    -- Obtener apertura activa el personal.
    SET v_idapecierre = f_get_apertura_activa(new.idpersonal);
    
    -- Determinar el concepto y tipo de compra en texto
    IF NEW.tipo = 1 THEN  -- Compra al contado
        SET v_idconcepto = 3;  -- FACTURA.COMPRA.CONT
        SET v_tipo_compra_str = 'CONTADO';
    ELSE  -- Compra a crédito (tipo = 2)
        SET v_idconcepto = 4;  -- FACTURA.COMPRA.CRED
        SET v_tipo_compra_str = 'CRÉDITO';
    END IF;
    
    -- Construir la descripción
    SET v_descripcion = CONCAT(
        'COMPRA ', v_tipo_compra_str, 
        ' - Factura: ', NEW.nro_factura,
        ' - Total: Gs. ', FORMAT(NEW.total, 0)
    );
    
    
    -- Insertar en mov_operacion con los nuevos campos
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        Nro_comprobante,
        monto,
        tipo,
        descripcion,
        idconcepto,
        idproveedor,
        idsucursal,
        idEmpresa,
        idpersonal,        -- ✅ Usando el idpersonal de la compra
        idformapago,
        tipo_venta,
        tipo_compra,        -- ✅ Nuevo campo VARCHAR
        idapecierre
    ) VALUES (
        NEW.fecha,
        'COMPRAS',
        NEW.nro_factura,
        NEW.total,
        'E',  -- Egreso
        v_descripcion,
        v_idconcepto,
        NEW.idproveedor,
        NEW.idsucursal,
        NEW.idEmpresa,
        NEW.idpersonal,    -- ✅ Tomado directamente de la compra
        0,                 -- Sin forma de pago específica
        NULL,              -- No aplica para compras
        v_tipo_compra_str,  -- ✅ Escribiendo el texto (CONTADO/CRÉDITO)
        v_idapecierre
        
    );
    
END$$

DELIMITER ;