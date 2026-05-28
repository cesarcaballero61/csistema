DROP PROCEDURE IF EXISTS inf_resumen_venta_articulo;
DELIMITER $
CREATE PROCEDURE inf_resumen_venta_articulo(desde DATE ,hasta DATE ,n_tipo_venta INT,n_cod_vendedor INT,n_cod_sucursal INT)

BEGIN
IF n_tipo_venta=1 THEN-- ambos
	IF n_cod_sucursal=0 THEN-- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F"
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
		ELSE
			SELECT
				sucursal.sucursal
				, detalle_venta.idarticulo
				, articulo.descripcion
				, SUM(detalle_venta.cantidad) AS Total_Cantidad
				, detalle_venta.preventa AS precio_venta
				, SUM(detalle_venta.subtotal) AS total_venta
				, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
				, vendedor.comision
				,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
			FROM
				detalle_venta
				INNER JOIN venta 
					ON (detalle_venta.idVenta = venta.idVenta)
				INNER JOIN sucursal 
					ON (sucursal.idsucursal=venta.idsucursal)
				INNER JOIN articulo 
					ON (articulo.idarticulo = detalle_venta.idarticulo)
				INNER JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				INNER JOIN personal 
					ON (vendedor.idPersonal = personal.idPersonal)
			WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idvendedor=n_cod_vendedor
			GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;			
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idsucursal=n_cod_sucursal
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;

		ELSE
			SELECT
				sucursal.sucursal
				, detalle_venta.idarticulo
				, articulo.descripcion
				, SUM(detalle_venta.cantidad) AS Total_Cantidad
				, detalle_venta.preventa AS precio_venta
				, SUM(detalle_venta.subtotal) AS total_venta
				, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
				, vendedor.comision
				,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
			FROM
				detalle_venta
				INNER JOIN venta 
					ON (detalle_venta.idVenta = venta.idVenta)
				INNER JOIN sucursal 
					ON (sucursal.idsucursal=venta.idsucursal)
				INNER JOIN articulo 
					ON (articulo.idarticulo = detalle_venta.idarticulo)
				INNER JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				INNER JOIN personal 
					ON (vendedor.idPersonal = personal.idPersonal)
			WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.idvendedor=n_cod_vendedor AND venta.idsucursal=n_cod_sucursal
			GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
			
		END IF;
	END IF;


ELSEIF n_tipo_venta=2 THEN-- contado
	IF n_cod_sucursal=0  THEN-- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;

		ELSE
				SELECT
					sucursal.sucursal
					, detalle_venta.idarticulo
					, articulo.descripcion
					, SUM(detalle_venta.cantidad) AS Total_Cantidad
					, detalle_venta.preventa AS precio_venta
					, SUM(detalle_venta.subtotal) AS total_venta
					, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
					, vendedor.comision
					,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
				FROM
					detalle_venta
					INNER JOIN venta 
						ON (detalle_venta.idVenta = venta.idVenta)
					INNER JOIN sucursal 
						ON (sucursal.idsucursal=venta.idsucursal)
					INNER JOIN articulo 
						ON (articulo.idarticulo = detalle_venta.idarticulo)
					INNER JOIN vendedor 
						ON (venta.idVendedor = vendedor.idVendedor)
					INNER JOIN personal 
						ON (vendedor.idPersonal = personal.idPersonal)
				WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1 AND venta.idvendedor=n_cod_vendedor
				GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1  AND venta.idsucursal=n_cod_sucursal
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		ELSE
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=1  AND venta.idsucursal=n_cod_sucursal AND venta.idvendedore=n_cod_vendedor
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		END IF;
	END IF;

ELSEIF n_tipo_venta=3 THEN -- credito
	IF n_cod_sucursal=0 THEN -- todas las sucursales
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
			SELECT
				sucursal.sucursal
				, detalle_venta.idarticulo
				, articulo.descripcion
				, SUM(detalle_venta.cantidad) AS Total_Cantidad
				, detalle_venta.preventa AS precio_venta
				, SUM(detalle_venta.subtotal) AS total_venta
				, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
				, vendedor.comision
				,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
			FROM
				detalle_venta
				INNER JOIN venta 
					ON (detalle_venta.idVenta = venta.idVenta)
				INNER JOIN sucursal 
					ON (sucursal.idsucursal=venta.idsucursal)
				INNER JOIN articulo 
					ON (articulo.idarticulo = detalle_venta.idarticulo)
				INNER JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				INNER JOIN personal 
					ON (vendedor.idPersonal = personal.idPersonal)
			WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2
			GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		ELSE
			SELECT
				sucursal.sucursal
				, detalle_venta.idarticulo
				, articulo.descripcion
				, SUM(detalle_venta.cantidad) AS Total_Cantidad
				, detalle_venta.preventa AS precio_venta
				, SUM(detalle_venta.subtotal) AS total_venta
				, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
				, vendedor.comision
				,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
			FROM
				detalle_venta
				INNER JOIN venta 
					ON (detalle_venta.idVenta = venta.idVenta)
				INNER JOIN sucursal 
					ON (sucursal.idsucursal=venta.idsucursal)
				INNER JOIN articulo 
					ON (articulo.idarticulo = detalle_venta.idarticulo)
				INNER JOIN vendedor 
					ON (venta.idVendedor = vendedor.idVendedor)
				INNER JOIN personal 
					ON (vendedor.idPersonal = personal.idPersonal)
			WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idvendedor=n_cod_vendedor
			GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		END IF;
	ELSE
		IF n_cod_vendedor=0 THEN -- todos los vendedores.
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idsucursal=n_cod_sucursal
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		ELSE
					SELECT
						sucursal.sucursal
						, detalle_venta.idarticulo
						, articulo.descripcion
						, SUM(detalle_venta.cantidad) AS Total_Cantidad
						, detalle_venta.preventa AS precio_venta
						, SUM(detalle_venta.subtotal) AS total_venta
						, CONCAT(personal.nombre,", ", personal.apellido) AS vendedor
						, vendedor.comision
						,calc_comision(SUM(detalle_venta.preventa),vendedor.comision) AS total_comision
					FROM
						detalle_venta
						INNER JOIN venta 
							ON (detalle_venta.idVenta = venta.idVenta)
						INNER JOIN sucursal 
							ON (sucursal.idsucursal=venta.idsucursal)
						INNER JOIN articulo 
							ON (articulo.idarticulo = detalle_venta.idarticulo)
						INNER JOIN vendedor 
							ON (venta.idVendedor = vendedor.idVendedor)
						INNER JOIN personal 
							ON (vendedor.idPersonal = personal.idPersonal)
					WHERE (venta.fecha>=desde AND venta.fecha<=hasta) AND venta.estado="F" AND venta.tipo=2 AND venta.idvendedor=n_cod_vendedor AND venta.idsucursal=n_cod_sucursal
					GROUP BY detalle_venta.idarticulo,vendedor.idvendedor;
					
		END IF;
	END IF;
END IF;
END