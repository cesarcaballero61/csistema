DROP PROCEDURE IF EXISTS cab_pagos_cuotas;
DELIMITER $
CREATE PROCEDURE cab_pagos_cuotas(
cod_cuota INT,
cap_fecha DATE,
cap_total_interes INT,
cap_total_descuento INT,
cap_total_importe INT,
cap_totaac INT,
cap_cod_cliente INT,
cap_tipo_pago INT,
cap_cod_sucursal INT,
cap_cod_empresa INT,
cap_cod_cobrador INT,
cap_cod_usuario INT
)

BEGIN


DECLARE codigo INT;
DECLARE nro_recibo_formateado VARCHAR(8);

SELECT COALESCE(MAX(idpago), 0) + 1 INTO codigo FROM pagos_cuotas;

-- Formatear el número de recibo con ceros a la izquierda.
SET nro_recibo_formateado = LPAD(codigo, 8, '0');

INSERT INTO pagos_cuotas
            (idpago,
             fecha,
             nro_recibo,
             total_interes,
             total_descuento,
             total_ac,
	     total_importe,
             idcliente,
             idTipo_pago,
             idsucursal,
             idEmpresa,
             idcobrador,
	     idcuotas,
	     idusuario,
             estado)
VALUES (codigo,
	cap_fecha,
	nro_recibo_formateado,
        cap_total_interes,
        cap_total_descuento,
        cap_totaac,
	cap_total_importe,
	cap_cod_cliente,
	cap_tipo_pago,
	cap_cod_sucursal,
        cap_cod_empresa,
        cap_cod_cobrador,
	cod_cuota,
	cap_cod_usuario,
        "COB");

SELECT codigo;
END $
DELIMITER ;