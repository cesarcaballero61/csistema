drop procedure if exists inf_venta001;
delimiter $
create procedure inf_venta001(desde date, hasta date,tipo_venta int, cod_sucursal int)
begin
if tipo_venta=1 then -- ambos
SELECT
    venta.nrofactura AS nrodoc
    , venta.fecha
	, sucursal.sucursal
    , if(venta.tipo=1,"CON","CRE") AS tipo
    , cliente.nombre
    , cliente.apellido
    , cliente.ci
    , cliente.ruc
    , venta.total
FROM
    venta
   JOIN cliente 
        ON venta.idcliente = cliente.idcliente 
	join sucursal
		on venta.idsucursal=sucursal.idsucursal
		where (venta.fecha>=desde and venta.fecha<=hasta) and venta.estado="F" 
		and venta.idsucursal=cod_sucursal;

	elseif tipo_venta=2 then -- ambos

SELECT
    venta.nrofactura AS nrodoc
    , venta.fecha
	, sucursal.sucursal
    , if(venta.tipo=1,"CON","CRE") AS tipo
    , cliente.nombre
    , cliente.apellido
    , cliente.ci
    , cliente.ruc
    , venta.total
FROM
    venta
   JOIN cliente 
        ON venta.idcliente = cliente.idcliente 
	join sucursal
		on venta.idsucursal=sucursal.idsucursal
				where (venta.fecha>=desde and venta.fecha<=hasta) 
				and venta.estado="F" and venta.tipo=1 and venta.idsucursal=cod_sucursal;
	else
	SELECT
		venta.nrofactura AS nrodoc
		, venta.fecha
		, sucursal.sucursal
		, if(venta.tipo=1,"CON","CRE") AS tipo
		, cliente.nombre
		, cliente.apellido
		, cliente.ci
		, cliente.ruc
		, venta.total
	FROM
		venta
	   JOIN cliente 
			ON venta.idcliente = cliente.idcliente 
		join sucursal
			on venta.idsucursal=sucursal.idsucursal
				where (venta.fecha>=desde and venta.fecha<=hasta) 
				and venta.estado="F" and venta.tipo=2 and venta.idsucursal=cod_sucursal;
		
end if;
end