DROP PROCEDURE IF EXISTS cur_factura_Detalle ;

DELIMITER $

CREATE PROCEDURE cur_factura_Detalle (cod_venta INT, cod_cli INT) 
BEGIN
  SELECT 
    venta.liqui_iva_10,
    venta.idsucursal,
    venta.idEmpresa,
    personal.idPersonal,
    venta.fecha,
    venta.idformapago,
    venta.nrofactura,
    venta.idVenta,
    venta.liqui_iva_5,
    venta.tipo,
    venta.total,
    articulo.descripcion,
    articulo.codbarra,
    detalle_venta.cantidad,
    detalle_venta.preventa,
    detalle_venta.subtotal,
    detalle_venta.iddeposito,
    detalle_venta.idarticulo 
  FROM
    detalle_venta 
    INNER JOIN venta 
      ON (
        detalle_venta.idVenta = venta.idVenta
      ) 
    INNER JOIN articulo 
      ON (
        articulo.idarticulo = detalle_venta.idarticulo
      ) 
    INNER JOIN vendedor 
      ON (
        venta.idVendedor = vendedor.idVendedor
      ) 
    INNER JOIN personal 
      ON (
        vendedor.idPersonal = personal.idPersonal
      ) 
  WHERE venta.idventa = cod_venta 
    AND venta.idcliente = cod_cli 
    AND venta.estado = "F" ;
END 