*-- Procedimiento para imprimir recibo
LPARAMETERS tnIdPago

LOCAL loConexion, lcSQL, lnHandle

*-- Llamar al stored procedure
lcSQL = "CALL sp_consultar_pago_cuotas_detalle(" + TRANSFORM(tnIdPago) + ")"

SQLEXEC(conexion, lcSQL, "cur_pago_detalle")

*-- Verificar si hay datos
IF RECCOUNT("cur_pago_detalle") = 0
    MESSAGEBOX("No se encontraron datos para este pago", 48, "Aviso")
    RETURN
ENDIF

*-- Crear cursor para el reporte (duplicando datos para Original y Copia)
CREATE CURSOR cur_recibo_impresion ( ;
    tipo_copia C(10), ;
    idpago I, ;
    nro_recibo C(20), ;
    fecha_pago D, ;
    total_pagado N(12,2), ;
    estado_pago C(3), ;
    cliente_nombre_completo C(100), ;
    cliente_ci C(20), ;
    cliente_celular C(20), ;
    cobrador_nombre C(100), ;
    forma_pago C(50), ;
    factura_completa C(30), ;
    fecha_venta D, ;
    sucursal C(100), ;
    direccion_sucursal C(200), ;
    telefono_sucursal C(50), ;
    empresa C(100), ;
    concepto_pago C(200), ;
    numero_cuota_char C(20), ;
    fecha_vencimiento D(8), ;
    monto_pagado N(12,2), ;
    saldo_despues_pago N(12,2), ;
    saldo_actual N(12,2),;
    orden_detalle I ,;
    personal_pago C(50);
)

*-- Insertar datos para ORIGINAL
SELECT cur_pago_detalle
SCAN
    SELECT cur_recibo_impresion
    APPEND BLANK
    REPLACE tipo_copia WITH "ORIGINAL"
    REPLACE idpago WITH cur_pago_detalle.idpago
    REPLACE nro_recibo WITH cur_pago_detalle.nro_recibo
    REPLACE fecha_pago WITH cur_pago_detalle.fecha_pago
    REPLACE total_pagado WITH cur_pago_detalle.total_pagado
    REPLACE estado_pago WITH cur_pago_detalle.estado_pago
    REPLACE cliente_nombre_completo WITH cur_pago_detalle.cliente_nombre_completo
    REPLACE cliente_ci WITH cur_pago_detalle.cliente_ci
    REPLACE cliente_celular WITH cur_pago_detalle.cliente_celular
    REPLACE cobrador_nombre WITH cur_pago_detalle.cobrador_nombre
    REPLACE forma_pago WITH cur_pago_detalle.forma_pago
    REPLACE factura_completa WITH cur_pago_detalle.factura_completa
    REPLACE fecha_venta WITH cur_pago_detalle.fecha_venta
    REPLACE sucursal WITH cur_pago_detalle.sucursal
    REPLACE direccion_sucursal WITH cur_pago_detalle.direccion_sucursal
    REPLACE telefono_sucursal WITH cur_pago_detalle.telefono_sucursal
    REPLACE empresa WITH cur_pago_detalle.empresa
    REPLACE concepto_pago WITH cur_pago_detalle.concepto_pago
    REPLACE numero_cuota_char WITH cur_pago_detalle.numero_cuota_char
    REPLACE fecha_vencimiento WITH IIF(!ISNULL(cur_pago_detalle.fecha_vencimiento),cur_pago_detalle.fecha_vencimiento,{})
    REPLACE monto_pagado WITH cur_pago_detalle.monto_pagado
    REPLACE saldo_despues_pago WITH cur_pago_detalle.saldo_despues_pago
    REPLACE saldo_actual WITH cur_pago_detalle.saldo_actual_cuota
    REPLACE orden_detalle WITH val(cur_pago_detalle.orden_tipo_pago)
    replace personal_pago  WITH cur_pago_detalle.personal_registro
ENDSCAN

*-- Insertar datos para DUPLICADO (mismos datos)
SELECT cur_pago_detalle
SCAN
    SELECT cur_recibo_impresion
    APPEND BLANK
    REPLACE tipo_copia WITH "DUPLICADO"
    REPLACE idpago WITH cur_pago_detalle.idpago
    REPLACE nro_recibo WITH cur_pago_detalle.nro_recibo
    REPLACE fecha_pago WITH cur_pago_detalle.fecha_pago
    REPLACE total_pagado WITH cur_pago_detalle.total_pagado
    REPLACE estado_pago WITH cur_pago_detalle.estado_pago
    REPLACE cliente_nombre_completo WITH cur_pago_detalle.cliente_nombre_completo
    REPLACE cliente_ci WITH cur_pago_detalle.cliente_ci
    REPLACE cliente_celular WITH cur_pago_detalle.cliente_celular
    REPLACE cobrador_nombre WITH cur_pago_detalle.cobrador_nombre
    REPLACE forma_pago WITH cur_pago_detalle.forma_pago
    REPLACE factura_completa WITH cur_pago_detalle.factura_completa
    REPLACE fecha_venta WITH cur_pago_detalle.fecha_venta
    REPLACE sucursal WITH cur_pago_detalle.sucursal
    REPLACE direccion_sucursal WITH cur_pago_detalle.direccion_sucursal
    REPLACE telefono_sucursal WITH cur_pago_detalle.telefono_sucursal
    REPLACE empresa WITH cur_pago_detalle.empresa
    REPLACE concepto_pago WITH cur_pago_detalle.concepto_pago
    REPLACE numero_cuota_char WITH cur_pago_detalle.numero_cuota_char
    REPLACE fecha_vencimiento WITH IIF(!ISNULL(cur_pago_detalle.fecha_vencimiento),cur_pago_detalle.fecha_vencimiento,{})
    REPLACE monto_pagado WITH cur_pago_detalle.monto_pagado
    REPLACE saldo_despues_pago WITH cur_pago_detalle.saldo_despues_pago
    REPLACE saldo_actual WITH cur_pago_detalle.saldo_actual_cuota
    REPLACE orden_detalle WITH val(cur_pago_detalle.orden_tipo_pago)
    replace personal_pago  WITH cur_pago_detalle.personal_registro
ENDSCAN

*-- Ordenar: primero ORIGINAL, luego DUPLICADO
*SELECT * FROM cur_recibo_impresion ;
    ORDER BY tipo_copia DESC, orden_detalle ;
    INTO CURSOR cur_recibo_final

SELECT cur_recibo_impresion 
*-- Llamar al reporte
REPORT FORM _recibos PREVIEW NOCONSOLE

*-- Limpiar
USE IN cur_pago_detalle
USE IN cur_recibo_impresion
*USE IN cur_recibo_final