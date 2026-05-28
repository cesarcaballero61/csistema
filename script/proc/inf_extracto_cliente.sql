DROP PROCEDURE IF EXISTS inf_extracto_cliente;
DELIMITER $
CREATE PROCEDURE inf_extracto_cliente(todos_vto INT,cod_suc INT,cod_cli INT,cod_zona INT,vto DATE, estado_moroso INT,saldo_Cero INT, n_cod_sucursal INT)
BEGIN
DECLARE moroso_desde,moroso_hasta INT;

IF estado_moroso=2 THEN
		SELECT mor_desde FROM parametro_sistema  WHERE idsucursal=n_cod_sucursal INTO moroso_desde;
		SELECT mor_hasta FROM parametro_sistema WHERE idsucursal=n_cod_sucursal INTO moroso_hasta;
ELSEIF  estado_moroso=3 THEN
			SELECT morg_desde FROM parametro_sistema  WHERE idsucursal=n_cod_sucursal INTO moroso_desde;
			SELECT morg_hasta FROM parametro_sistema WHERE idsucursal = n_cod_sucursal INTO moroso_hasta;
ELSEIF estado_moroso=4 THEN
		SELECT infor FROM parametro_sistema  WHERE idsucursal=n_cod_sucursal INTO moroso_hasta;
END IF;

IF todos_vto=0 THEN 
IF estado_moroso= 1 THEN -- todos los estados.
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
								WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					END IF;
			END IF;
		END IF;
	END IF;
END IF;



IF estado_moroso=2 OR estado_moroso=3 THEN
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
								SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	END IF;
END IF;





IF estado_moroso=4 THEN
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	END IF;
END IF;
END IF;


IF todos_vto=1 THEN
IF estado_moroso= 1 THEN -- todos los estados.
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
								WHERE venta.estado="F";
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idzona=cod_zona;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc;
					END IF;
			END IF;
		END IF;
	END IF;
END IF;



IF estado_moroso=2 OR estado_moroso=3 THEN
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
								SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cuotas_detalle.fecha_vto <=vto AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) >=moroso_desde AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	END IF;
END IF;





IF estado_moroso=4 THEN
	IF cod_suc=0 THEN -- todos las sucursales.
		IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								, DATEDIFF(NOW(),cuotas_detalle.fecha_vto) AS atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, cuotas_detalle.ultimo_interes_calcu AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cliente.idzona=cod_zona AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;
		END IF;
	ELSE -- por sucursal.
			IF cod_zona=0 THEN -- todas las zona.
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idcliente=cod_cli  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			END IF;

		ELSE -- por zona
			IF cod_cli=0 THEN 
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"  AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc  AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F"
										AND cuotas_detalle.saldo_cuota>0 AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					END IF;
			ELSE -- por cliente
					IF saldo_cero=1 THEN -- saldo igual cero.
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" AND cliente.idcliente=cod_cli AND cliente.idzona=cod_zona  AND venta.idsucursal=cod_suc AND  DATEDIFF(NOW(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					ELSE -- saldo mayor cero
							SELECT 
								cuotas.nrofactura AS factura
								, cuotas.fecha_alta AS fecha
								, cuotas_detalle.orden_char AS cuota
								, cuotas_detalle.ultima_Fecha_pago AS fechapago
								, cuotas_detalle.fecha_vto AS vto
								,@n_atraso:=IF(cuotas_detalle.Estado="PEN",DATEDIFF(NOW(),cuotas_detalle.fecha_vto),cuotas_detalle.ultimo_atraso) AS  atraso
								, cuotas_detalle.cuota AS monto
								, cuotas_detalle.ultimo_nro_recibo AS recibo
								, cuotas_detalle.ultimo_importe AS importe
								, cuotas_detalle.saldo_cuota AS saldo
								, cuotas_detalle.ultimo_descuento AS descuento
								, IF(cuotas_detalle.estado="PEN",calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,n_cod_sucursal),cuotas_detalle.ultimo_interes_calcu)  AS interes
								, cuotas.obs
								, cliente.referencia
								, cuotas.idcuotas
								, cliente.idcliente
								, cliente.nombre
								, cliente.apellido
								, cliente.ci
								, cliente.ruc
								, venta.idventa
								, cliente.idzona
								, zona.zona
								, sucursal.idsucursal
								, sucursal.sucursal
								, barrio.barrio
							FROM
								cuotas_detalle
								INNER JOIN cuotas 
									ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
								INNER JOIN cliente 
									ON (cuotas.idcliente = cliente.idcliente)
								INNER JOIN venta 
									ON (cuotas.idVenta = venta.idVenta) 
								INNER JOIN zona
									ON (zona.idzona = cliente.idzona) 
								INNER JOIN sucursal
									ON (sucursal.idsucursal = venta.idsucursal) 
								INNER JOIN barrio
									ON(barrio.idbarrio=cliente.idbarrio)
										WHERE venta.estado="F" 
										and cuotas_detalle.saldo_cuota>0 and cliente.idcliente=cod_cli and cliente.idzona=cod_zona  and venta.idsucursal=cod_suc  and  DATEDIFF(now(),cuotas_detalle.fecha_vto) <=moroso_hasta ;
					end if;
			end if;
		end if;
	end if;
end if;
end if;



end
