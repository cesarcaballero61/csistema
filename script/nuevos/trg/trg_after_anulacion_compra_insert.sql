DELIMITER $$

DROP TRIGGER IF EXISTS trg_after_anulacion_compra_insert$$

CREATE TRIGGER trg_after_anulacion_compra_insert
AFTER INSERT ON anulacion_compra
FOR EACH ROW
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_iddeposito INT;
    DECLARE v_total_compra DECIMAL(10,0);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    DECLARE v_idproveedor INT;
    DECLARE v_proveedor_nombre VARCHAR(45);
    DECLARE v_proveedor_ruc VARCHAR(20);
    DECLARE v_nro_factura VARCHAR(45);
    DECLARE v_fecha_compra DATE;
    DECLARE v_idconcepto INT;
    DECLARE v_idusuario_anulacion INT;
    DECLARE v_finished INTEGER DEFAULT 0;
    
    -- Variables para el cursor de detalles de compra
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precio_costo DECIMAL(10,0);
    DECLARE v_iddeposito_compra INT;
    
    -- Cursor para recorrer los detalles de la compra anulada
    DECLARE cur_detalles_compra CURSOR FOR 
        SELECT cd.idarticulo, cd.cantidad, cd.precio_costo, c.iddeposito
        FROM compra_detalle cd
        INNER JOIN compra c ON cd.idcompra = c.idcompra
        WHERE cd.idcompra = NEW.idcompra;
    
    -- Declarar handler para cuando no haya más filas en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
    -- 1. OBTENER DATOS DE LA COMPRA ANULADA
    SELECT 
        c.idEmpresa, 
        c.idsucursal, 
        c.iddeposito,
        c.total,
        c.tipo,
        c.idproveedor,
        p.proveedor,
        p.ruc,
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura),
        c.fecha
    INTO 
        v_idempresa, 
        v_idsucursal, 
        v_iddeposito,
        v_total_compra,
        v_tipo_compra,
        v_idproveedor,
        v_proveedor_nombre,
        v_proveedor_ruc,
        v_nro_factura,
        v_fecha_compra
    FROM compra c
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    WHERE c.idcompra = NEW.idcompra;
    
    -- 2. OBTENER EL CONCEPTO PARA ANULACIÓN DE COMPRA
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
    FROM parametros_sistema
    WHERE nombre = 'ANULACION_COMPRA'
    AND tabla = 'concepto_caja'
    LIMIT 1;
    
    -- Si no existe el parámetro, usar uno por defecto
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- 3. RECORRER DETALLES DE COMPRA Y REVERTIR STOCK
    OPEN cur_detalles_compra;
    
    get_detalles_compra: LOOP
        FETCH cur_detalles_compra INTO v_idarticulo, v_cantidad, v_precio_costo, v_iddeposito_compra;
        
        IF v_finished = 1 THEN
            LEAVE get_detalles_compra;
        END IF;
        
        -- 3.1. REVERTIR STOCK (RESTA LA CANTIDAD COMPRADA)
        UPDATE stockarticulo 
        SET stock = stock - v_cantidad
        WHERE idarticulo = v_idarticulo 
        AND iddeposito = v_iddeposito_compra
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- 3.2. REGISTRAR EN KARDEX (SALIDA POR DEVOLUCIÓN DE COMPRA)
        INSERT INTO kardex (
            fecha,
            Nro_comprobante,
            iddeposito,
            idmotivo,
            idarticulo,
            costo,
            cantidad,
            operacion,
            tipo,
            descripcion,
            idusuario,
            idEmpresa,
            idsucursal
        ) VALUES (
            NEW.fecha,
            CONCAT('ANU-C-', v_nro_factura),
            v_iddeposito_compra,
            (SELECT CAST(valor AS SIGNED) FROM parametros_sistema 
             WHERE nombre = 'KARDEX_ANULACION_COMPRA' AND tabla = 'motivo_ajuste' LIMIT 1),
            v_idarticulo,
            v_precio_costo,
            v_cantidad,
            'COMPRA',
            'SALIDA',  -- SALIDA porque se quita stock (reversión de compra)
            CONCAT('DEVOLUCIÓN POR ANULACIÓN COMPRA - ', v_nro_factura, 
                   ' - Proveedor: ', v_proveedor_nombre,
                   ' (RUC: ', v_proveedor_ruc, ')'),
            NEW.idusuario,
            v_idempresa,
            v_idsucursal
        );
        
    END LOOP get_detalles_compra;
    
    CLOSE cur_detalles_compra;
    
    -- 4. REGISTRAR EN MOV_OPERACION (INGRESO POR DEVOLUCIÓN DE DINERO)
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_op,
        tipo_mov,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idusuario,
        idsucursal,
        idEmpresa
    ) VALUES (
        NEW.fecha,
        'ANULACION_COMPRA',
        CASE 
            WHEN v_tipo_compra = 'CONTADO' THEN 'CONTADO'
            WHEN v_tipo_compra = 'CREDITO' THEN 'CREDITO'
            ELSE v_tipo_compra
        END,
        'INGRESOS',  -- INGRESOS porque se recupera dinero (devolución)
        v_idconcepto,
        CONCAT('ANU-C-', v_nro_factura),
        v_total_compra,
        CONCAT('ANULACIÓN COMPRA #', v_nro_factura, 
               ' - Proveedor: ', v_proveedor_nombre,
               ' (RUC: ', v_proveedor_ruc, ')',
               ' - Motivo: ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idempresa
    );
    
    -- 5. ACTUALIZAR ÚLTIMA FECHA DE AJUSTE EN ARTÍCULOS AFECTADOS
    UPDATE articulo a
    INNER JOIN compra_detalle cd ON a.idarticulo = cd.idarticulo
    SET a.ultima_fecha_ajuste = NEW.fecha
    WHERE cd.idcompra = NEW.idcompra;
    
END$$

DELIMITER ;