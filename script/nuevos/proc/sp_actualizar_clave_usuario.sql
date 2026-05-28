
+DELIMITER $$

DROP PROCEDURE IF EXISTS sp_actualizar_clave_usuario$$

CREATE PROCEDURE sp_actualizar_clave_usuario(
    IN p_idusuario INT,
    IN p_nueva_clave VARCHAR(48)
)
BEGIN
    UPDATE usuario 
    SET clave = p_nueva_clave
    WHERE idusuario = p_idusuario;
    
END$$

DELIMITER ;

SELECT MD5('admin') test;