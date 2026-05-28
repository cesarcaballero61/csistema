DROP PROCEDURE IF EXISTS cur_detcuota;
DELIMITER $
CREATE PROCEDURE cur_detcuota(
    IN cod_cuota INT,
    IN cod_suc INT
)
BEGIN
    SELECT
        cd.idcuotas_detalle AS codigo,
        cd.orden_cuota AS orden,
        cd.orden_char,
        cd.fecha_vto AS vto,
        CASE 
            WHEN cd.Estado = "PEN" THEN DATEDIFF(c.fecha_alta, cd.fecha_vto)
            ELSE cd.ultimo_atraso
        END AS atraso,
        -- Fecha de pago: si hay pago parcial (saldo != importe original) y está pendiente, mostrar fecha de pago
        CASE 
            WHEN cd.estado = "PEN" AND COALESCE(cd.ultimo_importe, 0) > 0  THEN cd.ultima_Fecha_pago
            WHEN cd.estado != "PEN" THEN cd.ultima_Fecha_pago
            ELSE NULL
        END AS fecha_pago,
        COALESCE(cd.ultimo_importe, 0) AS importe,
        cd.saldo_cuota AS saldo,
        CASE 
            WHEN cd.estado = "PEN" THEN COALESCE(calc_interes(
                CASE 
                    WHEN cd.Estado = "PEN" THEN DATEDIFF(c.fecha_alta, cd.fecha_vto)
                    ELSE cd.ultimo_atraso
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
                        WHEN cd.Estado = "PEN" THEN DATEDIFF(c.fecha_alta, cd.fecha_vto)
                        ELSE cd.ultimo_atraso
                    END,
                    cd.saldo_cuota,
                    cod_suc
                ), 0)
                ELSE cd.ultimo_interes_calcu
            END, 0) AS total_ac,
        cd.estado,
        -- Campo adicional para identificar pago parcial
        CASE 
            WHEN cd.estado = "PEN" AND cd.saldo_cuota > 0 AND cd.saldo_cuota < COALESCE(cd.ultimo_importe, 0) THEN 'PARCIAL'
            ELSE 'NO_PARCIAL'
        END AS tipo_pago
    FROM cuotas c
    INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
    WHERE cd.idcuotas = cod_cuota AND cd.estado = "PEN";
END$
DELIMITER ;