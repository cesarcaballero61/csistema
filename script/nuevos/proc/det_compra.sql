DROP PROCEDURE IF EXISTS det_compra;
DELIMITER $
CREATE PROCEDURE det_compra(
n_cantidad INT,
n_pre_costo DECIMAL(10,2),
n_iva INT,
n_excenta DECIMAL(10,2),
n_gravada5 DECIMAL(10,2),
n_gravada10 DECIMAL(10,2),
cod_compra INT,
cod_articulo INT,
n_subtotal DECIMAL(10,2)
)

BEGIN 
INSERT INTO detalle_compra
            (cantidad,
             preciocosto,
             iva,
             iva_exenta,
             iva_cinco,
             iva_diez,
             idcompra,
             idarticulo,
             subtotal)
VALUES (n_cantidad,
        n_pre_costo,
        n_iva,
        n_excenta,
        n_gravada5,
        n_gravada10,
        cod_compra,
        cod_articulo,
        n_subtotal);
END