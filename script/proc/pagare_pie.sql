DROP PROCEDURE IF EXISTS pagare_pie;
DELIMITER $
CREATE PROCEDURE pagare_pie(cod_venta INT)
BEGIN
	SELECT
	    cliente.nombre AS nomb_cli
	    , cliente.apellido AS ape_cli
	    , cliente.ci AS ci_cli
	    , personal.nombre AS nom_ven
	    , personal.apellido AS ape_ven
	    , personal.ci AS ci_ven
	FROM
	    db.venta
	    INNER JOIN db.cliente 
		ON (venta.idcliente = cliente.idcliente)
	    INNER JOIN db.vendedor 
		ON (venta.idVendedor = vendedor.idVendedor)
	    INNER JOIN db.personal 
		ON (vendedor.idPersonal = personal.idPersonal) WHERE venta.idVenta=cod_venta;
 END 