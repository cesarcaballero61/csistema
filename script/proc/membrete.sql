drop procedure if exists membrete;
delimiter $
create procedure membrete(cod_suc int,cod_empre int)
begin
SELECT
    empresa.empresa
    ,sucursal.sucursal
FROM
    sucursal
     JOIN empresa ON sucursal.idEmpresa = empresa.idEmpresa 
where sucursal.idsucursal=cod_suc and empresa.idempresa=cod_empre;

end