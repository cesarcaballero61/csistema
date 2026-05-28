DROP PROCEDURE IF EXISTS info_utilidad_venta_articulo;
DELIMITER $

CREATE PROCEDURE info_utilidad_venta_articulo(cod_art INT ,cod_tipo INT,desde DATE ,hasta DATE)

BEGIN
IF cod_art=0 THEN	
	IF cod_tipo=0 THEN -- todos los tipo de venta.
		SELECT
		venta.idVenta
		, venta.nrofactura
		, venta.fecha
		, venta.tipo
		, venta.hora
		, articulo.codbarra
		, articulo.descripcion
		, detalle_venta.idarticulo
		, detalle_venta.cantidad
		, detalle_venta.precosto
		, detalle_venta.preventa
		, detalle_venta.subtotal AS subpreventa
		, @subprecosto := (detalle_venta.precosto * detalle_venta.cantidad) AS subprecosto
		, detalle_venta.subtotal - @subprecosto AS utilidad
		, cliente.apellido
		, cliente.nombre
		, cliente.ci
		, cliente.ruc
		, cliente.telefono
		FROM
		detalle_venta
		INNER JOIN venta 
			ON (detalle_venta.idVenta = venta.idVenta)
		INNER JOIN articulo 
			ON (detalle_venta.idarticulo = articulo.idarticulo)
		INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		WHERE venta.fecha>=desde 
		AND venta.fecha<=hasta
		ORDER BY venta.idVenta ASC;
	ELSE
		SELECT
		venta.idVenta
		, venta.nrofactura
		, venta.fecha
		, venta.tipo
		, venta.hora
		, articulo.codbarra
		, articulo.descripcion
		, detalle_venta.idarticulo
		, detalle_venta.cantidad
		, detalle_venta.precosto
		, detalle_venta.preventa
		, detalle_venta.subtotal AS subpreventa
		, @subprecosto := (detalle_venta.precosto * detalle_venta.cantidad) AS subprecosto
		, detalle_venta.subtotal - @subprecosto AS utilidad
		, cliente.apellido
		, cliente.nombre
		, cliente.ci
		, cliente.ruc
		, cliente.telefono
		FROM
		detalle_venta
		INNER JOIN venta 
			ON (detalle_venta.idVenta = venta.idVenta)
		INNER JOIN articulo 
			ON (detalle_venta.idarticulo = articulo.idarticulo)
		INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		WHERE venta.fecha>=desde 
		AND venta.fecha<=hasta 
		AND venta.tipo = cod_tipo
		ORDER BY venta.idVenta ASC;			
	END IF;
ELSE
	IF cod_tipo=0 THEN -- todos los tipo de venta.
		SELECT
		venta.idVenta
		, venta.nrofactura
		, venta.fecha
		, venta.tipo
		, venta.hora
		, articulo.codbarra
		, articulo.descripcion
		, detalle_venta.idarticulo
		, detalle_venta.cantidad
		, detalle_venta.precosto
		, detalle_venta.preventa
		, detalle_venta.subtotal AS subpreventa
		, @subprecosto := (detalle_venta.precosto * detalle_venta.cantidad) AS subprecosto
		, detalle_venta.subtotal - @subprecosto AS utilidad
		, cliente.apellido
		, cliente.nombre
		, cliente.ci
		, cliente.ruc
		, cliente.telefono
		FROM
		detalle_venta
		INNER JOIN venta 
			ON (detalle_venta.idVenta = venta.idVenta)
		INNER JOIN articulo 
			ON (detalle_venta.idarticulo = articulo.idarticulo)
		INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		WHERE venta.fecha>=desde 
		AND venta.fecha<=hasta 
		AND detalle_venta.idarticulo = cod_art 
		ORDER BY venta.idVenta ASC;
	ELSE
		SELECT
		venta.idVenta
		, venta.nrofactura
		, venta.fecha
		, venta.tipo
		, venta.hora
		, articulo.codbarra
		, articulo.descripcion
		, detalle_venta.idarticulo
		, detalle_venta.cantidad
		, detalle_venta.precosto
		, detalle_venta.preventa
		, detalle_venta.subtotal AS subpreventa
		, @subprecosto := (detalle_venta.precosto * detalle_venta.cantidad) AS subprecosto
		, detalle_venta.subtotal - @subprecosto AS utilidad
		, cliente.apellido
		, cliente.nombre
		, cliente.ci
		, cliente.ruc
		, cliente.telefono
		FROM
		detalle_venta
		INNER JOIN venta 
			ON (detalle_venta.idVenta = venta.idVenta)
		INNER JOIN articulo 
			ON (detalle_venta.idarticulo = articulo.idarticulo)
		INNER JOIN cliente 
			ON (venta.idcliente = cliente.idcliente)
		WHERE venta.fecha>=desde 
		AND venta.fecha<=hasta 
		AND detalle_venta.idarticulo = cod_art 
		AND venta.tipo = cod_tipo
		ORDER BY venta.idVenta ASC;
	END IF;
end if;

END