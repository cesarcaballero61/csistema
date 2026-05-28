DELIMITER $$

DROP PROCEDURE IF EXISTS sp_extracto_cliente$$

CREATE PROCEDURE sp_extracto_cliente(p_idventa INT)
BEGIN
    -- Variables para almacenar totales
    DECLARE v_total_venta DECIMAL(10,2);
    DECLARE v_total_pagado DECIMAL(10,2);
    DECLARE v_total_pendiente DECIMAL(10,2);
    
    -- Calcular totales primero
    SELECT 
        SUM(cd.cuota),
        SUM(CASE WHEN cd.estado = 'PEN' THEN cd.saldo_cuota ELSE 0 END)
    INTO 
        v_total_venta,
        v_total_pendiente
    FROM venta v
    INNER JOIN cuotas c ON v.idVenta = c.idVenta
    INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
    WHERE v.idVenta = p_idventa;
    
    SET v_total_pagado = (v_total_venta - v_total_pendiente);
    
    -- Consulta principal con todos los datos
    SELECT 
        -- Datos de Empresa
        emp.empresa,
        emp.ruc AS empresa_ruc,
        emp.telefono AS empresa_telefono,
        
        -- Datos de Sucursal
        suc.sucursal,
        suc.direccion AS sucursal_direccion,
        suc.ciudad AS sucursal_ciudad,
        
        -- Datos del Cliente
        CONCAT(cli.ci, ' - ', cli.apellido, ', ', cli.nombre) AS cliente_info,
        CONCAT(IFNULL(TRIM(b.barrio), ''), ' - ', IFNULL(TRIM(z.zona), '')) AS direccion_cliente,
        CONCAT('Tel. ', IFNULL(cli.telefono, '-'), ' - Cel. ', IFNULL(cli.celular, '-')) AS contacto_cliente,
        
        -- Detalle de Cuotas
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS 'nro_factura',
        DATE_FORMAT(v.fecha, '%d/%m/%y') AS 'fecha_venta',
        CONCAT(cd.orden_cuota, '/', c.cantidad_cuota) AS 'orden_cuota',
        DATE_FORMAT(cd.fecha_vto, '%d/%m/%y') AS 'vto',
        CASE 
            WHEN cd.estado = 'CAN' THEN cd.ultimo_atraso
            WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto)
            ELSE 0
        END AS 'atraso',
        FORMAT(cd.cuota, 0) AS 'cuota',
        COALESCE(cd.ultimo_nro_recibo, '') AS 'ultimo_recibo',
        CASE 
            WHEN cd.ultima_Fecha_pago IS NOT NULL THEN DATE_FORMAT(cd.ultima_Fecha_pago, '%d/%m/%y')
            ELSE ''
        END AS 'fecha_pago',
        CASE 
            WHEN cd.ultimo_importe > 0 THEN FORMAT(cd.ultimo_importe, 0)
            ELSE ''
        END AS 'importe',
        FORMAT(cd.saldo_cuota, 0) AS 'saldo',
        
        -- Totales (solo en la primera fila)
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_venta, 0) ELSE '' END AS 'total_venta',
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_pagado, 0) ELSE '' END AS 'total_pagado',
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_pendiente, 0) ELSE '' END AS 'total_pendiente'
        
    FROM venta v
    INNER JOIN empresa emp ON v.idEmpresa = emp.idEmpresa
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN cliente cli ON v.idcliente = cli.idcliente
    LEFT JOIN barrio b ON cli.idbarrio = b.idbarrio
    LEFT JOIN zona z ON cli.idzona = z.idzona
    INNER JOIN cuotas c ON v.idVenta = c.idVenta
    INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
    WHERE v.idVenta = p_idventa
    ORDER BY cd.orden_cuota;
    
END$$

DELIMITER ;