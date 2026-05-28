drop procedure if exists parametros;
delimiter parametros;
-- cont_reg es el arg que deternima si existe o no los parametro para actualizar con en cod_parametro en update.
create procedure parametros(cont_reg int, cod_parametro int,cod_sucursal int,

-- conceptos para movimientos	
cap_concep_venta_cont int
,cap_concep_venta_cre int
	
,cap_concep_compra_cont int
,cap_concep_compra_cre int

,cap_concep_entr_rec_cont int
,cap_concep_entr_rec_cre int
	
,cap_concep_entr_recib_rec_cont int
,cap_concep_entr_recib_rec_cre int

,cap_concep_anu_recibo int
,cap_concep_anu_venta int
,cap_concep_anu_compra int

-- los logotipos..	
,cap_ruta_logo  char(150)
,cap_ruta_fondo char(150)

-- clasificacion de morosos..		
,cap_mor_desde int
,cap_mor_hasta int
,cap_morgrave_desde int
,cap_morgrave_hasta int
,cap_info int

,cap_concep_inv_venta_cont int
,cap_concep_inv_venta_cre int
,cap_concep_inv_compra_cont int
,cap_concep_inv_compra_cre int
,cap_concep_inv_inicial int

,cap_concep_inv_trasl_entrada int
,cap_concep_inv_trasl_salida int

,cap_mot_anula_venta int
,cap_mot_anula_compra int

,cap_porc_mor decimal(10,2)
,cap_dias_gracias int
,cap_calc_interes char(1))
begin

declare codigo int;
declare mensaje char(100);
select max(idparametro)  from parametro_sistema into codigo;
if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;


if cont_reg=0 then

INSERT INTO parametro_sistema

            (idParametro,
			-- conceptos
             concep_venta_cont,
             concep_venta_cre,

             concep_compra_cont,
             concep_compra_cre,

             concep_recibo_entrega_cont,
             concep_recibo_entrega_cre,

             concep_recibo_recibido_cont,
             concep_recibo_recibido_cre,

			-- anulaciones
             concep_anu_venta,
             concep_anu_compra,
             concep_anu_recibo,

             _logo,
             _fondo,
             mor_desde,
             mor_hasta,
             morg_desde,
             morg_hasta,
             infor,
             idsucursal,


			motivo_inv_inicial ,
			motivo_inv_venta_cont ,
			motivo_inv_venta_cre ,
			motivo_inv_compra_cont,
			motivo_inv_compra_cre,

			motivo_inv_anul_venta,
			motivo_inv_anul_compra,

			motivo_inv_trasla_entrada,
			motivo_inv_trasla_saldia,

			porc_interes_mor,
			dias_gracias,
			calc_interes)
VALUES (codigo,
	-- conceptos
		cap_concep_venta_cont,
        cap_concep_venta_cre,

		cap_concep_compra_cont,
        cap_concep_compra_cre,

        cap_concep_entr_rec_cont,
        cap_concep_entr_rec_cre,

        cap_concep_entr_recib_rec_cont,
		cap_concep_entr_recib_rec_cont,

	-- anulacion
		cap_concep_anu_venta,
		cap_concep_anu_compra,
		cap_concep_anu_recibo,

		-- logos
		cap_ruta_logo,
		cap_ruta_fondo,

		-- clas morosos
		cap_mor_desde,
		cap_mor_hasta,
		cap_morgrave_desde,
		cap_morgrave_hasta,
		cap_info,
		cod_sucursal,

		cap_concep_inv_inicial,
		cap_concep_inv_venta_cont,
		cap_concep_inv_venta_cre,
		cap_concep_inv_compra_cont,
		cap_concep_inv_compra_cre,
		
		cap_mot_anula_venta,
		cap_mot_anula_compra,

		 cap_concep_inv_trasl_entrada ,
		 cap_concep_inv_trasl_salida ,

		cap_porc_mor,
		cap_dias_gracias,
		cap_calc_interes);
else
update  parametro_sistema
		-- contadores
			set 

			-- conceptos
            concep_venta_cont=cap_concep_venta_cont,
             concep_venta_cre=cap_concep_venta_cre,

             concep_compra_cont=cap_concep_compra_cont,
             concep_compra_cre=cap_concep_compra_cre,

             concep_recibo_entrega_cont=cap_concep_entr_rec_cont,
             concep_recibo_entrega_cre=cap_concep_entr_rec_cre,

             concep_recibo_recibido_cont=cap_concep_entr_recib_rec_cont,
             concep_recibo_recibido_cre=cap_concep_entr_recib_rec_cont,

			-- anulaciones
             concep_anu_venta=cap_concep_anu_venta,
             concep_anu_compra=cap_concep_anu_compra,
             concep_anu_recibo=cap_concep_anu_recibo,

             _logo=cap_ruta_logo,
             _fondo=cap_ruta_fondo,

             mor_desde=cap_mor_desde,
             mor_hasta=cap_mor_hasta,
             morg_desde=cap_morgrave_desde,
             morg_hasta=cap_morgrave_hasta,
			infor=cap_info,
			
			motivo_inv_inicial= cap_concep_inv_inicial,
			motivo_inv_trasla_entrada=cap_concep_inv_trasl_entrada,
			motivo_inv_trasla_saldia=cap_concep_inv_trasl_salida,
			motivo_inv_venta_cont =cap_concep_inv_venta_cont,
			motivo_inv_venta_cre= cap_concep_inv_venta_cre,
			motivo_inv_compra_cont=cap_concep_inv_compra_cont,
			motivo_inv_compra_cre=cap_concep_inv_compra_cre,
			motivo_inv_anul_venta=cap_mot_anula_venta,
			motivo_inv_anul_compra=cap_mot_anula_compra,
			porc_interes_mor=cap_porc_mor,
			dias_gracias=cap_dias_gracias,
			calc_interes=cap_calc_interes

            where  idParametro=cod_parametro;
	
end if;
set mensaje= "Registro actualizado..";
select mensaje;
end