DROP PROCEDURE IF EXISTS recibo_contado;
DELIMITER $
CREATE PROCEDURE recibo_contado(cod_venta INT)
BEGIN
SELECT
    cliente.nombre AS nomb_cli
    , cliente.apellido AS ape_cli
    , cliente.ci AS ci_cli
    , cliente.ruc AS ruc_cli
    , personal.nombre AS nom_ven
    , personal.apellido AS ape_ven
    , personal.ci AS ci_ven
    , venta.total
    , empresa.ruc AS ruc_emp
    , empresa.timb_desde
    , empresa.timb_hasta
    , empresa.Timbrado
    , venta.idVenta AS nro_recibo
    , venta.nrofactura
    , venta.fecha
FROM
    db.venta
    INNER JOIN db.cliente 
        ON (venta.idcliente = cliente.idcliente)
    INNER JOIN db.vendedor 
        ON (venta.idVendedor = vendedor.idVendedor)
    INNER JOIN db.personal 
        ON (vendedor.idPersonal = personal.idPersonal)
    INNER JOIN db.empresa 
        ON (venta.idEmpresa = empresa.idEmpresa)
        WHERE venta.idVenta=cod_venta;
 END