DELIMITER $$

DROP PROCEDURE IF EXISTS sp_consultar_estado_cuotas$$

CREATE PROCEDURE sp_consultar_estado_cuotas(
    IN p_tipo_consulta ENUM('VENCIDAS', 'POR_VENCER', 'AL_DIA', 'TODAS'),
    IN p_dias_vencimiento INT,
    IN p_idsucursal INT,
    IN p_idcliente INT
)
BEGIN
    SELECT 
        -- Datos de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        e.telefono AS telefono_empresa,
        
        -- Datos de la sucursal
        s.idsucursal,
        s.sucursal AS nombre_sucursal,
        s.ciudad AS ciudad_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Datos del cliente
        c.idcliente,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        z.zona AS zona_cliente,
        b.barrio AS barrio_cliente,
        
        -- Datos de la venta
        v.idVenta,
        v.fecha AS fecha_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.total AS total_venta,
        
        -- Datos de la cuota general
        cu.idcuotas,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_pendiente,
        cu.cantidad_cuota AS total_cuotas,
        
        -- Datos del detalle de cuota específico
        cd.idcuotas_detalle,
        cd.orden_cuota,
        cd.orden_char,
        cd.fecha_vto,
        cd.cuota AS monto_cuota,
        cd.saldo_cuota AS saldo_cuota,
        cd.estado AS estado_cuota,
        
        -- Cálculos de vencimiento
        DATEDIFF(CURDATE(), cd.fecha_vto) AS dias_vencido,
        DATEDIFF(cd.fecha_vto, CURDATE()) AS dias_para_vencer,
        
        -- Clasificación
        CASE 
            WHEN cd.estado = 'CAN' THEN 'CANCELADA'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' THEN 'VENCIDA'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' THEN 'POR VENCER'
            ELSE 'INDEFINIDO'
        END AS situacion,
        
        -- Estado del cliente (AL DÍA o MOROSO)
        CASE 
            WHEN NOT EXISTS (
                SELECT 1 
                FROM cuotas_detalle cd2 
                INNER JOIN cuotas cu2 ON cd2.idcuotas = cu2.idcuotas
                INNER JOIN venta v2 ON cu2.idVenta = v2.idVenta
                WHERE cd2.estado = 'PEN'
                AND cu2.anulado = 'NO'
                AND v2.estado = 'F'
                AND cd2.fecha_vto < CURDATE()  -- Tiene cuotas vencidas
                AND v2.idcliente = c.idcliente
                AND (p_idsucursal IS NULL OR v2.idsucursal = p_idsucursal)
            ) THEN 'AL DÍA'
            ELSE 'MOROSO'
        END AS estado_cliente,
        
        -- Nivel de mora
        CASE 
            WHEN cd.estado = 'CAN' THEN 'PAGADA'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) <= 15 THEN 'MORA LEVE (1-15 días)'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) BETWEEN 16 AND 30 THEN 'MORA MODERADA (16-30 días)'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 30 THEN 'MORA GRAVE (+30 días)'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(cd.fecha_vto, CURDATE()) <= 7 THEN 'POR VENCER (<= 7 días)'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' THEN 'AL DÍA'
            ELSE 'SIN CLASIFICAR'
        END AS nivel_mora,
        
        -- Datos del cobrador
        cob.idcobrador,
        CONCAT(pc.nombre, ' ', pc.apellido) AS cobrador_nombre,
        pc.ci AS cobrador_ci,
        pc.telefono AS cobrador_telefono
        
    FROM cuotas_detalle cd
    INNER JOIN cuotas cu ON cd.idcuotas = cu.idcuotas
    INNER JOIN venta v ON cu.idVenta = v.idVenta
    INNER JOIN cliente c ON v.idcliente = c.idcliente
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa  -- JOIN con empresa
    INNER JOIN zona z ON c.idzona = z.idzona
    INNER JOIN barrio b ON c.idbarrio = b.idbarrio
    LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
    LEFT JOIN personal pc ON cob.idPersonal = pc.idPersonal
    WHERE cd.estado = 'PEN'  -- Solo cuotas pendientes
    AND cu.anulado = 'NO'    -- Cuotas no anuladas
    AND v.estado = 'F'       -- Ventas facturadas
    AND (p_idsucursal IS NULL OR v.idsucursal = p_idsucursal)
    AND (p_idcliente IS NULL OR v.idcliente = p_idcliente)
    AND (
        (p_tipo_consulta = 'VENCIDAS' AND cd.fecha_vto < CURDATE()) OR
        (p_tipo_consulta = 'POR_VENCER' AND cd.fecha_vto >= CURDATE()) OR
        (p_tipo_consulta = 'AL_DIA' AND NOT EXISTS (
            SELECT 1 
            FROM cuotas_detalle cd3 
            INNER JOIN cuotas cu3 ON cd3.idcuotas = cu3.idcuotas
            INNER JOIN venta v3 ON cu3.idVenta = v3.idVenta
            WHERE cd3.estado = 'PEN'
            AND cu3.anulado = 'NO'
            AND v3.estado = 'F'
            AND cd3.fecha_vto < CURDATE()
            AND v3.idcliente = c.idcliente
            AND (p_idsucursal IS NULL OR v3.idsucursal = p_idsucursal)
        )) OR
        (p_tipo_consulta = 'TODAS')
    )
    AND (
        p_dias_vencimiento IS NULL OR
        (p_tipo_consulta = 'VENCIDAS' AND DATEDIFF(CURDATE(), cd.fecha_vto) <= p_dias_vencimiento) OR
        (p_tipo_consulta = 'POR_VENCER' AND DATEDIFF(cd.fecha_vto, CURDATE()) <= p_dias_vencimiento) OR
        (p_tipo_consulta = 'AL_DIA')
    )
    ORDER BY 
        DATEDIFF(CURDATE(), cd.fecha_vto) DESC,  -- Vencidas: más días de mora primero
        c.nombre, c.apellido,                    -- Cliente
        cd.fecha_vto,                            -- Fecha vencimiento
        v.idVenta;                               -- ID venta
        
END$$

DELIMITER ;