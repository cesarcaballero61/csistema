DROP PROCEDURE IF EXISTS pagare_cab;
DELIMITER $
CREATE PROCEDURE pagare_cab(cod_venta INT)
BEGIN
SELECT
    venta.fecha
    , venta.total
    , cliente.ci
    , cliente.ruc
    , cliente.nombre
    , cliente.apellido
    , barrio.barrio
    , zona.zona
    , venta.nrofactura
    , cuotas.entrega_inicial
FROM
    venta
    INNER JOIN cliente 
        ON (venta.idcliente = cliente.idcliente)
    INNER JOIN barrio 
        ON (cliente.idbarrio = barrio.idbarrio)
    INNER JOIN zona 
        ON (cliente.idzona = zona.idzona)
	INNER JOIN cuotas 
	ON  (venta.idVenta=cuotas.idVenta)
		WHERE venta.idVenta=cod_Venta;

END