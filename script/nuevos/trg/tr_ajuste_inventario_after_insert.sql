DELIMITER $$
DROP TRIGGER IF EXISTS tr_ajuste_inventario_after_insert$$
-- Trigger para AFTER INSERT en ajuste_inventario_detalle
CREATE TRIGGER tr_ajuste_inventario_after_insert
AFTER INSERT ON ajuste_inventario_detalle
FOR EACH ROW
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_nro_ajuste VARCHAR(10);
    DECLARE v_fecha DATE;
    DECLARE v_idusuario INT;
    DECLARE v_tipo_ajuste ENUM('ENTRADAS','SALIDAS');
    DECLARE v_observacion VARCHAR(100);
    DECLARE v_tipo_kardex ENUM('ENTRADA','SALIDA');
    DECLARE v_operacion_kardex ENUM('COMPRA','VENTA','AJUSTE','S/D');
    DECLARE v_stock_actual INT;
    DECLARE v_nuevo_stock INT;
    
    -- Obtener datos del ajuste principal
    SELECT 
        ai.idempresa,
        ai.idsucursal,
        ai.nro_ajuste,
        ai.fecha,
        ai.idusuario,
        ai.tipo_ajuste,
        ai.observacion
    INTO 
        v_idempresa,
        v_idsucursal,
        v_nro_ajuste,
        v_fecha,
        v_idusuario,
        v_tipo_ajuste,
        v_observacion
    FROM ajuste_inventario ai
    WHERE ai.idajuste_inventario = NEW.idajuste_inventario;
    
    -- Determinar tipo de kardex basado en el tipo de ajuste
    IF v_tipo_ajuste = 'ENTRADAS' THEN
        SET v_tipo_kardex = 'ENTRADA';
        SET v_operacion_kardex = 'AJUSTE';
    ELSE
        SET v_tipo_kardex = 'SALIDA';
        SET v_operacion_kardex = 'AJUSTE';
    END IF;
    
    -- 1. ACTUALIZAR O INSERTAR STOCK (CON LOGICA PARA STOCK NEGATIVO)
    IF EXISTS (SELECT 1 FROM stockarticulo 
               WHERE idarticulo = NEW.idarticulo 
               AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
               AND idsucursal = v_idsucursal
               AND idEmpresa = v_idempresa) THEN
               
        -- Obtener stock actual
        SELECT stock INTO v_stock_actual
        FROM stockarticulo 
        WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- Calcular nuevo stock según la lógica requerida
        IF v_tipo_ajuste = 'ENTRADAS' THEN
            -- Si es ENTRADA y el stock actual es negativo, el nuevo stock será la cantidad de entrada
            IF v_stock_actual < 0 THEN
                SET v_nuevo_stock = NEW.cantidad;
            ELSE
                -- Si el stock es positivo, hacer la suma normal
                SET v_nuevo_stock = v_stock_actual + NEW.cantidad;
            END IF;
        ELSE
            -- Para SALIDAS, lógica normal (restar)
            SET v_nuevo_stock = v_stock_actual - NEW.cantidad;
        END IF;
        
        -- Actualizar stock
        UPDATE stockarticulo 
        SET stock = v_nuevo_stock
        WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
    ELSE
        -- Insertar nuevo registro de stock (solo para ENTRADAS)
        IF v_tipo_ajuste = 'ENTRADAS' THEN
            INSERT INTO stockarticulo (
                stock,
                iddeposito,
                idarticulo,
                idsucursal,
                idEmpresa
            ) VALUES (
                NEW.cantidad,
                (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
                NEW.idarticulo,
                v_idsucursal,
                v_idempresa
            );
        END IF;
    END IF;
    
    -- 2. REGISTRAR EN KARDEX
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
        CONCAT('AJ-', v_nro_ajuste),
        (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
        (SELECT idmotivo_ajuste FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
        NEW.idarticulo,
        NEW.precio_costo,
        NEW.cantidad,
        v_operacion_kardex,
        v_tipo_kardex,
        CONCAT('AJUSTE DE INVENTARIO - ', v_observacion),
        v_idusuario,
        v_idempresa,
        v_idsucursal
    );
    
    -- 3. ACTUALIZAR ULTIMA FECHA DE AJUSTE EN ARTICULO
    UPDATE articulo 
    SET ultima_fecha_ajuste = v_fecha
    WHERE idarticulo = NEW.idarticulo;
    
END$$

DELIMITER ;