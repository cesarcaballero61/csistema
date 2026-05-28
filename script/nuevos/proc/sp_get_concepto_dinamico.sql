DELIMITER $$
DROP PROCEDURE IF EXISTS sp_get_concepto_dinamico$$
CREATE PROCEDURE sp_get_concepto_dinamico(
    IN p_nombre_parametro VARCHAR(100),
    OUT p_idconcepto INT
)
BEGIN
    DECLARE v_sql TEXT;
    DECLARE v_sql_exec TEXT;

    -- Obtener la consulta almacenada en la tabla parametros_sistema
    SELECT valor INTO v_sql
    FROM parametros_sistema
    WHERE nombre = p_nombre_parametro
    LIMIT 1;

    -- Ejecutar la consulta dinámica (debe devolver un solo idconcepto)
    SET @dynsql = CONCAT('SELECT idconcepto INTO @resultado FROM (', v_sql, ') AS tmp LIMIT 1');
    PREPARE stmt FROM @dynsql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET p_idconcepto = @resultado;
END$$

DELIMITER ;
