LPARAMETERS tncodventa
*-- Procedimiento para imprimir factura

LOCAL lcSQL

*-- Llamar al stored procedure
lcSQL = "CALL sp_consultar_venta(" + TRANSFORM(tncodventa) + ")"

SQLEXEC(conexion, lcSQL, "cur_factura")

*-- Verificar si hay datos
IF RECCOUNT("cur_factura") = 0
    MESSAGEBOX("No se encontraron datos de esta venta", 48, "Aviso")
    RETURN
ENDIF

SELECT cur_factura
*-- Llamar al reporte
REPORT FORM _factura PREVIEW NOCONSOLE

*-- Limpiar
USE IN cur_factura