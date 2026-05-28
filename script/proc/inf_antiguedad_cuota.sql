DROP PROCEDURE IF EXISTS inf_antiguedad_cuota;
DELIMITER $
CREATE PROCEDURE inf_antiguedad_cuota(cod_suc INT,cod_cobrador INT,fecha_hasta DATE)
BEGIN
IF cod_suc=0  THEN-- todas las sucursales
	IF cod_cobrador=0 THEN -- todas las sucursales
		SELECT 
		     cliente.idcliente
		    , cuotas.idVenta
		    , cuotas.nrofactura AS doc
		    , DAY(cuotas.primera_fecha_vto) AS 'Dia'
		    , cliente.ci
		    , cliente.nombre
		    , cliente.apellido	
		    , cuotas.ultimo_fecha_pago AS ultima_fecha
		    , cuotas.ultimo_importe AS ultimo_pago
		    , cobrador.idcobrador
		    , personal.nombre AS nomb_per
		    , personal.apellido AS ape_per
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)>90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '+90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 61 AND 90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '61-90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 31 AND 60 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '31-60'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 0 AND 30 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '0-30'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)<0 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS 'A Vencer'
		    , IFNULL((SELECT SUM(detalle_pagos_cuotas.importe) FROM pagos_cuotas INNER JOIN detalle_pagos_cuotas ON pagos_cuotas.idpago=detalle_pagos_cuotas.idpago WHERE DATEDIFF(fecha_hasta,pagos_cuotas.fecha) BETWEEN 0 AND 30 AND  detalle_pagos_cuotas.fecha_vto <= fecha_hasta  AND pagos_cuotas.estado="COB" AND pagos_cuotas.idcuotas=cuotas.idcuotas),0) AS 'Logrado'
		    , SUM(cuotas_detalle.saldo_cuota) AS 'totalmonto'
		FROM
			venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cobrador 
				ON (venta.idcobrador = cobrador.idcobrador)
			INNER JOIN personal 
				ON (cobrador.idPersonal = personal.idPersonal)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
			WHERE venta.estado="F"
		    GROUP BY cuotas.idcuotas ORDER BY cliente.idcliente;
	ELSE
		SELECT 
		     cliente.idcliente
		    , cuotas.idVenta
		    , cuotas.nrofactura AS doc
		    , DAY(cuotas.primera_fecha_vto) AS 'Dia'
		    , cliente.ci
		    , cliente.nombre
		    , cliente.apellido	
		    , cuotas.ultimo_fecha_pago AS ultima_fecha
		    , cuotas.ultimo_importe AS ultimo_pago
		    , cobrador.idcobrador
		    , personal.nombre AS nomb_per
		    , personal.apellido AS ape_per
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)>90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '+90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 61 AND 90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '61-90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 31 AND 60 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '31-60'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 0 AND 30 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '0-30'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)<0 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS 'A Vencer'
		    , IFNULL((SELECT SUM(detalle_pagos_cuotas.importe) FROM pagos_cuotas INNER JOIN detalle_pagos_cuotas ON pagos_cuotas.idpago=detalle_pagos_cuotas.idpago WHERE DATEDIFF(fecha_hasta,pagos_cuotas.fecha) BETWEEN 0 AND 30 AND  detalle_pagos_cuotas.fecha_vto <= fecha_hasta  AND pagos_cuotas.estado="COB" AND pagos_cuotas.idcuotas=cuotas.idcuotas),0) AS 'Logrado'
		    , SUM(cuotas_detalle.saldo_cuota) AS 'totalmonto'
		FROM
			venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cobrador 
				ON (venta.idcobrador = cobrador.idcobrador)
			INNER JOIN personal 
				ON (cobrador.idPersonal = personal.idPersonal)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
		    WHERE venta.idcobrador=cod_cobrador AND venta.estado="F" 
		    GROUP BY cuotas.idcuotas ORDER BY cliente.idcliente;
	END IF;
