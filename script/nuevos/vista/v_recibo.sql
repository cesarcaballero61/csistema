DROP VIEW IF EXISTS v_recibo;
CREATE OR REPLACE VIEW v_recibo AS
SELECT 
    pc.idpago AS idpago,
    pc.fecha AS fecha,
    c.ci,
    c.apellido AS apellido,
    c.nombre AS nombre,
    pc.nro_recibo AS nro_recibo,
    c.idcliente AS idcliente,
    pc.total_importe AS tota_importe
FROM pagos_cuotas pc
JOIN cliente c ON pc.idcliente = c.idcliente
WHERE pc.estado = 'COB';


-- SELECT * FROM V_RECIBO WHERE 1=0