*---------------------------------------------------------------
* MÉTODO SIMPLIFICADO Y MÁS CONFIABLE
*---------------------------------------------------------------
FUNCTION WhatsAppEstaInstalado()
    LOCAL lnResultado
    
    * Declarar API de Windows
    DECLARE INTEGER ShellExecute IN shell32.dll ;
        INTEGER hwnd, STRING lpOperation, STRING lpFile, ;
        STRING lpParameters, STRING lpDirectory, INTEGER nShowCmd
    
    * Intentar abrir protocolo whatsapp://
    * Si retorna > 32, está instalado
    lnResultado = ShellExecute(0, "open", "whatsapp://", "", "", 0)
    
    RETURN (lnResultado > 32)
ENDFUNC