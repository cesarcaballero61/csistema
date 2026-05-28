DROP VIEW IF EXISTS v_vendedores;
CREATE VIEW v_vendedores AS
SELECT 
    v.idVendedor,
    v.tipo_vendedor,
    p.idPersonal,
    p.nombre,
    p.apellido,
    CONCAT(TRIM(p.nombre), ' ', TRIM(p.apellido)) AS vendedor,
    p.ci,
    p.telefono,
    p.Direccion AS direccion,
    s.idsucursal,
    s.sucursal,
    e.empresa
FROM 
    vendedor v
    INNER JOIN personal p ON v.idPersonal = p.idPersonal
    INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa;