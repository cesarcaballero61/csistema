DROP PROCEDURE IF EXISTS amb_plan_cuota;
DELIMITER $$

CREATE PROCEDURE amb_plan_cuota(
    tipo CHAR(1),
    IN n_cod INT,
    IN c_nombre_plan VARCHAR(45),
    IN n_margen_contado DECIMAL(10,2),
    IN n_interes_mensual DECIMAL(10,2),
    IN n_limite_cuota INT
)
BEGIN

    IF tipo = 'N' THEN
        INSERT INTO plan_cuota(
            nombre_plan, 
            margen_contado, 
            interes_mensual, 
            limite_cuota
        ) VALUES (
            c_nombre_plan,
            n_margen_contado,
            n_interes_mensual,
            n_limite_cuota
        );
        
    ELSEIF tipo = 'M' THEN
        UPDATE plan_cuota 
        SET nombre_plan = c_nombre_plan,
            margen_contado = n_margen_contado,
            interes_mensual = n_interes_mensual,
            limite_cuota = n_limite_cuota
        WHERE idplan_cuota = n_cod;
        
        
    ELSEIF tipo = 'B' THEN
        DELETE FROM plan_cuota 
        WHERE idplan_cuota = n_cod;
    
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tipo de operación no válido. Use N (Nuevo), M (Modificar) o B (Borrar).';
    END IF;

END$$
DELIMITER ;