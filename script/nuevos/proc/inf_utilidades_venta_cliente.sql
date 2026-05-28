DELIMITER $$

USE `db`$$

DROP PROCEDURE IF EXISTS `inf_utilidades_venta_cliente`$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inf_utilidades_venta_cliente`(
    IN cod_suc INT,
    IN cod_cli INT,
    IN cod_tipo INT,  -- 1=Todos, 2=Contado, 3=Crédito
    IN desde DATE,
    IN hasta DATE
)
BEGIN
    SELECT
        v.idVenta,
        v.nrofactura,
        v.fecha,
        cli.idcliente,
        cli.ci,
        CONCAT(cli.nombre, ' ', cli.apellido) AS cliente,
        s.sucursal,
        v.tipo,
        CASE 
            WHEN v.tipo = 0 THEN 'CONTADO'
            WHEN v.tipo = 2 THEN 'CRÉDITO'  -- CORREGIDO: tipo 2 es crédito
            ELSE CONCAT('OTRO: ', v.tipo)
        END AS tipo_venta,
        
        -- INFORMACIÓN DE ARTÍCULOS VENDIDOS
        GROUP_CONCAT(CONCAT(a.descripcion, ' (', dv.cantidad, ' uds.)') SEPARATOR '; ') AS articulos_vendidos,
        COUNT(dv.idDetalle) AS cantidad_articulos,
        SUM(dv.cantidad) AS total_unidades,
        
        -- CÁLCULO DE COSTOS Y UTILIDADES
        SUM(
            CASE 
                WHEN dv.precosto IS NOT NULL AND dv.precosto > 0 
                THEN dv.precosto * dv.cantidad
                ELSE a.precio_costo * dv.cantidad
            END
        ) AS costo_total,
        
        SUM(dv.subtotal) AS ingreso_total,
        
        SUM(dv.subtotal) - SUM(
            CASE 
                WHEN dv.precosto IS NOT NULL AND dv.precosto > 0 
                THEN dv.precosto * dv.cantidad
                ELSE a.precio_costo * dv.cantidad
            END
        ) AS utilidad_bruta,
        
        CASE 
            WHEN SUM(
                CASE 
                    WHEN dv.precosto IS NOT NULL AND dv.precosto > 0 
                    THEN dv.precosto * dv.cantidad
                    ELSE a.precio_costo * dv.cantidad
                END
            ) > 0 THEN
                ROUND(
                    ((SUM(dv.subtotal) - SUM(
                        CASE 
                            WHEN dv.precosto IS NOT NULL AND dv.precosto > 0 
                            THEN dv.precosto * dv.cantidad
                            ELSE a.precio_costo * dv.cantidad
                        END
                    )) / SUM(
                        CASE 
                            WHEN dv.precosto IS NOT NULL AND dv.precosto > 0 
                            THEN dv.precosto * dv.cantidad
                            ELSE a.precio_costo * dv.cantidad
                        END
                    )) * 100, 2
                )
            ELSE 0
        END AS porcentaje_utilidad,
        
        c.cantidad_cuota,
        c.cuotas_fija,
        c.total_venta,
        c.SALDO_ACTUAL,
        c.ESTADO AS estado_cuota,
        
        v.total_gravada_excenta,
        v.total_gravada_cinco,
        v.total_gravada_diez,
        v.total,
        v.total_liqui_iva
        
    FROM db.venta v
    INNER JOIN db.cliente cli ON (v.idcliente = cli.idcliente)
    INNER JOIN db.detalle_venta dv ON (v.idVenta = dv.idVenta)
    INNER JOIN db.articulo a ON (dv.idarticulo = a.idarticulo)
    INNER JOIN db.sucursal s ON (v.idsucursal = s.idsucursal)
    LEFT JOIN db.cuotas c ON (c.idVenta = v.idVenta AND c.idcliente = v.idcliente)
    
    WHERE v.estado = "F" 
        AND v.fecha BETWEEN desde AND hasta
        AND (cod_suc = 0 OR s.idsucursal = cod_suc)
        AND (cod_cli = 0 OR v.idcliente = cod_cli)
        -- CORRECCIÓN DEFINITIVA:
        AND (
            cod_tipo = 1 OR  -- Todos los tipos
            (cod_tipo = 2 AND v.tipo = 0) OR  -- Contado (tipo 0)
            (cod_tipo = 3 AND v.tipo = 2)     -- Crédito (tipo 2)
        )
    
    GROUP BY 
        v.idVenta,
        v.nrofactura,
        v.fecha,
        cli.idcliente,
        cli.ci,
        cliente,
        s.sucursal,
        v.tipo,
        tipo_venta,
        c.cantidad_cuota,
        c.cuotas_fija,
        c.total_venta,
        c.SALDO_ACTUAL,
        c.ESTADO,
        v.total_gravada_excenta,
        v.total_gravada_cinco,
        v.total_gravada_diez,
        v.total,
        v.total_liqui_iva
    
    ORDER BY v.fecha DESC, utilidad_bruta DESC;
    
END$$

DELIMITER ;