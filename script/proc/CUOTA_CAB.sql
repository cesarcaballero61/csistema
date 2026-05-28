drop procedure if exists cuota_cab;
delimiter $
create procedure cuota_cab(
cod_venta int
,cod_cliente int
,n_cantidad_cuota int
, n_dias_entr_pago int
, n_entrega_inicial int
, n_saldo_inicial int
, d_prim_fecha_vto date
, n_cuota_fija int
, n_total_venta int
, c_nrofactura char(20)
, d_fecha_alta date
, n_saldo int)
begin
declare codigo int;
select max(idcuotas) from cuotas into codigo;
if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;
INSERT INTO cuotas
            (idcuotas,
             cantidad_cuota,
             dias_entre_pago,
             entrega_inicial,
             saldo_inicial,
             primera_fecha_vto,
             cuotas_fija,
             total_venta,
             nrofactura,
             fecha_alta,
             SALDO_ACTUAL,
			obs,
             ESTADO,
             idVenta,
             idcliente)
VALUES (codigo,
        n_cantidad_cuota,
        n_dias_entr_pago,
        n_entrega_inicial,
        n_saldo_inicial,
        d_prim_fecha_vto,
        n_cuota_fija,
        n_total_venta,
        c_nrofactura,
        d_fecha_alta,
        n_saldo,
		"",
        "PEN",
        cod_venta,
        cod_cliente);
select codigo;
end
