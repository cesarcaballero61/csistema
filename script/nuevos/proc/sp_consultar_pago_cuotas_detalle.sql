DELIMITER $$

DROP PROCEDURE IF EXISTS sp_consultar_pago_cuotas_detalle$$

CREATE PROCEDURE sp_consultar_pago_cuotas_detalle(
    IN p_idpago INT
)
BEGIN
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
        CONCAT(TRIM(c.nombre), ' ', TRIM(c.apellido)) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', (pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la forma de pago
        tp.idTipo_pago,
        tp.tipo AS forma_pago,
        
        -- Información de la venta y cuota
        cu.idcuotas,
        cu.nrofactura AS factura_cuota,
        v.idVenta,
        v.nrofactura AS nro_factura_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.fecha AS fecha_venta,
        v.total AS total_venta,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_actual_cuota,
        
        -- Información del detalle del pago
        dpc.iddetalle_pagos_cuotas,
        dpc.tipo_pago,
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 'PAGO DE CUOTA' 
            WHEN 'OTRO' THEN 'OTRO CONCEPTO' 
        END AS tipo_pago_descripcion,
        dpc.orden AS numero_cuota,
        dpc.orden_char AS numero_cuota_char,
        dpc.fecha_vto AS fecha_vencimiento,
        dpc.atraso AS dias_atraso,
        dpc.cuota AS monto_cuota_original,
        dpc.importe AS monto_pagado,
        dpc.saldo AS saldo_despues_pago,
        
        -- Información del concepto
        cc.idconcepto,
        COALESCE(cc.concepto, dpc.concepto) AS concepto_pago,
        cc.tipo AS tipo_concepto,
        CASE cc.tipo 
            WHEN 'I' THEN 'INGRESO' 
            WHEN 'E' THEN 'EGRESO' 
        END AS tipo_concepto_descripcion,
        
        -- Información de la sucursal y empresa
        s.idsucursal,
        s.sucursal,
        COALESCE(s.direccion, 'S/D') AS direccion_sucursal,
        COALESCE(s.telefono, 'S/D') AS telefono_sucursal,
        e.idEmpresa,
        e.empresa,
        e.descrip AS descripcion_empresa,
        
        -- Información del usuario que registró el pago
        u.idusuario,
        u.nick AS usuario_registro,
        CONCAT(TRIM(pu.nombre), ' ', TRIM(pu.apellido)) AS personal_registro,
        
        -- Campo para ordenación (1 = CUOTA, 2 = OTRO)
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 1 
            WHEN 'OTRO' THEN 2 
        END AS orden_tipo_pago
        
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
    LEFT JOIN concepto_caja cc ON dpc.idconcepto = cc.idconcepto
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    LEFT JOIN personal pu ON u.idPersonal = pu.idPersonal
    WHERE pc.idpago = p_idpago
    ORDER BY 
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 1 
            WHEN 'OTRO' THEN 2 
        END,  -- Primero CUOTA, luego OTRO
        dpc.orden;  -- Luego por orden de cuota (si es tipo CUOTA)
    
END$$

DELIMITER ;