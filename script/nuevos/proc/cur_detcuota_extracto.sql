DROP PROCEDURE IF EXISTS cur_detcuota_extracto;
DELIMITER $
CREATE PROCEDURE cur_detcuota_extracto(
    IN cod_cuota INT,
    IN cod_suc INT
)
BEGIN
    SELECT
        cd.idcuotas_detalle AS codigo,
        cd.orden_char AS orden,
        cd.fecha_vto AS vto,
        CASE 
            WHEN cd.Estado = "CAN" THEN DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
            ELSE DATEDIFF(NOW(), cd.fecha_vto)
        END AS atraso,
        cd.ultimo_atraso,
        -- Fecha de pago: si hay pago parcial (saldo > 0) y saldo es menor que cuota, está pendiente, mostrar fecha de pago
        CASE 
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota  THEN cd.ultima_Fecha_pago
            WHEN cd.estado = "CAN" THEN cd.ultima_Fecha_pago
            ELSE NULL
        END AS fecha_pago,
        COALESCE(cd.ultimo_importe, 0) AS importe,
        cd.saldo_cuota AS saldo,
        CASE 
            WHEN cd.estado = "PEN" THEN COALESCE(calc_interes(
                CASE 
                    WHEN cd.Estado = "CAN" THEN DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
                    ELSE DATEDIFF(NOW(), cd.fecha_vto)
                END,
                cd.saldo_cuota,
                cod_suc
            ), 0)
            ELSE cd.ultimo_interes_calcu
        END AS interes,
        ROUND(cd.saldo_cuota + 
            CASE 
                WHEN cd.estado = "PEN" THEN COALESCE(calc_interes(
                    CASE 
                        WHEN cd.Estado = "CAN" THEN DATEDIFF(cd.ultima_Fecha_pago, cd.fecha_vto)
                        ELSE DATEDIFF(NOW(), cd.fecha_vto)
                    END,
                    cd.saldo_cuota,
                    cod_suc
                ), 0)
                ELSE cd.ultimo_interes_calcu
            END, 0) AS total_ac,
        cd.estado,
        -- Lógica corregida para identificar tipo de pago
        CASE 
            WHEN cd.estado = "CAN" THEN 'CANCELADO'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota = cd.cuota THEN 'PENDIENTE_TOTAL'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 'PARCIAL'
            WHEN cd.estado = "PEN" AND cd.saldo_cuota = 0 THEN 'CANCELADO' -- Por si acaso
            ELSE 'INDETERMINADO'
        END AS tipo_pago  -- Se quitó la coma extra aquí
    FROM cuotas_detalle cd
    WHERE cd.idcuotas = cod_cuota;
END$
DELIMITER ;