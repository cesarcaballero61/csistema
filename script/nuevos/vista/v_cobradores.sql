DROP VIEW IF EXISTS v_cobradores;
CREATE OR REPLACE VIEW v_cobradores AS
SELECT 
    cob.idcobrador,
    p.idPersonal,
    CONCAT(TRIM(p.nombre), ' ', TRIM(p.apellido)) AS nombre_completo,
    p.ci,
    p.telefono,
    z.idzona,
    z.zona,
    s.idsucursal,
    s.sucursal
    
FROM cobrador cob
INNER JOIN personal p ON cob.idPersonal = p.idPersonal
INNER JOIN zona z ON cob.idzona = z.idzona
INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
ORDER BY p.nombre, p.apellido;