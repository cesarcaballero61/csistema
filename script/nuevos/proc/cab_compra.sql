DROP PROCEDURE IF EXISTS cab_compra;
DELIMITER $
CREATE PROCEDURE cab_compra(
cap_fecha DATE,
cap_cod_proveedor INT,
cap_cod_tipo_doc INT,
cap_cod_deposito INT,
cap_factura CHAR(20),
cap_total_exenta INT,
cap_total_gravada5 INT,
cap_total_gravada10 INT,
cap_total INT,
cap_liqui_iva_cinco INT,
cap_liqui_iva_diez INT,
cap_total_liqui_iva INT,
cod_sucursal INT,
cod_empresa INT,
cod_personal INT
)
BEGIN
DECLARE codigo INT;
SELECT MAX(idcompra) FROM compra INTO codigo;

IF ISNULL(codigo) THEN
	SET codigo=1;
ELSE
	SET codigo=codigo+1;
END IF;

INSERT INTO compra
            (idcompra,
             fecha,
             nro_factura,
             tipo,
             estado,
             total_gravadas_excenta,
             total_gravadas_cinco,
             total_gravadas_diez,
             total,
             liqui_iva_cinco,
             liqui_iva_diez,
             total_liqui_iva,
             idproveedor,
             iddeposito,
             idsucursal,
             idEmpresa,
             idpersonal)
VALUES (codigo,
        cap_fecha,
        cap_factura,
        cap_cod_tipo_doc,
        "F",
        cap_total_exenta,
        cap_total_gravada5,
        cap_total_gravada10,
        cap_total,
        cap_liqui_iva_cinco,
        cap_liqui_iva_diez,
        cap_total_liqui_iva,
        cap_cod_proveedor,
        cap_cod_deposito,
        cod_sucursal,
        cod_empresa,
        cod_personal);
SELECT codigo;
END