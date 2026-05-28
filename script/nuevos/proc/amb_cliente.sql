DROP PROCEDURE IF EXISTS amb_cliente;
DELIMITER $$
CREATE PROCEDURE amb_cliente(
    tipo CHAR(1),
    IN n_codigo INT,
    IN n_idzona INT,
    IN n_idbarrio INT,
    IN n_idprofesion INT,
    IN c_nombre VARCHAR(45),
    IN c_apellido VARCHAR(45),
    IN c_ruc VARCHAR(45),
    IN c_ci VARCHAR(45),
    IN c_celular VARCHAR(20),
    IN c_telefono VARCHAR(20),
    IN c_referencia TEXT,
    IN c_trabajo_lugar VARCHAR(45),
    IN c_trabajo_telefono VARCHAR(20),
    IN c_ref1 VARCHAR(45),
    IN c_ref2 VARCHAR(45),
    IN c_ref3 VARCHAR(45),
    IN c_reftel1 VARCHAR(45),
    IN c_reftel2 VARCHAR(45),
    IN c_reftel3 VARCHAR(45),
    IN c_foto TEXT
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE v_tiene_creditos INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(255);
    
    -- Validar tipo de operación
    IF tipo NOT IN ('N', 'M', 'B') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tipo de operación no válido. Use: N (Nuevo), M (Modificar), B (Borrar)';
    END IF;
    
    -- Validaciones para MODIFICAR y BORRAR
    IF tipo IN ('M', 'B') THEN
        -- Verificar que el cliente existe
        SELECT COUNT(*) INTO v_existe 
        FROM cliente 
        WHERE idcliente = n_codigo;
        
        IF v_existe = 0 THEN
            SET v_mensaje = CONCAT('El cliente con ID ', n_codigo, ' no existe.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
    END IF;
    
    -- Para BORRAR: verificar que no tenga créditos pendientes
    IF tipo = 'B' THEN
        SELECT COUNT(*) INTO v_tiene_creditos 
        FROM cuotas 
        WHERE idcliente = n_codigo AND estado = 'PEN' AND ANULADO = 'NO';
        
        IF v_tiene_creditos > 0 THEN
            SET v_mensaje = CONCAT('No se puede eliminar el cliente. Tiene ', v_tiene_creditos, ' crédito(s) pendiente(s).');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
        
        -- Verificar que no tenga ventas asociadas
        SELECT COUNT(*) INTO v_tiene_creditos 
        FROM venta 
        WHERE idcliente = n_codigo AND estado = 'F';
        
        IF v_tiene_creditos > 0 THEN
            SET v_mensaje = 'No se puede eliminar el cliente. Tiene ventas asociadas.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
    END IF;

    -- Ejecutar operación según el tipo
    CASE tipo
        WHEN 'N' THEN
            -- Validar datos obligatorios para nuevo cliente
            IF c_nombre IS NULL OR TRIM(c_nombre) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del cliente es obligatorio.';
            END IF;
            
            IF c_apellido IS NULL OR TRIM(c_apellido) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido del cliente es obligatorio.';
            END IF;
            
            -- Insertar nuevo cliente (sin especificar idcliente, para que se autoincremente)
            INSERT INTO cliente(
                idzona, idbarrio, idprofesion, nombre, apellido, 
                ruc, ci, celular, telefono, referencia, trabajo_lugar, 
                trabajo_telefono, ref1, ref2, ref3, reftel1, reftel2, reftel3, foto
            ) VALUES (
                NULLIF(n_idzona, 0),
                NULLIF(n_idbarrio, 0),
                NULLIF(n_idprofesion, 0),
                c_nombre,
                c_apellido,
                NULLIF(c_ruc, ''),
                NULLIF(c_ci, ''),
                NULLIF(c_celular, ''),
                NULLIF(c_telefono, ''),
                NULLIF(c_referencia, ''),
                NULLIF(c_trabajo_lugar, ''),
                NULLIF(c_trabajo_telefono, ''),
                NULLIF(c_ref1, ''),
                NULLIF(c_ref2, ''),
                NULLIF(c_ref3, ''),
                NULLIF(c_reftel1, ''),
                NULLIF(c_reftel2, ''),
                NULLIF(c_reftel3, ''),
                c_foto
            );
            
            -- Obtener el último ID insertado
            SELECT 
                LAST_INSERT_ID() AS nuevo_id, 
                'Cliente creado exitosamente' AS mensaje,
                CONCAT('ID: ', LAST_INSERT_ID(), ' - ', TRIM(c_nombre), ' ', TRIM(c_apellido)) AS detalle;
            
        WHEN 'M' THEN
            -- Validar datos obligatorios para modificación
            IF c_nombre IS NULL OR TRIM(c_nombre) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del cliente es obligatorio.';
            END IF;
            
            IF c_apellido IS NULL OR TRIM(c_apellido) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido del cliente es obligatorio.';
            END IF;
            
            -- Actualizar cliente existente
            UPDATE cliente 
            SET 
                idzona = NULLIF(n_idzona, 0),
                idbarrio = NULLIF(n_idbarrio, 0),
                idprofesion = NULLIF(n_idprofesion, 0),
                nombre = c_nombre,
                apellido = c_apellido,
                ruc = NULLIF(c_ruc, ''),
                ci = NULLIF(c_ci, ''),
                celular = NULLIF(c_celular, ''),
                telefono = NULLIF(c_telefono, ''),
                referencia = NULLIF(c_referencia, ''),
                trabajo_lugar = NULLIF(c_trabajo_lugar, ''),
                trabajo_telefono = NULLIF(c_trabajo_telefono, ''),
                ref1 = NULLIF(c_ref1, ''),
                ref2 = NULLIF(c_ref2, ''),
                ref3 = NULLIF(c_ref3, ''),
                reftel1 = NULLIF(c_reftel1, ''),
                reftel2 = NULLIF(c_reftel2, ''),
                reftel3 = NULLIF(c_reftel3, ''),
                foto = c_foto
            WHERE idcliente = n_codigo;
            
            SELECT 
                n_codigo AS id_actualizado, 
                'Cliente actualizado exitosamente' AS mensaje,
                CONCAT('ID: ', n_codigo, ' - ', TRIM(c_nombre), ' ', TRIM(c_apellido)) AS detalle;
            
        WHEN 'B' THEN
            -- Eliminar cliente (solo si pasa todas las validaciones)
            DELETE FROM cliente 
            WHERE idcliente = n_codigo;
            
            SELECT 
                n_codigo AS id_eliminado, 
                'Cliente eliminado exitosamente' AS mensaje,
                CONCAT('ID: ', n_codigo,'CI: ',TRIM(c_ci)) AS detalle;
    END CASE;

END$$
DELIMITER ;