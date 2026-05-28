DELIMITER $$

DROP PROCEDURE IF EXISTS sp_informe_compras_detallado$$

CREATE PROCEDURE sp_informe_compras_detallado(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idproveedor INT
)
BEGIN
    SELECT 
        -- Datos de la empresa
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        
        -- Datos de la sucursal
        s.sucursal AS nombre_sucursal,
        s.ciudad AS ciudad_sucursal,
        s.direccion AS direccion_sucursal,
        
        -- Datos de la compra
        c.idcompra,
        c.fecha AS fecha_compra,
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura) AS nro_factura,
        
        -- Datos del proveedor
        P.idproveedor,
        p.proveedor AS nombre_proveedor,
        p.ruc AS ruc_proveedor,
        p.telefono AS telefono_proveedor,
        
        -- Tipo y estado
        c.tipo,
        CASE 
            WHEN c.tipo = 'CONTADO' THEN 'CONTADO'
            WHEN c.tipo = 'CREDITO' THEN 'CRÉDITO'
            ELSE c.tipo
        END AS tipo_compra,
        c.estado AS estado_compra,
        
        -- Datos del depósito
        d.deposito AS nombre_deposito,
        
        -- Datos del artículo
        a.descripcion AS articulo,
        a.codbarra,
        m.Marca AS marca,
        g.grupo AS grupo_articulo,
        sg.subgrupo AS subgrupo_articulo,
        
        -- Cantidades y precios
        cd.cantidad,
        cd.precio_costo,
        cd.subtotal,
        
        -- Impuestos
        CASE 
            WHEN cd.iva = '0' THEN 'Exenta'
            WHEN cd.iva = '5' THEN '5%'
            WHEN cd.iva = '10' THEN '10%'
            ELSE cd.iva
        END AS iva,
        cd.gravada_excenta,
        cd.gravada_cinco,
        cd.gravada_diez,
        
        -- Totales de la compra
        c.total AS total_compra,
        c.liqui_iva_cinco,
        c.liqui_iva_diez,
        c.total_liqui_iva,
        
        -- Información adicional
        c.fecha_vto AS fecha_vencimiento,
        c.plazo AS dias_plazo,
        
        -- Usuario que registró
        u.nick AS usuario_registro,
        CONCAT(TRIM(pe.nombre), ' ', TRIM(pe.apellido)) AS personal_registro
        
    FROM compra c
    INNER JOIN compra_detalle cd ON c.idcompra = cd.idcompra
    INNER JOIN articulo a ON cd.idarticulo = a.idarticulo
    INNER JOIN marca m ON a.idMarca = m.idMarca
    INNER JOIN grupo g ON a.idgrupo = g.idgrupo
    INNER JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    INNER JOIN deposito d ON c.iddeposito = d.iddeposito
    INNER JOIN sucursal s ON c.idsucursal = s.idsucursal
    INNER JOIN empresa e ON c.idEmpresa = e.idEmpresa
    LEFT JOIN usuario u ON c.idusuario = u.idusuario
    LEFT JOIN personal pe ON u.idPersonal = pe.idPersonal
    
    WHERE c.fecha BETWEEN p_fecha_desde AND p_fecha_hasta
      AND c.estado != 'ANULADO'
      AND (p_idproveedor = 0 OR c.idproveedor = p_idproveedor)
    
    ORDER BY c.fecha DESC, c.idcompra DESC, a.descripcion;
    
END$$

DELIMITER ;