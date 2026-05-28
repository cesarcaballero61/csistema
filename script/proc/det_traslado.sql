drop procedure if exists det_traslado;
delimiter $
create procedure det_traslado(
n_cant int,
cod_traslado int,
cod_articulo int


)
begin
INSERT INTO detalle_traslado
            (cantidad,
             idtraslado,
             idarticulo)
VALUES (n_cant,
        cod_traslado,
        cod_articulo);
end