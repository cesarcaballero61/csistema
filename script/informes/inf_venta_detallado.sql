DROP PROCEDURE IF EXISTS inf_venta_detalle;
DELIMITER $
CREATE PROCEDURE inf_venta_detalle(desde DATE ,hasta DATE ,n_tipo_venta INT,n_cod_vendedor INT,n_cod_sucursal INT)

BEGIN
IF n_tipo_venta=1 THEN-- ambos
	IF n_cod_sucursal=0 THEN-- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F";
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, detalle_venta.subtotal
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idvendedor=n_cod_vendedor;
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idsucursal=n_cod_sucursal;
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
			WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idvendedor=n_cod_vendedor AND venta.idsucursal=n_cod_sucursal;
		END IF;
	END IF;


ELSEIF n_tipo_venta=2 THEN-- contado
	IF n_cod_sucursal=0  THEN-- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1;
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1 AND venta.idvendedor=n_cod_vendedor;
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1  AND venta.idsucursal=n_cod_sucursal;
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1  AND venta.idsucursal=n_cod_sucursal AND venta.idvendedore=n_cod_vendedor;
		END IF;
	END IF;

ELSEIF n_tipo_venta=3 THEN -- credito
	IF n_cod_sucursal=0 THEN -- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2;
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idvendedor=n_cod_vendedor;
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idsucursal=n_cod_sucursal;
		ELSE
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				, sucursal.sucursal
				, CONCAT(personal.nombre," ",personal.apellido) AS vendedor
				, articulo.descripcion AS articulo
				, detalle_venta.cantidad
				, detalle_venta.preventa
				, detalle_venta.iva
				, detalle_venta.subtotal
				, venta.liqui_iva_5 AS liq_5
				, venta.liqui_iva_10 AS liq_10
			FROM
				venta
				 JOIN sucursal 
					ON (venta.idsucursal = sucursal.idsucursal)
				 JOIN cliente 
					ON (venta.idcliente = cliente.idcliente)
				 JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				 JOIN personal 
					ON  (vendedor.idPersonal = personal.idPersonal)
				 JOIN detalle_venta
					ON (venta.idventa=detalle_venta.idventa)
				 JOIN articulo
					ON (detalle_venta.idarticulo=articulo.idarticulo)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idvendedor=n_cod_vendedor AND venta.idsucursal=n_cod_sucursal;
		END IF;
	END IF;
END IF;
END