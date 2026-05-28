DROP VIEW IF EXISTS v_compra;
CREATE OR REPLACE VIEW v_compra AS
SELECT 
    c.idcompra AS idcompra,
    c.fecha AS fecha,
    -- Tipo de compra en texto
    CASE 
        WHEN c.tipo = 'CONTADO' THEN 'CONTADO'
        WHEN c.tipo = 'CREDITO' THEN 'CRÉDITO'
        ELSE c.tipo
    END AS tipo_compra_descripcion,
    -- Mantener el código original también
    c.tipo AS tipo_compra,
    p.proveedor AS nombre_proveedor,
    p.ruc AS ruc_proveedor,
    CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura) AS nro_factura,
    p.idproveedor AS idproveedor,
    d.deposito AS nombre_deposito,
    d.iddeposito AS iddeposito,
    c.total AS total_compra,
    c.estado AS estado_compra,
    -- Información de la sucursal
    s.idsucursal,
    s.sucursal AS nombre_sucursal,
    -- Información de la empresa
    e.idEmpresa,
    e.empresa AS nombre_empresa,
    -- Fechas importantes
    c.fecha_vto AS fecha_vencimiento,
    c.plazo AS dias_plazo,
    -- Totales de impuestos
    c.total_gravadas_excenta,
    c.total_gravadas_cinco,
    c.total_gravadas_diez,
    c.total_liqui_iva,
    -- Usuario que registró
    c.idusuario
FROM compra c
JOIN proveedor p ON c.idproveedor = p.idproveedor
JOIN deposito d ON c.iddeposito = d.iddeposito
JOIN sucursal s ON c.idsucursal = s.idsucursal
JOIN empresa e ON c.idEmpresa = e.idEmpresa
WHERE c.estado != 'ANULADO'  -- Solo compras no anuladas
ORDER BY c.fecha DESC;