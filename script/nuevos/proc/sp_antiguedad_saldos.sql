DELIMITER $$

DROP PROCEDURE IF EXISTS sp_antiguedad_saldos$$

CREATE PROCEDURE sp_antiguedad_saldos(
    IN p_idcobrador INT,
    IN p_fecha_corte DATE
)
BEGIN
    SELECT 
        e.empresa,
        s.sucursal AS nombre_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        c.ci AS ci_cliente,
        CONCAT(c.nombre, ' ', c.apellido)                      AS cliente,
        c.celular               			       AS telefonos,
        z.idzona					       AS idzona,
        z.zona                                                 AS zona,
        -- Datos del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pers.nombre), ' ', TRIM(pers.apellido))    AS nombre_cobrador,
        pers.ci                                                AS ci_cobrador,
        -- Antigüedad de saldos
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 0 AND 30 THEN cd.saldo_cuota ELSE 0 END) AS _0_30_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 31 AND 60 THEN cd.saldo_cuota ELSE 0 END) AS _31_60_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 61 AND 90 THEN cd.saldo_cuota ELSE 0 END) AS _61_90_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) > 90 THEN cd.saldo_cuota ELSE 0 END) AS mas_90_dias,
        -- SUMA TOTAL DE TODAS LAS ANTIGÜEDADES
        (SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 0 AND 30 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 31 AND 60 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 61 AND 90 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) > 90 THEN cd.saldo_cuota ELSE 0 END)) AS total_antiguedades,
        SUM(cd.saldo_cuota)                                     AS total_pendiente,
        SUM(CASE WHEN cd.fecha_vto >= p_fecha_corte THEN cd.saldo_cuota ELSE 0 END) AS cuotas_a_vencer,
        'Activo'                                                AS estado
    FROM cliente c
    INNER JOIN zona z ON z.idzona = c.idzona
    INNER JOIN cuotas cu ON cu.idcliente = c.idcliente
    INNER JOIN venta v ON v.idVenta = cu.idVenta
    INNER JOIN cuotas_detalle cd ON cd.idcuotas = cu.idcuotas
    INNER JOIN empresa e ON e.idEmpresa = v.idEmpresa
    INNER JOIN sucursal s ON s.idsucursal = v.idsucursal
    -- JOIN para cobrador
    LEFT JOIN cobrador cob ON cob.idcobrador = v.idcobrador
    LEFT JOIN personal pers ON pers.idPersonal = cob.idPersonal
    WHERE cd.estado = 'PEN'
      AND (p_idcobrador = 0 OR v.idcobrador = p_idcobrador)
    GROUP BY c.idcliente, cob.idcobrador, pers.nombre, pers.apellido, pers.ci
    ORDER BY nombre_cobrador, cliente;
END$$

DELIMITER ;

 CALL sp_antiguedad_saldos(0, '2025-11-24');