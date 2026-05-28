**programa main del sistema
set default to "C:\csistema\"

public conexion
conexion = 0

set classlib to \clases\foxribbon.vcx &&& para cargar el foxribbon

do system.app
if vartype(_screen.oribbon) = "O"
	_screen.removeobject('oRibbon')
ENDIF

_screen.newobject("oRibbon", "RibbonSettings") && clase visual para crear interfaz(ventana, botones y textbox etc).
with _screen.oribbon
	.fileini = _screen.oribbon.readfileini("curTheme.ini", "RIBBON", "Theme")
	.settings()
	.redraw()
ENDWITH


if vartype(_screen.oapp) = "O"
	_screen.removeobject("oApp")
ENDIF

_screen.newobject("oApp", "AppConfig", "clases\appconfig.prg", "", "ARIFAN ELECTRODOMESTICOS", "V1.0",.f.) && inicio mi aplicacion.

CLEAR ALL
