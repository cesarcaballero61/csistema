DROP PROCEDURE IF EXISTS operacionesCaja;
DELIMITER $	
CREATE PROCEDURE operacionesCaja(op CHAR(1),codOpe INT,dfecha DATE, codEmpresa INT,codSucursal INT, codOperacion INT, nMonto INT, cDescripcion CHAR(100) ,tOperacion CHAR(1))
BEGIN
DECLARE codmax INT DEFAULT 0;
	SELECT MAX(idmov) FROM mov_operacion INTO codmax;
	
	IF ISNULL(codmax) THEN
		SET codmax=0;
	ELSE
		SET codmax=codmax+1;
	END IF;
	
	IF op="N" THEN
		
		INSERT INTO mov_operacion
			    (idMov,
			     fecha,
			     operacion,
			     Nro_comprobante,
			     monto,
			     tipo,
			     descripcion,
			     idconcepto,
			     idcliente,
			     idproveedor,
			     idsucursal,
			     idEmpresa)
		VALUES (codmax,
			dfecha,
			"OPC",
			"",
			nMonto,
			tOperacion,
			cDescripcion,
			codOperacion,
			NULL,
			NULL,
			codSucursal,
			codEmpresa);
	ELSE
		UPDATE mov_operacion SET fecha = dfecha,
			  Nro_comprobante = "",
			  monto = nMonto,
			  tipo = tOperacion,
			  descripcion = cDescripcion,
			  idconcepto = codOperacion,
			  idsucursal = codSucursal,
			  idEmpresa = codEmpresa
		WHERE idMov = codOpe;
	END IF;
END 