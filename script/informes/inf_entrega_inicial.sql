DROP PROCEDURE IF EXISTS inf_entrega_inicial;
DELIMITER $
CREATE PROCEDURE inf_entrega_inicial(cod_suc INT , desde DATE, hasta DATE)
BEGIN
	IF cod_suc=0 THEN
		SELECT
			sucursal.sucursal
		    ,cuotas.entrega_inicial
		    , venta.nrofactura
		    , venta.fecha
		    , cliente.nombre
		    , cliente.apellido
		    , cliente.ci
		    , zona.zona
		    , barrio.barrio
		FROM
		    venta
		    INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		    INNER JOIN cuotas 
			ON (cuotas.idVenta = venta.idVenta)
		    INNER JOIN sucursal 
			ON (venta.idsucursal = sucursal.idsucursal)
		    INNER JOIN zona 
			ON (cliente.idzona = zona.idzona)
		    INNER JOIN barrio 
			ON (cliente.idbarrio = barrio.idbarrio) 
			WHERE venta.estado ="F" AND cuotas.entrega_inicial>0 AND venta.fecha>=desde AND venta.fecha<=hasta;
	ELSE
		SELECT
			sucursal.sucursal
		    ,cuotas.entrega_inicial
		    , venta.nrofactura
		    , venta.fecha
		    , cliente.nombre
		    , cliente.apellido
		    , cliente.ci
		    , zona.zona
		    , barrio.barrio
		FROM
		    venta
		    INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		    INNER JOIN cuotas 
			ON (cuotas.idVenta = venta.idVenta)
		    INNER JOIN sucursal 
			ON (venta.idsucursal = sucursal.idsucursal)
		    INNER JOIN zona 
			ON (cliente.idzona = zona.idzona)
		    INNER JOIN barrio 
			ON (cliente.idbarrio = barrio.idbarrio) 
			WHERE venta.estado ="F" AND cuotas.entrega_inicial>0 AND venta.idsucursal=cod_suc AND venta.fecha>=desde AND venta.fecha<=hasta;
	END IF ;
END 