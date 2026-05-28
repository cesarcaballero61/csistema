DELIMITER $$
DROP PROCEDURE IF EXISTS sp_resumen_cobranza_mes$$
CREATE PROCEDURE sp_resumen_cobranza_mes(
    IN p_mes INT,
    IN p_anio INT,
    IN p_idcobrador INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- Datos de la empresa y sucursal
        emp.idEmpresa,
        emp.empresa AS nombre_empresa,
        emp.ruc AS ruc_empresa,
        suc.idsucursal,
        suc.sucursal AS nombre_sucursal,
        suc.ciudad,
        suc.direccion AS direccion_sucursal,
        
        -- Datos del cobrador
        co.idcobrador,
        CONCAT(TRIM(pe.nombre), ' ', TRIM(pe.apellido)) AS cobrador,
        z.zona,
        pe.ci AS ci_cobrador,
        pe.telefono AS telefono_cobrador,
        
        -- Resumen de cuotas (CORREGIDO)
        COUNT(DISTINCT c.idcuotas) AS total_financiaciones,
        COUNT(cd.idcuotas_detalle) AS total_cuotas,
        SUM(cd.cuota) AS total_monto_original,
        
        -- Estado de cobranza (CORREGIDO - usa saldo_cuota)
        SUM(cd.cuota - cd.saldo_cuota) AS total_efectivamente_cobrado,
        SUM(cd.saldo_cuota) AS total_pendiente_real,
        SUM(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN cd.saldo_cuota ELSE 0 END) AS total_vencido_real,
        
        -- Porcentajes (CORREGIDOS)
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.cuota - cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_efectividad_real,
        
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_pendiente_real,
        
        -- Detalle de vencimientos (CORREGIDO)
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN 1 END) AS cuotas_vencidas,
        COUNT(CASE WHEN cd.estado = 'PEN' THEN 1 END) AS cuotas_pendientes,
        COUNT(CASE WHEN cd.estado = 'CAN' THEN 1 END) AS cuotas_cobradas,
        
        -- Información adicional sobre pagos parciales (NUEVO)
        COUNT(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 1 END) AS cuotas_con_pago_parcial,
        SUM(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN (cd.cuota - cd.saldo_cuota) ELSE 0 END) AS monto_pagos_parciales,
        
        -- Clientes activos
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN cl.idcliente END) AS clientes_con_saldo,
        COUNT(DISTINCT cl.idcliente) AS total_clientes_mes,
        
        -- Promedios (CORREGIDOS)
        ROUND(AVG(cd.cuota), 2) AS promedio_cuota_original,
        ROUND(AVG(cd.saldo_cuota), 2) AS promedio_saldo_pendiente,
        ROUND(AVG(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
                  THEN DATEDIFF(CURDATE(), cd.fecha_vto) END), 0) AS promedio_dias_vencido,
        
        -- Estadísticas de mora (NUEVO)
        MAX(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
            THEN DATEDIFF(CURDATE(), cd.fecha_vto) END) AS max_dias_vencido,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() AND DATEDIFF(CURDATE(), cd.fecha_vto) > 30 THEN 1 END) AS cuotas_mas_30_dias,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() AND DATEDIFF(CURDATE(), cd.fecha_vto) > 60 THEN 1 END) AS cuotas_mas_60_dias,
        
        -- Fechas de consulta
        CONCAT(p_mes, '/', p_anio) AS periodo_consulta,
        CURDATE() AS fecha_consulta,
        CONCAT('Del 01/', LPAD(p_mes, 2, '0'), '/', p_anio, ' al ', 
               DATE_FORMAT(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01')), '%d/%m/%Y')) AS rango_consulta

    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cl ON c.idcliente = cl.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN cobrador co ON v.idcobrador = co.idcobrador
    INNER JOIN personal pe ON co.idPersonal = pe.idPersonal
    INNER JOIN zona z ON co.idzona = z.idzona
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN empresa emp ON suc.idEmpresa = emp.idEmpresa
    
    WHERE MONTH(cd.fecha_vto) = p_mes 
        AND YEAR(cd.fecha_vto) = p_anio
        AND (p_idcobrador = 0 OR co.idcobrador = p_idcobrador)
        AND (p_idempresa = 0 OR emp.idEmpresa = p_idempresa)
        AND (p_idsucursal = 0 OR suc.idsucursal = p_idsucursal)
        AND c.anulado = 'NO'
    
    GROUP BY 
        emp.idEmpresa, emp.empresa, emp.ruc,
        suc.idsucursal, suc.sucursal, suc.ciudad, suc.direccion,
        co.idcobrador, cobrador, z.zona, pe.ci, pe.telefono
        
    ORDER BY 
        emp.empresa, 
        suc.sucursal, 
        total_pendiente_real DESC;
    
END$$

DELIMITER ;