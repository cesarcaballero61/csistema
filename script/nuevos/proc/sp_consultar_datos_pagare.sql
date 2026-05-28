DELIMITER $$

DROP PROCEDURE IF EXISTS sp_consultar_pagare $$

CREATE PROCEDURE sp_consultar_pagare(
    IN p_idventa INT
)
BEGIN
    DECLARE v_productos TEXT;
    DECLARE v_monto_total DECIMAL(10,2);
    DECLARE v_interes_mensual DECIMAL(10,2);
    
    -- Obtener datos de productos y montos
    SELECT 
        GROUP_CONCAT(
            CONCAT(
                dv.cantidad, 'x ',
                a.descripcion,
                ' (', m.Marca, ')'
            ) SEPARATOR '; '
        ),
        SUM(dv.subtotal),
        MAX(a.interes_mensual)
    INTO 
        v_productos,
        v_monto_total,
        v_interes_mensual
    FROM detalle_venta dv
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    INNER JOIN marca m ON a.idMarca = m.idMarca
    WHERE dv.idVenta = p_idventa;
    
    -- Consulta principal
    SELECT 
        -- =============================================
        -- ENCABEZADO DEL PAGARE
        -- =============================================
        CONCAT('PAG-', v.idVenta)                               AS numero_pagare,
        REPLACE(FORMAT(v.total, 0), ',', '.')                   AS monto_total_formateado,
        v.total                                                 AS monto_total,
        DATE_FORMAT(v.fecha_vto_pagare, '%d/%m/%Y')             AS vencimiento_formateado,
        COALESCE(s.ciudad, 'Asunción')                          AS ciudad_emision,
        DATE_FORMAT(v.fecha, '%d')                              AS dia_emision,
        
        -- Mes emisión en español
        ELT(MONTH(v.fecha),
            'Enero','Febrero','Marzo','Abril','Mayo','Junio',
            'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'
        )                                                       AS mes_emision,
        DATE_FORMAT(v.fecha, '%Y')                              AS ano_emision,
        
        -- Vencimiento en español
        DATE_FORMAT(v.fecha_vto_pagare, '%d')                   AS dia_vencimiento_texto,
        ELT(MONTH(v.fecha_vto_pagare),
            'Enero','Febrero','Marzo','Abril','Mayo','Junio',
            'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'
        )                                                       AS mes_vencimiento_texto,
        DATE_FORMAT(v.fecha_vto_pagare, '%Y')                   AS ano_vencimiento_texto,
        
        e.empresa                                               AS nombre_empresa,
        REPLACE(FORMAT(v.total, 0), ',', '.')                   AS monto_guaranies_formateado,
        v_productos                                             AS descripcion_valor_recibido,
        
        -- Intereses
        COALESCE(v_interes_mensual, 3.0)                        AS interes_compensatorio,
        COALESCE(v_interes_mensual, 3.0)                        AS interes_moratorio,
        2.0                                                     AS comision_retardo,
        
        -- =============================================
        -- DATOS DEL DEUDOR
        -- =============================================
        CONCAT(TRIM(c.nombre), ' ', TRIM(c.apellido))           AS deudor_nombre,
        CONCAT(TRIM(b.barrio), ' - ', TRIM(z.zona))             AS deudor_domicilio,
        c.ci                                                    AS deudor_cedula,
        COALESCE(c.celular, c.telefono, 'No tiene')             AS deudor_telefono,
        ''                                                      AS codeudor_nombre,
        ''                                                      AS codeudor_domicilio,
        ''                                                      AS codeudor_cedula,
        ''                                                      AS codeudor_telefono,
        
        -- =============================================
        -- DATOS ADICIONALES
        -- =============================================
        v.idVenta,
        v.fecha                                                 AS fecha_venta,
        v.fecha_vto_pagare                                      AS fecha_vencimiento_pagare,
        CONCAT(v.nrosuc,'-',v.nroexp,'-',v.nrofactura)          AS factura_completa,
        cu.cantidad_cuota,
        (
            SELECT cuota 
            FROM cuotas_detalle 
            WHERE idcuotas = cu.idcuotas 
            ORDER BY orden_cuota LIMIT 1
        )                                                       AS monto_cuota,
        DATE_FORMAT(v.fecha_vto_pagare, '%d/%m/%Y')             AS fecha_vencimiento_completa,
        DATE_FORMAT(v.fecha, '%d/%m/%Y')                        AS fecha_emision_completa,
        
        -- =============================================
        -- CONDICION DE PAGO — SECCION 1 (cuotas 1-5)
        -- =============================================
        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 1  LIMIT 1), '') AS c01_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 1  LIMIT 1), '') AS c01_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 1  LIMIT 1), 0) AS c01_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 2  LIMIT 1), '') AS c02_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 2  LIMIT 1), '') AS c02_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 2  LIMIT 1), 0) AS c02_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 3  LIMIT 1), '') AS c03_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 3  LIMIT 1), '') AS c03_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 3  LIMIT 1), 0) AS c03_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 4  LIMIT 1), '') AS c04_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 4  LIMIT 1), '') AS c04_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 4  LIMIT 1), 0) AS c04_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 5  LIMIT 1), '') AS c05_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 5  LIMIT 1), '') AS c05_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 5  LIMIT 1), 0) AS c05_imp,

        -- =============================================
        -- CONDICION DE PAGO — SECCION 2 (cuotas 6-10)
        -- =============================================
        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 6  LIMIT 1), '') AS c06_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 6  LIMIT 1), '') AS c06_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 6  LIMIT 1), 0) AS c06_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 7  LIMIT 1), '') AS c07_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 7  LIMIT 1), '') AS c07_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 7  LIMIT 1), 0) AS c07_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 8  LIMIT 1), '') AS c08_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 8  LIMIT 1), '') AS c08_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 8  LIMIT 1), 0) AS c08_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 9  LIMIT 1), '') AS c09_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 9  LIMIT 1), '') AS c09_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 9  LIMIT 1), 0) AS c09_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 10 LIMIT 1), '') AS c10_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 10 LIMIT 1), '') AS c10_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 10 LIMIT 1), 0) AS c10_imp,

        -- =============================================
        -- CONDICION DE PAGO — SECCION 3 (cuotas 11-15)
        -- =============================================
        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 11 LIMIT 1), '') AS c11_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 11 LIMIT 1), '') AS c11_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 11 LIMIT 1), 0) AS c11_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 12 LIMIT 1), '') AS c12_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 12 LIMIT 1), '') AS c12_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 12 LIMIT 1), 0) AS c12_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 13 LIMIT 1), '') AS c13_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 13 LIMIT 1), '') AS c13_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 13 LIMIT 1), 0) AS c13_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 14 LIMIT 1), '') AS c14_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 14 LIMIT 1), '') AS c14_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 14 LIMIT 1), 0) AS c14_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 15 LIMIT 1), '') AS c15_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 15 LIMIT 1), '') AS c15_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 15 LIMIT 1), 0) AS c15_imp,

        -- =============================================
        -- CONDICION DE PAGO — SECCION 4 (cuotas 16-20)
        -- =============================================
        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 16 LIMIT 1), '') AS c16_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 16 LIMIT 1), '') AS c16_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 16 LIMIT 1), 0) AS c16_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 17 LIMIT 1), '') AS c17_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 17 LIMIT 1), '') AS c17_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 17 LIMIT 1), 0) AS c17_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 18 LIMIT 1), '') AS c18_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 18 LIMIT 1), '') AS c18_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 18 LIMIT 1), 0) AS c18_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 19 LIMIT 1), '') AS c19_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 19 LIMIT 1), '') AS c19_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 19 LIMIT 1), 0) AS c19_imp,

        COALESCE((SELECT cd.orden_cuota FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 20 LIMIT 1), '') AS c20_nro,
        COALESCE((SELECT DATE_FORMAT(cd.fecha_vto,'%d/%m/%y') FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 20 LIMIT 1), '') AS c20_vto,
        COALESCE((SELECT cd.cuota              FROM cuotas_detalle cd WHERE cd.idcuotas = cu.idcuotas AND cd.orden_cuota = 20 LIMIT 1), 0) AS c20_imp

    FROM venta v
    INNER JOIN cliente c   ON v.idcliente   = c.idcliente
    INNER JOIN empresa e   ON v.idEmpresa   = e.idEmpresa
    INNER JOIN sucursal s  ON v.idsucursal  = s.idsucursal
    INNER JOIN cuotas cu   ON v.idVenta     = cu.idVenta
    INNER JOIN zona z      ON c.idzona      = z.idzona
    INNER JOIN barrio b    ON c.idbarrio    = b.idbarrio
    WHERE v.idVenta = p_idventa;
    
END$$

DELIMITER ;