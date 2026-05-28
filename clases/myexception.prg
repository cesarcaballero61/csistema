*====================================================
* myException.prg
* Clase para manejo de excepciones y registro en log
*====================================================
define class myexception as custom

	clogfile = "logErr.txt"   && Archivo de log por defecto

	*------------------------------------------------
	* Muestra un error y lo guarda en el log
	*------------------------------------------------
	procedure showerror(tcmessage, tcprocedure, tnline, tnerror)

		local lcformattedtext

		* Validar datos
		if vartype(tcmessage) # "C"
			tcmessage = "Error desconocido."
		endif
		if vartype(tcprocedure) # "C"
			tcprocedure = "N/D"
		endif
		if vartype(tnline) # "N"
			tnline = 0
		endif
		if vartype(tnerror) # "N"
			tnerror = 0
		endif

		* Texto formateado
		lcformattedtext = ;
			"Fecha/Hora: " + ttoc(datetime()) + chr(13) + ;
			"Host: " + this.gethostname() + chr(13) + ;
			"Procedimiento: " + tcprocedure + " (Línea: " + transform(tnline) + ")" + chr(13) + ;
			"Código Error: " + transform(tnerror) + chr(13) + ;
			"Mensaje: " + tcmessage + chr(13)

		* Mostrar en pantalla
		messagebox("Se ha producido un error:" + chr(13) + ;
			  lcformattedtext, 16, "Error en la aplicación")

		* Guardar en log
		this.savelog(tcmessage, tcprocedure, tnline, tnerror)
	endproc

			*------------------------------------------------
			* Guarda el error en el archivo de log (EN UNA SOLA LÍNEA)
			*------------------------------------------------
		*!*		procedure savelog(tcmessage, tcprocedure, tnline, tnerror)

		*!*			local lclogline, lnhandle		
		*!*			lclogfile = this.clogfile 
		*!*			 &&_screen.oapp.CLOGSPATH +

		*!*			* Formato en una sola línea separado por pipes |
		*!*			lclogline = ;
		*!*				ttoc(datetime()) + " | " + ;
		*!*				this.gethostname() + " | " + ;
		*!*				iif(vartype(tcprocedure) = "C", tcprocedure, "N/D") + " | " + ;
		*!*				"Línea:" + transform(iif(vartype(tnline) = "N", tnline, 0)) + " | " + ;
		*!*				"Error:" + transform(iif(vartype(tnerror) = "N", tnerror, 0)) + " | " + ;
		*!*				iif(vartype(tcmessage) = "C", alltrim(tcmessage), "N/D") + ;
		*!*				chr(13) + chr(10)  && Retorno de carro y nueva línea

		*!*			* Escribir en log.txt (modo append)
		*!*			lnhandle = fopen(lclogfile, 1)
		*!*			if lnhandle < 0
		*!*				* Si no existe, crear
		*!*				lnhandle = fcreate(lclogfile)
		*!*			endif

		*!*			if lnhandle >= 0
		*!*				= fseek(lnhandle, 0, 2) && Ir al final del archivo
		*!*				= fwrite(lnhandle, lclogline)
		*!*				= fclose(lnhandle)
		*!*			endif
		*!*		endproc


		*----------------------------------------------------------
		* Guarda el error en el archivo de log (EN UNA SOLA LÍNEA)-
		*----------------------------------------------------------
		PROCEDURE savelog(tcmessage, tcprocedure, tnline, tnerror)
		    TRY
		        local lclogline, lnhandle      
		        lclogfile = this.clogfile 
		        
				* Formato en una sola línea separado por pipes |
				lclogline = ;
						ttoc(datetime()) + " | " + ;
						this.gethostname() + " | " + ;
						iif(vartype(tcprocedure) = "C", tcprocedure, "N/D") + " | " + ;
						"Línea:" + transform(iif(vartype(tnline) = "N", tnline, 0)) + " | " + ;
						"Error:" + transform(iif(vartype(tnerror) = "N", tnerror, 0)) + " | " + ;
						iif(vartype(tcmessage) = "C", alltrim(tcmessage), "N/D") + ;
						chr(13) + chr(10)  && Retorno de carro y nueva línea

		        * Escribir en log.txt
		        lnhandle = fopen(lclogfile, 1)
		        if lnhandle < 0
		            lnhandle = fcreate(lclogfile)
		        endif

		        if lnhandle >= 0
		            = fseek(lnhandle, 0, 2) 
		            = fwrite(lnhandle, lclogline)
		            = fclose(lnhandle)
		        endif
		        
		    CATCH TO loErrLog
		        * Si falla guardar el log, NO hacemos nada para evitar crash.
		        MESSAGEBOX("No se pudo guardar el log de errores.")
		    ENDTRY
		ENDPROC
		
	*------------------------------------------------
	* Obtiene el nombre del host usando SYS(0)
	*------------------------------------------------
	procedure gethostname
		local lchostname
		lchostname = alltrim(sys(0))

		* SYS(0) devuelve información de red, extraemos solo el nombre del equipo
		if at("#", lchostname) > 0
			lchostname = alltrim(substr(lchostname, 1, at("#", lchostname) - 1))
		endif

		* Si está vacío o es inválido, usar valor por defecto
		if empty(lchostname) or lchostname == "0"
			lchostname = "N/D"
		endif

		return lchostname
	endproc

	*------------------------------------------------
	* Captura un error dentro de un bloque TRY...CATCH
	*------------------------------------------------
	procedure handlecatch(oerr)   && El objeto error (si se usa CATCH TO oErr)

		local lcmessage, lcprocedure, lnline, lnerror
		local loerror

		*--- Detectar si es un "User thrown error" (Error 2071) ---*
		if vartype(oerr) = "O" and oerr.errorno = 2071
		* Es un error lanzado manualmente con THROW
		* Usamos el mensaje original del objeto exception

			lcmessage   = oerr.uservalue.message
			lcprocedure = iif(empty(oerr.uservalue.procedure), program(), oerr.uservalue.procedure)
			lnline      = oerr.uservalue.lineno
			lnerror     = 1001  && Código personalizado para errores de aplicación
		else
			* Error del sistema o runtime
			if vartype(oerr) = "O"
				lcmessage   = oerr.message
				lcprocedure = oerr.procedure
				lnline      = oerr.lineno
				lnerror     = oerr.errorno
			else
				lcmessage   = message()
				lcprocedure = program()
				lnline      = lineno()
				lnerror     = error()
			endif
		endif

		* Mostrar y guardar el error con texto formateado
		this.showerror(lcmessage, lcprocedure, lnline, lnerror)
	endproc

enddefine