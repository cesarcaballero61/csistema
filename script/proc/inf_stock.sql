DROP PROCEDURE IF EXISTS inf_stock;
DELIMITER $
CREATE PROCEDURE inf_stock(cod_grupo INT,cod_subgrupo INT, cod_marca INT,cod_tipo INT)
BEGIN
IF cod_grupo=0 THEN
	IF cod_subgrupo=0 THEN
		IF cod_marca=0 THEN
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal);
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) WHERE stockarticulo.stock<=0;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) WHERE articulo.stockminimo>=stockarticulo.stock;
			END IF;
		ELSE -- por marca
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) WHERE articulo.idmarca=cod_marca;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE stockarticulo.stock<=0 AND articulo.idmarca=cod_marca;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idmarca=cod_marca;
			END IF;				
		END IF;
	ELSE -- por subgrupos
		IF cod_marca=0 THEN
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) WHERE  articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE stockarticulo.stock<=0 AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idsubgrupo=cod_subgrupo;
			END IF;

		ELSE -- por marca
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE stockarticulo.stock<=0 AND articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
				END IF;				
			END IF;
		END IF;
ELSE -- por grupo

	IF cod_subgrupo=0 THEN
		IF cod_marca=0 THEN
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE articulo.idgrupo=cod_grupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE stockarticulo.stock<=0 AND articulo.idgrupo=cod_grupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idgrupo=cod_grupo;
			END IF;
		ELSE -- por marca
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					WHERE articulo.idmarca=cod_marca AND  articulo.idgrupo=cod_grupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE stockarticulo.stock<=0 AND articulo.idmarca=cod_marca AND  articulo.idgrupo=cod_grupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
					WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idmarca=cod_marca AND  articulo.idgrupo=cod_grupo;
			END IF;				
		END IF;
	ELSE -- por subgrupos
		IF cod_marca=0 THEN
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) WHERE  articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal)
				WHERE stockarticulo.stock<=0 AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idsubgrupo=cod_subgrupo;
			END IF;
		ELSE -- por marca
			IF cod_tipo=1 THEN -- todos los stock.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=2 THEN -- stock cero
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
				WHERE stockarticulo.stock<=0 AND articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
			ELSEIF cod_tipo=3 THEN	-- stock minimo.
				SELECT
					articulo.codbarra
					, articulo.descripcion
					, articulo.precio_costo
					, articulo.precio_contado
					, articulo.stockminimo
					, stockarticulo.stock
					, deposito.iddeposito
					, deposito.deposito
					, sucursal.idsucursal
					, sucursal.sucursal
				FROM
					stockarticulo
					INNER JOIN articulo 
						ON (stockarticulo.idarticulo = articulo.idarticulo)
					INNER JOIN deposito 
						ON (deposito.iddeposito = stockarticulo.iddeposito)
					INNER JOIN sucursal 
						ON (stockarticulo.idsucursal = sucursal.idsucursal) 
					WHERE articulo.stockminimo>=stockarticulo.stock AND articulo.idmarca=cod_marca AND articulo.idsubgrupo=cod_subgrupo;
				end if;				
			end if;
		end if;
end if;
	
END