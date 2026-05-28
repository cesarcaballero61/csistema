drop procedure if exists movimiento_operacion;
delimiter $
create procedure movimiento_operacion(
d_fecha date
,c_operacion char(45)
,c_nro_comprobante char(45)
,n_monto int
,c_tipo char(1)
,c_descripcion char(100)
,cod_concepto int
,cod_cliente int
,cod_proveedor int
,cod_sucursal int
,cod_empresa int
)

begin
declare codigo int;
select max(idMov) from mov_operacion into codigo;

if isnull(codigo) then 
	set codigo=1;
else
	set codigo=codigo+1;
end if;	

INSERT INTO mov_operacion
            (idMov,
             fecha,
             operacion,
             Nro_comprobante,
             monto,
             tipo,
             descripcion,
             idconcepto,
             idcliente,
             idproveedor,
             idsucursal,
             idEmpresa)
VALUES (codigo,
        d_fecha,
        c_operacion,
        c_nro_comprobante,
        n_monto,
        c_tipo,
        c_descripcion,
        cod_concepto,
        cod_cliente,
        cod_proveedor,
        cod_sucursal,
        cod_empresa);
end