*-------------------------------------------------------
* FUNCIÓN: FechaToMySQL
* DESCRIPCIÓN: Convierte fecha de VFP a formato MySQL '0000-00-00'
* PARÁMETRO: tdFecha - Fecha a convertir (puede estar vacía)
* RETORNA: String en formato 'YYYY-MM-DD' o '0000-00-00' si está vacía
*-------------------------------------------------------
lparameters  tdfecha
local lcfechamysql

if empty(tdfecha) or isnull(tdfecha) or !type("tdFecha") = "D"
	lcfechamysql = '0000-00-00'
else
	lcfechamysql = transform(year(tdfecha), "@L 9999") + "-" + ;
		transform(month(tdfecha), "@L 99") + "-" + ;
		transform(day(tdfecha), "@L 99")
endif

return lcfechamysql
