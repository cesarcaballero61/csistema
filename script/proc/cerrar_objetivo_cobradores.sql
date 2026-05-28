drop procedure if exists cerrar_objetivo_cobradores;
delimiter $
create procedure cerrar_objetivo_cobradores(cod_objetivo int,cant_alcanzado int,monto_alcanzado int,porc_alcanzados decimal(10,2),saldo_alcanzado int)
begin
	update objetivo_cobrador 
set cerrado="S"
,cant_pagado=cant_alcanzado
,monto_pagado=monto_alcanzado
,porc_alcanzado=porc_alcanzados 
,saldo=saldo_alcanzado
where idobjetivo=cod_objetivo;
end