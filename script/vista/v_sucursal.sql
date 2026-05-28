DROP VIEW IF EXISTS  v_sucursal;
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW v_sucursal 
    AS

SELECT
    sucursal.*
    , empresa.empresa
FROM
    sucursal
    INNER JOIN empresa 
        ON (sucursal.idEmpresa = empresa.idEmpresa);