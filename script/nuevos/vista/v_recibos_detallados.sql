DROP VIEW IF EXISTS v_recibos_detallados;
CREATE OR REPLACE VIEW v_recibos_detallados AS
SELECT 
    -- Identificación del recibo
    c.idcuotas,
    pc.idpago,
    pc.fecha,
    pc.nro_recibo,
    
    -- Orden de cuota (formato: 1/12, 2/12, etc.)
    CONCAT(cd.orden_cuota, '/', c.cantidad_cuota) AS orden_cuota,
    cd.orden_char AS orden_cuota_char,
    
    -- Factura relacionada
    c.nrofactura AS factura,
    
    -- Concepto del pago
    COALESCE(
        dpc.concepto, 
        CONCAT('Cuota ', cd.orden_char, ' - ', c.nrofactura)
    ) AS concepto,
    
    -- Montos
    dpc.importe AS monto,
    dpc.cuota AS monto_cuota_original,
    dpc.saldo AS saldo_despues_pago,
    
    -- Detalles del pago
    dpc.tipo_pago,
    dpc.fecha_vto,
    dpc.atraso,
    
    -- Información del cliente
    cl.idcliente,
    CONCAT(cl.nombre, ' ', cl.apellido) AS cliente_nombre_completo,
    cl.ci AS cliente_ci,
    cl.celular AS cliente_celular,
    
    -- Información de la venta
    v.fecha AS fecha_venta,
    v.total AS total_venta,
    
    -- Información del cobrador
    CONCAT(p_cob.nombre, ' ', p_cob.apellido) AS cobrador_nombre,
    
    -- Forma de pago
    tp.tipo AS forma_pago,
    
    -- Estado
    pc.estado AS estado_recibo,
    cd.estado AS estado_cuota

FROM pagos_cuotas pc

-- Detalles del pago
INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago

-- Información de la cuota detalle
INNER JOIN cuotas_detalle cd ON dpc.idcuotas_detalle = cd.idcuotas_detalle

-- Información de la cuota cabecera
INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas

-- Información del cliente
INNER JOIN cliente cl ON pc.idcliente = cl.idcliente

-- Información de la venta
INNER JOIN venta v ON c.idVenta = v.idVenta

-- Información del cobrador
INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
INNER JOIN personal p_cob ON cob.idPersonal = p_cob.idPersonal

-- Forma de pago
INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago

WHERE pc.estado = 'COB'  -- Solo recibos cobrados
ORDER BY pc.fecha DESC, pc.idpago DESC, cd.orden_cuota;