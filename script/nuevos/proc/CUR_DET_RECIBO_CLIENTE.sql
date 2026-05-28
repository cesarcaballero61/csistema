DROP PROCEDURE IF EXISTS CUR_DET_RECIBO_CLIENTE;

DELIMITER $

CREATE PROCEDURE CUR_DET_RECIBO_CLIENTE(
    IN p_cod_pago INT, 
    IN p_cod_cli INT
)
BEGIN
SELECT
	pagos_cuotas.idpago
	, pagos_cuotas.fecha
	, cuotas.nrofactura
	, cuotas.idcuotas
	, pagos_cuotas.idcobrador
	, personal.idPersonal
	, pagos_cuotas.nro_recibo
	, pagos_cuotas.idTipo_pago AS idtipopago
	, detalle_pagos_cuotas.fecha_vto
	, detalle_pagos_cuotas.orden_char
	, detalle_pagos_cuotas.importe
	, detalle_pagos_cuotas.cuota
	, detalle_pagos_cuotas.idcuotas_detalle
FROM
    detalle_pagos_cuotas
    INNER JOIN pagos_cuotas 
        ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
    INNER JOIN cuotas 
        ON (pagos_cuotas.idcuotas = cuotas.idcuotas) 
    INNER JOIN cobrador
	ON(pagos_cuotas.idcobrador = cobrador.idcobrador)
    INNER JOIN personal
	ON(cobrador.idpersonal =personal.idpersonal)
		WHERE pagos_cuotas.estado="COB" AND detalle_pagos_cuotas.idpago=p_cod_pago AND pagos_cuotas.idcliente=p_cod_cli;
END$$

DELIMITER ;