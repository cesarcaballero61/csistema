DROP PROCEDURE IF EXISTS cambiar_cobrador;
DELIMITER $

CREATE PROCEDURE cambiar_cobrador(tnIdVenta INT,tnIdCobrador INT)
BEGIN
	UPDATE venta SET idcobrador = tnIdCobrador WHERE venta.idVenta = tnIdVenta;
END