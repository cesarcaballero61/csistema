DROP VIEW IF EXISTS v_personal;
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW v_personal 
    AS
SELECT
    personal.*
    , sucursal.sucursal
FROM
    personal
    INNER JOIN sucursal 
        ON (personal.idsucursal = sucursal.idsucursal);