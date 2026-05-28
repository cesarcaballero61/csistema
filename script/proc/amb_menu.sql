drop procedure if exists amb_menu;
delimiter $$
create procedure amb_menu(tipo int,cod_menu int,cod_parent int,cap_menu char(45),cap_comando char(200),cap_nd_carpeta int(1))
begin
declare codigo int;
select max(idmenu) from menu into codigo;
if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;
case tipo
	when 1 then
		insert into menu values(codigo,cod_parent,cap_menu,cap_comando,cap_nd_carpeta);
	when 2 then
		UPDATE menu
			SET
			texto =cap_menu,
			comando =cap_comando,
			nd_carpeta =cap_nd_carpeta
			WHERE idmenu =cod_menu;
	when 3 then 
		DELETE FROM menu WHERE  parent =cod_menu;
		DELETE FROM menu WHERE  idmenu =cod_menu;

end case;	
end 