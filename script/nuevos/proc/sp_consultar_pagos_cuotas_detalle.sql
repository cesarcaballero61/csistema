DELIMITER $$

DROP PROCEDURE IF EXISTS sp_consultar_pagos_cuotas_detalle$$

CREATE PROCEDURE sp_consultar_pagos_cuotas_detalle(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idcobrador INT,
    IN p_idcliente INT,
    IN p_idsucursal INT
)
BEGIN
    -- Convertir 0 a NULL para los filtros
    SET p_fecha_desde = NULLIF(p_fecha_desde, '0000-00-00');
    SET p_fecha_hasta = NULLIF(p_fecha_hasta, '0000-00-00');
    SET p_idcobrador = NULLIF(p_idcobrador, 0);
    SET p_idcliente = NULLIF(p_idcliente, 0);
    SET p_idsucursal = NULLIF(p_idsucursal, 0);

    SELECT 
        -- Información del pago
        pc.idpago,
        pc.fecha AS fecha_pago,
        pc.nro_recibo,
        pc.total_importe AS total_pagado,
        pc.estado AS estado_pago,
        CASE pc.estado 
            WHEN 'COB' THEN 'COBRADO' 
            WHEN 'ANU' THEN 'ANULADO' 
        END AS estado_pago_descripcion,
        
        -- Información del cliente
        c.idcliente,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información de la venta y cuota
        v.idVenta,
        v.fecha AS fecha_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_venta,
        v.total AS total_venta,
        
        cu.idcuotas,
        cu.nrofactura AS factura_cuota,
        cu.cantidad_cuota,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_actual_cuota,
        
        -- Información del detalle del pago
        dpc.iddetalle_pagos_cuotas,
        dpc.tipo_pago,
        dpc.importe,
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 'PAGO DE CUOTA' 
            WHEN 'OTRO' THEN 'OTRO CONCEPTO' 
        END AS tipo_pago_descripcion,
        
        -- Información de la cuota específica pagada
        cd.idcuotas_detalle,
        cd.orden_cuota,
        cd.orden_char,
        cd.fecha_vto,
        CASE 
            WHEN dpc.tipo_pago = 'OTRO' THEN 0
            ELSE cd.cuota 
        END AS monto_cuota_original,
        dpc.importe AS monto_pagado,
        dpc.saldo AS saldo_despues_pago,
        dpc.atraso AS dias_atraso_pago,
        
        -- Concepto del pago
        cc.idconcepto,
        COALESCE(cc.concepto, dpc.concepto) AS concepto_pago,
        cc.tipo AS tipo_concepto,
        CASE cc.tipo 
            WHEN 'I' THEN 'INGRESO' 
            WHEN 'E' THEN 'EGRESO' 
        END AS tipo_concepto_descripcion,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', (pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la forma de pago
        tp.idTipo_pago,
        tp.tipo AS forma_pago,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal,
        s.direccion AS direccion_sucursal,
        
        -- Información de la empresa
        e.idEmpresa,
        e.empresa,
        e.ruc AS ruc_empresa,
        
        -- Información del usuario que registró el pago
        u.idusuario,
        u.nick AS usuario_registro,
        CONCAT(TRIM(pu.nombre), ' ', TRIM(pu.apellido)) AS personal_registro,
        
        -- Cálculos adicionales
        (cd.cuota - dpc.saldo) AS diferencia_pagada,
        ROUND(((cd.cuota - dpc.saldo) / cd.cuota * 100), 2) AS porcentaje_pagado,
        
        -- Datos de ubicación del cliente
        z.zona,
        b.barrio,
        CONCAT(TRIM(b.barrio), ' - ', TRIM(z.zona)) AS ubicacion_cliente
        
    FROM pagos_cuotas pc
    INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago
    INNER JOIN cliente c ON pc.idcliente = c.idcliente
    INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
    INNER JOIN personal pcob ON cob.idPersonal = pcob.idPersonal
    INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago
    INNER JOIN cuotas cu ON pc.idcuotas = cu.idcuotas
    INNER JOIN venta v ON cu.idVenta = v.idVenta
    INNER JOIN sucursal s ON pc.idsucursal = s.idsucursal
    INNER JOIN empresa e ON pc.idEmpresa = e.idEmpresa
    LEFT JOIN cuotas_detalle cd ON dpc.idcuotas_detalle = cd.idcuotas_detalle
    LEFT JOIN concepto_caja cc ON dpc.idconcepto = cc.idconcepto
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    LEFT JOIN personal pu ON u.idPersonal = pu.idPersonal
    LEFT JOIN zona z ON c.idzona = z.idzona
    LEFT JOIN barrio b ON c.idbarrio = b.idbarrio
    WHERE pc.estado = 'COB'  -- Solo pagos cobrados (no anulados)
    AND (p_fecha_desde IS NULL OR pc.fecha >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR pc.fecha <= p_fecha_hasta)
    AND (p_idcobrador IS NULL OR cob.idcobrador = p_idcobrador)
    AND (p_idcliente IS NULL OR c.idcliente = p_idcliente)
    AND (p_idsucursal IS NULL OR s.idsucursal = p_idsucursal)
    ORDER BY 
        CASE 
            WHEN dpc.tipo_pago = 'CUOTA' THEN 1
            WHEN dpc.tipo_pago = 'OTRO' THEN 2
            ELSE 3
        END,        
        pc.fecha DESC,
        c.nombre, c.apellido,
        cd.orden_cuota;
        
END$$

DELIMITER ;