DROP VIEW IF EXISTS v_articulo2;
DELIMITER $
CREATE VIEW v_articulo2  AS
SELECT
    articulo.*
    , grupo.grupo
    , subgrupo.subgrupo
    , marca.Marca
    , proveedor.proveedor
FROM
    articulo
	JOIN grupo 
        ON (articulo.idgrupo = grupo.idgrupo)
	JOIN subgrupo 
        ON (articulo.idsubgrupo = subgrupo.idsubgrupo)
	JOIN marca 
        ON (articulo.idMarca = marca.idMarca)
	JOIN proveedor 
        ON (articulo.idproveedor = proveedor.idproveedor)
GROUP BY articulo.idarticulo 