ELSE
	IF cod_cobrador=0 THEN -- todas las sucursales
		SELECT 
		     cliente.idcliente
		    , cuotas.idVenta
		    , cuotas.nrofactura AS doc
		    , DAY(cuotas.primera_fecha_vto) AS 'Dia'
		    , cliente.ci
		    , cliente.nombre
		    , cliente.apellido	
		    , cuotas.ultimo_fecha_pago AS ultima_fecha
		    , cuotas.ultimo_importe AS ultimo_pago
		    , cobrador.idcobrador
		    , personal.nombre AS nomb_per
		    , personal.apellido AS ape_per
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)>90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '+90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 61 AND 90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '61-90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 31 AND 60 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '31-60'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 0 AND 30 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '0-30'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)<0 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS 'A Vencer'
		    , IFNULL((SELECT SUM(detalle_pagos_cuotas.importe) FROM pagos_cuotas INNER JOIN detalle_pagos_cuotas ON pagos_cuotas.idpago=detalle_pagos_cuotas.idpago WHERE DATEDIFF(fecha_hasta,pagos_cuotas.fecha) BETWEEN 0 AND 30 AND  detalle_pagos_cuotas.fecha_vto <= fecha_hasta  AND pagos_cuotas.estado="COB" AND pagos_cuotas.idcuotas=cuotas.idcuotas),0) AS 'Logrado'
		    , SUM(cuotas_detalle.saldo_cuota) AS 'totalmonto'
		FROM
			venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cobrador 
				ON (venta.idcobrador = cobrador.idcobrador)
			INNER JOIN personal 
				ON (cobrador.idPersonal = personal.idPersonal)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
			WHERE venta.idsucursal=cod_suc AND venta.estado="F"
		    GROUP BY cuotas.idcuotas ORDER BY cliente.idcliente;
	ELSE
		SELECT 
		     cliente.idcliente
		    , cuotas.idVenta
		    , cuotas.nrofactura AS doc
		    , DAY(cuotas.primera_fecha_vto) AS 'Dia'
		    , cliente.ci
		    , cliente.nombre
		    , cliente.apellido	
		    , cuotas.ultimo_fecha_pago AS ultima_fecha
		    , cuotas.ultimo_importe AS ultimo_pago
		    , cobrador.idcobrador
		    , personal.nombre AS nomb_per
		    , personal.apellido AS ape_per
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)>90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '+90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 61 AND 90 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '61-90'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 31 AND 60 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '31-60'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto) BETWEEN 0 AND 30 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS '0-30'
		    , SUM(CASE WHEN DATEDIFF(fecha_hasta,cuotas_detalle.fecha_vto)<0 THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS 'A Vencer'
		    , IFNULL((SELECT SUM(detalle_pagos_cuotas.importe) FROM pagos_cuotas INNER JOIN detalle_pagos_cuotas ON pagos_cuotas.idpago=detalle_pagos_cuotas.idpago WHERE DATEDIFF(fecha_hasta,pagos_cuotas.fecha) BETWEEN 0 AND 30 AND  detalle_pagos_cuotas.fecha_vto <= fecha_hasta  AND pagos_cuotas.estado="COB" AND pagos_cuotas.idcuotas=cuotas.idcuotas),0) AS 'Logrado'
		    , SUM(cuotas_detalle.saldo_cuota) AS 'totalmonto'
		FROM
			venta
			INNER JOIN cliente 
				ON (venta.idcliente = cliente.idcliente)
			INNER JOIN cobrador 
				ON (venta.idcobrador = cobrador.idcobrador)
			INNER JOIN personal 
				ON (cobrador.idPersonal = personal.idPersonal)
			INNER JOIN cuotas 
				ON (cuotas.idVenta = venta.idVenta)
			INNER JOIN cuotas_detalle 
				ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
		    WHERE venta.idsucursal=cod_suc AND venta.idcobrador=cod_cobrador AND venta.estado="F"
		    GROUP BY cuotas.idcuotas ORDER BY cliente.idcliente;
	END IF;
END IF;		
END 