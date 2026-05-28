DROP VIEW IF EXISTS v_cuotas_ventas_clientes;
CREATE OR REPLACE VIEW v_cuotas_ventas_clientes AS
SELECT 
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
    
    -- Datos de la Venta
    v.idVenta,
    v.fecha AS fecha_venta,
    v.hora,
    v.tipo AS tipo_venta,
    CASE v.tipo 
        WHEN 'CON' THEN 'CONTADO' 
        WHEN 'CRE' THEN 'CRÉDITO' 
    END AS tipo_venta_descripcion,
    v.nrosuc,
    v.nroexp,
    v.nrofactura,
    CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
    v.total_gravada_excenta,
    v.total_gravada_cinco,
    v.total_gravada_diez,
    v.total AS total_venta,
    v.liqui_iva_5,
    v.liqui_iva_10,
    v.total_liqui_iva,
    
    -- Datos de la Cuota (Cabecera)
    cu.idcuotas,
    cu.fecha AS fecha_cuota,
    cu.fecha_cancela,
    cu.nrofactura AS factura_cuota,
    cu.cantidad_cuota,
    cu.primera_fecha_vto,
    cu.total_venta AS total_cuota,
    cu.saldo_actual,
    cu.ultimo_fecha_pago,
    cu.ultimo_importe,
    cu.ultimo_interes_calc,
    cu.ultimo_descuento,
    cu.ultimo_totalac,
    cu.estado AS estado_cuota,
    CASE cu.estado 
        WHEN 'PEN' THEN 'PENDIENTE' 
        WHEN 'CAN' THEN 'CANCELADO' 
    END AS estado_cuota_descripcion,
    cu.anulado,
    
    -- NUEVAS COLUMNAS: Cuotas pagadas y pendientes
    (SELECT COUNT(*) 
     FROM cuotas_detalle cd 
     WHERE cd.idcuotas = cu.idcuotas 
     AND cd.estado = 'CAN') AS cuotas_pagadas,
     
    (SELECT COUNT(*) 
     FROM cuotas_detalle cd 
     WHERE cd.idcuotas = cu.idcuotas 
     AND cd.estado = 'PEN') AS cuotas_pendientes,
    
    -- Cálculo adicional: Porcentaje de cuotas pagadas
    ROUND(
        (SELECT COUNT(*) 
         FROM cuotas_detalle cd 
         WHERE cd.idcuotas = cu.idcuotas 
         AND cd.estado = 'CAN') * 100.0 / cu.cantidad_cuota, 
    2) AS porcentaje_cuotas_pagadas,
    
    -- Información Comercial
    ven.idVendedor,
    CONCAT(pv.nombre, ' ', pv.apellido) AS vendedor_nombre,
    cob.idcobrador,
    CONCAT(pc.nombre, ' ', pc.apellido) AS cobrador_nombre,
    s.idsucursal,
    s.sucursal,
    e.idEmpresa,
    e.empresa,
    
    -- Cálculos Adicionales
    (cu.total_venta - cu.saldo_actual) AS total_pagado,
    ROUND((cu.saldo_actual / cu.total_venta) * 100, 2) AS porcentaje_pendiente,
    DATEDIFF(CURDATE(), cu.primera_fecha_vto) AS dias_desde_primer_vencimiento

FROM cliente c
INNER JOIN venta v ON c.idcliente = v.idcliente
INNER JOIN cuotas cu ON v.idVenta = cu.idVenta
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


