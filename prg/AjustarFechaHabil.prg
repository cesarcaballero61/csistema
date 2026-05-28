*-----------------------------------------------
* Función: AjustarFechaHabil
* Propósito: Ajusta una fecha para que caiga en día hábil (Lun-Sáb)
* Parámetros: tdFecha - Fecha a ajustar
* Retorna: Fecha ajustada al siguiente día hábil
*-----------------------------------------------
FUNCTION AjustarFechaHabil(tdFecha)
    LOCAL ldFechaAjustada, lnDiaSemana
    
    ldFechaAjustada = tdFecha
    
    * DOW() retorna: 1=Domingo, 2=Lunes, 3=Martes, 4=Miércoles, 5=Jueves, 6=Viernes, 7=Sábado
    lnDiaSemana = DOW(ldFechaAjustada)
    
    * Si es domingo (1), pasar al lunes
    IF lnDiaSemana = 1
        ldFechaAjustada = ldFechaAjustada + 1
    ENDIF
    
    RETURN ldFechaAjustada
ENDFUNC
