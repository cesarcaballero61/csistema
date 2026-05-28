-- Trigger para AFTER INSERT en compra (cabecera)
DELIMITER $$
DROP TRIGGER tr_compra_after_insert$$
CREATE TRIGGER tr_compra_after_insert
AFTER INSERT ON compra
FOR EACH ROW
BEGIN
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion VARCHAR(250);
    DECLARE v_tipo_mov ENUM('EGRESOS','INGRESOS');
    DECLARE v_tipo_op ENUM('CONTADO','CREDITO','N/D');
    DECLARE v_valor_parametro VARCHAR(100);
    DECLARE v_nombre_proveedor VARCHAR(45);
    
    -- OBTENER NOMBRE DEL PROVEEDOR
    SELECT proveedor INTO v_nombre_proveedor
    FROM proveedor
    WHERE idproveedor = NEW.idproveedor;
    
    -- OBTENER EL CONCEPTO DESDE PARAMETROS_SISTEMA (USANDO SOLO UN PARÁMETRO)
    SELECT valor INTO v_valor_parametro
    FROM parametros_sistema
    WHERE nombre = 'COMPRA_CONCEPTO'
    LIMIT 1;
    
    -- ASIGNAR VALOR POR DEFECTO SI NO EXISTE EL PARÁMETRO
    IF v_valor_parametro IS NOT NULL AND v_valor_parametro != '' THEN
        SET v_idconcepto = CAST(v_valor_parametro AS UNSIGNED);
    ELSE
        SET v_idconcepto = 1; -- Valor por defecto único
    END IF;
    
    -- CONFIGURAR TIPOS
    SET v_tipo_mov = 'EGRESOS';
    SET v_tipo_op = NEW.tipo; -- Usa el mismo tipo de la compra
    
    -- CREAR DESCRIPCIÓN DETALLADA
    SET v_descripcion = CONCAT(
        'COMPRA ', NEW.tipo,
        ' - Fact: ', NEW.nro_est, '-', NEW.nro_exp, '-', NEW.nro_factura,
        ' | Proveedor: ', COALESCE(v_nombre_proveedor, 'N/A'),
        ' | Total: ', NEW.total,
        ' | Depósito: ', NEW.iddeposito
    );
    
    -- INSERTAR EN MOV_OPERACION PARA AMBOS TIPOS (CONTADO Y CRÉDITO)
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
        'COMPRA',
        v_tipo_op,
        v_tipo_mov,
        v_idconcepto,
        CONCAT(NEW.nro_est, '-', NEW.nro_exp, '-', NEW.nro_factura),
        NEW.total,
        v_descripcion,
        NEW.idusuario,
        NEW.idsucursal,
        NEW.idEmpresa
    );
    
END$$

DELIMITER ;