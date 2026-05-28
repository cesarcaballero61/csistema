DELIMITER $$
DROP PROCEDURE IF EXISTS ventas_cabecera$$

CREATE PROCEDURE ventas_cabecera(
	IN p_fecha DATE,
	IN p_fecha_vto DATE,
	IN p_tipo ENUM('CON','CRE'),
	IN p_nrosuc VARCHAR(5),
	IN p_nroexp VARCHAR(5),
	IN p_nrofactura VARCHAR(20),
	IN p_estado ENUM('A','F'),

	-- GRAVAMEN IVA
	IN p_exenta DECIMAL(10,2),
	IN p_gravada_cinco DECIMAL(10,2),
	IN p_gravada_diez DECIMAL(10,2),

	-- LIQUIDACION DE IVA
	IN p_liqui_iva_cinco DECIMAL(10,2),
	IN p_liqui_iva_diez DECIMAL(10,2),
	IN p_total_liqui_iva DECIMAL(10,2),

	-- TOTAL
	IN n_total DECIMAL(10,2),

	-- REFERENCIALES
	IN p_cod_vendedor INT,
	IN p_cod_cliente  INT,
	IN p_cod_sucursal INT,
	IN p_cod_empresa  INT,
	IN p_cod_deposito INT,
	IN p_cod_cobrador INT,
	IN p_cod_formapago INT,
	IN p_cod_usuario INT
)

BEGIN
	-- DECLARACION
	DECLARE v_nro_factura VARCHAR(20);
	DECLARE v_secuencia INT;
	
	
	IF p_nrofactura IS NULL OR p_nrofactura ='' THEN
		SELECT contador INTO v_secuencia FROM control_numeracion_timbrado
		WHERE tipo_documento = "FACTURA";
		SET v_nro_factura = LPAD(v_secuencia, 5, '0');
	ELSE
		SET v_nro_factura = p_nrofactura;
	END IF;
	
	
	INSERT INTO venta (
	  fecha,
	  fecha_vto_pagare,
	  hora,
	  tipo,
	  nrosuc,
	  nroexp,
	  nrofactura,
	  estado,
	  total_gravada_excenta,
	  total_gravada_cinco,
	  total_gravada_diez,
	  total,
	  liqui_iva_5,
	  liqui_iva_10,
	  total_liqui_iva,
	  idVendedor,
	  idcliente,
	  idsucursal,
	  idEmpresa,
	  iddeposito,
	  idcobrador,
	  idformapago,
	  idusuario
	)
	VALUES
	  (
	    p_fecha,
	    p_fecha_vto,
	    TIME(NOW()),
	    p_tipo,
	    p_nrosuc,
	    p_nroexp,
	    v_nro_factura,
	    p_estado,
	    p_exenta,
	    p_gravada_cinco,
	    p_gravada_diez,
	    n_total,
	    p_liqui_iva_cinco,
	    p_liqui_iva_diez,
	    p_total_liqui_iva,
	    p_cod_vendedor,
	    p_cod_cliente,
	    p_cod_sucursal,
	    p_cod_empresa,
	    p_cod_deposito,
	    p_cod_cobrador,
	    p_cod_formapago,
	    p_cod_usuario
	  );
		
	SELECT LAST_INSERT_ID() AS codigo;
	

END