DROP PROCEDURE IF EXISTS amb_usuario;
DELIMITER $
CREATE PROCEDURE amb_usuario(
    tipo CHAR(1),
    cap_tipo_usuario INT,
    cap_codigo INT, 
    cap_cod_personal INT, 
    cap_user VARCHAR(45), 
    cap_clave VARCHAR(45)
)
BEGIN
    IF tipo = "N" THEN
        -- NUEVO USUARIO
        INSERT INTO usuario (nick, clave, idPersonal,tipo)
        VALUES (cap_user, cap_clave, cap_cod_personal,cap_tipo_usuario);
        
    ELSEIF tipo = "M" THEN
        -- MODIFICAR USUARIO
        UPDATE usuario
        SET 
            nick = cap_user,
            tipo = cap_tipo_usuario,
            idPersonal = cap_cod_personal
        WHERE idusuario = cap_codigo;
        
    ELSEIF tipo = "B" THEN
        -- ELIMINAR USUARIO
        DELETE FROM usuario 
        WHERE idusuario = cap_codigo;
        
    END IF;
END $
DELIMITER ;