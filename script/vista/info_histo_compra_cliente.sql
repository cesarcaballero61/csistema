DROP PROCEDURE IF EXISTS info_histo_compra_cliente;
DELIMITER $
CREATE PROCEDURE info_histo_compra_cliente(cap_desde DATE,cap_hasta DATE,cap_cod_cliente INT,cap_chkfecha_Desde INT)
BEGIN
	IF cap_chkfecha_Desde=0 THEN
		IF cap_cod_cliente=0 THEN
			SELECT
			    venta.idVenta
			    , venta.fecha
			    , venta.nrofactura
			    , venta.tipo
				, cliente.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , articulo.codbarra
			    , zona.zona
			    , barrio.barrio
			    , articulo.descripcion
			    , detalle_venta.cantidad
			    , detalle_venta.subtotal
			FROM
			    venta
			    INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			    INNER JOIN detalle_venta 
				ON (detalle_venta.idVenta = venta.idVenta)
			    INNER JOIN articulo 
				ON (articulo.idarticulo = detalle_venta.idarticulo)
			    INNER JOIN zona
				ON(zona.idzona=cliente.idzona)
			    INNER JOIN barrio
				ON(barrio.idbarrio=cliente.idbarrio)
				WHERE venta.fecha>=cap_desde  AND venta.fecha<=cap_hasta  AND venta.estado="F";
				
		ELSE
			SELECT
			    venta.idVenta
			    , venta.fecha
			    , venta.nrofactura
			    , venta.tipo
				, cliente.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , articulo.codbarra
			    , zona.zona
			    , barrio.barrio
			    , articulo.descripcion
			    , detalle_venta.cantidad
			    , detalle_venta.subtotal
			FROM
			    venta
			    INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			    INNER JOIN detalle_venta 
				ON (detalle_venta.idVenta = venta.idVenta)
			    INNER JOIN articulo 
				ON (articulo.idarticulo = detalle_venta.idarticulo)
			    INNER JOIN zona
				ON(zona.idzona=cliente.idzona)
			    INNER JOIN barrio
				ON(barrio.idbarrio=cliente.idbarrio)
				WHERE venta.fecha>=cap_desde  AND venta.fecha<=cap_hasta AND cliente.idcliente=cap_cod_cliente  AND venta.estado="F";
		END IF;
	ELSE
		IF cap_cod_cliente=0 THEN 
			SELECT
			    venta.idVenta
			    , venta.fecha
			    , venta.nrofactura
			    , venta.tipo
				, cliente.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , articulo.codbarra
			    , zona.zona
			    , barrio.barrio
			    , articulo.descripcion
			    , detalle_venta.cantidad
			    , detalle_venta.subtotal
			FROM
			    venta
			    INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			    INNER JOIN detalle_venta 
				ON (detalle_venta.idVenta = venta.idVenta)
			    INNER JOIN articulo 
				ON (articulo.idarticulo = detalle_venta.idarticulo)
			    INNER JOIN zona
				ON(zona.idzona=cliente.idzona)
			    INNER JOIN barrio
				ON(barrio.idbarrio=cliente.idbarrio)
				WHERE  venta.fecha<=cap_hasta AND venta.estado="F";
				
		ELSE
			SELECT
			    venta.idVenta
			    , venta.fecha
			    , venta.nrofactura
			    , venta.tipo
				, cliente.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , articulo.codbarra
			    , zona.zona
			    , barrio.barrio
			    , articulo.descripcion
			    , detalle_venta.cantidad
			    , detalle_venta.subtotal
			FROM
			    venta
			    INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			    INNER JOIN detalle_venta 
				ON (detalle_venta.idVenta = venta.idVenta)
			    INNER JOIN articulo 
				ON (articulo.idarticulo = detalle_venta.idarticulo)
			    INNER JOIN zona
				ON(zona.idzona=cliente.idzona)
			    INNER JOIN barrio
				ON(barrio.idbarrio=cliente.idbarrio)
				WHERE   venta.fecha<=cap_hasta AND cliente.idcliente=cap_cod_cliente  AND venta.estado="F";
		END IF;	
	END IF;
END