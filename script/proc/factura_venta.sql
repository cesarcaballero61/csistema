drop procedure if exists factura_venta;
delimiter $
create procedure factura_venta(cod_venta int,cod_suc int)
begin
	select 
	
	vt.nrofactura
	,vt.fecha
	,concat(cli.apellido,", ",cli.nombre) as cliente 
	,cli.ruc
	,cli.ci
	,dir.barrio as direccion
	,zo.zona
	,concat(Per.apellido,", ",per.nombre) as vendedor
	,ven.idvendedor
	,if(tipo=2,"Credito","Contado") as tipo_fac
	,detvt.cantidad
	,art.descripcion
	,art.codbarra
	,detvt.preventa
	,detvt.iva
	,suc.sucursal
	,suc.direccion
	,suc.telefono
	,param.empresa
	,param.ruc
	,param.timbrado
from venta vt 	join detalle_venta detvt on vt.idventa=detvt.idventa
				join cliente cli on vt.idcliente=cli.idcliente
				join zona zo on cli.idzona=zo.idzona
				join barrio dir on cli.idbarrio=dir.idbarrio
				join articulo art on detvt.idarticulo=art.idarticulo
				join vendedor ven on vt.idvendedor=ven.idvendedor
				join personal per on per.idpersonal=ven.idPersonal
				join sucursal suc on vt.idsucursal=suc.idsucursal
				join parametro_sistema param on suc.idsucursal=param.idsucursal
where vt.idventa=cod_venta and vt.idsucursal=cod_suc;
end 
