DROP PROCEDURE IF EXISTS cur_cuota_Act;
DELIMITER $
CREATE PROCEDURE cur_cuota_Act(cod_cliente INT)
BEGIN

SELECT
    venta.nrofactura
    ,venta.idVendedor
    ,venta.fecha
    , cuotas.saldo_inicial AS monto
    , cuotas.entrega_inicial AS entrega
    , cuotas.SALDO_ACTUAL AS saldo
    , cuotas.cantidad_cuota AS cantidad
    , cuotas.idcuotas AS codcuota
    , venta.idVenta AS codventa
    , cuotas.primera_fecha_vto
    , cuotas.dias_entre_pago
    , cobrador.idcobrador
    , personal.nombre
    , personal.apellido
    , per2.nombre AS nomb_ven
    , per2.apellido AS ape_vent
    ,cuotas.obs
FROM venta
     INNER JOIN cliente ON venta.idcliente = cliente.idcliente
     INNER JOIN cuotas ON cuotas.idVenta = venta.idVenta 
     INNER JOIN cobrador ON venta.idcobrador=cobrador.idcobrador
     INNER JOIN personal ON cobrador.idPersonal=personal.idPersonal
     INNER JOIN vendedor ON venta.idvendedor=vendedor.idVendedor
     INNER JOIN personal AS per2 ON vendedor.idPersonal=per2.idPersonal
     WHERE venta.tipo=2 AND cliente.idcliente=cod_cliente AND CUOTAS.estado="PEN" AND venta.estado="F";

END
