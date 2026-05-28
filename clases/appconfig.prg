* appconfig.prg
define class appconfig as custom

	cappname     = ""
	cappversion  = ""
	ldebugmode   = .f.

* Propiedades de rutas
	capppath     = ""
	cclassespath = ""
	cformspath   = ""
	creportspath = ""
	cconfigpath  = ""
	clogspath    = ""
	clibprg		 = "" && para los prgs


* Propiedades de conexión BD
	cservidor = ""
	cbase     = ""
	cusuario  = ""
	cport     = ""
	cclave    = ""

* Instancia del manejador de excepciones
	oexception   = .null.

*Variable para verificar si todo inicio bien.
	allok =.f.

*usuario de en secion del sistema
	cusuariosistema = ""
	nusuariosistema = 0
	ctipousuario = ""

*datos del personal segun usuario en sesion
	npersonal 		= 0
	cpersonalnombre = ""

*datos de empresa y surcursal
	nempresa  = 0
	nsucursal = 0

*punto expedicion y establecimiento que seran leido de un archivo .ini

	cestablecimiento = ""
	cpuntoexpedicion = ""


* ----------------------------------------------
* Método ConnectDatabase: Conecta a MySQL
* Retorna: .T. si conectó exitosamente, .F. si falló
* ----------------------------------------------
	procedure connectdatabase
		local lcstringconexion, lnhandle, loerr
		local lcerrormsg, llok

		llok = .t.

		try
* Verificar que se hayan cargado los datos de configuración
			if empty(this.cservidor) or empty(this.cbase)
				throw "No se han cargado los datos de configuración de la base de datos"
			endif

* Construir cadena de conexión para MySQL ODBC
* Nota: Requiere MySQL ODBC Driver instalado (MySQL Connector/ODBC)
			lcstringconexion = ;
				"DRIVER={MySQL ODBC 5.1 Driver};" + ;
				"SERVER=" + alltrim(this.cservidor) + ";" + ;
				"DATABASE=" + alltrim(this.cbase) + ";" + ;
				"UID=" + alltrim(this.cusuario) + ";" + ;
				"PWD=" + alltrim(this.cclave) + ";" + ;
				"PORT=" + alltrim(this.cport) + ";" + ;
				"OPTION=3;"

* Cerrar conexión anterior si existe
			if conexion > 0
				sqldisconnect(conexion)
				conexion = 0
			endif

* Intentar conexión
			lnhandle = sqlstringconnect(lcstringconexion)

			if lnhandle < 0
* Error en la conexión
				lcerrormsg = "Error al conectar con la base de datos MySQL" + chr(13) + ;
					"Servidor: " + this.cservidor + chr(13) + ;
					"Base de datos: " + this.cbase + chr(13) + ;
					"Puerto: " + this.cport + chr(13) + chr(13) + ;
					"Verifique:" + chr(13) + ;
					"1. Que el servidor MySQL esté activo" + chr(13) + ;
					"2. Los datos de conexión en conexion.ini" + chr(13) + ;
					"3. Que tenga instalado MySQL ODBC Driver 5.1"

* Lanzar excepción
				local loex as exception
				loex = createobject("Exception")
				loex.message = lcerrormsg
				loex.procedure = program()
				loex.errorno = 1002  && Código personalizado para error de conexión
				throw loex
			endif

* Asignar handle a variable pública
			conexion = lnhandle

* Configurar opciones de la conexión
			sqlsetprop(conexion, "Transactions", 1)  && Manual transactions
			sqlsetprop(conexion, "BatchMode", .t.)
			sqlsetprop(conexion, "QueryTimeOut", 0)

* Log exitoso si está en modo debug
			if this.ldebugmode
				this.writelog("Conexión exitosa a MySQL: " + this.cbase + " en " + this.cservidor)
			endif

			llok =.t.

		catch to loerr
