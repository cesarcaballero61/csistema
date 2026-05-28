*---------------------------------------------------------------
* FUNCIÓN: NumeroALetras
* PROPÓSITO: Convierte un número a su representación en letras
* PARÁMETROS: tnNumero - Número a convertir
* RETORNA: Cadena con el número en letras
*---------------------------------------------------------------
LPARAMETERS tnNumero

LOCAL lcRetorno, lnEntero, lnDecimal, lcDecimal
LOCAL lnMiles, lnMillones, lnBillones, lnResto
LOCAL lnCentena, lnDecena, lnUnidad

*-- Validar parámetro
IF VARTYPE(tnNumero) # "N"
    RETURN ""
ENDIF

*-- Separar parte entera y decimal
lnEntero = INT(tnNumero)
lnDecimal = INT((tnNumero - lnEntero) * 100)

*-- Convertir parte entera
lcRetorno = ""

DO CASE
    *-- CERO
    CASE lnEntero = 0
        lcRetorno = "CERO"
    
    *-- NEGATIVOS
    CASE lnEntero < 0
        lcRetorno = "MENOS " + NumeroALetras(ABS(lnEntero))
        
    *-- BILLONES (1,000,000,000 - 999,999,999,999)
    CASE lnEntero >= 1000000000
        lnBillones = INT(lnEntero / 1000000000)
        lnResto = MOD(lnEntero, 1000000000)
        IF lnBillones = 1
            lcRetorno = "UN BILLON"
        ELSE
            lcRetorno = NumeroALetras(lnBillones) + " BILLONES"
        ENDIF
        IF lnResto > 0
            lcRetorno = lcRetorno + " " + NumeroALetras(lnResto)
        ENDIF
    
    *-- MILLONES (1,000,000 - 999,999,999)
    CASE lnEntero >= 1000000
        lnMillones = INT(lnEntero / 1000000)
        lnResto = MOD(lnEntero, 1000000)
        IF lnMillones = 1
            lcRetorno = "UN MILLON"
        ELSE
            lcRetorno = NumeroALetras(lnMillones) + " MILLONES"
        ENDIF
        IF lnResto > 0
            lcRetorno = lcRetorno + " " + NumeroALetras(lnResto)
        ENDIF
    
    *-- MILES (1,000 - 999,999)
    CASE lnEntero >= 1000
        lnMiles = INT(lnEntero / 1000)
        lnResto = MOD(lnEntero, 1000)
        IF lnMiles = 1
            lcRetorno = "MIL"
        ELSE
            lcRetorno = NumeroALetras(lnMiles) + " MIL"
        ENDIF
        IF lnResto > 0
            lcRetorno = lcRetorno + " " + NumeroALetras(lnResto)
        ENDIF
    
    *-- CENTENAS (100 - 999)
    CASE lnEntero >= 100
        lnCentena = INT(lnEntero / 100)
        lnResto = MOD(lnEntero, 100)
        
        DO CASE
            CASE lnCentena = 1
                IF lnResto = 0
                    lcRetorno = "CIEN"
                ELSE
                    lcRetorno = "CIENTO"
                ENDIF
            CASE lnCentena = 2
                lcRetorno = "DOSCIENTOS"
            CASE lnCentena = 3
                lcRetorno = "TRESCIENTOS"
            CASE lnCentena = 4
                lcRetorno = "CUATROCIENTOS"
            CASE lnCentena = 5
                lcRetorno = "QUINIENTOS"
            CASE lnCentena = 6
                lcRetorno = "SEISCIENTOS"
            CASE lnCentena = 7
                lcRetorno = "SETECIENTOS"
            CASE lnCentena = 8
                lcRetorno = "OCHOCIENTOS"
            CASE lnCentena = 9
                lcRetorno = "NOVECIENTOS"
        ENDCASE
        
        IF lnResto > 0
            lcRetorno = lcRetorno + " " + NumeroALetras(lnResto)
        ENDIF
    
    *-- DECENAS (30 - 99)
    CASE lnEntero >= 30
        lnDecena = INT(lnEntero / 10)
        lnUnidad = MOD(lnEntero, 10)
        
        DO CASE
            CASE lnDecena = 3
                lcRetorno = "TREINTA"
            CASE lnDecena = 4
                lcRetorno = "CUARENTA"
            CASE lnDecena = 5
                lcRetorno = "CINCUENTA"
            CASE lnDecena = 6
                lcRetorno = "SESENTA"
            CASE lnDecena = 7
                lcRetorno = "SETENTA"
            CASE lnDecena = 8
                lcRetorno = "OCHENTA"
            CASE lnDecena = 9
                lcRetorno = "NOVENTA"
        ENDCASE
        
        IF lnUnidad > 0
            lcRetorno = lcRetorno + " Y " + NumeroALetras(lnUnidad)
        ENDIF
    
    *-- UNIDADES Y VEINTENAS (1 - 29)
    CASE lnEntero >= 1
        DO CASE
            CASE lnEntero = 1
                lcRetorno = "UNO"
            CASE lnEntero = 2
                lcRetorno = "DOS"
            CASE lnEntero = 3
                lcRetorno = "TRES"
            CASE lnEntero = 4
                lcRetorno = "CUATRO"
            CASE lnEntero = 5
                lcRetorno = "CINCO"
            CASE lnEntero = 6
                lcRetorno = "SEIS"
            CASE lnEntero = 7
                lcRetorno = "SIETE"
            CASE lnEntero = 8
                lcRetorno = "OCHO"
            CASE lnEntero = 9
                lcRetorno = "NUEVE"
            CASE lnEntero = 10
                lcRetorno = "DIEZ"
            CASE lnEntero = 11
                lcRetorno = "ONCE"
            CASE lnEntero = 12
                lcRetorno = "DOCE"
            CASE lnEntero = 13
                lcRetorno = "TRECE"
            CASE lnEntero = 14
                lcRetorno = "CATORCE"
            CASE lnEntero = 15
                lcRetorno = "QUINCE"
            CASE lnEntero = 16
                lcRetorno = "DIECISEIS"
            CASE lnEntero = 17
                lcRetorno = "DIECISIETE"
            CASE lnEntero = 18
                lcRetorno = "DIECIOCHO"
            CASE lnEntero = 19
                lcRetorno = "DIECINUEVE"
            CASE lnEntero = 20
                lcRetorno = "VEINTE"
            CASE lnEntero = 21
                lcRetorno = "VEINTIUNO"
            CASE lnEntero = 22
                lcRetorno = "VEINTIDOS"
            CASE lnEntero = 23
                lcRetorno = "VEINTITRES"
            CASE lnEntero = 24
                lcRetorno = "VEINTICUATRO"
            CASE lnEntero = 25
                lcRetorno = "VEINTICINCO"
            CASE lnEntero = 26
                lcRetorno = "VEINTISEIS"
            CASE lnEntero = 27
                lcRetorno = "VEINTISIETE"
            CASE lnEntero = 28
                lcRetorno = "VEINTIOCHO"
            CASE lnEntero = 29
                lcRetorno = "VEINTINUEVE"
        ENDCASE
        
    OTHERWISE
        lcRetorno = "NÚMERO FUERA DE RANGO"
ENDCASE

*-- Agregar parte decimal si existe
IF lnDecimal > 0
    lcDecimal = PADL(ALLTRIM(STR(lnDecimal)), 2, "0")
    lcRetorno = lcRetorno + " CON " + lcDecimal + "/100"
ENDIF

RETURN UPPER(ALLTRIM(lcRetorno))