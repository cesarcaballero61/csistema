DROP VIEW IF EXISTS v_subgrupo;
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW V_subgrupo 
    AS
SELECT
    grupo.*
    , subgrupo.idsubgrupo
    , subgrupo.subgrupo
FROM
    subgrupo
     JOIN grupo 
       ON (subgrupo.idgrupo = grupo.idgrupo);