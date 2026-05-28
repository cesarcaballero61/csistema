DROP VIEW EXISTS v_facturas;
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW v_facturas 
    AS
SELECT
    venta.nrofactura
    , venta.fecha
    , cliente.apellido
    , cliente.nombre
    , venta.idVenta
    , venta.idcliente
    , venta.total
FROM
    venta
    INNER JOIN cliente 
        ON (venta.idcliente = cliente.idcliente) WHERE venta.estado="F";