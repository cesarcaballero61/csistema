DELIMITER $$
DROP PROCEDURE IF EXISTS sp_resumen_general_cobranza_mes$$
CREATE PROCEDURE sp_resumen_general_cobranza_mes(
    IN p_mes INT,
    IN p_anio INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- Datos de la empresa
        emp.idEmpresa,
        emp.empresa AS nombre_empresa,
        emp.ruc AS ruc_empresa,
        emp.descrip AS descripcion_empresa,
        emp.telefono AS telefono_empresa,
        
        -- Datos de la sucursal
        suc.idsucursal,
        suc.sucursal AS nombre_sucursal,
        suc.ciudad,
        suc.direccion AS direccion_sucursal,
        suc.telefono AS telefono_sucursal,
        
        -- Totales generales (CORREGIDOS)
        COUNT(DISTINCT c.idcuotas) AS total_financiaciones,
        COUNT(cd.idcuotas_detalle) AS total_cuotas_mes,
        SUM(cd.cuota) AS total_monto_original,  -- Monto original de las cuotas
        
        -- Estado de cobranza (CORREGIDO - usa saldo_cuota)
        SUM(cd.cuota - cd.saldo_cuota) AS total_efectivamente_cobrado,
        SUM(cd.saldo_cuota) AS total_pendiente_real,
        SUM(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN cd.saldo_cuota ELSE 0 END) AS total_vencido_real,
        
        -- Desglose por estado de cuotas
        COUNT(CASE WHEN cd.estado = 'CAN' THEN 1 END) AS cuotas_cobradas,
        COUNT(CASE WHEN cd.estado = 'PEN' THEN 1 END) AS cuotas_pendientes,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN 1 END) AS cuotas_vencidas,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto >= CURDATE() THEN 1 END) AS cuotas_por_vencer,
        
        -- Montos por estado (NUEVO - para comparación)
        SUM(CASE WHEN cd.estado = 'CAN' THEN cd.cuota ELSE 0 END) AS total_original_cobrado,
        SUM(CASE WHEN cd.estado = 'PEN' THEN cd.cuota ELSE 0 END) AS total_original_pendiente,
        
        -- Porcentajes de gestión (CORREGIDOS)
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
        
        -- Diferencia por pagos parciales (NUEVO)
        SUM(cd.cuota) - SUM(cd.saldo_cuota) AS diferencia_pagos_parciales,
        COUNT(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 1 END) AS cuotas_con_pago_parcial,
        
        -- Clientes involucrados
        COUNT(DISTINCT cl.idcliente) AS total_clientes,
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN cl.idcliente END) AS clientes_con_deuda,
        COUNT(DISTINCT CASE WHEN cd.estado = 'CAN' THEN cl.idcliente END) AS clientes_al_dia,
        
        -- Cobradores involucrados
        COUNT(DISTINCT co.idcobrador) AS total_cobradores,
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN co.idcobrador END) AS cobradores_con_cartera,
        
        -- Estadísticas financieras (ACTUALIZADAS)
        ROUND(AVG(cd.cuota), 2) AS promedio_valor_cuota_original,
        ROUND(AVG(cd.saldo_cuota), 2) AS promedio_saldo_pendiente,
        ROUND(MAX(cd.cuota), 2) AS cuota_mas_alta,
        ROUND(MIN(cd.cuota), 2) AS cuota_mas_baja,
        
        -- Estadísticas de vencimiento
        ROUND(AVG(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
                  THEN DATEDIFF(CURDATE(), cd.fecha_vto) END), 0) AS promedio_dias_vencido,
        
        MAX(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
            THEN DATEDIFF(CURDATE(), cd.fecha_vto) END) AS max_dias_vencido,
        
        -- Información del período consultado
        CONCAT(p_mes, '/', p_anio) AS periodo_consulta,
        DATE_FORMAT(CONCAT(p_anio, '-', p_mes, '-01'), '%M %Y') AS periodo_descripcion,
        DATE_FORMAT(CURDATE(), '%d/%m/%Y %H:%i:%s') AS fecha_generacion_reporte,
        DAY(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01'))) AS dias_del_mes,
        DAY(CURDATE()) AS dia_actual,
        
        -- Rangos de fechas para el período
        DATE_FORMAT(CONCAT(p_anio, '-', p_mes, '-01'), '%d/%m/%Y') AS inicio_periodo,
        DATE_FORMAT(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01')), '%d/%m/%Y') AS fin_periodo

    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cl ON c.idcliente = cl.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN cobrador co ON v.idcobrador = co.idcobrador
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN empresa emp ON suc.idEmpresa = emp.idEmpresa
    
    WHERE MONTH(cd.fecha_vto) = p_mes 
        AND YEAR(cd.fecha_vto) = p_anio
        AND (p_idempresa = 0 OR emp.idEmpresa = p_idempresa)
        AND (p_idsucursal = 0 OR suc.idsucursal = p_idsucursal)
        AND c.anulado = 'NO'
    
    GROUP BY 
        emp.idEmpresa, emp.empresa, emp.ruc, emp.descrip, emp.telefono,
        suc.idsucursal, suc.sucursal, suc.ciudad, suc.direccion, suc.telefono;
    
END$$

DELIMITER ;