DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_anulacion_venta_mov_operacion`$$

CREATE TRIGGER `trg_anulacion_venta_mov_operacion` 
AFTER INSERT ON `anulacion_venta`
FOR EACH ROW
BEGIN
    DECLARE v_idmov INT;
    DECLARE v_venta_total INT;
    DECLARE v_venta_nro_factura VARCHAR(20);
    DECLARE v_venta_idsucursal INT;
    DECLARE v_venta_idEmpresa INT;
    DECLARE v_venta_idcliente INT;
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_cliente_ci INT;
    
    -- Obtener datos de la venta anulada
    SELECT 
        v.total,
        v.nrofactura,
        v.idsucursal,
        v.idEmpresa,
        v.idcliente
    INTO 
        v_venta_total,
        v_venta_nro_factura,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_venta_idcliente
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- Obtener datos del cliente
    SELECT 
        CONCAT(nombre, ' ', apellido),
        ci
    INTO 
        v_cliente_nombre,
        v_cliente_ci
    FROM cliente 
    WHERE idcliente = v_venta_idcliente;
    
    
    -- Insertar en mov_operacion como EGRESO (anulación)
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        Nro_comprobante,
        monto,
        tipo,
        descripcion,
        idconcepto,
        idcliente,
        idsucursal,
        idEmpresa,
        idpersonal,
        idformapago,
        tipo_venta
    ) VALUES (
        v_idmov,
        NEW.fecha,
        'ANULACION.VENTA',
        v_venta_nro_factura,
        v_venta_total,
        'E',  -- Egreso (por anulación)
        CONCAT('Anulación venta - ', v_cliente_nombre, ' - Motivo: ', NEW.motivo),
        9,    -- ANUL.FACTURA
        v_venta_idcliente,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        0,    -- Personal por defecto
        0,
        NULL
    );
    
END$$

DELIMITER ;