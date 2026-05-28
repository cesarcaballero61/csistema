drop procedure if exists cuota_Det;
delimiter $
create procedure cuota_Det(cod_cuota int, c_orden char(10), n_orden int, d_fecha_vto date, n_cuota int, n_saldo int)
begin
declare codigo int;
select max(idcuotas_Detalle) from cuotas_detalle into codigo;

if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;

INSERT INTO cuotas_detalle
            (
				idcuotas_detalle,
				orden_char,
				fecha_vto,
				orden_cuota,
				cuota,
				saldo_cuota,
				ESTADO,
				idcuotas)
VALUES (
		codigo,
        c_orden,
        d_fecha_vto,
        n_orden,
        n_cuota,
        n_saldo,
        "PEN",
        cod_cuota);
end