* Manejar error con el manejador de excepciones
			if vartype(this.oexception) = "O"
				this.oexception.handlecatch(loerr)
			else
				messagebox("Error crítico al conectar: " + loerr.message, 16, "Error de Conexión")
			endif

			conexion = 0
			llok = .f.

		endtry

		return llok

	endproc


* ----------------------------------------------
* Método DisconnectDatabase: Desconecta de MySQL
* ----------------------------------------------
	procedure disconnectdatabase
		local lnresult

		if conexion > 0
			lnresult = sqldisconnect(conexion)
			conexion = 0

			if this.ldebugmode
				this.writelog("Desconexión de base de datos: " + iif(lnresult = 1, "Exitosa", "Con errores"))
			endif
		endif

	endproc


* ----------------------------------------------
* Método WriteLog: Escribe en el log (auxiliar)
* ----------------------------------------------
	procedure writelog(tcmessage)
		local lclogfile, lnhandle

		lclogfile = this.clogspath + "conexion_" + dtoc(date(), 1) + ".log"
		lnhandle = fopen(lclogfile, 2)  && Open for append

		if lnhandle < 0
			lnhandle = fcreate(lclogfile)
		endif

		if lnhandle > 0
			fseek(lnhandle, 0, 2)  && Go to end
			fputs(lnhandle, ttoc(datetime()) + " - " + tcmessage)
			fclose(lnhandle)
		endif

	endproc

* ----------------------------------------------
* Método INIT: inicializa la configuración		*
* Parámetros:									*
*   tcappname   -> nombre de la aplicación		*
*   tcversion   -> versión de la aplicación		*
*   tldebugmode -> modo depuración (.t. o .f.)	*
* ----------------------------------------------
* En appconfig.prg -> Procedure Init
	PROCEDURE Init(tcappname AS STRING, tcversion AS STRING, tldebugmode AS BOOLEAN)
	    LOCAL loerr
	    
	    * 1. Bloque de configuración (Protegido por TRY)
	    TRY
	        WITH THIS
	            .cappname    = m.tcappname
	            .cappversion = m.tcversion
	            .ldebugmode  = m.tldebugmode

	            .setpaths() 
	            
	            * Declaración de API
	            DECLARE INTEGER GetPrivateProfileString IN WIN32API ;
	                STRING cSection, STRING cEntry, STRING cDefault, ;
	                STRING @cRetVal, INTEGER nRetLen, STRING cFileName
	                
	            DECLARE INTEGER SetForegroundWindow IN user32 INTEGER

	            * Configurar errores PRIMERO
	            .oexception = NEWOBJECT("MyException", "myexception.prg")
	            .configureerrorhandler() 

	            .configureenvironment()
	            .createdirectories()
	            .setclasslib()
	            .loaddatabaseconfig()
	            .setestablecimiento_expedicion()
	            .connectdatabase()
	            
	            * Configurar FoxyPreviewer
	            DO foxypreviewer.app 
	            _Screen.oFoxyPreviewer.nButtonSize = 2
	            _Screen.oFoxyPreviewer.nButtonStyle = 2
	            _Screen.oFoxyPreviewer.nPreviewMode = 2

	            THIS.allok = .T.
	        ENDWITH
	        
	    CATCH TO loerr
	        THIS.allok = .F.
	        IF VARTYPE(THIS.oexception) = "O"
	            THIS.oexception.handlecatch(loerr)
	        ELSE
	            MESSAGEBOX("Error crítico al iniciar: " + loerr.Message, 16, "Error crítico")
	        ENDIF
	    ENDTRY

	    * 2. Ejecución de la App (FUERA DEL TRY...CATCH)
	    * Esto asegura que si hay un error después, el READ EVENTS no se cancele automáticamente
	    IF THIS.allok
	        IF NOT tldebugmode
	            _Screen.Visible = .F.
	            DO FORM frm_login
	            READ EVENTS      && <--- AQUÍ ES EL LUGAR SEGURO
	        ELSE
	            _Screen.oApp.cusuariosistema = "JUAN PEREZ"
	            _Screen.oApp.nusuariosistema = 1
	            * En modo debug no solemos poner READ EVENTS si trabajamos desde el IDE,
	            * pero si es un EXE debug, sí va.
	        ENDIF 
	    ELSE
	        * Si falló la configuración inicial, retornamos .F. para que el programa principal sepa
	        RETURN .F.
	    ENDIF
	    
	ENDPROC

