DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_anulacion_venta_kardex`$$

CREATE TRIGGER `trg_anulacion_venta_kardex` 
AFTER INSERT ON `anulacion_venta`
FOR EACH ROW
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precosto INT;
    DECLARE v_unidad VARCHAR(10);
    DECLARE v_cant_unidad INT;
    DECLARE v_iddeposito INT;
    DECLARE v_venta_fecha DATE;
    DECLARE v_venta_nro_factura VARCHAR(20);
    DECLARE v_venta_idsucursal INT;
    DECLARE v_venta_idEmpresa INT;
    DECLARE v_venta_iddeposito INT;
    DECLARE v_venta_tipo INT;
    DECLARE v_venta_idcliente INT;
    DECLARE v_idkardex INT;
    DECLARE v_idmotivo INT;
    DECLARE v_operacion_kardex VARCHAR(45);
    DECLARE v_descripcion_kardex VARCHAR(100);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_cliente_nombre VARCHAR(120);
    
    -- Cursor para recorrer los detalles de la venta anulada
    DECLARE cur_detalles CURSOR FOR 
        SELECT dv.idarticulo, dv.cantidad, dv.precosto, dv.unidad, dv.cant_unidad, dv.iddeposito
        FROM detalle_venta dv
        WHERE dv.idVenta = NEW.idVenta;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    
    -- Obtener datos de la venta anulada
    SELECT 
        v.fecha,
        v.nrofactura,
        v.idsucursal,
        v.idEmpresa,
        v.iddeposito,
        v.tipo,
        v.idcliente
    INTO 
        v_venta_fecha,
        v_venta_nro_factura,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_venta_iddeposito,
        v_venta_tipo,
        v_venta_idcliente
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- Obtener nombre del cliente
    SELECT CONCAT(nombre, ' ', apellido) INTO v_cliente_nombre
    FROM cliente 
    WHERE idcliente = v_venta_idcliente;
    
    -- Determinar parámetros según el tipo de venta
    IF v_venta_tipo = 0 THEN
        SET v_idmotivo = 8;  -- ANULACION.VENTA (contado)
        SET v_operacion_kardex = 'ANULACION.VENTA.CONTADO';
    ELSE
        SET v_idmotivo = 8;  -- ANULACION.VENTA (crédito)
        SET v_operacion_kardex = 'ANULACION.VENTA.CREDITO';
    END IF;
    
    OPEN cur_detalles;
    
    read_loop: LOOP
        FETCH cur_detalles INTO v_idarticulo, v_cantidad, v_precosto, v_unidad, v_cant_unidad, v_iddeposito;
        IF v_done THEN
            LEAVE read_loop;
        END IF;
        
        -- Obtener descripción del artículo
        SELECT descripcion INTO v_articulo_descripcion
        FROM articulo 
        WHERE idarticulo = v_idarticulo;
        
        -- ✅ DESCRIPCIÓN: 'VENTA. [ARTICULO] [CLIENTE] FACT: [NUMERO DE FACTURA]'
        SET v_descripcion_kardex = CONCAT('VENTA. ', v_articulo_descripcion, ' ', v_cliente_nombre, ' FACT: ', v_venta_nro_factura);
        
        -- ✅ INSERTAR EN KARDEX
        SELECT COALESCE(MAX(idkardex), 0) + 1 INTO v_idkardex FROM kardex;
        
        INSERT INTO kardex (
            idkardex,
            fecha,
            Nro_comprobante,
            costo,
            cantidad,
            operacion,
            descripcion,
            referencia,
            tipo,
            idarticulo,
            idmotivo,
            idEmpresa,
            idsucursal,
            iddeposito,
            unidad,
            cant_unidad,
            idreferencial
        ) VALUES (
            v_idkardex,
            NEW.fecha,
            v_venta_nro_factura,
            v_precosto,
            v_cantidad,
            v_operacion_kardex,
            v_descripcion_kardex,
            CONCAT('ANUL-', v_venta_nro_factura),
            'E',  -- Entrada (por anulación)
            v_idarticulo,
            v_idmotivo,
            v_venta_idEmpresa,
            v_venta_idsucursal,
            v_iddeposito,
            v_unidad,
            v_cant_unidad,
            NEW.idVenta  -- ✅ ID de la venta anulada como referencia
        );
        
        -- ✅ ACTUALIZAR STOCK (devolver stock)
        UPDATE stockarticulo 
        SET stock = stock + (v_cantidad * v_cant_unidad)
        WHERE idarticulo = v_idarticulo 
            AND iddeposito = v_iddeposito
            AND idsucursal = v_venta_idsucursal
            AND idEmpresa = v_venta_idEmpresa;
        
    END LOOP;
    
    CLOSE cur_detalles;
    
END$$

DELIMITER ;