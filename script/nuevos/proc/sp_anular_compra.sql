DELIMITER $$
DROP PROCEDURE IF EXISTS sp_anular_compra $$
CREATE PROCEDURE sp_anular_compra(
    IN p_idcompra INT,
    IN p_motivo VARCHAR(200),
    IN p_idusuario INT
)
BEGIN

    DECLARE v_existe_compra INT DEFAULT 0;
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    
    -- Verificar si la compra existe y obtener su estado y tipo
    SELECT COUNT(*), estado, tipo INTO v_existe_compra, v_estado_actual, v_tipo_compra
    FROM compra 
    WHERE idcompra = p_idcompra;
    
    IF v_existe_compra = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LA COMPRA NO EXISTE';
    ELSEIF v_estado_actual = 'ANULADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LA COMPRA YA FUE ANULADA!!';
    ELSEIF v_estado_actual = 'FACTURADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR UNA COMPRA YA FACTURADA';
    END IF;
    
    -- Verificar si la compra tiene pagos realizados (si es a crédito)
    IF v_tipo_compra = 'CREDITO' THEN
        -- Aquí podrías agregar validaciones si tu sistema registra pagos de compras a crédito
        -- Por ejemplo, verificar si hay pagos registrados en cuentas por pagar
        -- Por ahora, solo un mensaje informativo
         SELECT 1; -- Placeholder para futuras validaciones
    END IF;
    

     -- REGISTRA LA ANULACION DE COMPRAS. 
     INSERT INTO anulacion_compra (fecha, motivo, idcompra, idusuario)
     VALUES (NOW(), p_motivo, p_idcompra, p_idusuario);
    
    -- Actualizar estado de la compra
    UPDATE compra 
    SET estado = 'ANULADO'
    WHERE idcompra = p_idcompra;
    
    
END$$

DELIMITER ;