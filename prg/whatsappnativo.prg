*---------------------------------------------------------------
* CLASE: WhatsAppNativo.prg
* PROPÓSITO: Enviar notificaciones por WhatsApp usando app nativa
* VERSIÓN: 1.0
* FECHA: Diciembre 2024
*---------------------------------------------------------------

define class whatsappnativo as custom

* Propiedades de configuración
	cnombreempresa = "MI EMPRESA"
	lusarappnativa = .t.        && .T. = App nativa, .F. = WhatsApp Web
	llogactivo = .t.            && Activar registro de log
	carchivolog = "whatsapp_nativo_log.txt"
	npausaentreenvios = 2000    && Pausa en milisegundos entre envíos (2 segundos)
	lconfirmarantes = .t.       && Confirmar antes de enviar

* Propiedades internas
	ntotalenviados = 0
	ntotalerrores = 0

*-- Constructor
	function init
		this.cargarconfiguracion()
		this.registrarlog("=== Sesión iniciada ===")
	endfunc

*-- Destructor
	function destroy
		this.registrarlog("=== Sesión finalizada - Enviados: " + ;
			  transform(this.ntotalenviados) + ", Errores: " + ;
			  transform(this.ntotalerrores) + " ===")
	endfunc

*-- Cargar configuración
	function cargarconfiguracion
		local lcarchivo
		lcarchivo = addbs(sys(5) + sys(2003)) + "whatsapp_config.ini"

		if file(lcarchivo)
			this.cnombreempresa = this.leerini(lcarchivo, "General", "NombreEmpresa", "MI EMPRESA")
			this.lusarappnativa = (this.leerini(lcarchivo, "General", "UsarAppNativa", "1") = "1")
			this.lconfirmarantes = (this.leerini(lcarchivo, "General", "ConfirmarAntes", "1") = "1")
		endif
	endfunc

*-- Enviar notificación de cuota vencida
	function notificarcuotavencida(cnumero, cnombrecliente, cnrocuota, dfechavenc, nmonto, cmoneda)
		local lcmensaje, llexito

	* Validar datos
		if empty(cnumero)
			messagebox("Debe especificar un número de teléfono", 48, "Validación")
			this.registrarlog("Error: Número vacío para cliente " + cnombrecliente)
			return .f.
		endif

	* Limpiar número
		cnumero = this.limpiarnumerotelefono(cnumero)
		if empty(cnumero)
			messagebox("El número de teléfono no es válido: " + cnumero, 48, "Validación")
			this.registrarlog("Error: Número inválido para cliente " + cnombrecliente)
			return .f.
		endif

	* Confirmar envío si está configurado
		if this.lconfirmarantes
			if messagebox("¿Enviar notificación de cuota vencida a:" + chr(13) + chr(13) + ;
					  "Cliente: " + alltrim(cnombrecliente) + chr(13) + ;
					  "Teléfono: " + cnumero + chr(13) + ;
					  "Cuota: " + alltrim(cnrocuota) + chr(13) + ;
					  "Monto: " + alltrim(cmoneda) + " " + transform(nmonto, "999,999,999"), ;
					  4 + 32, "Confirmar Envío") != 6
				return .f.
			endif
		endif

		* Construir mensaje
		lcmensaje = this.construirmensajecuotavencida(cnombrecliente, cnrocuota, dfechavenc, nmonto, cmoneda)

		* Enviar
		llexito = this.abrirwhatsapp(cnumero, lcmensaje)

		* Registrar
		if llexito
			this.ntotalenviados = this.ntotalenviados + 1
			this.registrarlog("OK - Cliente: " + cnombrecliente + " | Tel: " + cnumero + " | Cuota: " + alltrim(cnrocuota))
		else
			this.ntotalerrores = this.ntotalerrores + 1
			this.registrarlog("ERROR - Cliente: " + cnombrecliente + " | Tel: " + cnumero)
		endif

		return llexito
	endfunc

	*-- Construir mensaje de cuota vencida
	function construirmensajecuotavencida(cnombre, cnrocuota, dfecha, nmonto, cmoneda)
		local lcmensaje, lcfecha, lcmonto

		lcfecha = dtoc(dfecha)
		lcmonto = transform(nmonto, "999,999,999")

		text TO lcMensaje TEXTMERGE NOSHOW
		
