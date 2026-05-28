DROP FUNCTION IF EXISTS f_get_apertura_activa;
DELIMITER $
CREATE FUNCTION f_get_apertura_activa(p_idpersonal INT) 
RETURNS INT
READS SQL DATA
DETERMINISTIC
BEGIN
    DECLARE v_idapecierre INT;
    
    SELECT idapecierre INTO v_idapecierre
    FROM apecierrecaja 
    WHERE idpersonal = p_idpersonal 
        AND estado = 'A'
    ORDER BY idapecierre DESC 
    LIMIT 1;
    
    RETURN v_idapecierre;
END$
DELIMITER ;


SELECT f_get_apertura_activa(1)AS idapercierre;