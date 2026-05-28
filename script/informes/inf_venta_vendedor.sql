drop procedure if exists inf_venta_vendedor;
delimiter $
create procedure inf_venta_vendedor(desde date ,hasta date ,n_tipo_venta int,n_cod_vendedor int,n_cod_sucursal int)
begin
if n_tipo_venta=1 then-- ambos
	if n_cod_sucursal=0 then-- todas las sucursales
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F";
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.idvendedor=n_cod_vendedor;
		end if;
	else
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.idsucursal=n_cod_sucursal;
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
			where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.idvendedor=n_cod_vendedor and venta.idsucursal=n_cod_sucursal;
		end if;
	end if;


elseif n_tipo_venta=2 then-- contado
	if n_cod_sucursal=0  then-- todas las sucursales
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=1;
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=1 and venta.idvendedor=n_cod_vendedor;
		end if;
	else
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=1  and venta.idsucursal=n_cod_sucursal;
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=1  and venta.idsucursal=n_cod_sucursal and venta.idvendedore=n_cod_vendedor;
		end if;
	end if;

elseif n_tipo_venta=3 then -- credito
	if n_cod_sucursal=0 then -- todas las sucursales
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=2;
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=2 and venta.idvendedor=n_cod_vendedor;
		end if;
	else
		if n_cod_vendedor=0 then -- todos los vendedores.
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=2 and venta.idsucursal=n_cod_sucursal;
		else
			SELECT
				venta.nrofactura
				, venta.fecha
				, venta.tipo
				, cliente.nombre
				, cliente.apellido
				, cliente.ci
				, cliente.ruc
				, venta.total
				,sucursal.sucursal
				,concat(personal.nombre," ",personal.apellido) as vendedor
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
					where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" and venta.tipo=2 and venta.idvendedor=n_cod_vendedor and venta.idsucursal=n_cod_sucursal;
		end if;
	end if;
end if;
end