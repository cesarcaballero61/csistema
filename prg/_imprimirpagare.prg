LPARAMETERS tncodventa
*-- Procedimiento para imprimir factura

LOCAL lcSQL

*-- Llamar al stored procedure
lcSQL = "CALL sp_consultar_pagare(" + TRANSFORM(tncodventa) + ")"

SQLEXEC(conexion, lcSQL, "cur_pagare")

*-- Verificar si hay datos
IF RECCOUNT("cur_pagare") = 0
    MESSAGEBOX("No se encontraron datos para esta venta", 48, "Aviso")
    RETURN
ENDIF

SELECT cur_pagare
 
*-- Llamar al reporte
REPORT FORM _pagare PREVIEW NOCONSOLE

*-- Limpiar
USE IN cur_pagare
