DROP PROCEDURE IF EXISTS inf_stock_valorizado;
DELIMITER $
CREATE PROCEDURE inf_stock_valorizado(cod_suc INT,cod_grupo INT,cod_subgrupo INT, cod_marca INT)
BEGIN
IF cod_suc=0 THEN

	IF cod_grupo=0 THEN

		IF cod_subgrupo=0 THEN

			IF cod_marca=0 THEN
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito);
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)	WHERE marca.idmarca=cod_marca;
			END IF;
		ELSE

			IF cod_marca=0 THEN
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE articulo.idsubgrupo=cod_subgrupo;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
			END IF;	
		END IF;
	ELSE
		IF cod_subgrupo=0 THEN

			IF cod_marca=0 THEN
			
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE articulo.idgrupo=cod_grupo;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idgrupo=cod_grupo;
			END IF;
		ELSE

			IF cod_marca=0 THEN
			
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)  WHERE articulo.idsubgrupo=cod_subgrupo AND articulo.idgrupo=cod_grupo;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo AND articulo.idgrupo=cod_grupo;
			END IF;	
		END IF;
	END IF;
ELSE
	IF cod_grupo=0 THEN

		IF cod_subgrupo=0 THEN

			IF cod_marca=0 THEN
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE stockarticulo.idsucursal;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND stockarticulo.idsucursal;
			END IF;
		ELSE

			IF cod_marca=0 THEN
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)  WHERE articulo.idsubgrupo=cod_subgrupo AND stockarticulo.idsucursal;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo AND stockarticulo.idsucursal;
			END IF;	
		END IF;
	ELSE
		IF cod_subgrupo=0 THEN

			IF cod_marca=0 THEN
			
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE articulo.idgrupo=cod_grupo AND stockarticulo.idsucursal;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idgrupo=cod_grupo AND stockarticulo.idsucursal;
			END IF;
		ELSE

			IF cod_marca=0 THEN
			
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE articulo.idsubgrupo=cod_subgrupo AND articulo.idgrupo=cod_grupo AND stockarticulo.idsucursal;
			ELSE
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_contado
					, articulo.precio_costo
					, grupo.idgrupo
					, grupo.grupo
					, subgrupo.idsubgrupo
					, subgrupo.subgrupo
					, marca.idMarca
					, marca.Marca
					, stockarticulo.stock
					, sucursal.sucursal
					, sucursal.idsucursal
					, deposito.iddeposito
					, deposito.deposito
				FROM
					articulo
					INNER JOIN marca 
						ON (articulo.idMarca = marca.idMarca)
					INNER JOIN grupo 
						ON (articulo.idgrupo = grupo.idgrupo)
					INNER JOIN subgrupo 
						ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
					INNER JOIN stockarticulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito) WHERE marca.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo AND articulo.idgrupo=cod_grupo AND stockarticulo.idsucursal;
			END IF;	
		end if;
	end if;

end if;
end