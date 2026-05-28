DROP VIEW IF EXISTS v_clientes;
CREATE VIEW v_clientes AS
SELECT 
    c.idcliente,
    c.nombre,
    c.apellido,
    CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    c.ci,
    c.ruc,
    c.celular,
    c.telefono,
    c.idzona,
    z.zona,
    c.idbarrio,
    b.barrio,
    c.idprofesion,
    p.profesion,
    c.referencia,
    c.trabajo_lugar,
    c.trabajo_telefono,
    c.ref1,
    c.ref2,
    c.ref3,
    c.reftel1,
    c.reftel2,
    c.reftel3,
    CONCAT(TRIM(b.barrio), ' - ', TRIM(z.zona)) AS ubicacion_completa,
    c.foto
    
FROM 
    cliente c
    LEFT JOIN zona z ON c.idzona = z.idzona
    LEFT JOIN barrio b ON c.idbarrio = b.idbarrio
    LEFT JOIN profesion p ON c.idprofesion = p.idprofesion;