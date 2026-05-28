DROP VIEW IF EXISTS  v_compra;
DELIMITER $
CREATE VIEW v_compra  AS 
SELECT
    compra.nro_factura
    , compra.fecha
    , proveedor.proveedor
    , compra.idcompra
    , compra.idproveedor
FROM
    compra
    INNER JOIN proveedor 
        ON (compra.idproveedor = proveedor.idproveedor) WHERE compra.estado="F";