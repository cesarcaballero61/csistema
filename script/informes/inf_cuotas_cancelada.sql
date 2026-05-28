DROP PROCEDURE IF EXISTS  inf_cuotas_cancelada;
DELIMITER $
CREATE PROCEDURE inf_cuotas_cancelada(cod_suc INT,desde DATE, hasta DATE)
BEGIN
	IF cod_suc=0 THEN 
		SELECT
		    sucursal.sucursal
		    ,cliente.nombre
		    , cliente.apellido
		    , cliente.ci
		    , cliente.ruc
		    , cliente.celular
		    , cliente.telefono
		    , venta.nrofactura
		    , venta.fecha
		    , cuotas.fecha_cancela
		    , venta.total
		FROM
		    venta
		    INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		    INNER JOIN cuotas 
			ON (cuotas.idVenta = venta.idVenta) 
		    INNER JOIN sucursal
			ON (venta.idsucursal=sucursal.idsucursal)
			WHERE cuotas.ESTADO="CAN" AND cuotas.fecha_cancela>=desde AND cuotas.fecha_cancela<=hasta;
	ELSE
		SELECT
		    sucursal.sucursal
		    ,cliente.nombre
		    , cliente.apellido
		    , cliente.ci
		    , cliente.ruc
		    , cliente.celular
		    , cliente.telefono
		    , venta.nrofactura
		    , venta.fecha
		    , cuotas.fecha_cancela
		    , venta.total
		FROM
		    venta
		    INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		    INNER JOIN cuotas 
			ON (cuotas.idVenta = venta.idVenta) 
		    INNER JOIN sucursal
			ON (venta.idsucursal=sucursal.idsucursal)
			WHERE cuotas.ESTADO="CAN" AND cuotas.fecha_cancela>=desde AND cuotas.fecha_cancela<=hasta AND venta.idsucursal=cod_suc;	
	END IF;

END 