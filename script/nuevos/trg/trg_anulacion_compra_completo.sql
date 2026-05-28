DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_anulacion_compra_completo`$$

CREATE TRIGGER `trg_anulacion_compra_completo` 
AFTER INSERT ON `anulacion_compra`
FOR EACH ROW
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_preciocosto INT;
    DECLARE v_compra_fecha DATE;
    DECLARE v_compra_nro_factura VARCHAR(20);
    DECLARE v_compra_idsucursal INT;
    DECLARE v_compra_idEmpresa INT;
    DECLARE v_compra_iddeposito INT;
    DECLARE v_compra_tipo INT;
    DECLARE v_compra_idpersonal INT;
    DECLARE v_compra_total INT;
    DECLARE v_compra_idproveedor INT;
    DECLARE v_idkardex INT;
    DECLARE v_idmov INT;
    DECLARE v_idmotivo INT;
    DECLARE v_idconcepto INT;
    DECLARE v_operacion_kardex VARCHAR(45);
    DECLARE v_descripcion_kardex VARCHAR(100);
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_proveedor_nombre VARCHAR(45);
    DECLARE v_ultimo_precio_costo INT;
    DECLARE v_contador INT DEFAULT 0;
    DECLARE v_tipo_compra_str VARCHAR(20);
    DECLARE v_idapecierre INT;
    
    -- Cursor para recorrer los detalles de la compra anulada
    DECLARE cur_detalles CURSOR FOR 
        SELECT dc.idarticulo, dc.cantidad, dc.preciocosto
        FROM detalle_compra dc
        WHERE dc.idcompra = NEW.idcompra;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_done = TRUE;
    
    -- Obtener datos de la compra anulada
    SELECT 
        c.fecha,
        c.nro_factura,
        c.idsucursal,
        c.idEmpresa,
        c.iddeposito,
        c.tipo,
        c.idpersonal,
        c.total,
        c.idproveedor
    INTO 
        v_compra_fecha,
        v_compra_nro_factura,
        v_compra_idsucursal,
        v_compra_idEmpresa,
        v_compra_iddeposito,
        v_compra_tipo,
        v_compra_idpersonal,
        v_compra_total,
        v_compra_idproveedor
    FROM compra c
    WHERE c.idcompra = NEW.idcompra;
    
    -- Obtener nombre del proveedor
    SELECT proveedor INTO v_proveedor_nombre
    FROM proveedor 
    WHERE idproveedor = v_compra_idproveedor;
    
    -- Obtener apertura activa del personal
    SET v_idapecierre = f_get_apertura_activa(v_compra_idpersonal);
    
    -- Determinar tipo de compra en texto
    IF v_compra_tipo = 1 THEN
        SET v_tipo_compra_str = 'CONTADO';
    ELSE
        SET v_tipo_compra_str = 'CRÉDITO';
    END IF;
    
    -- Determinar parámetros según el tipo de compra
    IF v_compra_tipo = 1 THEN
        SET v_idmotivo = 9;    -- ANULACION.COMPRA
        SET v_idconcepto = 11; -- ANUL.COMPRA
        SET v_operacion_kardex = 'ANULACION.COMPRA.CONTADO';
    ELSE
        SET v_idmotivo = 9;    -- ANULACION.COMPRA
        SET v_idconcepto = 11; -- ANUL.COMPRA
        SET v_operacion_kardex = 'ANULACION.COMPRA.CREDITO';
    END IF;
    
    
    SET v_descripcion_mov = CONCAT(
        'ANULACIÓN COMPRA ', v_tipo_compra_str,
        ' - Factura: ', v_compra_nro_factura,
        ' - Motivo: ', NEW.motivo,
        ' - Monto: Gs. ', FORMAT(v_compra_total, 0)
    );
    
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
        idpersonal,
        idformapago,
        tipo_venta,
        tipo_compra,
        idapecierre
    ) VALUES (
        NEW.fecha,
        'ANULACION.COMPRA',
        v_compra_nro_factura,
        v_compra_total,
        'I',  -- Ingreso (devolución)
        v_descripcion_mov,
        v_idconcepto,
        v_compra_idproveedor,
        v_compra_idsucursal,
        v_compra_idEmpresa,
        v_compra_idpersonal,
        0,
        NULL,
        v_tipo_compra_str,
        v_idapecierre
    );
    
    -- ✅ 2. PROCESAR DETALLES PARA KARDEX
    OPEN cur_detalles;
    
    read_loop: LOOP
        FETCH cur_detalles INTO v_idarticulo, v_cantidad, v_preciocosto;
        IF v_done THEN
            LEAVE read_loop;
        END IF;
        
        SET v_contador = v_contador + 1;
        
        -- Obtener descripción del artículo
        SELECT descripcion INTO v_articulo_descripcion
        FROM articulo 
        WHERE idarticulo = v_idarticulo;
        
        -- ✅ BUSCAR ÚLTIMO PRECIO VÁLIDO
        SELECT k.costo INTO v_ultimo_precio_costo
        FROM kardex k
        WHERE k.idarticulo = v_idarticulo 
            AND k.operacion LIKE 'COMPRAS%'
            AND k.idreferencial != NEW.idcompra
            AND k.tipo = 'E'
        ORDER BY k.fecha DESC, k.idkardex DESC 
        LIMIT 1;
        
        IF v_ultimo_precio_costo IS NULL THEN
            SELECT precio_costo INTO v_ultimo_precio_costo
            FROM articulo 
            WHERE idarticulo = v_idarticulo;
        END IF;
        
        IF v_ultimo_precio_costo IS NULL THEN
            SET v_ultimo_precio_costo = 0;
        END IF;
        
        -- ✅ ACTUALIZAR PRECIO DEL ARTÍCULO
        UPDATE articulo 
        SET precio_costo = v_ultimo_precio_costo
        WHERE idarticulo = v_idarticulo;
        
        -- ✅ DESCRIPCIÓN: 'COMPRA. [ARTICULO] [PROVEEDOR] FACT: [NUMERO DE FACTURA]'
        SET v_descripcion_kardex = CONCAT('COMPRA. ', v_articulo_descripcion, ' ', v_proveedor_nombre, ' FACT: ', v_compra_nro_factura);
        
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
            v_compra_nro_factura,
            v_preciocosto,
            v_cantidad,
            v_operacion_kardex,
            v_descripcion_kardex,
            CONCAT('ANUL-', v_compra_nro_factura),
            'S',  -- Salida (por anulación - retiro de stock)
            v_idarticulo,
            v_idmotivo,
            v_compra_idEmpresa,
            v_compra_idsucursal,
            v_compra_iddeposito,
            NULL,
            NULL,
            NEW.idcompra  -- ✅ ID de la compra anulada como referencia
        );
        
        -- ✅ ACTUALIZAR STOCK
        UPDATE stockarticulo 
        SET stock = stock - v_cantidad
        WHERE idarticulo = v_idarticulo 
            AND iddeposito = v_compra_iddeposito
            AND idsucursal = v_compra_idsucursal
            AND idEmpresa = v_compra_idEmpresa;
        
    END LOOP;
    
    CLOSE cur_detalles;
    
END$$

DELIMITER ;