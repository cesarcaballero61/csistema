DELIMITER $$
DROP PROCEDURE IF EXISTS sp_ranking_articulos_vendidos$$
CREATE PROCEDURE sp_ranking_articulos_vendidos(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_tipo_ranking ENUM('CANTIDAD', 'MONTO', 'UTILIDAD'),
    IN p_top INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    -- Variable para el límite
    DECLARE v_limit INT DEFAULT 1000;
    
    -- Si p_top es mayor que 0, usar ese valor, sino usar 1000 como límite por defecto
    IF p_top > 0 THEN
        SET v_limit = p_top;
    END IF;

    SELECT 
        -- Datos de Empresa y Sucursal
        e.empresa AS nombre_empresa,
        s.sucursal AS nombre_sucursal,
        s.direccion AS direccion_sucursal,
        
        -- Datos del Artículo
        a.idarticulo,
        a.descripcion AS nombre_articulo,
        a.codbarra AS codigo_barras,
        m.Marca AS marca,
        g.grupo AS categoria,
        sg.subgrupo AS subcategoria,
        prov.proveedor AS proveedor,
        
        -- Métricas de Ventas
        SUM(dv.cantidad) AS total_unidades_vendidas,
        COUNT(DISTINCT v.idVenta) AS total_ventas,
        SUM(dv.subtotal) AS total_monto_vendido,
        ROUND(AVG(dv.preventa), 2) AS precio_promedio_venta,
        
        -- Métricas de Costo y Utilidad
        ROUND(AVG(dv.precosto), 2) AS costo_promedio,
        SUM(dv.subtotal - (dv.precosto * dv.cantidad)) AS utilidad_total,
        ROUND(((SUM(dv.subtotal) - SUM(dv.precosto * dv.cantidad)) / NULLIF(SUM(dv.subtotal), 0)) * 100, 2) AS margen_utilidad_porcentaje,
        
        -- Porcentaje de participación
        ROUND((SUM(dv.subtotal) / NULLIF((SELECT SUM(dv2.subtotal) 
                                  FROM detalle_venta dv2 
                                  JOIN venta v2 ON dv2.idVenta = v2.idVenta
                                  WHERE v2.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
                                    AND v2.estado = 'F'
                                    AND (p_idempresa = 0 OR v2.idEmpresa = p_idempresa)
                                    AND (p_idsucursal = 0 OR v2.idsucursal = p_idsucursal)), 0)) * 100, 2) AS participacion_porcentaje,
        
        -- Fechas de movimiento
        MIN(v.fecha) AS primera_venta,
        MAX(v.fecha) AS ultima_venta,
        
        -- Tipos de venta
        COUNT(DISTINCT CASE WHEN v.tipo = 'CON' THEN v.idVenta END) AS ventas_contado,
        COUNT(DISTINCT CASE WHEN v.tipo = 'CRE' THEN v.idVenta END) AS ventas_credito,
        
        -- Stock actual (si existe)
        (SELECT stock FROM stockarticulo WHERE idarticulo = a.idarticulo AND idsucursal = s.idsucursal LIMIT 1) AS stock_actual

    FROM detalle_venta dv
    INNER JOIN venta v ON dv.idVenta = v.idVenta
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    INNER JOIN marca m ON a.idMarca = m.idMarca
    INNER JOIN grupo g ON a.idgrupo = g.idgrupo
    INNER JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    INNER JOIN proveedor prov ON a.idproveedor = prov.idproveedor
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
    
    WHERE v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
      AND v.estado = 'F'  -- Solo ventas facturadas, no anuladas
      AND (p_idempresa = 0 OR e.idEmpresa = p_idempresa)
      AND (p_idsucursal = 0 OR s.idsucursal = p_idsucursal)
    
    GROUP BY 
        a.idarticulo, a.descripcion, a.codbarra, m.Marca, g.grupo, sg.subgrupo, prov.proveedor,
        e.empresa, s.sucursal
    
    ORDER BY 
        CASE 
            WHEN p_tipo_ranking = 'CANTIDAD' THEN SUM(dv.cantidad)
            WHEN p_tipo_ranking = 'MONTO' THEN SUM(dv.subtotal)
            WHEN p_tipo_ranking = 'UTILIDAD' THEN SUM(dv.subtotal - (dv.precosto * dv.cantidad))
        END DESC
        
    LIMIT v_limit;

END$$

DELIMITER ;