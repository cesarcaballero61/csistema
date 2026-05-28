DROP PROCEDURE IF EXISTS cur_extracto_cliente;
DELIMITER $
CREATE PROCEDURE cur_extracto_cliente(
    IN cod_cuota INT,
    IN cod_suc INT
)
BEGIN
    SELECT
        v.idventa,
        v.nrofactura,
        v.fecha,
        cd.orden_char AS orden,
        cd.fecha_vto AS vto,
        cd.ultimo_atraso,
        cd.cuota,
        cd.ultimo_nro_recibo,
        cd.ultimo_importe,
        -- FECHA DE PAGO: Mostrar para pagos parciales y cancelados
        CASE 
            WHEN cd.estado = "CAN" THEN cd.ultima_Fecha_pago
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN cd.ultima_Fecha_pago
            ELSE NULL
        END AS fecha_pago,
        cd.saldo_cuota AS saldo,
        cd.ultimo_interes_calcu AS ultimo_interes,
        -- Cálculo de atraso
        CASE 
            WHEN cd.Estado = "CAN" THEN 
                DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
            ELSE 
                DATEDIFF(CURDATE(), cd.fecha_vto)
        END AS atraso,
        cd.ultimo_descuento,
        -- Cálculo de interés
        CASE 
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 THEN
                calc_interes(
                    CASE 
                        WHEN cd.Estado = "CAN" THEN 
                            DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
                        ELSE 
                            DATEDIFF(CURDATE(), cd.fecha_vto)
                    END,
                    cd.saldo_cuota,
                    cod_suc
                )
            ELSE 
                0
        END AS interes,
        c.apellido,
        c.nombre,
        c.ci,
        c.ruc,
        c.telefono,
        cu.obs,
        c.celular,
        z.zona,
        b.barrio,
        cd.estado,
        -- Identificación del tipo de pago
        CASE 
            WHEN cd.estado = "CAN" THEN 'CANCELADO'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota = cd.cuota THEN 'PENDIENTE_TOTAL'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 'PARCIAL'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota = 0 THEN 'CANCELADO'
            ELSE 'INDETERMINADO'
        END AS tipo_pago,
        -- Información adicional para claridad
        cd.cuota AS monto_original,
        (cd.cuota - cd.saldo_cuota) AS total_pagado,
        -- Total a pagar (saldo + intereses)
        ROUND(cd.saldo_cuota + 
            CASE 
                WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 THEN
                    calc_interes(
                        CASE 
                            WHEN cd.Estado = "CAN" THEN 
                                DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
                            ELSE 
                                DATEDIFF(CURDATE(), cd.fecha_vto)
                        END,
                        cd.saldo_cuota,
                        cod_suc
                    )
                ELSE 0
            END, 0
        ) AS total_a_pagar
    FROM cuotas cu
    JOIN cuotas_detalle cd ON cu.idcuotas = cd.idcuotas
    JOIN venta v ON cu.idVenta = v.idVenta
    JOIN cliente c ON v.idcliente = c.idcliente
    JOIN zona z ON c.idzona = z.idzona
    JOIN barrio b ON c.idbarrio = b.idbarrio
    WHERE cu.idcuotas = cod_cuota 
        AND cu.estado = "PEN" 
        AND v.estado = "F"
    ORDER BY cd.orden_cuota;
END$
DELIMITER ;