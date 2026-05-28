DROP PROCEDURE IF EXISTS inf_inventario_inicial;
DELIMITER $
CREATE PROCEDURE inf_inventario_inicial(tdDesde DATE ,tdHasta DATE, tCodDep INT)
BEGIN
	IF tCodDep = 0 THEN
		SELECT
		    ajuste_inicial.idAjuste_inicial
		    , ajuste_inicial.fecha
		    , ajuste_inicial.idsucursal
		    , detalle_ajuste_inicial.iddeposito
		    , articulo.codbarra
		    , articulo.descripcion
		    , motivo_ajuste.motivo
		    , motivo_ajuste.tipo
		    , detalle_ajuste_inicial.cantidad
		    , detalle_ajuste_inicial.stock_anterior
		    , detalle_ajuste_inicial.cant_aju
		    , deposito.deposito
		    , ajuste_inicial.obs
		    , ajuste_inicial.idsucursal
		FROM
		    detalle_ajuste_inicial
		    INNER JOIN ajuste_inicial 
			ON (detalle_ajuste_inicial.idAjuste_inicial = ajuste_inicial.idAjuste_inicial)
		    INNER JOIN motivo_ajuste
			ON(ajuste_inicial.idmotivo = motivo_ajuste.idmotivo)
		    INNER JOIN deposito 
			ON (detalle_ajuste_inicial.iddeposito = deposito.iddeposito)
		    INNER JOIN articulo 
			ON (detalle_ajuste_inicial.idarticulo = articulo.idarticulo) WHERE ajuste_inicial.fecha>=tdDesde AND ajuste_inicial.fecha<=tdHasta;
	
	ELSE
		SELECT
		    ajuste_inicial.idAjuste_inicial
		    , ajuste_inicial.fecha
		    , ajuste_inicial.idsucursal
		    , detalle_ajuste_inicial.iddeposito
		    , articulo.codbarra
		    , articulo.descripcion
		    , motivo_ajuste.motivo
		    , motivo_ajuste.tipo
		    , detalle_ajuste_inicial.cantidad
		    , detalle_ajuste_inicial.stock_anterior
		    , detalle_ajuste_inicial.cant_aju
		    , deposito.deposito
		    , ajuste_inicial.obs
		    , ajuste_inicial.idsucursal
		FROM
		    detalle_ajuste_inicial
		    INNER JOIN ajuste_inicial 
			ON (detalle_ajuste_inicial.idAjuste_inicial = ajuste_inicial.idAjuste_inicial)
		    INNER JOIN motivo_ajuste
			ON(ajuste_inicial.idmotivo = motivo_ajuste.idmotivo)
		    INNER JOIN deposito 
			ON (detalle_ajuste_inicial.iddeposito = deposito.iddeposito)
		    INNER JOIN articulo 
			ON (detalle_ajuste_inicial.idarticulo = articulo.idarticulo) 
			WHERE ajuste_inicial.fecha>=tdDesde AND ajuste_inicial.fecha<=tdHasta
			AND detalle_Ajuste_inicial.iddeposito = tCodDep;	
	
	END IF;
		
END