DROP PROCEDURE IF EXISTS inf_cobranza_zona;
DELIMITER $
CREATE PROCEDURE  inf_cobranza_zona(desde DATE, hasta DATE ,cod_suc INT,cod_zona INT)
BEGIN
	IF cod_suc=0 THEN -- todos las sucursal.accessible
		IF cod_zona= 0 THEN -- todos los cobradores.
			SELECT
				sucursal.sucursal
				, cuotas.nrofactura
				, cuotas.fecha_alta
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
				, zona.idzona
				, zona.zona
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente 
					ON (cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN zona 
					ON (cliente.idzona = zona.idzona)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal) WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB";
		ELSE
			SELECT
				sucursal.sucursal
				, cuotas.nrofactura
				, cuotas.fecha_alta
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
				, zona.idzona
				, zona.zona
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente 
					ON (cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN zona 
					ON (cliente.idzona = zona.idzona)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal) 
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB" AND pagos_cuotas.idzona=cod_zona;
		END IF;
	ELSE
		IF cod_zona= 0 THEN -- todos los cobradores.
			SELECT
				sucursal.sucursal
				, cuotas.nrofactura
				, cuotas.fecha_alta
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
				, zona.idzona
				, zona.zona
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente 
					ON (cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN zona 
					ON (cliente.idzona = zona.idzona)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal) 
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta AND pagos_cuotas.estado="COB" AND pagos_cuotas.idsucursal=cod_suc;

		ELSE
			SELECT
				sucursal.sucursal
				, cuotas.nrofactura
				, cuotas.fecha_alta
				, detalle_pagos_cuotas.orden_char
				, detalle_pagos_cuotas.importe
				, detalle_pagos_cuotas.interes
				, detalle_pagos_cuotas.descuento
				, zona.idzona
				, zona.zona
			FROM
				pagos_cuotas
				INNER JOIN cuotas 
					ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
				INNER JOIN cliente 
					ON (cuotas.idcliente = cliente.idcliente)
				INNER JOIN detalle_pagos_cuotas 
					ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				INNER JOIN zona 
					ON (cliente.idzona = zona.idzona)
				INNER JOIN sucursal 
					ON (pagos_cuotas.idsucursal = sucursal.idsucursal) 
				WHERE pagos_cuotas.fecha>=desde AND pagos_cuotas.fecha<=hasta  AND pagos_cuotas.estado="COB" AND pagos_cuotas.idsucursal=cod_suc AND pagos_cuotas.idzona=cod_zona;
		END IF;
	END IF;
END