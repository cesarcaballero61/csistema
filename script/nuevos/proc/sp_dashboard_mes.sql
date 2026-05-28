DELIMITER $$

DROP PROCEDURE IF EXISTS sp_dashboard_mes $$
CREATE PROCEDURE sp_dashboard_mes(
    IN pEmpresa  INT,
    IN pSucursal INT,
    IN pFecha    DATE
)
BEGIN
    DECLARE vDesde DATE;
    DECLARE vHasta DATE;

    DECLARE vTotVentasMes      DECIMAL(18,2);
    DECLARE vTotContado        DECIMAL(18,2);
    DECLARE vTotCredito        DECIMAL(18,2);

    DECLARE vTotalMesCuotas    DECIMAL(18,2);
    DECLARE vTotalCobradoMes   DECIMAL(18,2);
    DECLARE vTotalPendienteMes DECIMAL(18,2);
    DECLARE vPorcCobranza      DECIMAL(9,2);

    DECLARE vCantCuotasPendMes INT;
    DECLARE vCantCuotastotalcMes INT;
    DECLARE vCantCuotasCobMes  INT;

    /* Rango del mes de pFecha */
    SET vDesde = DATE_FORMAT(pFecha, '%Y-%m-01');
    SET vHasta = LAST_DAY(pFecha);

    /* 1) VENTAS DEL MES (TOTAL / CONTADO / CREDITO) */
    SELECT 
        IFNULL(SUM(v.total),0),
        IFNULL(SUM(CASE WHEN v.tipo='CON' THEN v.total ELSE 0 END),0),
        IFNULL(SUM(CASE WHEN v.tipo='CRE' THEN v.total ELSE 0 END),0)
    INTO
        vTotVentasMes,
        vTotContado,
        vTotCredito
    FROM venta v
    WHERE v.fecha BETWEEN vDesde AND vHasta
      AND v.estado = 'F'
      AND v.idEmpresa = pEmpresa
      AND v.idsucursal = pSucursal;

    /* 2) COBRANZAS DEL MES */
    /* Total de cuotas con vencimiento en el mes */
    SELECT IFNULL(SUM(cd.cuota),0)
    INTO vTotalMesCuotas
    FROM cuotas_detalle cd
    JOIN cuotas c ON c.idcuotas = cd.idcuotas
    WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
      AND c.anulado = 'NO';

    /* Total cobrado de esas cuotas en el mes */
    SELECT IFNULL(SUM(dpc.importe),0)
    INTO vTotalCobradoMes
    FROM detalle_pagos_cuotas dpc
    JOIN pagos_cuotas pc ON pc.idpago = dpc.idpago
    WHERE dpc.tipo_pago = 'CUOTA'
      AND dpc.fecha_vto BETWEEN vDesde AND vHasta
      AND pc.estado = 'COB'
      AND pc.idEmpresa = pEmpresa
      AND pc.idsucursal = pSucursal;

    SET vTotalPendienteMes = vTotalMesCuotas - vTotalCobradoMes;
    IF vTotalPendienteMes < 0 THEN
        SET vTotalPendienteMes = 0;
    END IF;

    IF vTotalMesCuotas > 0 THEN
        SET vPorcCobranza = (vTotalCobradoMes / vTotalMesCuotas) * 100;
    ELSE
        SET vPorcCobranza = 0;
    END IF;

    /* 3) CUOTAS PENDIENTES / VENCIDAS / COBRADAS DEL MES */

	/* 3.1) Cantidad de cuotas PENDIENTES del mes (estado PEN) */
	SELECT COUNT(*)
	INTO vCantCuotasPendMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND cd.estado = 'PEN'
	  AND c.anulado = 'NO';

	/* 3.2) Cantidad de cuotas del mes  
		(vto en el mes, ya vencidas hoy, estado PEN o CAN) */
	SELECT COUNT(*)
	INTO vCantCuotastotalcMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND c.anulado = 'NO';

	/* 3.3) Cantidad de cuotas COBRADAS del mes */
	SELECT COUNT(*)
	INTO vCantCuotasCobMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND cd.estado = 'CAN'
	  AND c.anulado = 'NO';


    /* RESULTADO ÚNICO PARA EL DASHBOARD */
    SELECT
        vTotVentasMes      AS total_ventas_mes,
        vTotContado        AS total_ventas_contado,
        vTotCredito        AS total_ventas_credito,

        vTotalMesCuotas    AS total_cuotas_mes,
        vTotalCobradoMes   AS total_cobrado_mes,
        vTotalPendienteMes AS total_pendiente_mes,
        vPorcCobranza      AS porcentaje_cobranza,

        vCantCuotasPendMes   AS cantidad_cuotas_pendientes_mes,
        vCantCuotastotalcMes AS cantidad_cuotas_total_mes,
        vCantCuotasCobMes    AS cantidad_cuotas_cobradas_mes;
END $$

DELIMITER ;
