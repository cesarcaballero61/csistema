DROP PROCEDURE IF EXISTS inf_resumen_venta_vendedor;
DELIMITER $
CREATE PROCEDURE inf_resumen_venta_vendedor(desde DATE ,hasta DATE,cod_sucursal INT)
BEGIN
SELECT
    personal.nombre
    , personal.apellido
    , personal.ci
    , COUNT(venta.nrofactura) AS cantidad
    , SUM(venta.total) AS total
	, calc_comision( SUM(venta.total) , vendedor.comision) AS comision
FROM
    venta
    INNER JOIN vendedor 
        ON (venta.idVendedor = vendedor.idVendedor)
    INNER JOIN personal 
        ON (vendedor.idPersonal = personal.idPersonal)
	WHERE venta.fecha>=desde AND venta.fecha<=hasta AND venta.idsucursal=cod_sucursal AND venta.estado="F"
	GROUP BY vendedor.idvendedor;
END