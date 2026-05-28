DROP PROCEDURE IF EXISTS venta_det;
DELIMITER $
CREATE PROCEDURE venta_det(
n_cantidad INT
,n_precioventa INT
,n_preciocosto INT
,n_iva INT
,n_gravada_exenta INT
,n_gravada_cinco INT
,n_gravada_diez INT
,n_subtotal INT
,cod_venta INT
,cod_Arti INT
,cod_depos INT
)
BEGIN 

INSERT INTO detalle_venta
            (cantidad,
             preventa,
             precosto,
             iva,
             gravada_excenta,
             gravada_cinco,
             gravada_diez,
             subtotal,
             idarticulo,
             iddeposito,
             idVenta)
VALUES (n_cantidad,
        n_precioventa,
        n_preciocosto,
        n_iva,
        n_gravada_exenta,
        n_gravada_cinco,
        n_gravada_diez,
        n_subtotal,
        cod_Arti,
        cod_depos,
        cod_venta);
END
