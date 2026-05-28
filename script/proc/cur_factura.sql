drop procedure if exists cur_factura;
delimiter $
create procedure cur_factura( in cod_venta int)
begin
select 
	emp.descrip as membrete
	,emp.empresa
	,vent.idventa
	,emp.timbrado
	,emp.ruc as emp_ruc
	,suc.sucursal
	,suc.direccion as suc_direccion
	,suc.telefono as suc_telefono
	,concat("Nº: " , vent.nrofactura) as factura
	,vent.fecha
	,if(vent.tipo=2,"Credito","Contado") as vent_tipo
	,concat(cli.nombre , ", ",cli.apellido) as cliente
	,cli.ci as cli_ci
	,cli.ruc as cli_Ruc
	,ba.barrio as cli_direccion
	,zo.zona as cli_zona
	,concat(per.nombre, ", ",per.apellido) as vendedor
	,art.codbarra as art_codigo
	,art.descripcion as art_descripcion
	,detventa.cantidad as art_cantidad
	,detventa.preventa as art_preventa
	,detventa.subtotal as art_subtotal
	,detventa.gravada_excenta
	,detventa.gravada_cinco
	,detventa.gravada_diez
	,art.impuesto as iva
from empresa as emp join sucursal as suc on emp.idempresa=suc.idempresa
					join venta as vent on vent.idsucursal=suc.idsucursal
					join cliente as cli on vent.idcliente=cli.idcliente
					join zona as zo on cli.idzona=zo.idzona
					join barrio as ba on cli.idbarrio=ba.idbarrio
					join detalle_venta as detventa on vent.idventa=detventa.idventa
					join articulo as art on detventa.idarticulo=art.idarticulo
					join vendedor as vend on vent.idvendedor=vend.idvendedor
					join personal as per on vend.idpersonal=per.idpersonal
 where vent.idventa=cod_venta;
end