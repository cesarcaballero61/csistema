drop procedure if exists det_ajuste_inicial;
delimiter $
create procedure det_ajuste_inicial(
n_cant int,
n_stock_anterior int,
n_precost int,
n_cant_aju int,
cod_ajuste int,
cod_depo int,
cod_Articulo int)
begin
INSERT INTO detalle_ajuste_inicial
            (cantidad,
             stock_anterior,
             pre_costo,
			 cant_aju,
			 idarticulo,
             idAjuste_inicial,
             iddeposito)
VALUES (n_cant,
        n_stock_anterior,
        n_precost,
		n_cant_aju,
		cod_Articulo,
        cod_ajuste,
        cod_depo);
end
