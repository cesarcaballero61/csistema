DROP TRIGGER IF EXISTS `trg_detalle_venta_kardex`;
DELIMITER $$
CREATE TRIGGER `trg_detalle_venta_kardex` AFTER INSERT ON `detalle_venta` FOR EACH ROW 
BEGIN
    DECLARE v_venta_fecha DATE;
    DECLARE v_venta_nro_factura VARCHAR(20);
    DECLARE v_venta_idsucursal INT;
    DECLARE v_venta_idEmpresa INT;
    DECLARE v_venta_iddeposito INT;
    DECLARE v_venta_tipo ENUM('CON','CRE');
    DECLARE v_venta_idcliente INT;
    DECLARE v_idmotivo INT;
    DECLARE v_operacion_kardex ENUM('COMPRA','VENTA','AJUSTE','S/D');
    DECLARE v_tipo_kardex ENUM('ENTRADA','SALIDA');
    DECLARE v_descripcion_kardex VARCHAR(255);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_establecimiento VARCHAR(3);
    DECLARE v_puntoExpedicion VARCHAR(3);
    DECLARE v_nro_factura_unificado VARCHAR(45);
    DECLARE v_idusuario_venta INT;
    
    -- Obtener datos de la venta
    SELECT 
        v.fecha,
        v.nrosuc,
        v.nroexp,
        v.nrofactura,
        v.idsucursal,
        v.idEmpresa,
        v.iddeposito,
        v.tipo,
        v.idcliente,
        v.idusuario
    INTO 
        v_venta_fecha,
        v_establecimiento,
        v_puntoExpedicion,
        v_venta_nro_factura,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_venta_iddeposito,
        v_venta_tipo,
        v_venta_idcliente,
        v_idusuario_venta
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- Nro. factura unificado
    SET v_nro_factura_unificado = CONCAT(v_establecimiento,'-',v_puntoExpedicion,'-',v_venta_nro_factura);
    
    -- Obtener descripción del artículo
    SELECT descripcion INTO v_articulo_descripcion
    FROM articulo 
    WHERE idarticulo = NEW.idarticulo;
    
    -- Obtener nombre del cliente
    SELECT CONCAT(nombre, ' ', apellido) INTO v_cliente_nombre
    FROM cliente 
    WHERE idcliente = v_venta_idcliente;
    
    -- Determinar parámetros según el tipo de venta
    SET v_operacion_kardex = 'VENTA';
    SET v_tipo_kardex = 'SALIDA';
	
    -- Obtener el idconcepto.
	SELECT CAST(valor AS SIGNED) INTO v_idmotivo
	FROM parametros_sistema
	WHERE nombre = 'KADEX_VENTA'
	AND tabla='motivo_ajuste'
	LIMIT 1;

    
    -- Construir descripción
    SET v_descripcion_kardex = CONCAT('VENTA. ', v_articulo_descripcion, ' ', v_cliente_nombre, ' FACT: ', v_nro_factura_unificado);
    
    -- Actualizar última fecha de venta del artículo
    UPDATE articulo 
    SET ultima_fecha_venta = v_venta_fecha
    WHERE idarticulo = NEW.idarticulo;
    
    -- Insertar en KARDEX (nueva estructura)
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
        v_venta_fecha,
        v_nro_factura_unificado,
        NEW.iddeposito,
        v_idmotivo,
        NEW.idarticulo,
        NEW.precosto,
        NEW.cantidad,
        v_operacion_kardex,
        v_tipo_kardex,
        v_descripcion_kardex,
        v_idusuario_venta,
        v_venta_idEmpresa,
        v_venta_idsucursal
    );
    
    -- Actualizar stock
    UPDATE stockarticulo 
    SET stock = stock - NEW.cantidad 
    WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = NEW.iddeposito
        AND idsucursal = v_venta_idsucursal
        AND idEmpresa = v_venta_idEmpresa;
    
END$$
DELIMITER ;