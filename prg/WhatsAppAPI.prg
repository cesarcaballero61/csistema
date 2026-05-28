*=========================================================
* Clase WhatsAppAPI para Visual FoxPro 9
* Green API Integration
* Autor: [Cesar Godoy]
* Fecha: 06/12/2025
*=========================================================

DEFINE CLASS WhatsAppAPI AS Custom
    *-- Propiedades
    cIdInstance = ""
    cApiToken = ""
    cBaseURL = "https://api.green-api.com/waInstance"
    lDebugMode = .F.
    
    *-- Constructor
    PROCEDURE Init(tcIdInstance, tcApiToken)
        This.cIdInstance = tcIdInstance
        This.cApiToken = tcApiToken
    ENDPROC
    
    *=========================================================
    * Método: EnviarMensaje
    * Descripción: Envía un mensaje de texto a un número
    * Parámetros:
    *   tcTelefono: Número con código de país (ej: "595981123456")
    *   tcMensaje: Texto del mensaje
    * Retorna: Objeto con la respuesta
    *=========================================================
    PROCEDURE EnviarMensaje(tcTelefono, tcMensaje)
        LOCAL loHTTP, lcURL, lcJSON, lcResponse, loResponse
        LOCAL llError, lcMensajeError
        
        llError = .F.
        lcMensajeError = ""
        loResponse = .NULL.
        
        *-- Validar parámetros
        IF EMPTY(tcTelefono) OR EMPTY(tcMensaje)
            loResponse = This.CrearError("Teléfono y mensaje son requeridos")
            RETURN loResponse
        ENDIF
        
        *-- Limpiar número (solo dígitos)
        tcTelefono = This.LimpiarNumero(tcTelefono)
        
        *-- Crear objeto HTTP
        TRY
            loHTTP = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al crear objeto HTTP: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
            RETURN loResponse
        ENDIF
        
        *-- Construir URL
        lcURL = This.cBaseURL + This.cIdInstance + ;
                "/sendMessage/" + This.cApiToken
        
        *-- Construir JSON (escapar comillas)
        lcMensaje = This.EscaparJSON(tcMensaje)
        TEXT TO lcJSON NOSHOW TEXTMERGE
        {
            "chatId": "<<tcTelefono>>@c.us",
            "message": "<<lcMensaje>>"
        }
        ENDTEXT
        
        *-- Mostrar en modo debug
        IF This.lDebugMode
            ? "URL:", lcURL
            ? "JSON:", lcJSON
        ENDIF
        
        *-- Enviar petición
        TRY
            loHTTP.OPEN("POST", lcURL, .F.)
            loHTTP.setRequestHeader("Content-Type", "application/json")
            loHTTP.SEND(lcJSON)
            
            *-- Obtener respuesta
            lcResponse = loHTTP.responseText
            WAIT WINDOW lcResponse 
            IF This.lDebugMode
                ? "Respuesta:", lcResponse
            ENDIF
            
            *-- Parsear respuesta JSON
            loResponse = This.ParsearJSON(lcResponse)
            
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al enviar: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
        ENDIF
        
        RETURN loResponse
    ENDPROC
    
    *=========================================================
    * Método: EnviarImagen
    * Descripción: Envía una imagen desde URL
    * Parámetros:
    *   tcTelefono: Número con código de país
    *   tcURLImagen: URL de la imagen
    *   tcCaption: Texto descriptivo (opcional)
    *=========================================================
    PROCEDURE EnviarImagen(tcTelefono, tcURLImagen, tcCaption)
        LOCAL loHTTP, lcURL, lcJSON, lcResponse, loResponse
        LOCAL llError, lcMensajeError
        
        llError = .F.
        lcMensajeError = ""
        loResponse = .NULL.
        
        tcCaption = IIF(EMPTY(tcCaption), "", tcCaption)
        tcTelefono = This.LimpiarNumero(tcTelefono)
        
        TRY
            loHTTP = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al crear objeto HTTP: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
            RETURN loResponse
        ENDIF
        
        lcURL = This.cBaseURL + This.cIdInstance + ;
                "/sendFileByUrl/" + This.cApiToken
        
        lcCaption = This.EscaparJSON(tcCaption)
        TEXT TO lcJSON NOSHOW TEXTMERGE
        {
            "chatId": "<<tcTelefono>>@c.us",
            "urlFile": "<<tcURLImagen>>",
            "fileName": "imagen.jpg",
            "caption": "<<lcCaption>>"
        }
        ENDTEXT
        
        TRY
            loHTTP.OPEN("POST", lcURL, .F.)
            loHTTP.setRequestHeader("Content-Type", "application/json")
            loHTTP.SEND(lcJSON)
            
            lcResponse = loHTTP.responseText
            loResponse = This.ParsearJSON(lcResponse)
            
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al enviar imagen: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
        ENDIF
        
        RETURN loResponse
    ENDPROC
    
    *=========================================================
    * Método: VerificarNumero
    * Descripción: Verifica si un número tiene WhatsApp
    * Parámetros:
    *   tcTelefono: Número con código de país
    *=========================================================
    PROCEDURE VerificarNumero(tcTelefono)
        LOCAL loHTTP, lcURL, lcJSON, lcResponse, loResponse
        LOCAL llError, lcMensajeError
        
        llError = .F.
        lcMensajeError = ""
        loResponse = .NULL.
        
        tcTelefono = This.LimpiarNumero(tcTelefono)
        
        TRY
            loHTTP = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al crear objeto HTTP: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
            RETURN loResponse
        ENDIF
        
        lcURL = This.cBaseURL + This.cIdInstance + ;
                "/checkWhatsapp/" + This.cApiToken
        
        TEXT TO lcJSON NOSHOW TEXTMERGE
        {
            "phoneNumber": <<tcTelefono>>
        }
        ENDTEXT
        
        TRY
            loHTTP.OPEN("POST", lcURL, .F.)
            loHTTP.setRequestHeader("Content-Type", "application/json")
            loHTTP.SEND(lcJSON)
            
            lcResponse = loHTTP.responseText
            loResponse = This.ParsearJSON(lcResponse)
            
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al verificar: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
        ENDIF
        
        RETURN loResponse
    ENDPROC
    
    *=========================================================
    * Método: EnviarArchivo
    * Descripción: Envía un archivo desde URL
    * Parámetros:
    *   tcTelefono: Número con código de país
    *   tcURLArchivo: URL del archivo
    *   tcNombreArchivo: Nombre del archivo (opcional)
    *   tcCaption: Texto descriptivo (opcional)
    *=========================================================
    PROCEDURE EnviarArchivo(tcTelefono, tcURLArchivo, tcNombreArchivo, tcCaption)
        LOCAL loHTTP, lcURL, lcJSON, lcResponse, loResponse
        LOCAL llError, lcMensajeError
        
        llError = .F.
        lcMensajeError = ""
        loResponse = .NULL.
        
        tcNombreArchivo = IIF(EMPTY(tcNombreArchivo), "documento.pdf", tcNombreArchivo)
        tcCaption = IIF(EMPTY(tcCaption), "", tcCaption)
        tcTelefono = This.LimpiarNumero(tcTelefono)
        
        TRY
            loHTTP = CREATEOBJECT("MSXML2.ServerXMLHTTP.6.0")
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al crear objeto HTTP: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
            RETURN loResponse
        ENDIF
        
        lcURL = This.cBaseURL + This.cIdInstance + ;
                "/sendFileByUrl/" + This.cApiToken
        
        lcCaption = This.EscaparJSON(tcCaption)
        TEXT TO lcJSON NOSHOW TEXTMERGE
        {
            "chatId": "<<tcTelefono>>@c.us",
            "urlFile": "<<tcURLArchivo>>",
            "fileName": "<<tcNombreArchivo>>",
            "caption": "<<lcCaption>>"
        }
        ENDTEXT
        
        TRY
            loHTTP.OPEN("POST", lcURL, .F.)
            loHTTP.setRequestHeader("Content-Type", "application/json")
            loHTTP.SEND(lcJSON)
            
            lcResponse = loHTTP.responseText
            loResponse = This.ParsearJSON(lcResponse)
            
        CATCH TO loEx
            llError = .T.
            lcMensajeError = "Error al enviar archivo: " + loEx.Message
        ENDTRY
        
        IF llError
            loResponse = This.CrearError(lcMensajeError)
        ENDIF
        
        RETURN loResponse
    ENDPROC
    
    *=========================================================
    * Métodos auxiliares
    *=========================================================
    
    *-- Limpiar número (solo dígitos)
    PROCEDURE LimpiarNumero(tcNumero)
        LOCAL lcLimpio, i, cChar
        lcLimpio = ""
        FOR i = 1 TO LEN(tcNumero)
            cChar = SUBSTR(tcNumero, i, 1)
            IF ISDIGIT(cChar)
                lcLimpio = lcLimpio + cChar
            ENDIF
        ENDFOR
        RETURN lcLimpio
    ENDPROC
    
    *-- Escapar comillas en JSON
    PROCEDURE EscaparJSON(tcTexto)
        tcTexto = STRTRAN(tcTexto, '\', '\\')
        tcTexto = STRTRAN(tcTexto, '"', '\"')
        tcTexto = STRTRAN(tcTexto, CHR(13), '\n')
        tcTexto = STRTRAN(tcTexto, CHR(10), '')
        RETURN tcTexto
    ENDPROC
    
    *-- Parsear respuesta JSON (simple)
    PROCEDURE ParsearJSON(tcJSON)
        LOCAL loObj
        loObj = CREATEOBJECT("Empty")
        
        *-- Extraer idMessage si existe
        IF '"idMessage"' $ tcJSON
            ADDPROPERTY(loObj, "idMessage", This.ExtraerValor(tcJSON, "idMessage"))
            ADDPROPERTY(loObj, "Exito", .T.)
            ADDPROPERTY(loObj, "Error", "")
        ELSE
            ADDPROPERTY(loObj, "Exito", .F.)
            ADDPROPERTY(loObj, "idMessage", "")
            ADDPROPERTY(loObj, "Error", "No se recibió confirmación del envío")
        ENDIF
        
        ADDPROPERTY(loObj, "RespuestaCompleta", tcJSON)
        
        RETURN loObj
    ENDPROC
    
    *-- Extraer valor de JSON
    PROCEDURE ExtraerValor(tcJSON, tcClave)
        LOCAL lnPos1, lnPos2, lcValor
        lnPos1 = AT('"' + tcClave + '"', tcJSON)
        IF lnPos1 = 0
            RETURN ""
        ENDIF
        lnPos1 = AT('":', tcJSON, lnPos1) + 3
        lnPos2 = AT('"', tcJSON, lnPos1)
        lcValor = SUBSTR(tcJSON, lnPos1, lnPos2 - lnPos1)
        RETURN lcValor
    ENDPROC
    
    *-- Crear objeto de error
    PROCEDURE CrearError(tcMensaje)
        LOCAL loObj
        loObj = CREATEOBJECT("Empty")
        ADDPROPERTY(loObj, "Exito", .F.)
        ADDPROPERTY(loObj, "Error", tcMensaje)
        ADDPROPERTY(loObj, "idMessage", "")
        ADDPROPERTY(loObj, "RespuestaCompleta", "")
        RETURN loObj
    ENDPROC
    
ENDDEFINE

*=========================================================
* Función de prueba rápida
*=========================================================
PROCEDURE TestWhatsApp
    LOCAL loWA, loResult
    
    *-- Configurar tus credenciales
    loWA = CREATEOBJECT("WhatsAppAPI", "TU_ID_INSTANCE", "TU_API_TOKEN")
    loWA.lDebugMode = .T.
    
    *-- Enviar mensaje de prueba
    loResult = loWA.EnviarMensaje("595981123456", "Hola desde VFP! ??")
    
    IF loResult.Exito
        ? "? Mensaje enviado exitosamente!"
        ? "ID del mensaje:", loResult.idMessage
    ELSE
        ? "? Error:", loResult.Error
    ENDIF
    
    *-- Verificar número
    ? ""
    ? "Verificando número..."
    loResult = loWA.VerificarNumero("595981123456")
    
    IF loResult.Exito
        ? "? Número verificado"
    ELSE
        ? "? Error:", loResult.Error
    ENDIF
ENDPROC