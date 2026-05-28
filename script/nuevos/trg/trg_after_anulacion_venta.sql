DELIMITER $$

CREATE TRIGGER trg_after_anulacion_venta
AFTER INSERT ON anulacion_venta
FOR EACH ROW
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_iddeposito INT;
    DECLARE v_total_venta DECIMAL(10,2);
    DECLARE v_tipo_venta ENUM('CON','CRE');
    DECLARE v_idcliente INT;
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_nro_factura VARCHAR(45);
    DECLARE v_fecha_venta DATE;
    DECLARE v_idconcepto INT;
    DECLARE v_idusuario_anulacion INT;
    DECLARE v_idapecierre INT;
    DECLARE v_idpersonal_vendedor INT;
    DECLARE v_finished INTEGER DEFAULT 0;
    
    -- Variables para el cursor de detalles de venta
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precosto DECIMAL(10,2);
    DECLARE v_iddeposito_venta INT;
    
    -- Cursor para recorrer los detalles de la venta anulada
    DECLARE cur_detalles CURSOR FOR 
        SELECT dv.idarticulo, dv.cantidad, dv.precosto, dv.iddeposito
        FROM detalle_venta dv
        WHERE dv.idVenta = NEW.idVenta;
    
    -- Declarar handler para cuando no haya más filas en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
    -- 1. OBTENER DATOS DE LA VENTA ANULADA
    SELECT 
        v.idEmpresa, 
        v.idsucursal, 
        v.iddeposito,
        v.total,
        v.tipo,
        v.idcliente,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura),
        v.fecha,
        v.idusuario
    INTO 
        v_idempresa, 
        v_idsucursal, 
        v_iddeposito,
        v_total_venta,
        v_tipo_venta,
        v_idcliente,
        v_nro_factura,
        v_fecha_venta,
        v_idusuario_anulacion
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- 2. OBTENER NOMBRE DEL CLIENTE
    SELECT CONCAT(nombre, ' ', apellido) INTO v_cliente_nombre
    FROM cliente 
    WHERE idcliente = v_idcliente;
    
    -- 3. OBTENER PERSONAL DEL VENDEDOR PARA APERTURA DE CAJA
    SELECT vd.idPersonal INTO v_idpersonal_vendedor 
    FROM vendedor vd 
    INNER JOIN venta v ON v.idVendedor = vd.idVendedor
    WHERE v.idVenta = NEW.idVenta;
    
    -- Obtener id apertura cierre caja (si existe)
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_vendedor);
    
    -- 4. OBTENER EL CONCEPTO PARA ANULACIÓN DE VENTA
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
    FROM parametros_sistema
    WHERE nombre = 'ANULACION_VENTA'
    AND tabla = 'concepto_caja'
    LIMIT 1;
    
    -- Si no existe el parámetro, usar uno por defecto
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- 5. RECORRER DETALLES DE VENTA Y DEVOLVER STOCK
    OPEN cur_detalles;
    
    get_detalles: LOOP
        FETCH cur_detalles INTO v_idarticulo, v_cantidad, v_precosto, v_iddeposito_venta;
        
        IF v_finished = 1 THEN
            LEAVE get_detalles;
        END IF;
        
        -- 5.1. ACTUALIZAR STOCK (SUMA LA CANTIDAD DEVUELTA)
        UPDATE stockarticulo 
        SET stock = stock + v_cantidad
        WHERE idarticulo = v_idarticulo 
        AND iddeposito = v_iddeposito_venta
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- 5.2. REGISTRAR EN KARDEX (ENTRADA POR DEVOLUCIÓN)
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
            CONCAT('ANU-', v_nro_factura),
            v_iddeposito_venta,
            (SELECT CAST(valor AS SIGNED) FROM parametros_sistema WHERE nombre = 'KARDEX_ANULACION' AND tabla = 'motivo_ajuste' LIMIT 1),
            v_idarticulo,
            v_precosto,
            v_cantidad,
            'VENTA',
            'ENTRADA',  -- ENTRADA porque se devuelve stock
            CONCAT('DEVOLUCIÓN POR ANULACIÓN VENTA - ', v_nro_factura, ' - Cliente: ', v_cliente_nombre),
            NEW.idusuario,
            v_idempresa,
            v_idsucursal
        );
        
    END LOOP get_detalles;
    
    CLOSE cur_detalles;
    
    -- 6. REGISTRAR EN MOV_OPERACION
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
        idEmpresa,
        idapecierre
    ) VALUES (
        NEW.fecha,
        'ANULACION_VENTA',
        CASE WHEN v_tipo_venta = 'CON' THEN 'CONTADO' ELSE 'CREDITO' END,
        'EGRESOS',  -- Egreso porque se devuelve dinero
        v_idconcepto,
        CONCAT('ANU-', v_nro_factura),
        v_total_venta,
        CONCAT('ANULACIÓN VENTA #', v_nro_factura, 
               ' - Cliente: ', v_cliente_nombre,
               ' - Motivo: ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idempresa,
        v_idapecierre
    );
    
END$$

DELIMITER ;