* Configurar rutas del proyecto
	procedure setpaths
		this.capppath = addbs(sys(5) + sys(2003))


		this.cclassespath = this.capppath + "clases\"
		this.cformspath   = this.capppath + ""
		this.creportspath = this.capppath + "informes\"
		this.cconfigpath  = this.capppath + ""
		this.clogspath    = this.capppath + "log\"
		this.clibprg	  = this.capppath + "prg\"

* Añadir rutas al SET PATH de VFP

		set path to (this.cclassespath) additive
		set path to (this.cformspath)   additive
		set path to (this.cconfigpath)  additive
		set path to (this.cconfigpath) additive
		set path to (this.clogspath) additive
		set path to (this.clibprg) additive

	endproc

	procedure setclasslib
		set classlib to  vfphash.vcx, controles.vcx additive
	endproc

	procedure configureenvironment
		set exclusive off
		set safety off
		set deleted on
		set multilocks on
		set nulldisplay to [NULL]
		set century on
		set talk off
		set date dmy
		set hours to 24
		set exact on
		
		*-- 1. Desactivar que VFP lea la configuración de Windows
		SET SYSFORMATS OFF

		*-- 2. Configurar manualmente los separadores
		*-- Ejemplo: 130.000,50 (Miles con punto, decimales con coma)
		SET SEPARATOR TO "."
		SET POINT TO ","

		*-- Opcional: Definir formato de fecha para evitar errores de fecha
		SET DATE TO BRITISH  && dd/mm/aaaa
		SET CENTURY ON       && 2025 en lugar de 25
		
		CLEAR
		
		
	endproc

* Crear carpetas si no existen
	procedure createdirectories
		local array ladirs[6]
		local i, lcdir
		local loexception as exception

		ladirs[1] = this.clogspath
		ladirs[2] = this.cconfigpath
		ladirs[3] = this.creportspath
		ladirs[4] = this.cformspath
		ladirs[5] = this.cclassespath
		ladirs[6] = this.clibprg


		for i = 1 to alen(ladirs, 1)
			lcdir = alltrim(ladirs[i])
			if !directory(lcdir)
				md (lcdir)
			endif
		endfor

	endproc



* Modifica el método configureerrorhandler así:
	procedure configureerrorhandler
* Cargar la clase de excepción personalizada
		set procedure to (this.cclassespath + "myexception.prg") additive

* Crear instancia del manejador de errores
		this.oexception = createobject("MyException")
		this.oexception.clogfile = this.clogspath + "logErr.txt"

* Configurar manejador global de errores apuntando AL MÉTODO DE LA CLASE
		if !this.ldebugmode
* Usamos _SCREEN.oApp.HandleError en lugar de DO globalerrorhandler
			on error _screen.oapp.handleerror(error(), message(), lineno(), program())
		else
			on error
		endif
	endproc


	procedure loaddatabaseconfig
		local lcinifile, lcerrormessage
		lcinifile = this.cconfigpath + "conexion.ini"

		if !file(lcinifile)
			lcerrormessage = "No se encontró el archivo de configuración: " + lcinifile
