DROP PROCEDURE IF EXISTS inf_list_precio;
DELIMITER $
CREATE PROCEDURE inf_list_precio(cod_grupo INT,cod_subgrupo INT, cod_marca INT)
BEGIN
IF cod_grupo=0 THEN
	IF cod_subgrupo=0 THEN
		IF cod_marca=0 THEN
			SELECT
				articulo.idarticulo
				, articulo.codbarra
				, articulo.descripcion
				, articulo.precio_contado
				, articulo.cant_pack
				, articulo.precio_combo
				, articulo.cant_combo
				, articulo.precio_unidad
				, grupo.idgrupo
				, grupo.grupo
				, subgrupo.idsubgrupo
				, subgrupo.subgrupo
				, marca.idMarca
				, marca.Marca
			FROM
				articulo
				INNER JOIN marca 
					ON (articulo.idMarca = marca.idMarca)
				INNER JOIN grupo 
					ON (articulo.idgrupo = grupo.idgrupo)
				INNER JOIN subgrupo 
					ON (articulo.idsubgrupo = subgrupo.idsubgrupo);
		ELSE

			SELECT
				articulo.idarticulo
				, articulo.codbarra
				, articulo.descripcion
				, articulo.precio_contado
				, articulo.cant_pack
				, articulo.precio_combo
				, articulo.cant_combo
				, articulo.precio_unidad
				, grupo.idgrupo
				, grupo.grupo
				, subgrupo.idsubgrupo
				, subgrupo.subgrupo
				, marca.idMarca
				, marca.Marca
			FROM
				articulo
				INNER JOIN marca 
					ON (articulo.idMarca = marca.idMarca)
				INNER JOIN grupo 
					ON (articulo.idgrupo = grupo.idgrupo)
				INNER JOIN subgrupo 
					ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE marca.idmarca=cod_marca;
		END IF;

	ELSE

			IF cod_marca=0 THEN
					SELECT
						articulo.idarticulo
						, articulo.codbarra
						, articulo.descripcion
						, articulo.precio_contado
						, articulo.cant_pack
						, articulo.precio_combo
						, articulo.cant_combo
						, articulo.precio_unidad
						, grupo.idgrupo
						, grupo.grupo
						, subgrupo.idsubgrupo
						, subgrupo.subgrupo
						, marca.idMarca
						, marca.Marca
					FROM
						articulo
						INNER JOIN marca 
							ON (articulo.idMarca = marca.idMarca)
						INNER JOIN grupo 
							ON (articulo.idgrupo = grupo.idgrupo)
						INNER JOIN subgrupo 
							ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE subgrupo.idsubgrupo=cod_subgrupo; 
				ELSE

					SELECT
						articulo.idarticulo
						, articulo.codbarra
						, articulo.descripcion
						, articulo.precio_contado
						, articulo.cant_pack
						, articulo.precio_combo
						, articulo.cant_combo
						, articulo.precio_unidad
						, grupo.idgrupo
						, grupo.grupo
						, subgrupo.idsubgrupo
						, subgrupo.subgrupo
						, marca.idMarca
						, marca.Marca
					FROM
						articulo
						INNER JOIN marca 
							ON (articulo.idMarca = marca.idMarca)
						INNER JOIN grupo 
							ON (articulo.idgrupo = grupo.idgrupo)
						INNER JOIN subgrupo 
							ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE marca.idmarca=cod_marca AND subgrupo.idsubgrupo=cod_subgrupo;
				END IF;
		END IF;
ELSE
IF cod_subgrupo=0 THEN
		IF cod_marca=0 THEN
			SELECT
				articulo.idarticulo
				, articulo.codbarra
				, articulo.descripcion
				, articulo.precio_contado
				, articulo.cant_pack
				, articulo.precio_combo
				, articulo.cant_combo
				, articulo.precio_unidad
				, grupo.idgrupo
				, grupo.grupo
				, subgrupo.idsubgrupo
				, subgrupo.subgrupo
				, marca.idMarca
				, marca.Marca
			FROM
				articulo
				INNER JOIN marca 
					ON (articulo.idMarca = marca.idMarca)
				INNER JOIN grupo 
					ON (articulo.idgrupo = grupo.idgrupo)
				INNER JOIN subgrupo 
					ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE grupo.idgrupo=cod_grupo;
		ELSE

			SELECT
				articulo.idarticulo
				, articulo.codbarra
				, articulo.descripcion
				, articulo.precio_contado
				, articulo.cant_pack
				, articulo.precio_combo
				, articulo.cant_combo
				, articulo.precio_unidad
				, grupo.idgrupo
				, grupo.grupo
				, subgrupo.idsubgrupo
				, subgrupo.subgrupo
				, marca.idMarca
				, marca.Marca
			FROM
				articulo
				INNER JOIN marca 
					ON (articulo.idMarca = marca.idMarca)
				INNER JOIN grupo 
					ON (articulo.idgrupo = grupo.idgrupo)
				INNER JOIN subgrupo 
					ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE marca.idmarca=cod_marca AND grupo.idgrupo=cod_grupo;
		END IF;

	ELSE

			IF cod_marca=0 THEN
					SELECT
						articulo.idarticulo
						, articulo.codbarra
						, articulo.descripcion
						, articulo.precio_contado
						, articulo.cant_pack
						, articulo.precio_combo
						, articulo.cant_combo
						, articulo.precio_unidad
						, grupo.idgrupo
						, grupo.grupo
						, subgrupo.idsubgrupo
						, subgrupo.subgrupo
						, marca.idMarca
						, marca.Marca
					FROM
						articulo
						INNER JOIN marca 
							ON (articulo.idMarca = marca.idMarca)
						INNER JOIN grupo 
							ON (articulo.idgrupo = grupo.idgrupo)
						INNER JOIN subgrupo 
							ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE subgrupo.idsubgrupo=cod_subgrupo AND grupo.idgrupo=cod_grupo; 
				ELSE

					SELECT
						articulo.idarticulo
						, articulo.codbarra
						, articulo.descripcion
						, articulo.precio_contado
						, articulo.cant_pack
						, articulo.precio_combo
						, articulo.cant_combo
						, articulo.precio_unidad
						, grupo.idgrupo
						, grupo.grupo
						, subgrupo.idsubgrupo
						, subgrupo.subgrupo
						, marca.idMarca
						, marca.Marca
					FROM
						articulo
						INNER JOIN marca 
							ON (articulo.idMarca = marca.idMarca)
						INNER JOIN grupo 
							ON (articulo.idgrupo = grupo.idgrupo)
						INNER JOIN subgrupo 
							ON (articulo.idsubgrupo = subgrupo.idsubgrupo) WHERE marca.idmarca=cod_marca AND subgrupo.idsubgrupo=cod_subgrupo AND grupo.idgrupo=cod_grupo;
				END IF;
		END IF;
END IF;




		
			
		

END