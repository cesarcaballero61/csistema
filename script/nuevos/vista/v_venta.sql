DROP VIEW IF EXISTS v_venta;
CREATE OR REPLACE VIEW v_venta AS
SELECT 
    v.idVenta AS idVenta,
    v.fecha AS fecha,
    -- Tipo de venta en texto
    CASE 
        WHEN v.tipo = 'CON' THEN 'CONTADO'
        WHEN v.tipo = 'CRE' THEN 'CRÉDITO'
        ELSE v.tipo
    END AS tipo_venta_descripcion,
    -- Mantener el código original también por si acaso
    v.tipo AS tipo_venta,
    c.ci,
    c.apellido AS apellido,
    c.nombre AS nombre,
    CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS nro_factura,
    c.idcliente AS idcliente,
    v.total AS total_venta,
    -- Vendedor
    CONCAT(p_vend.nombre, ' ', p_vend.apellido) AS vendedor_nombre,
    -- Cobrador (LEFT JOIN porque puede ser NULL)
    CONCAT(p_cob.nombre, ' ', p_cob.apellido) AS cobrador_nombre
FROM venta v
JOIN cliente c ON v.idcliente = c.idcliente
-- Información del vendedor
JOIN vendedor vend ON v.idVendedor = vend.idVendedor
JOIN personal p_vend ON vend.idPersonal = p_vend.idPersonal
-- Información del cobrador (puede ser NULL)
LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
LEFT JOIN personal p_cob ON cob.idPersonal = p_cob.idPersonal
WHERE v.estado = 'F';