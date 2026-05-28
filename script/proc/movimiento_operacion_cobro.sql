DROP PROCEDURE IF EXISTS movimiento_operacion_cobro;
DELIMITER $
CREATE PROCEDURE movimiento_operacion_cobro(
d_fecha DATE
,c_operacion CHAR(45)
,c_nro_comprobante CHAR(45)
,n_monto INT
,c_tipo CHAR(1)
,c_tipoventa CHAR(3)
,c_descripcion CHAR(100)
,cod_concepto INT
,cod_cliente INT
,cod_personal INT
,cod_proveedor INT
,cod_formapago INT
,cod_sucursal INT
,cod_empresa INT
)

BEGIN
DECLARE codigo INT;
SELECT MAX(idMov) FROM mov_operacion INTO codigo;

IF ISNULL(codigo) THEN 
	SET codigo=1;
ELSE
	SET codigo=codigo+1;
END IF;	

INSERT INTO mov_operacion
            (idMov,
             fecha,
             operacion,
             Nro_comprobante,
             monto,
             tipo,
             tipo_venta,
             descripcion,
             idconcepto,
             idcliente,
             idpersonal,
             idformapago,
             idproveedor,
             idsucursal,
             idEmpresa)
VALUES (codigo,
        d_fecha,
        c_operacion,
        c_nro_comprobante,
        n_monto,
        c_tipo,
        c_tipoventa,
        c_descripcion,
        cod_concepto,
        cod_cliente,
        cod_personal,
        cod_formapago,
        cod_proveedor,
        cod_sucursal,
        cod_empresa);
END