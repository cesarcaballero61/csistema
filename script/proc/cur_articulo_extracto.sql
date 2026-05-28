drop procedure if exists cur_articulo_extracto;
delimiter $
create procedure cur_articulo_extracto(cod_venta int)
begin
select 
	art.codbarra as codref
	,art.descripcion
	,det.cantidad
	,det.preventa as precio
	,det.subtotal
from articulo art join detalle_venta det on art.idarticulo=det.idarticulo where det.idventa=cod_venta;

end