_NOTIFICACIÓN DE CUOTA VENCIDA_

Estimado/a *<<ALLTRIM(cNombre)>>*

Le informamos que tiene una cuota pendiente de pago:

 *Cuota N°:* <<ALLTRIM(cNroCuota)>>
 *Fecha de vencimiento:* <<lcFecha>>
 *Monto adeudado:* <<ALLTRIM(cMoneda)>> <<ALLTRIM(lcMonto)>>

Por favor, regularice su situación a la brevedad posible para evitar recargos adicionales.

Para consultas o acordar forma de pago, comuníquese con nosotros.

Atentamente,
_<<ALLTRIM(THIS.cNombreEmpresa)>>_

_Mensaje automático - No responder a este número_

		ENDTEXT

		return lcmensaje
	endfunc

	*-- Enviar mensaje de recordatorio simple
	function enviarrecordatorio(cnumero, cnombre, cmensajepersonalizado)
		local lcmensaje

		* Validar número
		cnumero = this.limpiarnumerotelefono(cnumero)
		if empty(cnumero)
			return .f.
		endif

	* Mensaje por defecto o personalizado
		if empty(cmensajepersonalizado)
			text TO lcMensaje TEXTMERGE NOSHOW
Hola *<<ALLTRIM(cNombre)>>*

Este es un recordatorio amigable sobre su cuenta pendiente.

Por favor, comuníquese con nosotros para regularizar su situación.

Gracias.
_<<ALLTRIM(THIS.cNombreEmpresa)>>_
			ENDTEXT
		else
			lcmensaje = cmensajepersonalizado
		endif

		return this.abrirwhatsapp(cnumero, lcmensaje)
	endfunc

	*-- Enviar mensaje genérico
	function enviarmensaje(cnumero, cmensaje)
		cnumero = this.limpiarnumerotelefono(cnumero)
		if empty(cnumero)
			return .f.
		endif

		return this.abrirwhatsapp(cnumero, cmensaje)
	endfunc

	*-- Abrir WhatsApp con mensaje prellenado
	function abrirwhatsapp(cnumero, cmensaje)
	*-- Abrir WhatsApp con mensaje prellenado
	function abrirwhatsapp(cnumero, cmensaje)
		local lcurl, lcmensajecodificado, lnresultado, llexito
		local loerror


		llexito = .f.  && Variable para controlar el resultado

		try
			* Codificar mensaje para URL
			lcmensajecodificado = this.codificarurl(cmensaje)

			* Crear URL según preferencia (app nativa o web)
			if this.lusarappnativa
				* Protocolo para aplicación nativa de WhatsApp
				lcurl = "whatsapp://send?phone=" + alltrim(cnumero) + "&text=" + lcmensajecodificado
			else
				* URL para WhatsApp Web
				lcurl = "https://web.whatsapp.com/send?phone=" + alltrim(cnumero) + "&text=" + lcmensajecodificado
			endif

			* Declarar función de Windows API
			declare integer ShellExecute in shell32.dll ;
				integer hwnd, string lpOperation, string lpFile, ;
				string lpParameters, string lpDirectory, integer nShowCmd

			* Ejecutar
			lnresultado = shellexecute(0, "open", lcurl, "", "", 1)

			* ShellExecute retorna > 32 si tiene éxito
			if lnresultado > 32
				this.registrarlog("WhatsApp abierto correctamente: " + cnumero)
				llexito = .t.
			else
				this.registrarlog("Error al abrir WhatsApp. Código: " + transform(lnresultado))
				messagebox("No se pudo abrir WhatsApp. Verifique que esté instalado.", 16, "Error")
				llexito = .f.
			endif

		catch to loerror
			this.registrarlog("Excepción: " + loerror.message)
			messagebox("Error al intentar abrir WhatsApp: " + loerror.message, 16, "Error")
			llexito = .f.
		endtry

		return llexito
	endfunc

  	*-- Codificar mensaje para URL
	function codificarurl(ctexto)
		local lcresultado, i, cchar

		lcresultado = ctexto

