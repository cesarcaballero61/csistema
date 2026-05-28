DROP PROCEDURE IF EXISTS inf_resumen_venta_zona;
DELIMITER $
CREATE PROCEDURE inf_resumen_venta_zona(desde DATE ,hasta DATE,cod_sucursal INT)
BEGIN
	SELECT
		venta.nrofactura
		, SUM(venta.total) AS total
		, zona.zona
		, zona.idzona
		 , COUNT(venta.idVenta) AS cant_venta
	FROM
		venta
		INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		INNER JOIN zona 
			ON (cliente.idzona = zona.idzona)
	WHERE venta.fecha>=desde AND venta.fecha<=hasta AND venta.idsucursal=cod_sucursal AND venta.estado="F"
	GROUP BY zona.idzona;
END