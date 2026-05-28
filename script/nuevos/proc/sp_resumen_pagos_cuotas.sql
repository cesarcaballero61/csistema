DELIMITER $$

DROP PROCEDURE IF EXISTS sp_resumen_pagos_cuotas$$

CREATE PROCEDURE sp_resumen_pagos_cuotas(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idcobrador INT,
    IN p_idsucursal INT
)
BEGIN
    -- Convertir 0 a NULL para los filtros
    SET p_fecha_desde = NULLIF(p_fecha_desde, '0000-00-00');
    SET p_fecha_hasta = NULLIF(p_fecha_hasta, '0000-00-00');
    SET p_idcobrador = NULLIF(p_idcobrador, 0);
    SET p_idsucursal = NULLIF(p_idsucursal, 0);

    SELECT 
        -- Fechas y agrupaciones
        pc.fecha,
        DATE_FORMAT(pc.fecha, '%Y-%m') AS mes_anio,
        DATE_FORMAT(pc.fecha, '%M %Y') AS mes_anio_texto,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', TRIM(pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Información de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        e.telefono AS telefono_empresa,
        
        -- Totales y conteos
        COUNT(DISTINCT pc.idpago) AS cantidad_recibos,
        COUNT(dpc.iddetalle_pagos_cuotas) AS cantidad_conceptos,
        SUM(dpc.importe) AS total_cobrado,
        
        -- Desglose por tipo de pago
        SUM(CASE WHEN dpc.tipo_pago = 'CUOTA' THEN dpc.importe ELSE 0 END) AS total_cuotas,
        SUM(CASE WHEN dpc.tipo_pago = 'OTRO' THEN dpc.importe ELSE 0 END) AS total_otros,
        
        -- Desglose por concepto
        COUNT(DISTINCT c.idcliente) AS cantidad_clientes,
        
        -- Promedios y cálculos adicionales
        ROUND(AVG(dpc.importe), 2) AS promedio_por_concepto,
        ROUND(SUM(dpc.importe) / COUNT(DISTINCT c.idcliente), 2) AS promedio_por_cliente,
        
        -- Formas de pago más utilizadas
        GROUP_CONCAT(DISTINCT tp.tipo) AS formas_pago_utilizadas,
        COUNT(DISTINCT tp.idTipo_pago) AS cantidad_formas_pago,
        
        -- Información del usuario que registró los pagos
        GROUP_CONCAT(DISTINCT u.nick) AS usuarios_registro,
        COUNT(DISTINCT u.idusuario) AS cantidad_usuarios
        
    FROM pagos_cuotas pc
    INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago
    INNER JOIN cliente c ON pc.idcliente = c.idcliente
    INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
    INNER JOIN personal pcob ON cob.idPersonal = pcob.idPersonal
    INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago
    INNER JOIN sucursal s ON pc.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    WHERE pc.estado = 'COB'
    AND (p_fecha_desde IS NULL OR pc.fecha >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR pc.fecha <= p_fecha_hasta)
    AND (p_idcobrador IS NULL OR cob.idcobrador = p_idcobrador)
    AND (p_idsucursal IS NULL OR s.idsucursal = p_idsucursal)
    GROUP BY 
        pc.fecha,
        cob.idcobrador,
        s.idsucursal,
        e.idEmpresa
    ORDER BY 
        pc.fecha DESC,
        total_cobrado DESC;
        
END$$

DELIMITER ;