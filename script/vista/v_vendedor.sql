DROP VIEW IF EXISTS v_vendedores_simple;
CREATE OR REPLACE VIEW v_vendedor AS
SELECT 
    v.idVendedor,
    v.idPersonal,
    v.tipo_vendedor,
    p.nombre,
    p.apellido,
    CONCAT(p.nombre, ' ', p.apellido) AS vendedor,
    p.ci,
    p.telefono,
    p.Direccion,
    s.idsucursal,
    s.sucursal,
    
    -- Estado activo/inactivo
    CASE 
        WHEN p.idPersonal IS NOT NULL THEN 'ACTIVO'
        ELSE 'INACTIVO'
    END AS estado

FROM vendedor v
INNER JOIN personal p ON v.idPersonal = p.idPersonal
INNER JOIN sucursal s ON p.idsucursal = s.idsucursal

ORDER BY p.nombre, p.apellido;