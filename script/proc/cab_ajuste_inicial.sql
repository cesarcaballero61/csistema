drop procedure if exists cab_ajuste_inicial;
delimiter $
create procedure cab_ajuste_inicial(
f_fecha date
,c_observacion char(100)
,c_tipo char(1)
,n_cod_sucursal int
,n_cod_motivo int
,n_cod_empresa int)
begin
declare codigo int;
select 
    max(idAjuste_inicial)
from
    ajuste_inicial into codigo;

if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;
INSERT INTO ajuste_inicial
            (idAjuste_inicial,
             fecha,
             obs,
			 tipo,
             idmotivo,
             idsucursal,
             idEmpresa)
VALUES (codigo,
        f_fecha,
        c_observacion,
		c_tipo,
        n_cod_motivo,
        n_cod_sucursal,
        n_cod_empresa);
select codigo;

end