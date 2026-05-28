drop procedure if exists anular_recibo;
delimiter $
create procedure anular_recibo(cod_recibo int)
begin
	update pagos_cuotas set estado="ANU" where idpago=cod_recibo;

end