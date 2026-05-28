DROP PROCEDURE IF EXISTS cur_det_compra;

DELIMITER $

CREATE PROCEDURE cur_det_compra(
    IN p_cod_compra INT, 
    IN p_cod_proveedor INT
)
BEGIN
    SELECT
        a.codbarra,
        a.descripcion,
        dc.cantidad,
        dc.preciocosto AS precio,
        dc.preciocosto * dc.cantidad AS subtotal,
        dc.idarticulo,
        c.idsucursal,
        c.idEmpresa,
        c.iddeposito,
        c.nro_factura,
        c.estado,
        -- ✅ NUEVOS CAMPOS ADICIONALES
        c.fecha,
        c.total,
        c.total_gravadas_excenta,
        c.total_gravadas_cinco,
        c.total_gravadas_diez,
        c.liqui_iva_cinco,
        c.liqui_iva_diez,
        c.total_liqui_iva,
        p.proveedor,
        p.ruc AS ruc_proveedor,
        s.sucursal,
        e.empresa,
        d.deposito,
        a.impuesto,
        a.precio_costo AS precio_actual,
        a.ultima_fecha_compra,
        m.Marca,
        g.grupo,
        sg.subgrupo
    FROM detalle_compra dc
    INNER JOIN articulo a 
        ON dc.idarticulo = a.idarticulo
    INNER JOIN compra c 
        ON dc.idcompra = c.idcompra
    INNER JOIN proveedor p 
        ON c.idproveedor = p.idproveedor
    INNER JOIN sucursal s 
        ON c.idsucursal = s.idsucursal
    INNER JOIN empresa e 
        ON c.idEmpresa = e.idEmpresa
    INNER JOIN deposito d 
        ON c.iddeposito = d.iddeposito
    INNER JOIN marca m 
        ON a.idMarca = m.idMarca
    INNER JOIN grupo g 
        ON a.idgrupo = g.idgrupo
    INNER JOIN subgrupo sg 
        ON a.idsubgrupo = sg.idsubgrupo
    WHERE c.idcompra = p_cod_compra 
      AND c.idproveedor = p_cod_proveedor
      AND c.estado = 'F'
    ORDER BY a.descripcion;

END$

DELIMITER ;