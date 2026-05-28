DROP PROCEDURE IF EXISTS cur_cuota;
DELIMITER $
CREATE PROCEDURE cur_cuota(cod_cliente INT)
BEGIN

SELECT
    venta.nrofactura
    , cuotas.saldo_inicial AS monto
    , cuotas.entrega_inicial AS entrega
    , cuotas.SALDO_ACTUAL AS saldo
    , cuotas.cantidad_cuota AS cantidad
    , cuotas.idcuotas AS codcuota
    , venta.idVenta AS codventa
    , cobrador.idcobrador
    , personal.idPersonal
    , personal.nombre
    , personal.apellido
	,cuotas.obs
FROM venta
     INNER JOIN cliente ON venta.idcliente = cliente.idcliente
     INNER JOIN cuotas ON cuotas.idVenta = venta.idVenta 
     INNER JOIN cobrador ON cobrador.idcobrador=venta.idcobrador
     INNER JOIN personal ON cobrador.idPersonal=personal.idPersonal
     WHERE venta.tipo=2 AND cliente.idcliente=cod_cliente AND CUOTAS.estado="PEN" AND venta.estado="F";

END
