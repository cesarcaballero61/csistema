DROP VIEW IF EXISTS vOperacionesCaja;
DELIMITER $
CREATE
    /*[ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
    [DEFINER = { user | CURRENT_USER }]
    [SQL SECURITY { DEFINER | INVOKER }]*/
    VIEW vOperacionesCaja
    AS
SELECT
    mov_operacion.idMov
    , mov_operacion.fecha
    , mov_operacion.idEmpresa
    , empresa.empresa
    , mov_operacion.idsucursal
    , sucursal.sucursal
    , mov_operacion.idconcepto
    , concepto_caja.concepto
    , mov_operacion.descripcion
    , mov_operacion.monto
    , mov_operacion.tipo
FROM
    mov_operacion
    INNER JOIN concepto_caja 
        ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
    INNER JOIN empresa 
        ON (mov_operacion.idEmpresa = empresa.idEmpresa)
    INNER JOIN sucursal 
        ON (sucursal.idEmpresa = empresa.idEmpresa) AND (mov_operacion.idsucursal = sucursal.idsucursal)
ORDER BY mov_operacion.idMov DESC;