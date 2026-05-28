DROP PROCEDURE IF EXISTS sp_movimientos_cierre_caja;
DELIMITER $
CREATE PROCEDURE sp_movimientos_cierre_caja(
    IN p_idapecierre INT  -- ID de la apertura de caja
)
BEGIN
    SELECT 
        mo.idMov,
        mo.fecha,
        mo.operacion,
        mo.Nro_comprobante,
        mo.monto,
        mo.tipo,
        -- Leyenda para tipo de movimiento
        CASE 
            WHEN mo.tipo = 'I' THEN 'INGRESO'
            WHEN mo.tipo = 'E' THEN 'EGRESO'
            ELSE 'INDEFINIDO'
        END AS tipo_movimiento,
        mo.descripcion,
        cc.concepto,
        -- Información de clientes/proveedores
        CASE 
            WHEN mo.idcliente IS NOT NULL THEN c.nombre
            WHEN mo.idproveedor IS NOT NULL THEN p.proveedor
            ELSE 'VARIOS'
        END AS nombre_cliente_proveedor,
        -- Información de forma de pago
        fp.tipo AS forma_pago,
        -- Información de sucursal y empresa
        s.sucursal,
        e.empresa,
        -- Campos para cierre de caja
        CASE 
            WHEN mo.tipo = 'I' THEN mo.monto
            ELSE 0
        END AS ingreso,
        CASE 
            WHEN mo.tipo = 'E' THEN mo.monto
            ELSE 0
        END AS egreso,
        -- Estado del movimiento con leyenda descriptiva
        CASE 
            WHEN ac.estado = 'C' THEN 'CAJA CERRADA'
            WHEN ac.estado = 'A' THEN 'CAJA ABIERTA'
            ELSE 'ESTADO DESCONOCIDO'
        END AS estado_cierre,
        -- Datos de la apertura/cierre de caja
        ac.fechaape,
        ac.horaape,
        ac.montoape,
        IFNULL(DATE_FORMAT(ac.fechacierre, '%Y-%m-%d'), '-') AS fechacierre,
        IFNULL(TIME_FORMAT(ac.horacierre, '%H:%i:%s'), '-') AS horacierre,
        ac.estado AS estado_original
    FROM mov_operacion mo
    LEFT JOIN concepto_caja cc ON mo.idconcepto = cc.idconcepto
    LEFT JOIN cliente c ON mo.idcliente = c.idcliente
    LEFT JOIN proveedor p ON mo.idproveedor = p.idproveedor
    LEFT JOIN tipo_pago fp ON mo.idformapago = fp.idTipo_pago
    LEFT JOIN sucursal s ON mo.idsucursal = s.idsucursal
    LEFT JOIN empresa e ON mo.idEmpresa = e.idEmpresa
    INNER JOIN apecierrecaja ac ON mo.idapecierre = ac.idapecierre   -- JOIN con la tabla de apertura/cierre
    WHERE mo.idapecierre = p_idapecierre
    ORDER BY 
        mo.tipo DESC,  -- Primero ingresos, luego egresos
        cc.concepto,
        mo.fecha;
END$
DELIMITER ;