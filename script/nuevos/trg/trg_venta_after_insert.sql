DROP TRIGGER IF EXISTS `trg_venta_after_insert`;
DELIMITER $$

CREATE TRIGGER `trg_venta_after_insert`
AFTER INSERT ON `venta`
FOR EACH ROW 
BEGIN
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion_mov VARCHAR(500);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_cliente_ci VARCHAR(20);
    DECLARE v_vendedor_nombre VARCHAR(90);
    DECLARE v_idapecierre INT;
    DECLARE v_nrofactura VARCHAR(45);
    DECLARE v_idpersonal_vendedor INT;

    -- Obtener datos del cliente
    SELECT 
        COALESCE(CONCAT(nombre, ' ', apellido), 'CLIENTE NO ENCONTRADO'),
        COALESCE(ci, 'N/D')
    INTO 
        v_cliente_nombre,
        v_cliente_ci
    FROM cliente 
    WHERE idcliente = NEW.idcliente;

    -- Obtener datos del vendedor
    SELECT 
        COALESCE(CONCAT(TRIM(p.nombre), ' ', TRIM(p.apellido)), 'VENDEDOR NO ENCONTRADO')
    INTO 
        v_vendedor_nombre
    FROM vendedor v
    INNER JOIN personal p ON p.idPersonal = v.idPersonal
    WHERE v.idVendedor = NEW.idVendedor;

    -- Obtener personal del vendedor para la apertura de caja
    SELECT vd.idPersonal INTO v_idpersonal_vendedor 
    FROM vendedor vd WHERE vd.idVendedor = NEW.idVendedor;
    
    -- Obtener id apertura cierre caja.
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_vendedor);

    -- Nro_factura formateado
    SET v_nrofactura = CONCAT(TRIM(NEW.nrosuc), '-', TRIM(NEW.nroexp), '-', TRIM(NEW.nrofactura));

    -- Obtener el id concepto
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
	FROM parametros_sistema
	WHERE nombre = 'CONCEPTO_VENTA'
	AND tabla ='concepto_caja'
	LIMIT 1;

    -- Construir descripción detallada
    SET v_descripcion_mov = CONCAT(
        'VENTA ', NEW.tipo, ' - ',
        v_cliente_nombre,
        ' CI. ', v_cliente_ci,
        ' - Factura: ', COALESCE(v_nrofactura, 'SIN-NUMERO'),
        ' - Vendedor: ', v_vendedor_nombre,
        ' - Monto: Gs. ', FORMAT(NEW.total, 0)
    );

    -- Insertar en mov_operacion
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_mov,
        tipo_op,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idsucursal,
        idEmpresa,
        idapecierre,
        idusuario 
    ) VALUES (
        NEW.fecha,
        'VENTA',
        'INGRESOS',  -- Ingreso
        CASE new.tipo WHEN  'CON' THEN 'CONTADO' ELSE 'CREDITO' END,
        v_idconcepto,
        COALESCE(v_nrofactura, 'SIN-NUMERO'),
        NEW.total,
        v_descripcion_mov,
        NEW.idsucursal,
        NEW.idEmpresa,
        COALESCE(v_idapecierre,0),
        NEW.idusuario  
    );
END$$

DELIMITER ;
