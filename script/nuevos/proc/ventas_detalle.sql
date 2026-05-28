DELIMITER $$
DROP PROCEDURE IF EXISTS ventas_detalle$$
CREATE PROCEDURE ventas_detalle(
		  IN p_codventa INT,
		  IN p_tipo_cuota ENUM('CUOTA','CONTADO'),
		  IN p_plan_cuota VARCHAR(45),
		  IN p_interes_mensual DECIMAL(10),
		  IN p_cant_cuota INT,
		  IN p_margen_conta DECIMAL(10),
		  IN p_monto_cuota DECIMAL(10,2),
		  IN p_precosto DECIMAL(10,2),
		  IN p_cantidad INT,
		  IN p_preventa DECIMAL(10,2),
		  IN p_subtotal DECIMAL(10,2),
		  IN p_iva ENUM('0','10','5'),
		  IN p_gravada_excenta DECIMAL(10,2),
		  IN p_gravada_cinco DECIMAL(10,2),
		  IN p_gravada_diez DECIMAL(10,2),
		  IN p_idarticulo INT,
		  IN p_iddeposito INT
)

BEGIN

		INSERT INTO detalle_venta (
		  idVenta,
		  tipo_cuota,
		  plan_cuota,
		  interes_mensual,
		  cant_cuota,
		  margen_conta,
		  monto_cuota,
		  precosto,
		  cantidad,
		  preventa,
		  subtotal,
		  iva,
		  gravada_excenta,
		  gravada_cinco,
		  gravada_diez,
		  idarticulo,
		  iddeposito
		)	
		VALUES
		  (
		   p_codventa ,
		   p_tipo_cuota,
		   p_plan_cuota ,
		   p_interes_mensual ,
		   p_cant_cuota ,
		   p_margen_conta ,
		   p_monto_cuota ,
		   p_precosto ,
		   p_cantidad ,
		   p_preventa ,
		   p_subtotal ,
		   p_iva,
		   p_gravada_excenta ,
		   p_gravada_cinco ,
		   p_gravada_diez ,
		   p_idarticulo ,
		   p_iddeposito 
		  );

END