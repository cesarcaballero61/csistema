DELIMITER $$
DROP PROCEDURE IF EXISTS ajuste_inventario$$
CREATE PROCEDURE ajuste_inventario(
    IN p_idempresa INT,
    IN p_idsucursal INT,
    IN p_fecha DATE,
    IN p_idusuario INT,
    IN p_idmotivo_ajuste INT,
    IN p_iddeposito INT,
    IN p_tipo_ajuste ENUM('ENTRADAS','SALIDAS'),
    IN p_observacion VARCHAR(100)
)
BEGIN
    DECLARE v_nro_ajuste VARCHAR(10);
    DECLARE v_ultimo_numero INT;

    -- Obtener el último número de ajuste para esta empresa/sucursal
    SELECT COALESCE(MAX(CAST(SUBSTRING(nro_ajuste, 4) AS UNSIGNED)), 0) + 1 
    INTO v_ultimo_numero
    FROM ajuste_inventario 
    WHERE idempresa = p_idempresa 
    AND idsucursal = p_idsucursal;

    -- Generar número de ajuste automático (formato: AJ-0001, AJ-0002, etc.)
    SET v_nro_ajuste = CONCAT('AJ-', LPAD(v_ultimo_numero, 4, '0'));

    -- Insertar nuevo ajuste
    INSERT INTO ajuste_inventario (
        idempresa,
        idsucursal,
        nro_ajuste,
        fecha,
        idusuario,
        idmotivo_ajuste,
        iddeposito,
        tipo_ajuste,
        observacion
    ) VALUES (
        p_idempresa,
        p_idsucursal,
        v_nro_ajuste,
        p_fecha,
        p_idusuario,
        p_idmotivo_ajuste,
        p_iddeposito,
        p_tipo_ajuste,
        p_observacion
    );

    -- Devolver solo el último ID generado
    SELECT LAST_INSERT_ID() AS id_generado;

END$$

DELIMITER ;