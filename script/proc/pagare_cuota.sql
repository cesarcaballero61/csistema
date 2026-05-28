DROP PROCEDURE IF EXISTS pagare_cuota;
DELIMITER $
CREATE PROCEDURE pagare_cuota(cod_venta INT)
BEGIN
SELECT
    cuotas_detalle.orden_char
    , cuotas_detalle.fecha_vto
    , cuotas_detalle.cuota
FROM
    cuotas_detalle
    INNER JOIN cuotas 
        ON (cuotas_detalle.idcuotas = cuotas.idcuotas) WHERE cuotas.idVenta=cod_venta;
END