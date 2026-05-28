drop procedure if exists cur_detcuota;
delimiter $
create procedure cur_detcuota(cod_cuota int,cod_suc int)
begin
SELECT
    idcuotas_detalle as codigo
    , orden_char
    , orden_cuota
    , fecha_vto
    , @n_atraso:=dateiif(fecha_vto,now()) as  atraso
    , ultima_Fecha_pago as fecha_pago
	, ultimo_importe as importe
	,saldo
	, @n_interes:=calc_interes(@n_atraso,saldo,cod_suc) as interes
	,saldo+n_interes as total_ac
FROM
    cuotas_detalle where idcuotas=cod_cuota;

end