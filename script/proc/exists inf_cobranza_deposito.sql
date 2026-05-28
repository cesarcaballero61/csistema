drop procedure if exists inf_cobranza_deposito;
delimiter $
create procedure inf_cobranza_deposito(desde date, hasta date ,cod_suc int,cod_depo int)
begin
	if cod_suc=0 then -- todos las sucursal.accessible
		if cod_depo = 0 then -- todos los cobradores.
			select
			    pagos_cuotas.idpago
			    , venta.idVenta
			    , cuotas.idcuotas
			    , detalle_venta.iddeposito
			    , deposito.deposito
			    , cuotas.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , cliente.telefono
			    , pagos_cuotas.fecha
			    , pagos_cuotas.total_ac
			    , detalle_pagos_cuotas.orden_char
			    , detalle_pagos_cuotas.orden
			    , pagos_cuotas.total_importe
			    , detalle_pagos_cuotas.importe
			    , detalle_pagos_cuotas.interes
			    , detalle_pagos_cuotas.descuento
			    , detalle_pagos_cuotas.totalac
			from
			    detalle_venta
			    inner join deposito 
				on (detalle_venta.iddeposito = deposito.iddeposito)
			    inner join venta 
				on (detalle_venta.idVenta = venta.idVenta)
			    inner join cuotas 
				on (cuotas.idVenta = venta.idVenta)
			    inner join cliente 
				on (venta.idcliente = cliente.idcliente)
			    inner join pagos_cuotas 
				on (pagos_cuotas.idcuotas = cuotas.idcuotas)
			    inner join detalle_pagos_cuotas 
				on (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago) 
				where pagos_cuotas.fecha>=desde and pagos_cuotas.fecha<=hasta and pagos_cuotas.estado="COB";
		else
			select
			    pagos_cuotas.idpago
			    , venta.idVenta
			    , cuotas.idcuotas
			    , detalle_venta.iddeposito
			    , deposito.deposito
			    , cuotas.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , cliente.telefono
			    , pagos_cuotas.fecha
			    , pagos_cuotas.total_ac
			    , detalle_pagos_cuotas.orden_char
			    , detalle_pagos_cuotas.orden
			    , pagos_cuotas.total_importe
			    , detalle_pagos_cuotas.importe
			    , detalle_pagos_cuotas.interes
			    , detalle_pagos_cuotas.descuento
			    , detalle_pagos_cuotas.totalac
			from
			    detalle_venta
			    inner join deposito 
				on (detalle_venta.iddeposito = deposito.iddeposito)
			    inner join venta 
				on (detalle_venta.idVenta = venta.idVenta)
			    inner join cuotas 
				on (cuotas.idVenta = venta.idVenta)
			    inner join cliente 
				on (venta.idcliente = cliente.idcliente)
			    inner join pagos_cuotas 
				on (pagos_cuotas.idcuotas = cuotas.idcuotas)
			    inner join detalle_pagos_cuotas 
				on (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				where pagos_cuotas.fecha>=desde and pagos_cuotas.fecha<=hasta and pagos_cuotas.estado="COB" and detalle_venta.iddeposito=cod_depo;
		end if;
	else
		if cod_depo= 0 then -- todos los cobradores.
			select
			    pagos_cuotas.idpago
			    , venta.idVenta
			    , cuotas.idcuotas
			    , detalle_venta.iddeposito
			    , deposito.deposito
			    , cuotas.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , cliente.telefono
			    , pagos_cuotas.fecha
			    , pagos_cuotas.total_ac
			    , detalle_pagos_cuotas.orden_char
			    , detalle_pagos_cuotas.orden
			    , pagos_cuotas.total_importe
			    , detalle_pagos_cuotas.importe
			    , detalle_pagos_cuotas.interes
			    , detalle_pagos_cuotas.descuento
			    , detalle_pagos_cuotas.totalac
			from
			    detalle_venta
			    inner join deposito 
				on (detalle_venta.iddeposito = deposito.iddeposito)
			    inner join venta 
				on (detalle_venta.idVenta = venta.idVenta)
			    inner join cuotas 
				on (cuotas.idVenta = venta.idVenta)
			    inner join cliente 
				on (venta.idcliente = cliente.idcliente)
			    inner join pagos_cuotas 
				on (pagos_cuotas.idcuotas = cuotas.idcuotas)
			    inner join detalle_pagos_cuotas 
				on (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				where pagos_cuotas.fecha>=desde and pagos_cuotas.fecha<=hasta and pagos_cuotas.estado="COB" and pagos_cuotas.idsucursal=cod_suc;

		else
			select
			    pagos_cuotas.idpago
			    , venta.idVenta
			    , cuotas.idcuotas
			    , detalle_venta.iddeposito
			    , deposito.deposito
			    , cuotas.idcliente
			    , cliente.apellido
			    , cliente.nombre
			    , cliente.ci
			    , cliente.telefono
			    , pagos_cuotas.fecha
			    , pagos_cuotas.total_ac
			    , detalle_pagos_cuotas.orden_char
			    , detalle_pagos_cuotas.orden
			    , pagos_cuotas.total_importe
			    , detalle_pagos_cuotas.importe
			    , detalle_pagos_cuotas.interes
			    , detalle_pagos_cuotas.descuento
			    , detalle_pagos_cuotas.totalac
			from
			    detalle_venta
			    inner join deposito 
				on (detalle_venta.iddeposito = deposito.iddeposito)
			    inner join venta 
				on (detalle_venta.idVenta = venta.idVenta)
			    inner join cuotas 
				on (cuotas.idVenta = venta.idVenta)
			    inner join cliente 
				on (venta.idcliente = cliente.idcliente)
			    inner join pagos_cuotas 
				on (pagos_cuotas.idcuotas = cuotas.idcuotas)
			    inner join detalle_pagos_cuotas 
				on (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
				where pagos_cuotas.fecha>=desde and pagos_cuotas.fecha<=hasta  and pagos_cuotas.estado="COB" and pagos_cuotas.idsucursal=cod_suc and detalle_venta.iddeposito=cod_depo;
		end if;
	end if;
end