* Caracteres especiales que necesitan codificación
		lcresultado = strtran(lcresultado, "%", "%25")   && Debe ser primero
		lcresultado = strtran(lcresultado, " ", "%20")
		lcresultado = strtran(lcresultado, chr(13), "")  && Remover CR
		lcresultado = strtran(lcresultado, chr(10), "%0A")
		lcresultado = strtran(lcresultado, chr(9), "%09")
		lcresultado = strtran(lcresultado, "*", "%2A")
		lcresultado = strtran(lcresultado, "_", "%5F")
		lcresultado = strtran(lcresultado, "~", "%7E")
		lcresultado = strtran(lcresultado, "#", "%23")
		lcresultado = strtran(lcresultado, "&", "%26")
		lcresultado = strtran(lcresultado, "=", "%3D")
		lcresultado = strtran(lcresultado, "+", "%2B")

		return lcresultado
	endfunc

*-- Limpiar y validar número de teléfono
	function limpiarnumerotelefono(cnumero)
		local lcnumero, i, cchar

		lcnumero = alltrim(cnumero)

* Remover caracteres no numéricos
		lcnumero = chrtran(lcnumero, "()-. +", "")

* Si está vacío después de limpiar
		if empty(lcnumero)
			return ""
		endif

* Para Paraguay: Si tiene 9 dígitos y empieza con 9, agregar 595
		if len(lcnumero) = 9 and left(lcnumero, 1) = "9"
			lcnumero = "595" + lcnumero
		endif

* Para Paraguay: Si tiene 10 dígitos y empieza con 09, cambiar a 595
		if len(lcnumero) = 10 and left(lcnumero, 2) = "09"
			lcnumero = "595" + substr(lcnumero, 2)
		endif

* Validar longitud mínima
		if len(lcnumero) < 10
			return ""
		endif

		return lcnumero
	endfunc

*-- Procesar lista de cuotas vencidas
	function procesarcuotasvencidas(caliascuotas, lmostrarprogreso)
		local lntotal, lnprocesados, lnexitosos, lnomitidos
		local loform

		if parameters() < 2
			lmostrarprogreso = .t.
		endif

		lntotal = 0
		lnprocesados = 0
		lnexitosos = 0
		lnomitidos = 0

* Contar registros
		select (caliascuotas)
		count to lntotal for !empty(telefono)

		if lntotal = 0
			messagebox("No hay registros con teléfono para procesar", 48, "Aviso")
			return 0
		endif

* Confirmar proceso
		if messagebox("Se procesarán " + transform(lntotal) + " notificaciones." + chr(13) + chr(13) + ;
				  "¿Desea continuar?", 4 + 32, "Confirmar Proceso Masivo") != 6
			return 0
		endif

* Crear formulario de progreso si es necesario
		if lmostrarprogreso
			loform = this.crearformprogreso(lntotal)
		endif

* Procesar registros
		select (caliascuotas)
		scan for !empty(telefono)
			lnprocesados = lnprocesados + 1

* Actualizar progreso
			if lmostrarprogreso and type("loForm") = "O"
				loform.actualizarprogreso(lnprocesados, alltrim(nombre_cliente))
			endif

* Enviar notificación (sin confirmar en modo masivo)
			this.lconfirmarantes = .f.

			if this.notificarcuotavencida(telefono, nombre_cliente, ;
					  nro_cuota, fecha_venc, monto, moneda)

				lnexitosos = lnexitosos + 1

