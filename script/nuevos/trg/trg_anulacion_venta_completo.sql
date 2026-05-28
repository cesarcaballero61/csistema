DROP TRIGGER IF EXISTS `trg_anulacion_venta_completo`;
DELIMITER $$
CREATE TRIGGER `trg_anulacion_venta_completo` AFTER INSERT ON `anulacion_venta` FOR EACH ROW 
BEGIN
    DECLARE v_done INT DEFAULT FALSE;
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precosto INT;
    DECLARE v_iddeposito INT;
    DECLARE v_venta_fecha DATE;
    DECLARE v_venta_nro_factura VARCHAR(20);
    DECLARE v_venta_idsucursal INT;
    DECLARE v_venta_idEmpresa INT;
    DECLARE v_venta_iddeposito INT;
    DECLARE v_venta_tipo INT;
    DECLARE v_venta_idcliente INT;
    DECLARE v_venta_total INT;
    DECLARE v_venta_idvendedor INT;
    DECLARE v_idkardex INT;
    DECLARE v_idmov INT;
    DECLARE v_idmotivo INT;
    DECLARE v_idconcepto INT;
    DECLARE v_operacion_kardex VARCHAR(45);
    DECLARE v_descripcion_kardex VARCHAR(100);
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_cliente_ci INT;
    DECLARE v_contador INT DEFAULT 0;
    
    -- variables para apertura caja.
    DECLARE v_idpersonal_vendedor INT;
    DECLARE v_idapecierre INT;
    
    -- Cursor para recorrer los detalles de la venta anulada
    DECLARE cur_detalles CURSOR FOR 
        SELECT dv.idarticulo, dv.cantidad, dv.precosto, dv.iddeposito
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
        v.idcliente,
        v.total,
        v.idVendedor
    INTO 
        v_venta_fecha,
        v_venta_nro_factura,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_venta_iddeposito,
        v_venta_tipo,
        v_venta_idcliente,
        v_venta_total,
        v_venta_idvendedor
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
    
     -- obtener el personal a partir del codigo de vendedor
    SELECT vd.idPersonal INTO v_idpersonal_vendedor 
    FROM vendedor vd WHERE vd.idVendedor = v_venta_idvendedor;
    -- obtener el id de apertura caja.
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_vendedor);
    
    -- Determinar parámetros según el tipo de venta
    IF v_venta_tipo = 0 THEN
        SET v_idmotivo = 8;    -- ANULACION.VENTA (contado)
        SET v_idconcepto = 9;  -- ANUL.FACTURA
        SET v_operacion_kardex = 'ANULACION.VENTA.CONTADO';
    ELSE
        SET v_idmotivo = 8;    -- ANULACION.VENTA (crédito)
        SET v_idconcepto = 9;  -- ANUL.FACTURA
        SET v_operacion_kardex = 'ANULACION.VENTA.CREDITO';
    END IF;
    
    SET v_descripcion_mov = CONCAT(
        'Anulación venta - ', 
        v_cliente_nombre, 
        ' - Factura: ', v_venta_nro_factura,
        ' - Motivo: ', NEW.motivo
    );
    
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
        tipo_venta,
        idapecierre
    ) VALUES (
        NEW.fecha,
        'ANULACION.VENTA',
        v_venta_nro_factura,
        v_venta_total,
        'E',  -- Egreso (por anulación)
        v_descripcion_mov,
        v_idconcepto,
        v_venta_idcliente,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_idpersonal_vendedor,  -- Usar el personal original
        0,    -- Sin forma de pago específica
        NULL,
        v_idapecierre  -- id de apertura caja.
    );
    
    -- ✅ 2. PROCESAR DETALLES PARA KARDEX
    OPEN cur_detalles;
    
    read_loop: LOOP
        FETCH cur_detalles INTO v_idarticulo, v_cantidad, v_precosto, v_iddeposito;
        IF v_done THEN
            LEAVE read_loop;
        END IF;
        
        SET v_contador = v_contador + 1;
        
        -- Obtener descripción del artículo
        SELECT descripcion INTO v_articulo_descripcion
        FROM articulo 
        WHERE idarticulo = v_idarticulo;
        
        -- ✅ DESCRIPCIÓN: 'VENTA. [ARTICULO] [CLIENTE] FACT: [NUMERO DE FACTURA]'
        SET v_descripcion_kardex = CONCAT('ANUL.VENTA ', v_articulo_descripcion, ' ', v_cliente_nombre, ' FACT: ', v_venta_nro_factura);
        
        INSERT INTO kardex (
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
            idreferencial
        ) VALUES (
            NEW.fecha,
            v_venta_nro_factura,
            v_precosto,
            v_cantidad,
            v_operacion_kardex,
            v_descripcion_kardex,
            CONCAT('ANUL-', v_venta_nro_factura),
            'E',  -- Entrada (por anulación - devolución de stock)
            v_idarticulo,
            v_idmotivo,
            v_venta_idEmpresa,
            v_venta_idsucursal,
            v_iddeposito,
            NEW.idVenta  -- ✅ ID de la venta anulada como referencia
        );
        
        -- ✅ ACTUALIZAR STOCK (devolver stock) - ya no se multiplica por cant_unidad
        UPDATE stockarticulo 
        SET stock = stock + v_cantidad
        WHERE idarticulo = v_idarticulo 
            AND iddeposito = v_iddeposito
            AND idsucursal = v_venta_idsucursal
            AND idEmpresa = v_venta_idEmpresa;
        
    END LOOP;
    
    CLOSE cur_detalles;
    
    -- ANULAR LA VENTA 
    UPDATE VENTA SET ESTADO = 'A'
    WHERE VENTA.idVenta = NEW.IDVENTA;
    
    -- ANULAR CUOTA
    UPDATE CUOTAS SET ANULADO = 'SI'
    WHERE CUOTAS.IDVENTA = NEW.IDVENTA;
END $$