* Crear y lanzar excepción personalizada
			local loex as exception
			loex = createobject("Exception")
			loex.message = lcerrormessage
			loex.procedure = program()
			loex.errorno = 1001  && Código personalizado para "archivo no encontrado"
			throw loex
		endif

		this.cservidor = this.readini("DATABASE", "Servidor", lcinifile, "localhost")
		this.cbase     = this.readini("DATABASE", "Base", 	 lcinifile, "")
		this.cusuario  = this.readini("DATABASE", "Usuario", lcinifile, "root")
		this.cport	   = this.readini("DATABASE", "Port",	 lcinifile, "3306")
		this.cclave    = this.readini("DATABASE", "Password", lcinifile, "")
	endproc


	procedure setestablecimiento_expedicion
		local lcinifile, lcerrormessage
		lcinifile = this.cconfigpath + "Dato_local.ini"

		if !file(lcinifile)
			lcerrormessage = "No se encontró el archivo de configuración: " + lcinifile
* Crear y lanzar excepción personalizada
			local loex as exception
			loex = createobject("Exception")
			loex.message = lcerrormessage
			loex.procedure = program()
			loex.errorno = 1001  && Código personalizado para "archivo no encontrado"
			throw loex
		endif

		*this.cestablecimiento = this.readini("EXPEDICION", "cExpedicion", lcinifile, "001")
		*this.cpuntoexpedicion = this.readini("ESTABLECIMIENTO", "cEstablecimiento",  lcinifile, "001")
		
		this.cpuntoexpedicion = this.readini("EXPEDICION", "cExpedicion", lcinifile, "001")
		this.cestablecimiento = this.readini("ESTABLECIMIENTO", "cEstablecimiento",  lcinifile, "001")

		this.nempresa  = this.readini("DATOS_EMPRESA", "nEmpresa", lcinifile,  "1")
		this.nsucursal = this.readini("DATOS_EMPRESA", "nSucursal", lcinifile, "1")

		this.nempresa = int(val(this.nempresa))
		this.nsucursal = int(val(this.nsucursal))


	endproc

	procedure readini(tcsection, tckey, tcfile, tcdefault)
		local lcbuffer, lncantidadcaracteres
		lcbuffer = space(255)

		lncantidadcaracteres = getprivateprofilestring(tcsection, tckey, tcdefault,;
			  @lcbuffer, len(lcbuffer), tcfile)

		lcbuffer = left(lcbuffer, lncantidadcaracteres)
		lcbuffer = iif(lcbuffer == "*NULL*", "", lcbuffer)

		return (lcbuffer)
	endproc

* ----------------------------------------------
* Método Shutdown: Cierra toda la aplicación de forma segura
* Realiza limpieza de recursos antes de salir
* Parámetros:
*   tlConfirm -> .T. para mostrar confirmación, .F. para cerrar directo
* ----------------------------------------------
	procedure shutdown(tlconfirm)
		local lnresponse, llproceed, lclogmsg, llcancelado

*SET STEP ON 

* Por defecto, pedir confirmación
		if pcount() = 0
			tlconfirm = .t.
		endif

		llproceed = .t.
		llcancelado = .f.

* Verificar confirmación ANTES del TRY-CATCH
		if tlconfirm
			lnresponse = messagebox("¿Está seguro que desea cerrar la aplicación?", ;
				  36, ;  && MB_YESNO + MB_ICONQUESTION
				  this.cappname)

			if lnresponse <> 6  && IDYES - Usuario canceló
				llcancelado = .t.
				llproceed = .f.
			endif
		endif

* Si canceló, salir sin hacer nada
		if llcancelado
			return .f.
		endif

		try
* Guardar log de cierre si está en modo debug
			if this.ldebugmode
				lclogmsg = "Cerrando aplicación: " + this.cappname + " v" + this.cappversion
				this.writelog(lclogmsg)
				if !empty(this.cusuariosistema)
					this.writelog("Usuario: " + this.cusuariosistema)
				endif
			endif

* Cerrar todos los formularios abiertos
			this.closeallforms()

* Desconectar de la base de datos
			this.disconnectdatabase()

* Limpiar objetos globales
			this.cleanupobjects()

* Cerrar bases de datos locales
			close databases all

