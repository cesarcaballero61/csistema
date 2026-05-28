DROP PROCEDURE IF EXISTS cur_recibo;
DELIMITER $
CREATE PROCEDURE cur_recibo(cod_recibo INT)
BEGIN
SELECT
	 "CHORE"  lugar
	,empresa.ruc AS RUC_EMPRESA
	,empresa.empresa
	,empresa.descrip
	,empresa.telefono
	,sucursal.direccion
   , pagos_cuotas.nro_recibo
	, pagos_cuotas.total_importe
    , cuotas.nrofactura
    , cuotas.fecha_alta AS Fecha_factura
    , detalle_pagos_cuotas.fecha_vto
    , detalle_pagos_cuotas.orden_char
    , detalle_pagos_cuotas.importe
    , cliente.apellido
    , cliente.nombre
    , cliente.ruc
    , cliente.ci
    , personal.apellido AS ape_cobrador
    , personal.nombre AS nom_cobrador
FROM
    pagos_cuotas
    INNER JOIN cuotas 
        ON (pagos_cuotas.idcuotas = cuotas.idcuotas)
    INNER JOIN cliente 
        ON (cuotas.idcliente = cliente.idcliente)
    INNER JOIN detalle_pagos_cuotas 
        ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago)
    INNER JOIN cobrador 
        ON (pagos_cuotas.idcobrador = cobrador.idcobrador)
    INNER JOIN personal 
        ON (cobrador.idPersonal = personal.idPersonal)
	 INNER JOIN empresa
	 	  ON (pagos_cuotas.idEmpresa = empresa.idEmpresa)	 
	 INNER JOIN  sucursal
	 		ON(pagos_cuotas.idsucursal = sucursal.idsucursal) 
	WHERE pagos_cuotas.idpago=cod_recibo;
				
				
				
				

END