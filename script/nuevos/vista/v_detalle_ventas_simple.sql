DROP VIEW IF EXISTS v_detalle_ventas_simple;
CREATE VIEW v_detalle_ventas_simple AS
SELECT 
    -- Datos básicos de la venta
    v.idVenta,
    v.fecha AS fecha_venta,
    v.hora,
    CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
    v.tipo AS tipo_venta,
    CASE v.tipo 
        WHEN 'CON' THEN 'CONTADO' 
        WHEN 'CRE' THEN 'CRÉDITO' 
    END AS tipo_venta_descripcion,
    v.total AS total_venta,
    v.total_gravada_excenta,
    v.total_gravada_cinco,
    v.total_gravada_diez,
    v.liqui_iva_5,
    v.liqui_iva_10,
    v.total_liqui_iva,
    v.estado AS estado_venta,
    
    -- Datos del cliente (solo información básica)
    c.idcliente,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
    c.ci AS cliente_ci,
    c.celular,
    
    -- Datos del artículo vendido
    dv.idDetalle,
    dv.cantidad,
    dv.precosto AS precio_costo,
    dv.preventa AS precio_venta,
    dv.subtotal,
    dv.iva,
    dv.gravada_excenta,
    dv.gravada_cinco,
    dv.gravada_diez,
    dv.tipo_cuota,
    dv.plan_cuota,
    dv.cant_cuota,
    dv.interes_mensual,
    dv.margen_conta,
    dv.monto_cuota,
    
    -- Información del artículo
    a.idarticulo,
    a.descripcion AS articulo_descripcion,
    a.codbarra,
    a.impuesto,
    a.precio_costo AS costo_actual,
    a.precio_contado,
    
    -- Información comercial básica
    ven.idVendedor,
    CONCAT(pv.nombre, ' ', pv.apellido) AS vendedor_nombre,
    s.sucursal,
    e.empresa,
    
    -- Información de depósito
    d.deposito

FROM venta v
INNER JOIN detalle_venta dv ON v.idVenta = dv.idVenta
INNER JOIN cliente c ON v.idcliente = c.idcliente
INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
INNER JOIN vendedor ven ON v.idVendedor = ven.idVendedor
INNER JOIN personal pv ON ven.idPersonal = pv.idPersonal
INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa
LEFT JOIN deposito d ON dv.iddeposito = d.iddeposito
WHERE v.estado = 'F';