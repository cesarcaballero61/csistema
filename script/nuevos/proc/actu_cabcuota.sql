DROP PROCEDURE IF EXISTS actu_cabcuota;
DELIMITER $
CREATE PROCEDURE actu_cabcuota(
    IN cod_cuota INT,
    IN cap_fecha DATE,
    IN cap_total_importe INT,
    IN cap_total_interes INT,
    IN cap_total_descuento INT,
    IN cap_ultimo_totalac INT
)
BEGIN
    DECLARE v_saldo INT;

    -- Obtener el saldo actual (ya será calculado por el trigger)
    SELECT SALDO_ACTUAL INTO v_saldo
    FROM cuotas 
    WHERE idcuotas = cod_cuota;

    -- Solo actualizar estado si el saldo es cero o negativo
    IF v_saldo <= 0 THEN
        UPDATE cuotas 
        SET estado = 'CAN', 
            fecha_cancela = cap_fecha 
        WHERE idcuotas = cod_cuota;
    END IF;
     
END $
DELIMITER ;