DROP VIEW IF EXISTS v_parametro;
DELIMITER $
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW v_parametro 
    AS
SELECT
    parametro_sistema.*
    , sucursal.sucursal
FROM
    parametro_sistema
    LEFT JOIN sucursal 
        ON (parametro_sistema.idsucursal = sucursal.idsucursal);