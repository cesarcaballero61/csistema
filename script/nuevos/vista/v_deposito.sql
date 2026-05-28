DROP VIEW IF EXISTS v_deposito;
CREATE VIEW v_deposito AS
SELECT 
    d.iddeposito,
    d.deposito,
    d.idsucursal,
    s.sucursal,
    e.idEmpresa,
    e.empresa
FROM 
    deposito d
    INNER JOIN sucursal s ON d.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa;