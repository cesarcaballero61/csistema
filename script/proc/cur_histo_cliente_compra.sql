DROP PROCEDURE IF EXISTS cur_histo_cliente_compra;
DELIMITER $
CREATE PROCEDURE cur_histo_cliente_compra(desde DATE, hasta DATE, cod_suc INT, cod_cli INT)
BEGIN
IF cod_suc=0 THEN -- todas las sucursales
	IF cod_cli=0 THEN -- todos los clientes.
		SELECT
			venta.nrofactura
			, venta.fecha
			, IF(venta.tipo=1,"CON","CRE") AS Tipo
			, venta.total
			, cliente.idcliente
			, cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.ruc
			, sucursal.sucursal
		FROM
			db.venta
			INNER JOIN db.cliente 
				ON (venta.idcliente = cliente.idcliente) 
			INNER JOIN db.sucursal
				ON(venta.idsucursal=sucursal.idsucursal)
			WHERE venta.estado="F" AND venta.fecha>=desde AND venta.fecha<=hasta;
	ELSE
		SELECT
			venta.nrofactura
			, venta.fecha
			, IF(venta.tipo=1,"CON","CRE") AS Tipo
			, venta.total
			, cliente.idcliente
			, cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.ruc
			, sucursal.sucursal
		FROM
			db.venta
			INNER JOIN db.cliente 
				ON (venta.idcliente = cliente.idcliente) 
			INNER JOIN db.sucursal
				ON(venta.idsucursal=sucursal.idsucursal)
			WHERE venta.estado="F" AND venta.fecha>=desde AND venta.fecha<=hasta AND venta.idcliente=cod_cli;
	END IF;
ELSE	
	IF cod_cli=0 THEN -- todos los clientes.
		SELECT
			venta.nrofactura
			, venta.fecha
			, IF(venta.tipo=1,"CON","CRE") AS Tipo
			, venta.total
			, cliente.idcliente
			, cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.ruc
			, sucursal.sucursal
		FROM
			db.venta
			INNER JOIN db.cliente 
				ON (venta.idcliente = cliente.idcliente) 
			INNER JOIN db.sucursal
				ON(venta.idsucursal=sucursal.idsucursal)
			WHERE venta.estado="F" AND venta.fecha>=desde AND venta.fecha<=hasta AND venta.idsucursal=cod_suc;
	ELSE
		SELECT
			venta.nrofactura
			, venta.fecha
			, IF(venta.tipo=1,"CON","CRE") AS Tipo
			, venta.total
			, cliente.idcliente
			, cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.ruc
			, sucursal.sucursal
		FROM
			db.venta
			INNER JOIN db.cliente 
				ON (venta.idcliente = cliente.idcliente) 
			INNER JOIN db.sucursal
				ON(venta.idsucursal=sucursal.idsucursal)
			WHERE venta.estado="F" AND venta.fecha>=desde AND venta.fecha<=hasta AND venta.idcliente=cod_cli AND venta.idsucursal=cod_suc;
	END IF;
END IF;

END