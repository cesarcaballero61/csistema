DELIMITER $$
DROP PROCEDURE IF EXISTS abm_articulo $$
CREATE PROCEDURE `abm_articulo`(
    IN p_operacion CHAR(1),
    IN p_idarticulo INT,
    IN p_descripcion VARCHAR(100),
    IN p_codbarra CHAR(45),
    IN p_idplan_cuota INT,
    IN p_idMarca INT,
    IN p_idgrupo INT,
    IN p_idsubgrupo INT,
    IN p_idproveedor INT,
    IN p_unidad VARCHAR(45),
    IN p_ultima_fecha_compra DATE,
    IN p_ultima_fecha_venta DATE,
    IN p_ultima_fecha_ajuste DATE,
    IN p_impuesto ENUM('10','5'),
    IN p_margen_contado DECIMAL(10,2),
    IN p_interes_mensual DECIMAL(10,2),
    IN p_limite_cuota DECIMAL(10,0),
    IN p_precio_costo INT,
    IN p_precio_contado INT,
    IN p_stockminimo INT,
    IN p_tipo_imagen ENUM('LOCAL','URL'),
    IN p_foto TEXT,
    IN p_detalle TEXT,
    OUT p_codigo_generado VARCHAR(45),
    OUT p_error_code INT,
    OUT p_error_message VARCHAR(255)
)
BEGIN
    -- DECLARACIÓN DE VARIABLES
    DECLARE v_nuevo_codigo VARCHAR(45);
    DECLARE v_secuencia INT;
    DECLARE v_codigo_existente INT;
    DECLARE v_codigo_actual VARCHAR(45);
    
    -- HANDLER PARA CUALQUIER ERROR SQL (compatible con MySQL 5.6)
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    BEGIN
        SET p_error_code = 23000;
        SET p_error_message = 'Error de integridad: clave duplicada o restricción violada';
    END;
    
    DECLARE EXIT HANDLER FOR SQLSTATE '45000'
    BEGIN
        SET p_error_code = 45000;
        SET p_error_message = 'Error de validación';
    END;
    
    -- Inicializar parámetros de error
    SET p_error_code = 0;
    SET p_error_message = '';

    -- OPERACIÓN: NUEVO ARTÍCULO
    IF p_operacion = 'N' THEN
        IF p_codbarra IS NULL OR p_codbarra = '' THEN
            UPDATE secuencias SET valor = valor + 1 WHERE nombre = 'articulos';
            SELECT valor INTO v_secuencia FROM secuencias WHERE nombre = 'articulos';
            SET v_nuevo_codigo = LPAD(v_secuencia, 5, '0');
            
            WHILE EXISTS (SELECT 1 FROM articulo WHERE codbarra = v_nuevo_codigo) DO
                UPDATE secuencias SET valor = valor + 1 WHERE nombre = 'articulos';
                SELECT valor INTO v_secuencia FROM secuencias WHERE nombre = 'articulos';
                SET v_nuevo_codigo = LPAD(v_secuencia, 5, '0');
            END WHILE;
        ELSE
            SET v_nuevo_codigo = p_codbarra;
            
            SELECT COUNT(*) INTO v_codigo_existente 
            FROM articulo 
            WHERE codbarra = v_nuevo_codigo;
            
            IF v_codigo_existente > 0 THEN
                SET p_error_code = 45000;
                SET p_error_message = 'El código de barras ya existe en la base de datos';
                SET p_codigo_generado = '';
            END IF;
        END IF;

        -- Solo insertar si no hubo error
        IF p_error_code = 0 THEN
            INSERT INTO articulo (
                descripcion, codbarra, idplan_cuota, idMarca, idgrupo, idsubgrupo, 
                idproveedor, unidad, ultima_fecha_compra, ultima_fecha_venta, 
                ultima_fecha_ajuste, impuesto, margen_contado, interes_mensual, 
                limite_cuota, precio_costo, precio_contado, stockminimo, 
                tipo_imagen, foto, detalle
            ) VALUES (
                p_descripcion, v_nuevo_codigo, p_idplan_cuota, p_idMarca, p_idgrupo, 
                p_idsubgrupo, p_idproveedor, p_unidad, p_ultima_fecha_compra, 
                p_ultima_fecha_venta, p_ultima_fecha_ajuste, p_impuesto, 
                p_margen_contado, p_interes_mensual, p_limite_cuota, 
                p_precio_costo, p_precio_contado, p_stockminimo, p_tipo_imagen, 
                p_foto, p_detalle
            );
            
            SET p_codigo_generado = v_nuevo_codigo;
        END IF;

    -- OPERACIÓN: MODIFICAR ARTÍCULO
    ELSEIF p_operacion = 'M' THEN
        SELECT codbarra INTO v_codigo_actual 
        FROM articulo 
        WHERE idarticulo = p_idarticulo;
        
        IF p_codbarra IS NOT NULL AND p_codbarra != '' AND p_codbarra != v_codigo_actual THEN
            SELECT COUNT(*) INTO v_codigo_existente 
            FROM articulo 
            WHERE codbarra = p_codbarra AND idarticulo != p_idarticulo;
            
            IF v_codigo_existente > 0 THEN
                SET p_error_code = 45000;
                SET p_error_message = 'El código de barras ya existe en otro artículo';
                SET p_codigo_generado = v_codigo_actual;
            ELSE
                SET p_codigo_generado = p_codbarra;
            END IF;
        ELSE
            SET p_codigo_generado = v_codigo_actual;
        END IF;

        -- Solo actualizar si no hubo error
        IF p_error_code = 0 THEN
            UPDATE articulo 
            SET 
                descripcion = p_descripcion,
                codbarra = p_codigo_generado,
                idplan_cuota = p_idplan_cuota,
                idMarca = p_idMarca,
                idgrupo = p_idgrupo,
                idsubgrupo = p_idsubgrupo,
                idproveedor = p_idproveedor,
                unidad = p_unidad,
                impuesto = p_impuesto,
                margen_contado = p_margen_contado,
                interes_mensual = p_interes_mensual,
                limite_cuota = p_limite_cuota,
                precio_costo = p_precio_costo,
                precio_contado = p_precio_contado,
                stockminimo = p_stockminimo,
                tipo_imagen = p_tipo_imagen,
                foto = p_foto,
                detalle = p_detalle
            WHERE idarticulo = p_idarticulo;
        END IF;

    -- OPERACIÓN: ELIMINAR ARTÍCULO
    ELSEIF p_operacion = 'B' THEN
        SELECT codbarra INTO p_codigo_generado 
        FROM articulo 
        WHERE idarticulo = p_idarticulo;
        
        DELETE FROM articulo 
        WHERE idarticulo = p_idarticulo;

    ELSE
        SET p_error_code = 45000;
        SET p_error_message = 'Operación no válida. Use N, M o B.';
    END IF;

END$$

DELIMITER ;