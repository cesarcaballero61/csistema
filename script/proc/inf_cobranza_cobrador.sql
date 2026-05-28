DROP PROCEDURE IF EXISTS inf_cobranza_cobrador;
DELIMITER $
CREATE PROCEDURE  inf_cobranza_cobrador(desde DATE, hasta DATE ,cod_suc INT,cod_cob INT)
BEGIN
	IF cod_suc=0 THEN -- todos las sucursal.accessible
		IF cod_cob= 0 THEN -- todos los cobradores.
			SELECT
				sucursal.sucursal
				, personal.nombre AS nomb_cob
				, personal.apellido AS apell_cob
				, cliente.apellido AS ape_cliente
				, cliente.nombre AS nom_cliente
				, cuotas.nrofactura
				, cuotas.fecha_alta AS fecha
				, pagos_cuotas.idcobrador
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.atraso
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente
					ON(cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal)
				INNER JOIN cobrador 
					ON (pagos_cuotas.idcobrador = cobrador.idcobrador)
				INNER JOIN personal 
					ON (personal.idPersonal = cobrador.idPersonal) 
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB";
		ELSE
			SELECT
				sucursal.sucursal
				, personal.nombre AS nomb_cob
				, personal.apellido AS apell_cob
				, cliente.apellido AS ape_cliente
				, cliente.nombre AS nom_cliente
				, cuotas.nrofactura
				, cuotas.fecha_alta AS fecha
				, pagos_cuotas.idcobrador
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.atraso
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente
					ON(cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal)
				INNER JOIN cobrador 
					ON (pagos_cuotas.idcobrador = cobrador.idcobrador)
				INNER JOIN personal 
					ON (personal.idPersonal = cobrador.idPersonal)
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB" AND pagos_cuotas.idcobrador=cod_cob;
		END IF;
	ELSE
		IF cod_cob= 0 THEN -- todos los cobradores.
			SELECT
				sucursal.sucursal
				, personal.nombre AS nomb_cob
				, personal.apellido AS apell_cob
				, cliente.apellido AS ape_cliente
				, cliente.nombre AS nom_cliente
				, cuotas.nrofactura
				, cuotas.fecha_alta AS fecha
				, pagos_cuotas.idcobrador
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.atraso
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente
					ON(cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal)
				INNER JOIN cobrador 
					ON (pagos_cuotas.idcobrador = cobrador.idcobrador)
				INNER JOIN personal 
					ON (personal.idPersonal = cobrador.idPersonal)
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB" AND pagos_cuotas.idsucursal=cod_suc;
		ELSE
			SELECT
				sucursal.sucursal
				, personal.nombre AS nomb_cob
				, personal.apellido AS apell_cob
				, cliente.apellido AS ape_cliente
				, cliente.nombre AS nom_cliente
				, cuotas.nrofactura
				, cuotas.fecha_alta AS fecha
				, pagos_cuotas.idcobrador
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.atraso
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente
					ON(cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal)
				INNER JOIN cobrador 
					ON (pagos_cuotas.idcobrador = cobrador.idcobrador)
				INNER JOIN personal 
					ON (personal.idPersonal = cobrador.idPersonal)
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB" AND pagos_cuotas.idsucursal=cod_suc AND pagos_cuotas.idcobrador=cod_cob;
		END IF;
	END IF;
END