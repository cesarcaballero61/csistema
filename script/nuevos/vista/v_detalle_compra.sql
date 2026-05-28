DROP VIEW IF EXISTS v_detalle_compra;
CREATE OR REPLACE VIEW v_detalle_compra AS
SELECT 
    -- Identificación de la compra
    c.idcompra,
    c.fecha AS fecha_compra,
    CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura) AS nro_factura,
    
    -- Detalle del artículo
    cd.idcompra_detalle,
    cd.idarticulo,
    a.descripcion AS articulo_descripcion,
    a.codbarra,
    
    -- Cantidad y precios
    cd.cantidad,
    cd.precio_costo,
    cd.subtotal,
    
    -- Información de impuestos
    cd.iva,
    cd.gravada_excenta,
    cd.gravada_cinco,
    cd.gravada_diez,
    
    -- Información del artículo
    m.Marca AS marca,
    g.grupo AS grupo_articulo,
    sg.subgrupo AS subgrupo_articulo,
    p.proveedor AS nombre_proveedor,
    
    -- Información del proveedor
    pr.idproveedor,
    pr.proveedor,
    pr.ruc AS ruc_proveedor,
    pr.telefono AS telefono_proveedor,
    
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
    
    -- Estado de la compra
    c.estado AS estado_compra,
    c.tipo AS tipo_compra,
    CASE 
        WHEN c.tipo = 'CONTADO' THEN 'CONTADO'
        WHEN c.tipo = 'CREDITO' THEN 'CRÉDITO'
        ELSE c.tipo
    END AS tipo_compra_descripcion,
    
    -- Totales de la factura
    c.total_gravadas_excenta,
    c.total_gravadas_cinco,
    c.total_gravadas_diez,
    c.total AS total_factura,
    c.liqui_iva_cinco,
    c.liqui_iva_diez,
    c.total_liqui_iva,
    
    -- Fechas importantes
    c.fecha_vto AS fecha_vencimiento,
    c.plazo AS dias_plazo,
    
    -- Información del usuario
    u.idusuario,
    u.nick AS usuario_registro,
    CONCAT(pe.nombre, ' ', pe.apellido) AS personal_registro

FROM compra c

-- Detalle de la compra
INNER JOIN compra_detalle cd ON c.idcompra = cd.idcompra

-- Información del artículo
INNER JOIN articulo a ON cd.idarticulo = a.idarticulo
INNER JOIN marca m ON a.idMarca = m.idMarca
INNER JOIN grupo g ON a.idgrupo = g.idgrupo
INNER JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
INNER JOIN proveedor pr ON a.idproveedor = pr.idproveedor

-- Información del proveedor de la compra (puede ser diferente al proveedor del artículo)
INNER JOIN proveedor p ON c.idproveedor = p.idproveedor

-- Información del depósito
INNER JOIN deposito d ON c.iddeposito = d.iddeposito

-- Información de la sucursal y empresa
INNER JOIN sucursal s ON c.idsucursal = s.idsucursal
INNER JOIN empresa e ON c.idEmpresa = e.idEmpresa

-- Información del usuario
LEFT JOIN usuario u ON c.idusuario = u.idusuario
LEFT JOIN personal pe ON u.idPersonal = pe.idPersonal

WHERE c.estado != 'ANULADO'  -- Solo compras no anuladas
ORDER BY c.fecha DESC, c.idcompra DESC, cd.idcompra_detalle;