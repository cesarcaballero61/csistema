drop procedure if exists cur_movimiento_operacion;
delimiter $
create procedure cur_movimiento_operacion(desde date, hasta date, cod_suc int , cod_operacion int)
begin
if cod_suc=0 then -- todos sucursal.
	if cod_operacion =0 then -- todos operacion.accessible
			SELECT
				mov_operacion.operacion
				, mov_operacion.fecha
				, mov_operacion.monto
				, cliente.apellido
				, cliente.nombre
				, cliente.ci
				, proveedor.proveedor
				, sucursal.sucursal
				, concepto_caja.concepto
				, mov_operacion.Nro_comprobante
				, mov_operacion.tipo
			FROM
				db.mov_operacion
				LEFT JOIN db.cliente 
					ON (mov_operacion.idcliente = cliente.idcliente)
				LEFT JOIN db.proveedor 
					ON (mov_operacion.idproveedor = proveedor.idproveedor)
				INNER JOIN db.concepto_caja 
					ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
				INNER JOIN db.sucursal 
					ON (mov_operacion.idsucursal = sucursal.idsucursal) where mov_operacion.fecha>=desde and mov_operacion.fecha<=hasta;
	else
			SELECT
				mov_operacion.operacion
				, mov_operacion.fecha
				, mov_operacion.monto
				, cliente.apellido
				, cliente.nombre
				, cliente.ci
				, proveedor.proveedor
				, sucursal.sucursal
				, concepto_caja.concepto
				, mov_operacion.Nro_comprobante
				, mov_operacion.tipo
			FROM
				db.mov_operacion
				LEFT JOIN db.cliente 
					ON (mov_operacion.idcliente = cliente.idcliente)
				LEFT JOIN db.proveedor 
					ON (mov_operacion.idproveedor = proveedor.idproveedor)
				INNER JOIN db.concepto_caja 
					ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
				INNER JOIN db.sucursal 
					ON (mov_operacion.idsucursal = sucursal.idsucursal) 
				where mov_operacion.fecha>=desde and mov_operacion.fecha<=hasta and mov_operacion.idconcepto=cod_operacion;
	end if;
else 
	if cod_operacion =0 then -- todos operacion.accessible
			SELECT
				mov_operacion.operacion
				, mov_operacion.fecha
				, mov_operacion.monto
				, cliente.apellido
				, cliente.nombre
				, cliente.ci
				, proveedor.proveedor
				, sucursal.sucursal
				, concepto_caja.concepto
				, mov_operacion.Nro_comprobante
				, mov_operacion.tipo
			FROM
				db.mov_operacion
				LEFT JOIN db.cliente 
					ON (mov_operacion.idcliente = cliente.idcliente)
				LEFT JOIN db.proveedor 
					ON (mov_operacion.idproveedor = proveedor.idproveedor)
				INNER JOIN db.concepto_caja 
					ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
				INNER JOIN db.sucursal 
					ON (mov_operacion.idsucursal = sucursal.idsucursal) 
				where mov_operacion.fecha>=desde and mov_operacion.fecha<=hasta and mov_operacion.idsucursal=cod_suc;
	else
			SELECT
				mov_operacion.operacion
				, mov_operacion.fecha
				, mov_operacion.monto
				, cliente.apellido
				, cliente.nombre
				, cliente.ci
				, proveedor.proveedor
				, sucursal.sucursal
				, concepto_caja.concepto
				, mov_operacion.Nro_comprobante
				, mov_operacion.tipo
			FROM
				db.mov_operacion
				LEFT JOIN db.cliente 
					ON (mov_operacion.idcliente = cliente.idcliente)
				LEFT JOIN db.proveedor 
					ON (mov_operacion.idproveedor = proveedor.idproveedor)
				INNER JOIN db.concepto_caja 
					ON (mov_operacion.idconcepto = concepto_caja.idconcepto)
				INNER JOIN db.sucursal 
					ON (mov_operacion.idsucursal = sucursal.idsucursal) 
				where mov_operacion.fecha>=desde and mov_operacion.fecha<=hasta and mov_operacion.idconcepto=cod_operacion and mov_operacion.idsucursal=cod_suc;
	end if;
end if;
end