DELIMITER //
DROP PROCEDURE IF EXISTS CalcularPrecioCuotasDetallado //
CREATE PROCEDURE CalcularPrecioCuotasDetallado(
    IN p_nombre_producto VARCHAR(100),
    IN p_precio_contado DECIMAL(10,2),
    IN p_interes_anual DECIMAL(5,2),
    IN p_cantidad_cuota INT
)
BEGIN
    DECLARE v_porcentaje_mensual DECIMAL(10,4);
    DECLARE v_interes DECIMAL(10,2);
    DECLARE v_cuota DECIMAL(10,2);
    DECLARE v_contador INT DEFAULT 2; -- Empezamos desde 2 porque 1 es contado
    DECLARE v_monto_formateado VARCHAR(50);
    
    -- Crear tabla temporal para resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        tipo VARCHAR(20),
        descripcion VARCHAR(100),
        monto DECIMAL(15,2),
        orden INT
    );
    
    TRUNCATE TABLE temp_resultados;
    
    -- Validaciones
    IF p_precio_contado IS NULL OR p_precio_contado <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de contado debe ser mayor a 0';
    END IF;
    
    IF p_interes_anual IS NULL OR p_interes_anual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El interés anual debe ser mayor a 0';
    END IF;
    
    IF p_cantidad_cuota IS NULL OR p_cantidad_cuota <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de cuotas debe ser mayor a 0';
    END IF;
    
    -- Calcular porcentaje mensual
    SET v_porcentaje_mensual = p_interes_anual;
    
    -- Redondear precio de contado al millar superior
    SET p_precio_contado = CEIL(p_precio_contado/1000)*1000;
    
    -- Insertar producto (opcional, si quieres mantenerlo)
    IF p_nombre_producto IS NOT NULL AND p_nombre_producto != '' THEN
        INSERT INTO temp_resultados VALUES 
        ('PRODUCTO', UPPER(p_nombre_producto), NULL, 0);
    END IF;
    
    -- Insertar contado (PRIMERA FILA) - Formato especial para contado
    INSERT INTO temp_resultados VALUES 
    ('CONTADO', 
     CONCAT('Precio Contado: ', REPLACE(FORMAT(p_precio_contado, 0), ',', '.'), ' Gs.'), 
     p_precio_contado, 1);
    
    -- Calcular y insertar cuotas (desde 2 hasta p_cantidad_cuota)
    WHILE v_contador <= p_cantidad_cuota DO
        -- Calcular interés para esta cantidad de cuotas
        SET v_interes = v_porcentaje_mensual * v_contador;
        
        -- Calcular valor de la cuota
        SET v_cuota = ROUND((p_precio_contado * (v_interes / 100) + p_precio_contado) / v_contador);
        SET v_cuota = CEIL(v_cuota/1000)*1000; -- Redondear al millar superior
        
        -- Insertar en resultados con nuevo formato
        INSERT INTO temp_resultados VALUES 
        ('CUOTA', 
         CONCAT(v_contador, ' Cuotas x ', REPLACE(FORMAT(v_cuota, 0), ',', '.'), ' Gs.'), 
         v_cuota, 
         v_contador);
        
        SET v_contador = v_contador + 1;
    END WHILE;
    
    -- Retornar resultados
    SELECT 
        descripcion AS 'Descripcion',
        tipo,
        CASE 
            WHEN monto IS NOT NULL THEN CONCAT(REPLACE(FORMAT(monto, 0), ',', '.'), ' Gs.') 
            ELSE ''
        END AS 'Monto',
        orden,
        IFNULL(monto, 0) AS cuota
    FROM temp_resultados 
    ORDER BY orden;
    
    DROP TEMPORARY TABLE temp_resultados;
    
END //

DELIMITER ;