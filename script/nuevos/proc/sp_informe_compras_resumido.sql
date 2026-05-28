DELIMITER $$

DROP PROCEDURE IF EXISTS sp_informe_compras_resumido$$

CREATE PROCEDURE sp_informe_compras_resumido(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idproveedor INT
)
BEGIN

    -- Informe detallado por cada factura de compra (sin agrupar por proveedor)
    SELECT 
        -- Identificación de la compra
        c.idcompra,
        
        -- Número de factura formateado
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura) AS numero_factura,
        
        -- Fecha de la compra
        c.fecha AS fecha_compra,
        
        -- Datos del proveedor
        p.proveedor AS nombre_proveedor,
        p.ruc AS ruc_proveedor,
        
        -- Tipo de compra
        CASE 
            WHEN c.tipo = 'CONTADO' THEN 'CONTADO'
            WHEN c.tipo = 'CREDITO' THEN 'CRÉDITO'
            ELSE c.tipo
        END AS tipo_compra_descripcion,
        
        -- Estado de la compra
        c.estado AS estado_compra,
        
        -- Información de la sucursal
        s.sucursal AS nombre_sucursal,
        
        -- Información del depósito
        d.deposito AS nombre_deposito,
        
        -- Totales de la factura
        c.total AS total_factura,
        c.total_gravadas_excenta AS exenta_factura,
        c.total_gravadas_cinco AS gravada_5_factura,
        c.total_gravadas_diez AS gravada_10_factura,
        c.total_liqui_iva AS iva_factura,
        
        -- Detalles de artículos (resumen)
        COUNT(cd.idcompra_detalle) AS cantidad_items,
        SUM(cd.cantidad) AS total_unidades,
        
        -- Lista de artículos (resumida)
        GROUP_CONCAT(
            DISTINCT CONCAT(
                a.descripcion, 
                ' (', cd.cantidad, ' un.)'
            ) 
            SEPARATOR '; '
        ) AS articulos_resumen,
        
        -- Fechas importantes
        c.fecha_vto AS fecha_vencimiento,
        c.plazo AS dias_plazo,
        
        -- Información del usuario
        u.nick AS usuario_registro,
        CONCAT(TRIM(per.nombre), ' ', TRIM(per.apellido)) AS personal_registro
        
    FROM compra c
    
    -- Detalle de la compra
    INNER JOIN compra_detalle cd ON c.idcompra = cd.idcompra
    
    -- Información del artículo
    INNER JOIN articulo a ON cd.idarticulo = a.idarticulo
    
    -- Información del proveedor
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    
    -- Información de la sucursal
    INNER JOIN sucursal s ON c.idsucursal = s.idsucursal
    
    -- Información del depósito
    INNER JOIN deposito d ON c.iddeposito = d.iddeposito
    
    -- Información del usuario
    LEFT JOIN usuario u ON c.idusuario = u.idusuario
    LEFT JOIN personal per ON u.idPersonal = per.idPersonal
    
    WHERE c.fecha BETWEEN p_fecha_desde AND p_fecha_hasta
      AND c.estado != 'ANULADO'
      AND (p_idproveedor = 0 OR c.idproveedor = p_idproveedor)
    
    -- Agrupar por cada compra individual
    GROUP BY c.idcompra, c.nro_est, c.nro_exp, c.nro_factura, c.fecha,
             p.proveedor, p.ruc, c.tipo, c.estado, s.sucursal, d.deposito,
             c.total, c.total_gravadas_excenta, c.total_gravadas_cinco,
             c.total_gravadas_diez, c.total_liqui_iva, c.fecha_vto, c.plazo,
             u.nick, per.nombre, per.apellido
    
    ORDER BY c.fecha DESC, c.idcompra DESC;
    
    -- Totales generales (opcional, como segunda tabla de resultados)
    SELECT 
        COUNT(DISTINCT c.idcompra) AS total_compras,
        SUM(c.total) AS monto_total,
        SUM(c.total_gravadas_excenta) AS total_exenta,
        SUM(c.total_gravadas_cinco) AS total_gravada_5,
        SUM(c.total_gravadas_diez) AS total_gravada_10,
        SUM(c.total_liqui_iva) AS total_iva,
        COUNT(DISTINCT c.idproveedor) AS cantidad_proveedores
    FROM compra c
    WHERE c.fecha BETWEEN p_fecha_desde AND p_fecha_hasta
      AND c.estado != 'ANULADO'
      AND (p_idproveedor = 0 OR c.idproveedor = p_idproveedor);
    
END$$

DELIMITER ;