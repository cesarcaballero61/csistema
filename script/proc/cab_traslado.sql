drop procedure if exists cab_traslado;
delimiter $
create procedure cab_traslado(
d_fecha date,
n_cod_suc_origen int,
n_cod_dep_origen int,

n_cod_suc_destino int,
n_cod_dep_destino int

)
begin
declare codigo int;
select max(idtraslado) from traslado into codigo;
if isnull(codigo) then

	set codigo=1;
else

	set codigo=codigo+1;
end if;

INSERT INTO traslado
            (idtraslado,
             fecha,
             suc_origen,
             dep_origen,
             suc_destino,
             dep_destino)
VALUES (codigo,
        d_fecha,
        n_cod_suc_origen,
        n_cod_dep_origen,
        n_cod_suc_destino,
        n_cod_dep_destino);

select codigo;
end