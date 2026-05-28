-- Trigger para AFTER INSERT en compra_detalle con reset de stock negativo
DELIMITER $$
DROP TRIGGER tr_compra_detalle_after_insert$$
CREATE TRIGGER tr_compra_detalle_after_insert
AFTER INSERT ON compra_detalle
FOR EACH ROW
BEGIN
    DECLARE v_iddeposito INT;
    DECLARE v_idsucursal INT;
    DECLARE v_idEmpresa INT;
    DECLARE v_idusuario INT;
    DECLARE v_fecha DATE;
    DECLARE v_nro_comprobante VARCHAR(45);
    DECLARE v_idmotivo INT;
    DECLARE v_descripcion VARCHAR(255);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    DECLARE v_nombre_proveedor VARCHAR(45);
    DECLARE v_ruc_proveedor VARCHAR(20);
    DECLARE v_valor_parametro VARCHAR(100);
    DECLARE v_existe_stock INT DEFAULT 0;
    DECLARE v_stock_actual INT DEFAULT 0;
    
    -- Obtener datos de la cabecera de compra y proveedor
    SELECT 
        c.iddeposito, 
        c.idsucursal, 
        c.idEmpresa, 
        c.idusuario,
        c.fecha,
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura),
        c.tipo,
        p.proveedor,
        p.ruc
    INTO 
        v_iddeposito, 
        v_idsucursal, 
        v_idEmpresa, 
        v_idusuario,
        v_fecha,
        v_nro_comprobante,
        v_tipo_compra,
        v_nombre_proveedor,
        v_ruc_proveedor
    FROM compra c
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    WHERE c.idcompra = NEW.idcompra;
    
    -- OBTENER EL ID MOTIVO DESDE PARAMETROS_SISTEMA
    SELECT valor INTO v_valor_parametro
    FROM parametros_sistema
    WHERE nombre = 'KARDEX_COMPRA'
    LIMIT 1;
    
    -- Validar y convertir el parámetro
    IF v_valor_parametro IS NOT NULL AND v_valor_parametro != '' THEN
        SET v_idmotivo = CAST(v_valor_parametro AS UNSIGNED);
    ELSE
        SET v_idmotivo = 1;
    END IF;
    
    -- CREAR DESCRIPCIÓN DETALLADA
    SET v_descripcion = CONCAT(
        'COMPRA - Fact: ', v_nro_comprobante,
        '  Tipo: ', v_tipo_compra,
        '  Prov: ', LEFT(v_nombre_proveedor, 20),
        ' (', v_ruc_proveedor, ')'
        );
    
    -- 1. INSERTAR EN KARDEX
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
        v_fecha,
        v_nro_comprobante,
        v_iddeposito,
        v_idmotivo,
        NEW.idarticulo,
        NEW.precio_costo,
        NEW.cantidad,
        'COMPRA',
        'ENTRADA',
        v_descripcion,
        v_idusuario,
        v_idEmpresa,
        v_idsucursal
    );
    
    -- 2. VERIFICAR SI EXISTE STOCK Y OBTENER STOCK ACTUAL
    SELECT COUNT(*), COALESCE(stock, 0) INTO v_existe_stock, v_stock_actual
    FROM stockarticulo 
    WHERE idarticulo = NEW.idarticulo 
    AND iddeposito = v_iddeposito 
    AND idsucursal = v_idsucursal 
    AND idEmpresa = v_idEmpresa;
    
    -- ACTUALIZAR O INSERTAR STOCK (RESETEAR SI ES NEGATIVO)
    IF v_existe_stock > 0 THEN
        -- Si el stock actual es negativo, resetear a la cantidad comprada
        IF v_stock_actual < 0 THEN
            UPDATE stockarticulo 
            SET stock = NEW.cantidad
            WHERE idarticulo = NEW.idarticulo 
            AND iddeposito = v_iddeposito 
            AND idsucursal = v_idsucursal 
            AND idEmpresa = v_idEmpresa;
        ELSE
            -- Si el stock es positivo, hacer suma normal
            UPDATE stockarticulo 
            SET stock = stock + NEW.cantidad
            WHERE idarticulo = NEW.idarticulo 
            AND iddeposito = v_iddeposito 
            AND idsucursal = v_idsucursal 
            AND idEmpresa = v_idEmpresa;
        END IF;
    ELSE
        -- Insertar nuevo registro de stock
        INSERT INTO stockarticulo (
            stock, 
            iddeposito, 
            idarticulo, 
            idsucursal, 
            idEmpresa
        ) VALUES (
            NEW.cantidad,
            v_iddeposito,
            NEW.idarticulo,
            v_idsucursal,
            v_idEmpresa
        );
    END IF;
    
    -- 3. ACTUALIZAR PRECIO COSTO Y FECHA DE ÚLTIMA COMPRA
    UPDATE articulo 
    SET precio_costo = NEW.precio_costo,
        ultima_fecha_compra = v_fecha
    WHERE idarticulo = NEW.idarticulo;
    
END$$

DELIMITER ;