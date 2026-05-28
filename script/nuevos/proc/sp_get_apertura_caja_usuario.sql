DELIMITER $$

DROP PROCEDURE IF EXISTS sp_get_apertura_caja_usuario$$

CREATE PROCEDURE `sp_get_apertura_caja_usuario`(
    IN p_idpersonal INT
)
BEGIN
    DECLARE v_count INT;
    
    -- Verificar si existe apertura activa
    SELECT COUNT(*) INTO v_count
    FROM apecierrecaja 
    WHERE idpersonal = p_idpersonal AND estado = 'A';
    
    IF v_count > 0 THEN
        SELECT 
            ac.idapecierre,
            ac.fechaape,
            ac.horaape,
            ac.montoape,
            ac.fechacierre,
            ac.horacierre,
            ac.montocierre,
            ac.estado,
            ac.idpersonal,
            ac.ingreso,
            ac.egreso,
            ac.diferencia,
            p.nombre,
            p.apellido,
            p.ci,
            s.sucursal,
            e.empresa,
            'APERTURA_ENCONTRADA' AS resultado
        FROM apecierrecaja ac
        INNER JOIN personal p ON ac.idpersonal = p.idPersonal
        INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
        INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
        WHERE ac.idpersonal = p_idpersonal
            AND ac.estado = 'A'
        ORDER BY ac.idapecierre DESC
        LIMIT 1;
    ELSE
        SELECT 
            NULL AS idapecierre,
            NULL AS fechaape,
            NULL AS horaape,
            NULL AS montoape,
            NULL AS fechacierre,
            NULL AS horacierre,
            NULL AS montocierre,
            NULL AS estado,
            p.idPersonal AS idpersonal,
            NULL AS ingreso,
            NULL AS egreso,
            NULL AS diferencia,
            p.nombre,
            p.apellido,
            p.ci,
            s.sucursal,
            e.empresa,
            'SIN_APERTURA' AS resultado
        FROM personal p
        INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
        INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
        WHERE p.idPersonal = p_idpersonal;
    END IF;
END$$

DELIMITER ;