
CREATE OR REPLACE VIEW v_usuarios AS
SELECT 
    u.idusuario,
    u.nick,
    u.tipo,
    u.clave,
    CASE 
        WHEN u.tipo = 1 THEN 'ADMINISTRADOR'
        WHEN u.tipo = 2 THEN 'VENDEDOR'
        WHEN u.tipo = 3 THEN 'COBRADOR'
        ELSE 'Desconocido'
    END AS tipo_descripcion,
    CONCAT(TRIM(p.nombre), ' ', TRIM(p.apellido)) AS nombre_completo,
    p.idpersonal,
    p.ci,
    p.telefono,
    p.Direccion,
    s.sucursal
FROM usuario u
INNER JOIN personal p ON u.idPersonal = p.idPersonal
INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
WHERE u.nick IS NOT NULL;