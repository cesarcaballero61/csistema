DROP PROCEDURE IF EXISTS pago_por_tarjeta;
DELIMITER $
CREATE PROCEDURE pago_por_tarjeta(
cod_cuota INT,
dfecha DATE,
ninteres INT,
ndescuento INT,
nimporte INT,
ntotalac INT,
cod_cliente INT,
cod_tipopago INT,
cod_sucursal INT,
cod_empresa INT,
cod_cobrador INT,
cap_des_mov CHAR(150),
norden INT,
corden CHAR(10),
cod_det_cuota INT,
dvto DATE,
natraso INT,
nsaldo INT,
ncod_concepto INT)


BEGIN

DECLARE codigo,cod_mov,saldo_de_cuota INT;

SELECT MAX(idpago) FROM pagos_cuotas INTO codigo;

IF ISNULL(codigo) THEN
	SET codigo=1;
ELSE
	SET codigo=codigo+1;
END IF;

INSERT INTO pagos_cuotas
            (idpago,
             fecha,
             total_interes,
             total_descuento,
             total_importe,
             total_ac,
             nro_recibo,
             idcliente,
             idTipo_pago,
             idsucursal,
             idEmpresa,
             idcobrador,
             idcuotas,
             estado)
VALUES (codigo,
        dfecha,
        ninteres,
        ndescuento,
        nimporte,
        ntotalac,
        codigo,
        cod_cliente,
        cod_tipopago,
        cod_sucursal,
        cod_empresa,
        cod_cobrador,
        cod_cuota,
        "COB");
        
 INSERT INTO detalle_pagos_cuotas
	            (orden,
	             orden_char,
	             fecha_vto,
	             atraso,
	             cuota,
	             importe,
	             interes,
	             descuento,
	             totalac,
	             idpago,
	             idcuotas_detalle)
	VALUES ( norden,
	        corden,
	        dvto,
	        natraso,
	        nsaldo,
	        nimporte,
	        ninteres,
	        ndescuento,
	        ntotalac,
	        codigo,
	        cod_det_cuota);
-- **********************************--	        
   UPDATE cuotas_detalle 
SET 
    saldo_cuota = nsaldo,
    ultimo_nro_recibo = codigo,
    ultimo_atraso = natraso,
    ultimo_importe = IFNULL(ultimo_importe, 0) + nimporte,
    ultima_Fecha_pago = dfecha,
    ultimo_interes_calcu = ninteres,
    ultimo_descuento = ndescuento,
    ultimo_totalac = ntotalac,
    Estado = IF(nsaldo = 0, 'CAN', 'PEN')
WHERE
    idcuotas_detalle = cod_det_cuota;
-- *****************************--

-- actualizacion de saldo en cabecera de cuotas --
    UPDATE cuotas SET 
    SALDO_ACTUAL=(SELECT IF(ISNULL(SUM(saldo_cuota)),0,SUM(saldo_cuota)) AS saldo FROM cuotas_detalle WHERE idcuotas=cod_cuota)
    ,ultimo_fecha_pago=dfecha
    ,ultimo_importe=nimporte
    ,ultimo_interes_calc=ninteres
    ,ultimo_descuento=ndescuento
    ,ultimo_totalac=ntotalac
    WHERE idcuotas=cod_cuota;
    
    SELECT SALDO_ACTUAL FROM cuotas WHERE idcuotas=cod_cuota INTO saldo_de_cuota;
    
	IF saldo_de_cuota<=0 THEN
	    UPDATE cuotas SET estado="CAN", fecha_cancela=dfecha WHERE idcuotas=cod_cuota;
	END IF;
-- *******************************************--
        
SELECT MAX(idmov) FROM mov_operacion INTO cod_mov;
IF ISNULL(cod_mov) THEN
	SET cod_mov=1;
ELSE
	SET cod_mov=cod_mov+1;
END IF;



INSERT INTO mov_operacion
            (idMov,
             fecha,
             operacion,
             Nro_comprobante,
             monto,
             tipo,
             descripcion,
             idconcepto,
             idcliente,
             idproveedor,
             idsucursal,
             idEmpresa)
VALUES (cod_mov,
        dfecha,
        "COBROS",
        codigo,
        nimporte,
        "I",
        cap_des_mov,
        ncod_concepto,
        cod_cliente,
        NULL,
        cod_sucursal,
        cod_empresa);
        
END