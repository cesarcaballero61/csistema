DELIMITER $$

USE `db`$$

DROP TRIGGER IF EXISTS `trg_detalle_compra_kardex`$$

CREATE TRIGGER `trg_detalle_compra_kardex` 
AFTER INSERT ON `detalle_compra`
FOR EACH ROW
BEGIN
    DECLARE v_idkardex INT;
    DECLARE v_compra_fecha DATE;
    DECLARE v_compra_nro_factura VARCHAR(20);
    DECLARE v_compra_idsucursal INT;
    DECLARE v_compra_idEmpresa INT;
    DECLARE v_compra_iddeposito INT;
    DECLARE v_compra_tipo INT;
    DECLARE v_compra_idproveedor INT;
    DECLARE v_idmotivo INT;
    DECLARE v_operacion_kardex VARCHAR(45);
    DECLARE v_descripcion_kardex VARCHAR(100);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_proveedor_nombre VARCHAR(45);
    
    -- Obtener datos de la compra
    SELECT 
        c.fecha,
        c.nro_factura,
        c.idsucursal,
        c.idEmpresa,
        c.iddeposito,
        c.tipo,
        c.idproveedor
    INTO 
        v_compra_fecha,
        v_compra_nro_factura,
        v_compra_idsucursal,
        v_compra_idEmpresa,
        v_compra_iddeposito,
        v_compra_tipo,
        v_compra_idproveedor
    FROM compra c
    WHERE c.idcompra = NEW.idcompra;
    
    -- Obtener descripción del artículo
    SELECT descripcion INTO v_articulo_descripcion
    FROM articulo 
    WHERE idarticulo = NEW.idarticulo;
    
    -- Obtener nombre del proveedor
    SELECT proveedor INTO v_proveedor_nombre
    FROM proveedor 
    WHERE idproveedor = v_compra_idproveedor;
    
    -- Determinar parámetros según el tipo de compra
    IF v_compra_tipo = 1 THEN  -- Compra al contado
        SET v_idmotivo = 4;        -- COMPRA.CONTADO
        SET v_operacion_kardex = 'COMPRAS.CONTADO';
    ELSE  -- Compra a crédito
        SET v_idmotivo = 5;        -- COMPRA.CREDITO
        SET v_operacion_kardex = 'COMPRAS.CREDITO';
    END IF;
    
    -- ✅ NUEVA DESCRIPCIÓN: 'COMPRA. [ARTICULO] [PROVEEDOR] FACT: [NUMERO DE FACTURA]'
    SET v_descripcion_kardex = CONCAT('COMPRA. ', v_articulo_descripcion, ' ', v_proveedor_nombre, ' FACT: ', v_compra_nro_factura);
    
    -- ✅ 1. ACTUALIZAR PRECIO DE COMPRA DEL ARTÍCULO
    UPDATE articulo 
    SET precio_costo = NEW.preciocosto,
        ultima_fecha_compra = v_compra_fecha
    WHERE idarticulo = NEW.idarticulo;
    
    -- ✅ 2. INSERTAR EN KARDEX
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
        v_compra_fecha,
        v_compra_nro_factura,
        NEW.preciocosto,
        NEW.cantidad,
        v_operacion_kardex,
        v_descripcion_kardex,  -- ✅ NUEVA DESCRIPCIÓN
        v_compra_nro_factura,
        'E',  -- Entrada
        NEW.idarticulo,
        v_idmotivo,
        v_compra_idEmpresa,
        v_compra_idsucursal,
        v_compra_iddeposito,
        NULL,
        NULL,
        NEW.idcompra
    );
    
    -- ✅ 3. ACTUALIZAR STOCK
    UPDATE stockarticulo 
    SET stock = stock + NEW.cantidad
    WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = v_compra_iddeposito
        AND idsucursal = v_compra_idsucursal
        AND idEmpresa = v_compra_idEmpresa;
    
END$$

DELIMITER ;