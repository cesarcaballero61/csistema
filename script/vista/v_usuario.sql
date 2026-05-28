DROP VIEW IF EXISTS v_usuario;
DELIMITER $
CREATE VIEW v_usuario  AS
SELECT
    usuario.idusuario
    , personal.idPersonal
    , personal.nombre
    , personal.apellido
    , usuario.nick
    , usuario.clave
FROM
    usuario
    INNER JOIN personal 
        ON (usuario.idPersonal = personal.idPersonal);