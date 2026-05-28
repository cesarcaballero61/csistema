drop procedure if exists kardex;
delimiter $
create procedure kardex(
d_fecha date,
n_cant int,
c_nro_comprobante char(15),
c_tipo char(1),
c_operacion char(45),
c_descripcion char(45),
cod_articulo int,
cod_sucursal int,
cod_motivo int,
cod_empresa int,
cod_deposito int
)
begin
declare codigo int;
select max(idkardex) from kardex into codigo;
if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;
INSERT INTO kardex
            (idkardex,
             fecha,
             Nro_comprobante,
             cantidad,
             operacion,
             descripcion,
             tipo,
             idarticulo,
             idmotivo,
             idEmpresa,
             idsucursal,
             iddeposito)
VALUES (codigo,
        d_fecha,
        c_nro_comprobante,
        n_cant,
        c_operacion,
        c_descripcion,
        c_tipo,
        cod_articulo,
        cod_motivo,
        cod_empresa,
        cod_sucursal,
        cod_deposito);

end