DROP PROCEDURE IF EXISTS inf_cobranza_cobrador;
DELIMITER $
CREATE PROCEDURE inf_cobranza_cobrador(tncodSucursal INT, tnCoCobrador INT, tdFechaDesde DATE ,tdFechaHAsta DATE)
BEGIN
	IF tncodSucursal = 0 THEN -- todos los cobradores
		IF tnCoCobrador = 0 THEN -- todos los cobradores
			SELECT
				cliente.ci
				, cliente.celular
				, barrio.barrio
				, venta.idVenta
				, venta.fecha
				, sucursal.idsucursal
				, sucursal.sucursal
				, cliente.nombre
				, cliente.apellido
				, cuotas_detalle.fecha_vto
				, cuotas_detalle.orden_char
				, cuotas.cuotas_fija
				, DATEDIFF(NOW(),cuotas_detalle.fecha_vto) AS atraso
				, cuotas_detalle.ultimo_importe
				, cuotas_detalle.saldo_cuota
				, cobrador.idcobrador
				, personal.ci AS ci_Personal
				, personal.nombre AS nomb_personal
				, personal.apellido AS apellido_personal
			FROM
				cuotas
				INNER JOIN cliente 
					ON (cuotas.idcliente = cliente.idcliente)
				INNER JOIN cuotas_detalle 
					ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
				INNER JOIN venta 
					ON (cuotas.idVenta = venta.idVenta)
				INNER JOIN cobrador 
					ON (venta.idcobrador = cobrador.idcobrador)
				INNER JOIN personal 
					ON (cobrador.idPersonal = personal.idPersonal)
				INNER JOIN sucursal
					ON(venta.idsucursal = sucursal.idsucursal)
				INNER JOIN barrio
					ON(cliente.idbarrio = barrio.idbarrio)
				WHERE (cuotas_detalle.fecha_vto >= tdFechaDesde AND cuotas_detalle.fecha_vto <= tdFechaHAsta) 
				AND cuotas.estado = "PEN" 
				AND cuotas_detalle.estado ="PEN";
				
		ELSE
				SELECT
					cliente.ci
					, cliente.celular
					, barrio.barrio
					, venta.idVenta
					, venta.fecha
					, sucursal.idsucursal
					, sucursal.sucursal
					, cliente.nombre
					, cliente.apellido
					, cuotas_detalle.fecha_vto
					, cuotas_detalle.orden_char
					, cuotas.cuotas_fija
					, DATEDIFF(NOW(),cuotas_detalle.fecha_vto) AS atraso
					, cuotas_detalle.ultimo_importe
					, cuotas_detalle.saldo_cuota
					, cobrador.idcobrador
					, personal.ci AS ci_Personal
					, personal.nombre AS nomb_personal
					, personal.apellido AS apellido_personal
				FROM
					cuotas
					INNER JOIN cliente 
						ON (cuotas.idcliente = cliente.idcliente)
					INNER JOIN cuotas_detalle 
						ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
					INNER JOIN venta 
						ON (cuotas.idVenta = venta.idVenta)
					INNER JOIN cobrador 
						ON (venta.idcobrador = cobrador.idcobrador)
					INNER JOIN personal 
						ON (cobrador.idPersonal = personal.idPersonal) 
					INNER JOIN sucursal
						ON(venta.idsucursal = sucursal.idsucursal)
					INNER JOIN barrio
						ON(cliente.idbarrio = barrio.idbarrio)
					WHERE (cuotas_detalle.fecha_vto >= tdFechaDesde AND cuotas_detalle.fecha_vto <= tdFechaHAsta)
						AND cobrador.idcobrador =tnCoCobrador 
						AND cuotas.estado = "PEN" AND cuotas_detalle.estado ="PEN";
		END IF;
	ELSE 
		IF tnCoCobrador = 0 THEN -- todos los cobradores
				SELECT
					cliente.ci
					, cliente.celular
					, venta.idVenta
					, venta.fecha
					, barrio.barrio
					, sucursal.idsucursal
					, sucursal.sucursal
					, cliente.nombre
					, cliente.apellido
					, cuotas_detalle.fecha_vto
					, cuotas_detalle.orden_char
					, cuotas.cuotas_fija
					, DATEDIFF(NOW(),cuotas_detalle.fecha_vto) AS atraso
					, cuotas_detalle.ultimo_importe
					, cuotas_detalle.saldo_cuota
					, cobrador.idcobrador
					, personal.ci AS ci_Personal
					, personal.nombre AS nomb_personal
					, personal.apellido AS apellido_personal
				FROM
					cuotas
					INNER JOIN cliente 
						ON (cuotas.idcliente = cliente.idcliente)
					INNER JOIN cuotas_detalle 
						ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
					INNER JOIN venta 
						ON (cuotas.idVenta = venta.idVenta)
					INNER JOIN cobrador 
						ON (venta.idcobrador = cobrador.idcobrador)
					INNER JOIN personal 
						ON (cobrador.idPersonal = personal.idPersonal)
					INNER JOIN sucursal
						ON(venta.idsucursal = sucursal.idsucursal)
					INNER JOIN barrio
						ON(cliente.idbarrio = barrio.idbarrio)
				WHERE (cuotas_detalle.fecha_vto >= tdFechaDesde AND cuotas_detalle.fecha_vto <= tdFechaHAsta)
				AND venta.idsucursal = tncodSucursal 
				AND cuotas.estado = "PEN" AND cuotas_detalle.estado ="PEN";
					
			ELSE
				SELECT
					cliente.ci
					, cliente.celular
					, venta.idVenta
					, venta.fecha
					, barrio.barrio
					, sucursal.idsucursal
					, sucursal.sucursal
					, cliente.nombre
					, cliente.apellido
					, cuotas_detalle.fecha_vto
					, cuotas_detalle.orden_char
					, cuotas.cuotas_fija
					, DATEDIFF(NOW(),cuotas_detalle.fecha_vto) AS atraso
					, cuotas_detalle.ultimo_importe
					, cuotas_detalle.saldo_cuota
					, cobrador.idcobrador
					, personal.ci AS ci_Personal
					, personal.nombre AS nomb_personal
					, personal.apellido AS apellido_personal
				FROM
					cuotas
					INNER JOIN cliente 
						ON (cuotas.idcliente = cliente.idcliente)
					INNER JOIN cuotas_detalle 
						ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
					INNER JOIN venta 
						ON (cuotas.idVenta = venta.idVenta)
					INNER JOIN cobrador 
						ON (venta.idcobrador = cobrador.idcobrador)
					INNER JOIN personal 
						ON (cobrador.idPersonal = personal.idPersonal)
					INNER JOIN sucursal
					ON(venta.idsucursal = sucursal.idsucursal)
					INNER JOIN barrio
						ON(cliente.idbarrio = barrio.idbarrio)
					WHERE (cuotas_detalle.fecha_vto >= tdFechaDesde AND cuotas_detalle.fecha_vto <= tdFechaHAsta)
						AND cobrador.idcobrador =tnCoCobrador AND venta.idsucursal = tncodSucursal 
						AND cuotas.estado = "PEN" AND cuotas_detalle.estado ="PEN";

			END IF;
		END IF;
END
