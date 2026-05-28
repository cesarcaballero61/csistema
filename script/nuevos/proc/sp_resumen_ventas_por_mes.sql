DELIMITER $$
DROP PROCEDURE IF EXISTS sp_resumen_ventas_por_mes$$
CREATE PROCEDURE sp_resumen_ventas_por_mes(
    IN p_anio INT,
    IN p_mes INT,
    IN p_idsucursal INT
)
BEGIN
    -- Crear tabla temporal para ventas agrupadas
    CREATE TEMPORARY TABLE tmp_ventas_agrupadas AS
    SELECT 
        v.idVenta,
        v.fecha,
        v.tipo,
        v.total,
        v.idsucursal,
        s.sucursal,
        s.ciudad,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.telefono AS telefono_empresa,
        YEAR(v.fecha) AS anio,
        MONTH(v.fecha) AS mes,
        MONTHNAME(v.fecha) AS nombre_mes
    FROM venta v
    JOIN sucursal s ON v.idsucursal = s.idsucursal
    JOIN empresa e ON s.idEmpresa = e.idEmpresa
    WHERE YEAR(v.fecha) = p_anio
      AND (p_mes = 0 OR MONTH(v.fecha) = p_mes)
      AND v.estado = 'F'
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal);

    -- Crear tabla temporal para productos y utilidad
    CREATE TEMPORARY TABLE tmp_productos_utilidad AS
    SELECT 
        dv.idVenta,
        SUM((dv.preventa - dv.precosto) * dv.cantidad) AS utilidad,
        COUNT(dv.idDetalle) AS lineas_detalle,
        SUM(dv.cantidad) AS cantidad_productos
    FROM detalle_venta dv
    JOIN venta v ON dv.idVenta = v.idVenta
    WHERE YEAR(v.fecha) = p_anio
      AND (p_mes = 0 OR MONTH(v.fecha) = p_mes)
      AND v.estado = 'F'
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal)
    GROUP BY dv.idVenta;

    -- Consulta principal con los datos correctos
    SELECT 
        -- Datos de Empresa y Sucursal
        va.nombre_empresa,
        va.ruc_empresa,
        va.telefono_empresa,
        va.sucursal AS nombre_sucursal,
        va.ciudad AS ciudad_sucursal,
        va.direccion_sucursal,
        va.telefono_sucursal,
        
        -- Periodo
        va.anio,
        va.mes,
        CONCAT(va.anio, '-', LPAD(va.mes, 2, '0')) AS periodo,
        va.nombre_mes,
        
        -- Métricas de Ventas (SIN DUPLICACIÓN)
        COUNT(va.idVenta) AS cantidad_ventas,
        SUM(CASE WHEN va.tipo = 'CON' THEN 1 ELSE 0 END) AS cantidad_ventas_contado,
        SUM(CASE WHEN va.tipo = 'CRE' THEN 1 ELSE 0 END) AS cantidad_ventas_credito,
        
        -- Totales monetarios (SIN DUPLICACIÓN)
        SUM(va.total) AS total_ventas,
        SUM(CASE WHEN va.tipo = 'CON' THEN va.total ELSE 0 END) AS ventas_contado,
        SUM(CASE WHEN va.tipo = 'CRE' THEN va.total ELSE 0 END) AS ventas_credito,
        
        -- Utilidad y productos desde la tabla temporal
        SUM(COALESCE(pu.utilidad, 0)) AS utilidad_total,
        ROUND((SUM(COALESCE(pu.utilidad, 0)) / NULLIF(SUM(va.total), 0)) * 100, 2) AS margen_utilidad_porcentaje,
        
        -- Promedios y Totales de productos
        ROUND(AVG(va.total), 2) AS ticket_promedio,
        SUM(COALESCE(pu.lineas_detalle, 0)) AS total_productos_vendidos,
        SUM(COALESCE(pu.cantidad_productos, 0)) AS cantidad_total_productos,
        
        -- Porcentajes de distribución
        ROUND((SUM(CASE WHEN va.tipo = 'CON' THEN va.total ELSE 0 END) / NULLIF(SUM(va.total), 0)) * 100, 2) AS porcentaje_contado,
        ROUND((SUM(CASE WHEN va.tipo = 'CRE' THEN va.total ELSE 0 END) / NULLIF(SUM(va.total), 0)) * 100, 2) AS porcentaje_credito

    FROM tmp_ventas_agrupadas va
    LEFT JOIN tmp_productos_utilidad pu ON va.idVenta = pu.idVenta
    GROUP BY 
        va.nombre_empresa, 
        va.ruc_empresa, 
        va.telefono_empresa,
        va.sucursal, 
        va.ciudad, 
        va.direccion_sucursal, 
        va.telefono_sucursal,
        va.anio, 
        va.mes,
        va.nombre_mes
    ORDER BY 
        va.anio DESC, 
        va.mes DESC;

    -- Limpiar tablas temporales
    DROP TEMPORARY TABLE IF EXISTS tmp_ventas_agrupadas;
    DROP TEMPORARY TABLE IF EXISTS tmp_productos_utilidad;
END$$

DELIMITER ;