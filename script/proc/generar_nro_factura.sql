DROP FUNCTION IF EXISTS generar_nro_factura;
DELIMITER $
CREATE FUNCTION generar_nro_factura(cod_exp INT,cod_sucursal INT)
RETURNS CHAR(17)
BEGIN

-- Inicializar las variables --
-- ----------------------------
-- contador_sucursal: contador p/ el digito que contenga el codigo de suscursal
-- contador_punto : contador p/ el digito que contenga el codigo de punto de expedicion.accessible
-- char_sucursal:  Para guardar la combersion en caracter del codigo de sucursal.
-- char_punto_expendio: Para guardar la combersion de caracteres del punto de expedicion.
-- ultmo_recibo_gen: almacena el numero de recibo.
-- contador_ultimo_recibo_gen: contador p/ el digito de recibo.
-- char_ultimo_recibo: para guardar la conversion en caracter de recibo.

DECLARE punto_expedicion,sucursal,contador_sucursal,contador_punto,ultimo_recibo_gen,contador_ultimo_recibo_gen INT;
DECLARE char_sucursal,char_punto_expendio,char_ultimo_recibo CHAR(17);

-- -----------------------------------------------------------------
-- COMBIERTE A CARACTER EL NRO. DE SUCURSAL Y EL PUNTO DE EXPEDICION
-- -----------------------------------------------------------------
SET char_sucursal= 	CAST(cod_sucursal AS CHAR);
SET char_punto_expendio=CAST(cod_exp AS CHAR);
-- -----------------------------------------------------------------
-- CUENTA LA CANTIDAD DE DIGITOS QUE EL NUMERO DE CONTINE EL NUMERO DE SUCURSAL Y PUNTO DE EXPENDIO.
-- -----------------------------------------------------------------
SET contador_sucursal=LENGTH(char_sucursal);
SET contador_punto= LENGTH(char_punto_expendio);
-- *-------------------------------------------
-- *CONVIERTE NRO. DE SUCURSAL EN CARACTER
-- *-------------------------------------------
IF contador_sucursal=1 THEN
	SET char_sucursal=CONCAT("00","",char_sucursal);
ELSE
	IF contador_sucursal=2 THEN
		SET char_sucursal=CONCAT("0","",char_sucursal);
	END IF;
END IF;
-- *---------------------------------------------
-- *CONVIERTE EL PUNTO DE EXPEDICION EN CARACTER.
-- *---------------------------------------------
IF char_punto_expendio=1 THEN
	SET char_punto_expendio=CONCAT("00","",char_punto_expendio);
ELSE
	IF char_punto_expendio=2 THEN
		SET char_punto_expendio=CONCAT("0","",char_punto_expendio);
	END IF;
END IF;
-- ---------------------------------------------------------
SELECT MAX(idventa) FROM venta INTO ultimo_recibo_gen;

IF ultimo_recibo_gen=0 THEN
	SET ultimo_recibo_gen=1;
ELSE
	SET ultimo_recibo_gen=ultimo_recibo_gen+1;
END IF;

SET char_ultimo_recibo=CAST(ultimo_recibo_gen AS CHAR);
SET contador_ultimo_recibo_gen=LENGTH(char_ultimo_recibo);

IF contador_ultimo_recibo_gen=1 THEN
	SET char_ultimo_recibo=CONCAT("000000","",char_ultimo_recibo);
ELSE
	IF contador_ultimo_recibo_gen=2 THEN
		SET char_ultimo_recibo=CONCAT("00000","",char_ultimo_recibo);
	ELSE
		IF contador_ultimo_recibo_gen=3 THEN
			SET char_ultimo_recibo=CONCAT("0000","",char_ultimo_recibo);
		ELSE
			IF contador_ultimo_recibo_gen=4 THEN
				SET char_ultimo_recibo=CONCAT("000","",char_ultimo_recibo);
			ELSE
				IF contador_ultimo_recibo_gen=5 THEN
					SET char_ultimo_recibo=CONCAT("00","",char_ultimo_recibo);
				ELSE
					IF contador_ultimo_recibo_gen=6 THEN
						SET char_ultimo_recibo=CONCAT("0","",char_ultimo_recibo);
					END IF;
				END IF;
			END IF;
		END IF;
	END IF;
END IF;
	SET char_ultimo_recibo= CONCAT_WS("-",char_sucursal,char_punto_expendio,char_ultimo_recibo);
	RETURN char_ultimo_recibo;
END