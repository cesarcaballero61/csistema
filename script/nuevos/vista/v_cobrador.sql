DROP VIEW IF EXISTS v_cobrador;
CREATE VIEW v_cobrador AS
SELECT 
    c.idcobrador,
    c.comision,
    c.idzona,
    c.con_objetivo,
    p.idPersonal,
    p.nombre,
    p.apellido,
    CONCAT(p.nombre, ' ', p.apellido) AS cobrador,
    p.ci,
    p.telefono,
    p.Direccion AS direccion,
    s.idsucursal,
    s.sucursal,
    e.idEmpresa,
    e.empresa,
    z.zona AS nombre_zona
FROM 
    cobrador c
    INNER JOIN personal p ON c.idPersonal = p.idPersonal
    INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
    INNER JOIN zona z ON c.idzona = z.idzona;