* Marcar como enviado si el campo existe
				if type("enviado_wsp") = "L"
					replace enviado_wsp with .t., ;
						fecha_envio_wsp with datetime()
				endif

* Pausa entre envíos
				if lnprocesados < lntotal
					this.pausar(this.npausaentreenvios)
				endif
			else
				lnomitidos = lnomitidos + 1
			endif

* Permitir ESC para cancelar
			if lastkey() = 27
				if messagebox("¿Desea cancelar el proceso?", 4 + 32, "Confirmar") = 6
					exit
				endif
			endif
		endscan

* Cerrar formulario de progreso
		if lmostrarprogreso and type("loForm") = "O"
			loform.release()
		endif

* Restaurar configuración
		this.lconfirmarantes = .t.

* Mostrar resumen
		messagebox("Proceso completado:" + chr(13) + chr(13) + ;
			  "Total registros: " + transform(lntotal) + chr(13) + ;
			  "Procesados: " + transform(lnprocesados) + chr(13) + ;
			  "Exitosos: " + transform(lnexitosos) + chr(13) + ;
			  "Omitidos: " + transform(lnomitidos), 64, "Resumen de Envíos")

		return lnexitosos
	endfunc

*-- Crear formulario de progreso
	function crearformprogreso(ntotal)
		local loform

		loform = createobject("FormProgreso", ntotal)
		loform.show()

		return loform
	endfunc

*-- Pausa en milisegundos
	function pausar(nmilisegundos)
		declare Sleep in Win32API integer
		sleep(nmilisegundos)
	endfunc

*-- Registrar en log
	function registrarlog(cmensaje)
		local lnhandle, lclinea

		if !this.llogactivo
			return
		endif

		try
			lclinea = ttoc(datetime()) + " | " + cmensaje + chr(13) + chr(10)

* Abrir o crear archivo
			if !file(this.carchivolog)
				lnhandle = fcreate(this.carchivolog, 0)
			else
				lnhandle = fopen(this.carchivolog, 2)  && Abrir para lectura/escritura
			endif

			if lnhandle > 0
				fseek(lnhandle, 0, 2)  && Ir al final
				fwrite(lnhandle, lclinea)
				fclose(lnhandle)
			endif
		catch
* Ignorar errores de log
		endtry
	endfunc

*-- Leer archivo INI
	function leerini(carchivo, cseccion, cclave, cdefault)
		local lcbuffer, lntam
		lcbuffer = space(255)

		declare integer GetPrivateProfileString in Win32API ;
			string cSection, string cKey, string cDefault, ;
			string @cBuffer, integer nSize, string cFileName

		lntam = getprivateprofilestring(cseccion, cclave, cdefault, @lcbuffer, 255, carchivo)

		return left(lcbuffer, lntam)
	endfunc

*-- Ver log
	function verlog()
		if file(this.carchivolog)
			modify file (this.carchivolog) nowait
		else
			messagebox("No existe archivo de log", 48, "Aviso")
		endif
	endfunc

*-- Limpiar log
	function limpiarlog()
		if file(this.carchivolog)
			if messagebox("¿Eliminar el archivo de log?", 4 + 32, "Confirmar") = 6
				erase (this.carchivolog)
				messagebox("Log eliminado", 64, "Aviso")
			endif
		endif
	endfunc

enddefine


