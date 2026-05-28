DELIMITER $$
DROP PROCEDURE IF EXISTS sp_reporte_ventas_detallado$$
CREATE PROCEDURE sp_reporte_ventas_detallado(
    IN p_fecha_ini DATE,
    IN p_fecha_fin DATE,
    IN p_idcliente INT,
    IN p_idvendedor INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- DATOS DE EMPRESA (YA ESTÁN INCLUIDOS)
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.telefono AS telefono_empresa,
        
        -- DATOS DE SUCURSAL
        s.sucursal AS nombre_sucursal,
        s.ciudad AS ciudad_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- DATOS DE VENTA
        v.idVenta,
        v.fecha,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS nro_factura_completo,
        v.tipo AS tipo_venta,
        -- Campo adicional para ordenamiento
        CASE 
            WHEN v.tipo = 'CON' THEN 1  -- Contado primero
            WHEN v.tipo = 'CRE' THEN 2  -- Crédito después
            ELSE 3
        END AS orden_tipo_venta,
        v.estado,
        v.total AS total_venta,

        -- DATOS DE CLIENTE
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(TRIM(c.nombre), ' ',TRIM(c.apellido)) AS cliente_completo,
        c.ci AS cliente_ci,
        c.ruc AS cliente_ruc,

        -- DATOS DE VENDEDOR
        ven.idvendedor,
        CONCAT(TRIM(p.nombre), ' ', TRIM(p.apellido)) AS vendedor_nombre,

        -- DATOS DE PRODUCTO
        a.codbarra,
        a.descripcion AS producto,
        dv.cantidad,
        dv.precosto AS precio_costo,
        dv.preventa AS precio_venta,
        dv.subtotal,
        
        -- CÁLCULO DE UTILIDAD
        (dv.preventa - dv.precosto) AS utilidad_bruta,
        ROUND(((dv.preventa - dv.precosto) / NULLIF(dv.precosto, 0)) * 100, 2) AS margen_utilidad_porcentaje,
        (dv.subtotal - (dv.precosto * dv.cantidad)) AS utilidad_total_linea,
        
        -- DATOS DE FINANCIAMIENTO
        dv.tipo_cuota,
        dv.plan_cuota,
        dv.cant_cuota,
        dv.monto_cuota,
        dv.interes_mensual

    FROM venta v
    JOIN cliente c ON v.idcliente = c.idcliente
    JOIN vendedor ven ON v.idVendedor = ven.idVendedor
    JOIN personal p ON ven.idPersonal = p.idPersonal
    JOIN sucursal s ON v.idsucursal = s.idsucursal
    JOIN empresa e ON s.idEmpresa = e.idEmpresa 
    JOIN detalle_venta dv ON v.idVenta = dv.idVenta
    JOIN articulo a ON dv.idarticulo = a.idarticulo
    WHERE v.fecha BETWEEN p_fecha_ini AND p_fecha_fin
      AND (p_idcliente = 0 OR v.idcliente = p_idcliente)
      AND (p_idvendedor = 0 OR v.idVendedor = p_idvendedor)
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal)
    ORDER BY  
	    orden_tipo_venta ASC,
	    v.fecha,
	    v.idVenta, 
	    dv.idDetalle, 
	    v.tipo;
END$$

DELIMITER ;