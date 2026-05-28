DELIMITER $$

DROP PROCEDURE IF EXISTS sp_resumen_morosidad_clientes$$

CREATE PROCEDURE sp_resumen_morosidad_clientes(
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        c.idcliente,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente,
        c.ci,
        c.celular,
        z.zona,
        b.barrio,
        
        -- Totales
        COUNT(DISTINCT cu.idcuotas) AS total_creditos,
        COUNT(cd.idcuotas_detalle) AS total_cuotas_pendientes,
        
        -- Cuotas vencidas
        SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN 1 ELSE 0 END) AS cuotas_vencidas,
        MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) AS max_dias_vencido,
        
        -- Montos
        SUM(cd.cuota) AS total_deuda,
        SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN cd.cuota ELSE 0 END) AS total_vencido,
        
        -- Clasificación de morosidad
        CASE 
            WHEN MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) > 30 THEN 'MOROSO GRAVE'
            WHEN MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) > 15 THEN 'MOROSO MODERADO'
            WHEN SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN 1 ELSE 0 END) > 0 THEN 'MOROSO LEVE'
            ELSE 'AL DÍA'
        END AS estado_morosidad,
        
        -- Próximo vencimiento
        MIN(CASE WHEN cd.fecha_vto >= CURDATE() THEN cd.fecha_vto ELSE NULL END) AS proximo_vencimiento,
        
        -- Cobrador asignado
        CONCAT(TRIM(pc.nombre), ' ', TRIM(pc.apellido)) AS cobrador_asignado
        
    FROM cliente c
    INNER JOIN venta v ON c.idcliente = v.idcliente
    INNER JOIN cuotas cu ON v.idVenta = cu.idVenta
    INNER JOIN cuotas_detalle cd ON cu.idcuotas = cd.idcuotas
    INNER JOIN zona z ON c.idzona = z.idzona
    INNER JOIN barrio b ON c.idbarrio = b.idbarrio
    LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
    LEFT JOIN personal pc ON cob.idPersonal = pc.idPersonal
    WHERE cd.estado = 'PEN'
    AND cu.anulado = 'NO'
    AND v.estado = 'F'
    AND (p_idsucursal IS NULL OR v.idsucursal = p_idsucursal)
    GROUP BY c.idcliente
    HAVING total_cuotas_pendientes > 0
    ORDER BY max_dias_vencido DESC, total_vencido DESC;
    
END$$

DELIMITER ;