*---------------------------------------------------------------
* CLASE AUXILIAR: Formulario de Progreso
*---------------------------------------------------------------
define class formprogreso as form
	height = 150
	width = 450
	autocenter = .t.
	borderstyle = 2
	caption = "Procesando envíos..."
	maxbutton = .f.
	minbutton = .f.

	ntotal = 0

	add object lblprogreso as label with ;
		top = 20, left = 20, width = 410, height = 20, ;
		caption = "Iniciando proceso..."

	add object lblcliente as label with ;
		top = 50, left = 20, width = 410, height = 20, ;
		caption = ""

	add object shpbarra as shape with ;
		top = 80, left = 20, width = 0, height = 20, ;
		backcolor = rgb(0, 120, 215), borderstyle = 0

	add object shpmarco as shape with ;
		top = 80, left = 20, width = 410, height = 20, ;
		backstyle = 0, borderwidth = 1

	add object lblporcentaje as label with ;
		top = 110, left = 20, width = 410, height = 20, ;
		alignment = 2, caption = "0%"

	function init(ntotalregistros)
		this.ntotal = ntotalregistros
	endfunc

	function actualizarprogreso(nactual, ccliente)
		local nporcentaje, nancho

		nporcentaje = int((nactual / this.ntotal) * 100)
		nancho = int((nactual / this.ntotal) * 410)

		this.lblprogreso.caption = "Procesando " + transform(nactual) + " de " + transform(this.ntotal)
		this.lblcliente.caption = "Cliente: " + alltrim(ccliente)
		this.shpbarra.width = nancho
		this.lblporcentaje.caption = transform(nporcentaje) + "%"

		doevents
	endfunc
enddefine


*---------------------------------------------------------------
* EJEMPLOS DE USO
*---------------------------------------------------------------

*-- Ejemplo 1: Envío individual
procedure ejemplo1_envioindividual
	local lowa

	lowa = createobject("WhatsAppNativo")

* Enviar notificación de cuota vencida
	if lowa.notificarcuotavencida("0971728763", "Sr/a. MARCO ARIEL OJEDA.", ;
			  "1/1", date() - 10, 500000, "Gs.")

		messagebox("Notificación preparada. Complete el envío en WhatsApp.", 64)
	endif

	lowa = null
endproc


*-- Ejemplo 2: Envío masivo
procedure ejemplo2_enviomasivo
	local lowa

* Crear cursor con datos de ejemplo
	create cursor curvencidas ( ;
		  nombre_cliente c(50), ;
		  telefono c(20), ;
		  nro_cuota c(10), ;
		  fecha_venc d, ;
		  monto n(12, 2), ;
		  moneda c(5), ;
		  enviado_wsp l, ;
		  fecha_envio_wsp t)

* Insertar datos de ejemplo
	insert into curvencidas values ("Juan Pérez", "0981234567", "003", date() - 5, 500000, "Gs.", .f., {})
	insert into curvencidas values ("María González", "0971234567", "007", date() - 15, 750000, "Gs.", .f., {})
	insert into curvencidas values ("Pedro Martínez", "0961234567", "002", date() - 3, 250000, "Gs.", .f., {})

* Procesar envíos
	lowa = createobject("WhatsAppNativo")
	lowa.procesarcuotasvencidas("curVencidas", .t.)

* Mostrar resultados
	browse

	lowa = null
endproc


*-- Ejemplo 3: Envío simple
procedure ejemplo3_mensajesimple
	local lowa

	lowa = createobject("WhatsAppNativo")

	lowa.enviarmensaje("0981234567", "Hola, este es un mensaje de prueba desde VFP!")

	lowa = null
endproc


*-- Ejemplo 4: Ver estadísticas
procedure ejemplo4_verlog
	local lowa

	lowa = createobject("WhatsAppNativo")
	lowa.verlog()

	lowa = null
endproc


*---------------------------------------------------------------
* PROCEDIMIENTO: Crear archivo de configuración
*---------------------------------------------------------------
procedure crearconfiguracion
	local lcarchivo, lccontenido

	lcarchivo = addbs(sys(5) + sys(2003)) + "whatsapp_config.ini"

	text TO lcContenido NOSHOW
[General]
NombreEmpresa=MI EMPRESA S.A.
UsarAppNativa=1
ConfirmarAntes=1
	ENDTEXT

	strtofile(lccontenido, lcarchivo)

	messagebox("Archivo de configuración creado en:" + chr(13) + lcarchivo, 64)
endproc