DROP PROCEDURE IF EXISTS pagare_articulo;
DELIMITER $
CREATE PROCEDURE pagare_articulo(cod_venta INT)
BEGIN
SELECT
    venta.idVenta
    , detalle_venta.cantidad
    , detalle_venta.preventa
    , articulo.codbarra
    , articulo.descripcion
FROM
    detalle_venta
    INNER JOIN venta 
        ON (detalle_venta.idVenta = venta.idVenta)
    INNER JOIN articulo 
        ON (articulo.idarticulo = detalle_venta.idarticulo) WHERE venta.idVenta=cod_venta;
        
 END