* Liberar bibliotecas y procedimientos
			set library to
			set procedure to
			set classlib to

* Restaurar configuración de errores
			on error

* Log final
			if this.ldebugmode
				this.writelog("Aplicación cerrada exitosamente")
			endif

* Limpiar Ribbon si existe
			if type("_SCREEN.oRibbon") = "O"
				_screen.removeobject("oRibbon")

			endif

* Limpiar oApp de _SCREEN
			if type("_SCREEN.oApp") = "O"

				_screen.removeobject("oApp")
			endif

* Cerrar eventos
			clear events

* Salir de VFP
			if version(2) = 0  && Runtime
				quit
			endif


		catch to loerr
* Manejar error en el cierre
			local lcerrmsg
			lcerrmsg = "Error al cerrar: " + loerr.message

			try
				if vartype(this.oexception) = "O"
					this.oexception.handlecatch(loerr)
				else
					messagebox(lcerrmsg, 16, "Error")
				endif
			catch
				messagebox(lcerrmsg, 16, "Error")
			endtry

* Forzar cierre de todas formas
			on error
			clear events
			clear all
			quit

		endtry

		return .t.

	endproc



* ----------------------------------------------
* Método CloseAllForms: Cierra todos los formularios activos
* ----------------------------------------------
	procedure closeallforms
		local i, loform

		try
* Recorrer todos los formularios desde el último al primero
			for i = _screen.formcount to 1 step - 1
				loform = _screen.forms(i)

* Intentar cerrar el formulario
				if vartype(loform) = "O" and !isnull(loform)
					loform.release()
				endif
			endfor

		catch to loerr
* Si hay error cerrando formularios, continuar de todas formas
			if this.ldebugmode
				this.writelog("Error cerrando formularios: " + loerr.message)
			endif
		endtry

	endproc

* ----------------------------------------------
* Método CleanupObjects: Limpia objetos globales
* ----------------------------------------------
	procedure cleanupobjects

		try
* Limpiar FoxyPreviewer si existe
			if type("_SCREEN.oFoxyPreviewer") = "O"
				_screen.ofoxypreviewer = .null.
			endif

* Limpiar ThemesManager si existe
			if vartype(_screen.themesmanager) = "O"
				_screen.removeobject("ThemesManager")
			endif

* Limpiar BindWindowsEventsProxy si existe
			if type("_VFP.BindWindowsEventsProxy") <> "U"
				_vfp.bindwindowseventsproxy = .null.
			endif

* Limpiar variable pública de conexión
			if type("conexion") = "N"
				if conexion > 0
					sqldisconnect(conexion)
				endif
				release conexion
			endif

* Liberar manejador de excepciones (al final)
			this.oexception = .null.


		catch to loerr
* Continuar aun si hay errores
			if this.ldebugmode
				this.writelog("Error limpiando objetos: " + loerr.message)
			endif
		endtry

	endproc


*------------------------------------------------
* Nuevo Método: Manejador global de errores (Reemplaza al proc suelto)
*------------------------------------------------
	procedure handleerror(tnerror, tcmessage, tnline, tcprocedure)

	* Validamos que el objeto de excepción exista para evitar bucles infinitos
		if vartype(this.oexception) = "O"
			try
				this.oexception.showerror(tcmessage, tcprocedure, tnline, tnerror)
			catch
	* Si falla el propio log de errores, mostramos un mensaje nativo simple
	* para evitar que la app se cierre de golpe.
				messagebox("Error crítico (Sistema de Logs): " + tcmessage, 16, "Error Grave")
			endtry
		else
			messagebox("Error " + transform(tnerror) + " en " + tcprocedure + ;
				  " (Línea " + transform(tnline) + "): " + tcmessage, 16, "Error Global")
		endif

	* IMPORTANTE: No ponemos QUIT ni CLEAR EVENTS aquí.
	* Al terminar este método, VFP intentará continuar en la siguiente línea de código.
	endproc
enddefine
