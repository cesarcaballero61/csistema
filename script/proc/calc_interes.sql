DROP FUNCTION IF EXISTS calc_interes;
DELIMITER $$

CREATE FUNCTION `db`.`calc_interes`(d_atraso INT,n_monto INT,cod_sucursal INT)
    RETURNS NUMERIC(10,2)

    BEGIN
    DECLARE d_gracias, resultado_interes INT;
	DECLARE cal_interes CHAR(1);
    DECLARE proc_interes NUMERIC(10,2);
    
	SELECT dias_gracias FROM parametro_sistema WHERE idsucursal=cod_sucursal INTO d_gracias;
	SELECT calc_interes FROM parametro_sistema WHERE idsucursal=cod_sucursal INTO cal_interes;
	SELECT porc_interes_mor FROM parametro_sistema WHERE idsucursal=cod_sucursal INTO proc_interes;
    
	IF cal_interes="S" THEN
		IF (d_atraso > 0 + d_gracias) THEN
			SET resultado_interes=ROUND(((n_monto*proc_interes)/100) * (d_atraso/30),0);
		END IF;
		RETURN resultado_interes;
	ELSE
		RETURN 0;
	END IF; 
    END$$
