DELIMITER $$

DROP PROCEDURE IF EXISTS sp_consultar_venta$$

CREATE PROCEDURE sp_consultar_venta(
    IN p_idventa INT
)
BEGIN
    SELECT 
        -- Información de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal AS nombre_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Información del timbrado
        cnt.timbrado,
        cnt.timb_desde,
        cnt.timb_hasta,
        cnt.establecimiento,
        cnt.nro_expedicion,
        
        -- Información de la venta
        v.idVenta,
        v.fecha AS fecha_venta,
        v.hora AS hora_venta,
        v.tipo AS tipo_venta,
        CASE v.tipo 
            WHEN 'CON' THEN 'CONTADO' 
            WHEN 'CRE' THEN 'CRÉDITO' 
        END AS tipo_venta_descripcion,
        v.nrosuc,
        v.nroexp,
        v.nrofactura,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.estado AS estado_venta,
        CASE v.estado 
            WHEN 'F' THEN 'FACTURADO' 
            WHEN 'A' THEN 'ANULADO' 
        END AS estado_venta_descripcion,
        
        -- Totales de la venta
        v.total_gravada_excenta,
        v.total_gravada_cinco,
        v.total_gravada_diez,
        v.total AS total_venta,
        v.liqui_iva_5,
        v.liqui_iva_10,
        v.total_liqui_iva,
        
        -- Información del cliente
        c.idcliente,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        COALESCE(c.ruc, c.ci) AS documento_cliente,
        c.ci AS cedula_cliente,
        c.ruc AS ruc_cliente,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información del vendedor
        ven.idVendedor,
        CONCAT(TRIM(pv.nombre), ' ', TRIM(pv.apellido)) AS vendedor_nombre,
        
        -- Información del detalle de venta
        dv.idDetalle,
        dv.cantidad,
        a.idarticulo,
        a.descripcion AS descripcion_articulo,
        a.codbarra AS codigo_barras,
        dv.precosto AS precio_costo,
        dv.preventa AS precio_venta,
        dv.subtotal,
        dv.iva AS iva_porcentaje,
        CASE dv.iva 
            WHEN '0' THEN 'EXENTA' 
            WHEN '5' THEN '5%' 
            WHEN '10' THEN '10%' 
        END AS iva_descripcion,
        dv.gravada_excenta,
        dv.gravada_cinco,
        dv.gravada_diez,
        dv.tipo_cuota,
        dv.plan_cuota,
        dv.cant_cuota,
        dv.monto_cuota,
        
        -- Información del artículo
        m.Marca AS marca_articulo,
        g.grupo AS grupo_articulo,
        sg.subgrupo AS subgrupo_articulo,
        a.unidad,
        
        -- Cálculos por línea
        (dv.cantidad * dv.preventa) AS total_linea,
        ROUND(((dv.preventa - dv.precosto) / dv.precosto * 100), 2) AS margen_porcentaje
        
    FROM venta v
    INNER JOIN detalle_venta dv ON v.idVenta = dv.idVenta
    INNER JOIN cliente c ON v.idcliente = c.idcliente
    INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN vendedor ven ON v.idVendedor = ven.idVendedor
    INNER JOIN personal pv ON ven.idPersonal = pv.idPersonal
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    LEFT JOIN marca m ON a.idMarca = m.idMarca
    LEFT JOIN grupo g ON a.idgrupo = g.idgrupo
    LEFT JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    LEFT JOIN control_numeracion_timbrado cnt ON (
        s.idsucursal = cnt.idsucursal 
        AND cnt.establecimiento = v.nrosuc
        AND cnt.nro_expedicion =v.nroexp
        AND cnt.tipo_documento = 'FACTURA'
        AND cnt.activo = 1
    )
    WHERE v.idVenta = p_idventa
    ORDER BY dv.idDetalle;
    
END$$

DELIMITER ;