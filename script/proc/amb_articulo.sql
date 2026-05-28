DROP PROCEDURE IF EXISTS amb_articulo;
DELIMITER $
CREATE PROCEDURE amb_articulo(tipo CHAR(1)
,n_codigo INT
,c_descripcion CHAR(100)
,c_barra CHAR(45)
,n_impuesto INT
,n_precio_costo INT
,n_precio_contado INT
,n_activo BOOL
,n_stockminimo INT
,n_idmarca INT
,n_idgrupo INT
,n_idsubgrupo INT
,n_idproveedor INT)
BEGIN
	DECLARE codigo INT;
	SELECT MAX(idarticulo) FROM articulo INTO codigo;

	IF ISNULL(codigo) THEN
		SET codigo=1;
	ELSE
		SET codigo=codigo+1;
	END IF;

IF tipo="N" THEN
	INSERT INTO articulo VALUES(codigo,c_descripcion,c_barra,CURDATE(),CURDATE(),CURDATE(),
	n_impuesto,n_precio_costo,n_precio_contado,n_activo,n_stockminimo,n_idmarca,n_idgrupo,
	n_idsubgrupo,n_idproveedor);
ELSE
	UPDATE articulo SET descripcion = c_descripcion,
					codbarra = c_barra,
					impuesto =n_impuesto,
					precio_costo=n_precio_costo,
					precio_contado=n_precio_contado,
					activo =n_activo,
					stockminimo=n_stockminimo,
					idMarca =n_idmarca,
					idgrupo = n_idgrupo,
					idsubgrupo = n_idsubgrupo,
					idproveedor =n_idproveedor 
	WHERE idarticulo = n_codigo;

END IF;
END