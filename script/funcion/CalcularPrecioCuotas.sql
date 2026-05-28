DELIMITER //

CREATE PROCEDURE CalcularPrecioCuotas(
    IN p_nombre_producto VARCHAR(100),
    IN p_precio_costo DECIMAL(10,2),
    IN p_porcentaje_contado DECIMAL(5,2),
    IN p_interes_anual DECIMAL(5,2),
    IN p_cantidad_cuota INT
)
BEGIN
    DECLARE v_porcentaje_mensual DECIMAL(10,4);
    DECLARE v_precio_contado DECIMAL(10,2);
    DECLARE v_interes DECIMAL(10,2);
    DECLARE v_cuota DECIMAL(10,2);
    DECLARE v_resultado TEXT;
    DECLARE v_contador INT DEFAULT 1;
    
    -- Validaciones básicas
    IF p_precio_costo IS NULL OR p_precio_costo <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de costo debe ser mayor a 0';
    END IF;
    
    IF p_porcentaje_contado IS NULL OR p_porcentaje_contado <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El porcentaje para contado debe ser mayor a 0';
    END IF;
    
    IF p_interes_anual IS NULL OR p_interes_anual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El interés anual debe ser mayor a 0';
    END IF;
    
    IF p_cantidad_cuota IS NULL OR p_cantidad_cuota <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de cuotas debe ser mayor a 0';
    END IF;
    
    -- Calcular porcentaje mensual
    SET v_porcentaje_mensual = p_interes_anual / 12;
    
    -- Calcular precio de contado
    SET v_precio_contado = ROUND(p_precio_costo * (p_porcentaje_contado / 100) + p_precio_costo);
    
    -- Inicializar resultado
    IF p_nombre_producto IS NULL OR p_nombre_producto = '' THEN
        SET v_resultado = CONCAT('*PRODUCTO SIN NOMBRE*', CHAR(10));
    ELSE
        SET v_resultado = CONCAT('*', UPPER(p_nombre_producto), '*', CHAR(10));
    END IF;
    
    -- Calcular cuotas
    WHILE v_contador <= p_cantidad_cuota DO
        IF v_contador = 1 THEN
            -- Precio de contado
            SET v_resultado = CONCAT(v_resultado, 'Contado: ', FORMAT(CEIL(v_precio_contado/1000)*1000, 0), ' Gs.', CHAR(10));
        ELSE
            -- Calcular cuotas
            SET v_interes = v_porcentaje_mensual * v_contador;
            SET v_cuota = ROUND((v_precio_contado * (v_interes / 100) + v_precio_contado) / v_contador);
            SET v_cuota = CEIL(v_cuota/1000)*1000; -- Redondear al millar superior
            
            SET v_resultado = CONCAT(v_resultado, 
                                    v_contador, ' cuotas x ', 
                                    FORMAT(v_cuota, 0), ' Gs.', CHAR(10));
        END IF;
        
        SET v_contador = v_contador + 1;
    END WHILE;
    
    -- Agregar separador final
    SET v_resultado = CONCAT(v_resultado, '***************************************');
    
    -- Retornar resultado
    SELECT v_resultado AS resultado;
    
END //

DELIMITER ;


