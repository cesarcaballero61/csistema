DROP PROCEDURE IF EXISTS cur_cuota_vencidas;
DELIMITER $
CREATE PROCEDURE cur_cuota_vencidas(desde DATE, hasta DATE, n_cod_sucursal INT)
BEGIN
	IF n_cod_sucursal=0 THEN
		SELECT
			cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.celular
			, cliente.telefono
			, cliente.ruc
			, venta.nrofactura
			, cuotas_detalle.orden_char AS orden
			, cuotas_detalle.saldo_cuota AS cuota
			, cuotas_detalle.fecha_vto AS vto
			, @n_atraso:=DATEDIFF(CURDATE(),cuotas_detalle.fecha_vto) AS atraso
			, calc_interes(IF(@n_atraso<0,0,@n_atraso),cuotas_detalle.saldo_cuota,n_cod_sucursal) AS interes
			, zona.idzona
			, zona.zona
			, barrio.barrio
			FROM venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
			INNER JOIN zona 
				ON (cliente.idzona = zona.idzona) 
			INNER JOIN barrio
				ON (cliente.idbarrio=barrio.idbarrio)
			WHERE (cuotas_detalle.fecha_vto>=desde AND cuotas_detalle.fecha_vto<=hasta) 
			AND cuotas_detalle.estado="PEN" AND venta.estado="F";
	ELSE
		SELECT
			cliente.nombre
			, cliente.apellido
			, cliente.ci
			, cliente.celular
			, cliente.telefono
			, cliente.ruc
			, venta.nrofactura
			, cuotas_detalle.orden_char AS orden
			, cuotas_detalle.saldo_cuota AS cuota
			, cuotas_detalle.fecha_vto AS vto
			, @n_atraso:=DATEDIFF(CURDATE(),cuotas_detalle.fecha_vto) AS atraso
			, calc_interes(IF(@n_atraso<0,0,@n_atraso),cuotas_detalle.saldo_cuota,n_cod_sucursal) AS interes
			, zona.idzona
			, zona.zona
			, barrio.barrio
			FROM venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
			INNER JOIN zona 
				ON (cliente.idzona = zona.idzona) 
			INNER JOIN barrio
				ON (cliente.idbarrio=barrio.idbarrio)
			WHERE (cuotas_detalle.fecha_vto>=desde AND cuotas_detalle.fecha_vto<=hasta) 
			AND cuotas_detalle.estado="PEN" AND venta.estado="F" AND venta.idsucursal = n_cod_sucursal;	

	END IF;
END