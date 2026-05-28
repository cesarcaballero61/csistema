DROP VIEW IF EXISTS v_deposito;
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW v_deposito 
    AS
SELECT
    deposito.*
    , sucursal.sucursal
FROM
    deposito
    INNER JOIN sucursal 
        ON (deposito.idsucursal = sucursal.idsucursal);