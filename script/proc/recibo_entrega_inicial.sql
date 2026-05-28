DROP PROCEDURE IF EXISTS recibo_entrega_inicial;
DELIMITER $
CREATE PROCEDURE recibo_entrega_inicial(cod_venta INT)
BEGIN
	SELECT
	    cliente.nombre AS nomb_cli
	    , cliente.apellido AS ape_cli
	    , cliente.ci AS ci_cli
	    , cliente.ruc AS ruc_cli
	    , venta.total
	    , empresa.ruc AS ruc_emp
	    , empresa.timb_desde
	    , empresa.timb_hasta
	    , empresa.Timbrado
	    , venta.idVenta AS nro_recibo
	    , cuotas.entrega_inicial
	    , VENTA.idVenta
	    , venta.nrofactura
	    , venta.fecha
	FROM
	    db.venta
	    INNER JOIN db.cliente 
		ON (venta.idcliente = cliente.idcliente)
	    INNER JOIN db.vendedor 
		ON (venta.idVendedor = vendedor.idVendedor)
	    INNER JOIN db.empresa 
		ON (venta.idEmpresa = empresa.idEmpresa)
	    INNER JOIN db.cuotas 
		ON (cuotas.idVenta = venta.idVenta) WHERE venta.idVenta=cod_venta;
   END