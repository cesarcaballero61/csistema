DROP VIEW IF EXISTS v_detalle_venta;
CREATE OR REPLACE VIEW v_detalle_venta AS
SELECT 
    -- Identificación de la venta
    v.idVenta,
    v.fecha AS fecha_venta,
    CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS nro_factura,
    
    -- Detalle del artículo
    dv.idDetalle,
    dv.idarticulo,
    a.descripcion AS articulo_descripcion,
    a.codbarra,
    
    -- Cantidad y precios
    dv.cantidad,
    dv.precosto AS precio_costo,
    dv.preventa AS precio_venta,
    dv.subtotal AS subtotal,
    
    -- Información del artículo
    m.Marca AS marca,
    g.grupo AS grupo_articulo,
    sg.subgrupo AS subgrupo_articulo,
    p.proveedor AS nombre_proveedor,
    
    -- Información de financiación (si aplica)
    dv.tipo_cuota,
    dv.plan_cuota,
    dv.cant_cuota,
    dv.interes_mensual,
    dv.margen_conta,
    dv.monto_cuota,
    
    -- Información de impuestos
    dv.iva,
    dv.gravada_excenta,
    dv.gravada_cinco,
    dv.gravada_diez,
    
    -- Información del cliente
    c.idcliente,
    CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
    c.ci AS cliente_ci,
    c.celular AS cliente_celular,
    c.telefono AS cliente_telefono,
    
    -- Información de la ubicación del cliente
    z.zona,
    b.barrio,
    
    -- Información del vendedor
    vend.idVendedor,
    CONCAT(p_vend.nombre, ' ', p_vend.apellido) AS vendedor_nombre,
    
    -- Información del cobrador (si aplica)
    cob.idcobrador,
    CONCAT(p_cob.nombre, ' ', p_cob.apellido) AS cobrador_nombre,
    
    -- Información del depósito
    d.iddeposito,
    d.deposito AS nombre_deposito,
    
    -- Información de la sucursal y empresa
    s.idsucursal,
    s.sucursal,
    s.ciudad,
    s.direccion AS direccion_sucursal,
    e.idEmpresa,
    e.empresa AS nombre_empresa,
    e.ruc AS ruc_empresa,
    
    -- Estado de la venta
    v.estado AS estado_venta,
    v.tipo AS tipo_venta,
    CASE 
        WHEN v.tipo = 'CON' THEN 'CONTADO'
        WHEN v.tipo = 'CRE' THEN 'CRÉDITO'
        ELSE v.tipo
    END AS tipo_venta_descripcion,
    
    -- Totales de la factura
    v.total_gravada_excenta,
    v.total_gravada_cinco,
    v.total_gravada_diez,
    v.total AS total_factura,
    v.liqui_iva_5,
    v.liqui_iva_10,
    v.total_liqui_iva,
    
    -- Fecha de vencimiento del pagaré (si aplica)
    v.fecha_vto_pagare

FROM venta v

-- Detalle de la venta
INNER JOIN detalle_venta dv ON v.idVenta = dv.idVenta

-- Información del artículo
INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
INNER JOIN marca m ON a.idMarca = m.idMarca
INNER JOIN grupo g ON a.idgrupo = g.idgrupo
INNER JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
INNER JOIN proveedor p ON a.idproveedor = p.idproveedor

-- Información del cliente
INNER JOIN cliente c ON v.idcliente = c.idcliente
INNER JOIN zona z ON c.idzona = z.idzona
INNER JOIN barrio b ON c.idbarrio = b.idbarrio

-- Información del vendedor
INNER JOIN vendedor vend ON v.idVendedor = vend.idVendedor
INNER JOIN personal p_vend ON vend.idPersonal = p_vend.idPersonal

-- Información del cobrador (LEFT JOIN porque puede ser NULL en ventas contado)
LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
LEFT JOIN personal p_cob ON cob.idPersonal = p_cob.idPersonal

-- Información del depósito
INNER JOIN deposito d ON dv.iddeposito = d.iddeposito

-- Información de la sucursal y empresa
INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa

WHERE v.estado = 'F'  -- Solo ventas facturadas
ORDER BY v.fecha DESC, v.idVenta DESC, dv.idDetalle;