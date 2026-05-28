DROP PROCEDURE IF EXISTS eliminar_articulo;
DELIMITER &
CREATE PROCEDURE eliminar_articulo(tnidArticulo INT)
BEGIN
	DECLARE codAjusteIni INT;
	SELECT DISTINCT detalle_ajuste_inicial.idAjuste_inicial FROM  detalle_ajuste_inicial WHERE detalle_ajuste_inicial.idarticulo
	=  tnidArticulo INTO codAjusteIni;
	
	DELETE FROM detalle_ajuste_inicial WHERE detalle_ajuste_inicial.idAjuste_inicial = codAjusteIni;	
	DELETE FROM ajuste_inicial WHERE ajuste_inicial.idAjuste_inicial = codAjusteIni;
	DELETE FROM kardex WHERE kardex.idarticulo = tnidArticulo;
	DELETE FROM stockarticulo WHERE idarticulo =tnidArticulo;
	DELETE FROM articulo WHERE idarticulo = tnidArticulo;
END
