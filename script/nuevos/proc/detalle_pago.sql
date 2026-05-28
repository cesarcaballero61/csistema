DROP PROCEDURE IF EXISTS detalle_pago;
DELIMITER $
CREATE PROCEDURE detalle_pago(
    IN cod_pago INT,
    IN cod_det_cuo INT,
    IN n_orden INT,
    IN c_orden VARCHAR(10),
    IN d_fecha_vto DATE,
    IN n_atraso INT,
    IN n_cuota INT,
    IN n_importe DECIMAL(10,2),
    IN n_interes DECIMAL(10,2),
    IN n_descuento DECIMAL(10,2),
    IN n_totalac DECIMAL(10,2),
    IN n_saldo DECIMAL(10,2)
)
BEGIN

    -- Solo insertar en detalle_pagos_cuotas
    -- La actualización de cuotas_detalle ahora la hará el trigger
    INSERT INTO detalle_pagos_cuotas (
        orden,
        orden_char,
        fecha_vto,
        atraso,
        cuota,
        importe,
        saldo,
        interes,
        descuento,
        totalac,
        idpago,
        idcuotas_detalle
    ) VALUES (
        n_orden,
        c_orden,
        d_fecha_vto,
        n_atraso,
        n_cuota,
        n_importe,
        n_saldo,
        n_interes,
        n_descuento,
        n_totalac,
        cod_pago,
        cod_det_cuo
    );

END $
DELIMITER ;