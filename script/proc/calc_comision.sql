drop function if exists calc_comision;
DELIMITER $$

CREATE FUNCTION calc_comision (monto INT,poc INT)
    RETURNS INT

    BEGIN
		DECLARE resultado INT;
	SET resultado=(monto*poc)/100;
	
		RETURN resultado;
    END$$

DELIMITER ;