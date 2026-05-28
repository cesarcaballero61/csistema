DELIMITER $$

CREATE PROCEDURE sp_anular_recibo(
    IN p_idpago INT,
    IN p_motivo VARCHAR(100),
    IN p_idusuario INT
)
BEGIN
    DECLARE v_existe_pago INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_existe_pago 
    FROM pagos_cuotas 
    WHERE idpago = p_idpago AND estado = 'COB';
    
    IF v_existe_pago = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El recibo no existe o ya está anulado';
    ELSE
        -- Usando el nombre correcto del campo si lo corriges
        INSERT INTO anulacion_recibo (fecha, motivo, idpago, idusuario)
        VALUES (NOW(), p_motivo, p_idpago, p_idusuario);
        
        UPDATE pagos_cuotas 
        SET estado = 'ANU' 
        WHERE idpago = p_idpago;
        
    END IF;
END$$

DELIMITER ;