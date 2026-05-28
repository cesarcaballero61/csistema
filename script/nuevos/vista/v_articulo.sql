DELIMITER $$
DROP VIEW IF EXISTS v_articulo $$
CREATE VIEW v_articulo AS
SELECT 
    a.idarticulo,
    a.descripcion,
    a.codbarra,
    a.idplan_cuota,
    a.idMarca,
    a.idgrupo,
    a.idsubgrupo,
    a.idproveedor,
    a.unidad,
    a.ultima_fecha_compra,
    a.ultima_fecha_venta,
    a.ultima_fecha_ajuste,
    a.impuesto,
    a.margen_contado,
    a.interes_mensual,
    a.limite_cuota,
    a.precio_costo,
    a.precio_contado,
    a.stockminimo AS stock_minimo,
    a.tipo_imagen,
    a.foto,
    a.detalle,
    -- Información de marca
    m.Marca AS nombre_marca,
    -- Información de grupo
    g.grupo AS nombre_grupo,
    -- Información de subgrupo
    sg.subgrupo AS nombre_subgrupo,
    -- Información de proveedor
    p.proveedor AS nombre_proveedor,
    p.ruc AS ruc_proveedor,
    -- Información del plan de cuotas
    pc.nombre_plan AS nombre_plan_cuota,
    pc.margen_contado AS margen_plan,
    pc.interes_mensual AS interes_plan,
    pc.limite_cuota AS limite_plan,
    -- Stock disponible
    COALESCE(s.stock, 0) AS stock_actual,
    -- Ubicación del stock
    s.iddeposito,
    d.deposito AS nombre_deposito,
    s.idsucursal,
    suc.sucursal AS nombre_sucursal
FROM 
    articulo a
    LEFT JOIN marca m ON a.idMarca = m.idMarca
    LEFT JOIN grupo g ON a.idgrupo = g.idgrupo
    LEFT JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    LEFT JOIN proveedor p ON a.idproveedor = p.idproveedor
    LEFT JOIN plan_cuota pc ON a.idplan_cuota = pc.idplan_cuota
    LEFT JOIN stockarticulo s ON a.idarticulo = s.idarticulo
    LEFT JOIN deposito d ON s.iddeposito = d.iddeposito
    LEFT JOIN sucursal suc ON s.idsucursal = suc.idsucursal;