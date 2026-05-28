DROP VIEW IF EXISTS v_detalle_cuotas;
CREATE VIEW v_detalle_cuotas AS
SELECT 
    -- Datos del Detalle de Cuota
    cd.idcuotas_detalle,
    cd.orden_char,
    cd.orden_cuota,
    cd.fecha_vto,
    cd.cuota,
    cd.saldo_cuota,
    cd.ultimo_nro_recibo,
    cd.ultimo_atraso,
    cd.ultimo_importe,
    cd.ultima_Fecha_pago,
    cd.ultimo_interes_calcu,
    cd.ultimo_descuento,
    cd.ultimo_totalac,
    cd.estado AS estado_detalle,
    CASE cd.estado 
        WHEN 'PEN' THEN 'PENDIENTE' 
        WHEN 'CAN' THEN 'CANCELADO' 
    END AS estado_detalle_descripcion,
    
    -- Cálculos de atraso e interés
    DATEDIFF(CURDATE(), cd.fecha_vto) AS dias_atraso_actual,
    CASE 
        WHEN cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 0 
        THEN DATEDIFF(CURDATE(), cd.fecha_vto)
        ELSE 0 
    END AS dias_atraso_efectivo,
    
    -- Datos de la Cabecera de Cuotas
    cu.idcuotas,
    cu.fecha AS fecha_cuota,
    cu.nrofactura AS factura_cuota,
    cu.cantidad_cuota,
    cu.primera_fecha_vto,
    cu.total_venta AS total_cuota,
    cu.saldo_actual AS saldo_cuota_cabecera,
    cu.ultimo_fecha_pago,
    cu.ultimo_importe AS ultimo_importe_cabecera,
    cu.ultimo_interes_calc AS ultimo_interes_cabecera,
    cu.ultimo_descuento AS ultimo_descuento_cabecera,
    cu.ultimo_totalac AS ultimo_totalac_cabecera,
    cu.estado AS estado_cuota,
    CASE cu.estado 
        WHEN 'PEN' THEN 'PENDIENTE' 
        WHEN 'CAN' THEN 'CANCELADO' 
    END AS estado_cuota_descripcion,
    cu.anulado,
    
    -- Datos de la Venta
    v.idVenta,
    v.fecha AS fecha_venta,
    v.nrofactura,
    CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
    v.total AS total_venta,
    v.total_gravada_excenta,
    v.total_gravada_cinco,
    v.total_gravada_diez,
    v.liqui_iva_5,
    v.liqui_iva_10,
    v.total_liqui_iva,
    
    -- Datos del Cliente
    c.idcliente,
    c.nombre AS cliente_nombre,
    c.apellido AS cliente_apellido,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
    c.ci AS cliente_ci,
    c.ruc AS cliente_ruc,
    c.celular,
    c.telefono,
    c.referencia,
    c.trabajo_lugar,
    c.trabajo_telefono,
    z.zona,
    b.barrio,
    prof.profesion,
    
    -- Información Comercial
    ven.idVendedor,
    CONCAT(pv.nombre, ' ', pv.apellido) AS vendedor_nombre,
    cob.idcobrador,
    CONCAT(pc.nombre, ' ', pc.apellido) AS cobrador_nombre,
    s.idsucursal,
    s.sucursal,
    e.idEmpresa,
    e.empresa,
    
    -- Cálculos Adicionales del Detalle
    (cd.cuota - cd.saldo_cuota) AS total_pagado_detalle,
    ROUND(((cd.cuota - cd.saldo_cuota) / cd.cuota) * 100, 2) AS porcentaje_pagado_detalle,
    
    -- Indicadores de Estado
    CASE 
        WHEN cd.estado = 'CAN' THEN 'COMPLETAMENTE PAGADO'
        WHEN cd.saldo_cuota = 0 THEN 'COMPLETAMENTE PAGADO'
        WHEN cd.saldo_cuota < cd.cuota AND cd.saldo_cuota > 0 THEN 'PAGO PARCIAL'
        WHEN cd.saldo_cuota = cd.cuota THEN 'SIN PAGOS'
        ELSE 'ESTADO INDETERMINADO'
    END AS situacion_pago,
    
    -- Alertas
    CASE 
        WHEN cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 30 THEN 'MORA GRAVE'
        WHEN cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 15 THEN 'MORA MODERADA'
        WHEN cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 0 THEN 'MORA LEVE'
        WHEN cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) <= 0 THEN 'AL DÍA'
        ELSE 'NO APLICA'
    END AS nivel_mora

FROM cuotas_detalle cd
INNER JOIN cuotas cu ON cd.idcuotas = cu.idcuotas
INNER JOIN venta v ON cu.idVenta = v.idVenta
INNER JOIN cliente c ON v.idcliente = c.idcliente
INNER JOIN zona z ON c.idzona = z.idzona
INNER JOIN barrio b ON c.idbarrio = b.idbarrio
INNER JOIN profesion prof ON c.idprofesion = prof.idprofesion
INNER JOIN vendedor ven ON v.idVendedor = ven.idVendedor
INNER JOIN personal pv ON ven.idPersonal = pv.idPersonal
LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
LEFT JOIN personal pc ON cob.idPersonal = pc.idPersonal
INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa
WHERE v.estado = 'F' 
AND cu.anulado = 'NO';