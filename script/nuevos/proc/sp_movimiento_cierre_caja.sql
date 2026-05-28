DROP PROCEDURE IF EXISTS sp_movimientos_cierre_caja;
DELIMITER $
CREATE PROCEDURE sp_movimientos_cierre_caja(
    IN p_idpersonal INT
)
BEGIN
    SELECT 
        mo.idMov,
        mo.fecha,
        mo.operacion,
        mo.Nro_comprobante,
        mo.monto,
        mo.tipo,
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
        -- Estado del movimiento
        'PENDIENTE_CIERRE' AS estado_cierre
    FROM mov_operacion mo
    LEFT JOIN concepto_caja cc ON mo.idconcepto = cc.idconcepto
    LEFT JOIN cliente c ON mo.idcliente = c.idcliente
    LEFT JOIN proveedor p ON mo.idproveedor = p.idproveedor
    LEFT JOIN tipo_pago fp ON mo.idformapago = fp.idTipo_pago
    LEFT JOIN sucursal s ON mo.idsucursal = s.idsucursal
    LEFT JOIN empresa e ON mo.idEmpresa = e.idEmpresa
    WHERE mo.idpersonal = p_idpersonal
        AND mo.fecha = CURDATE()  -- Solo movimientos del día actual
    ORDER BY 
        mo.fecha DESC,
        mo.tipo,
        cc.concepto;
END$
DELIMITER ;