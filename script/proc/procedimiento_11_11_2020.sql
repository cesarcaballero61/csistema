/*
SQLyog Ultimate v12.4.1 (64 bit)
MySQL - 5.1.40-community : Database - db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
/* Procedure structure for procedure `cambiar_cobrador` */

/*!50003 DROP PROCEDURE IF EXISTS  `cambiar_cobrador` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`localhost` PROCEDURE `cambiar_cobrador`(tnIdVenta int,tnIdCobrador int)
begin
	update venta set idcobrador = tnIdCobrador where venta.idVenta = tnIdVenta;
end */$$
DELIMITER ;

/* Procedure structure for procedure `cur_cuota_extracto` */

/*!50003 DROP PROCEDURE IF EXISTS  `cur_cuota_extracto` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `cur_cuota_extracto`(cod_cliente INT)
BEGIN
SELECT
	venta.nrofactura
	,venta.fecha
	,cuotas.total_venta AS monto
	, cuotas.entrega_inicial AS entrega
	, cuotas.SALDO_ACTUAL AS saldo
	, cuotas.cantidad_cuota AS cantidad
	, cuotas.ultimo_fecha_pago AS ult_fecha_pago
	, cuotas.idcuotas AS codcuota
	, venta.idVenta AS codventa
	, v_cobrador.idcobrador
	, v_cobrador.nombre as nombreCobrador
	, v_cobrador.apellido as apellidoCobrador
	,cuotas.obs
FROM venta
     JOIN cliente ON venta.idcliente = cliente.idcliente
     JOIN cuotas ON cuotas.idVenta = venta.idVenta 
     join v_cobrador on v_cobrador.idcobrador = venta.idcobrador
     WHERE venta.tipo=2 AND cliente.idcliente=cod_cliente AND CUOTAS.estado="PEN" AND venta.estado="F";
END */$$
DELIMITER ;

/* Procedure structure for procedure `cur_extracto_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `cur_extracto_cliente` */;

DELIMITER $$

/*!50003 CREATE DEFINER=`root`@`%` PROCEDURE `cur_extracto_cliente`(cod_cuota INT,cod_suc INT)
BEGIN
SELECT
	venta.idventa
    ,venta.nrofactura
    , venta.fecha
    , cuotas_detalle.orden_char AS orden
    , cuotas_detalle.fecha_vto AS vto
    , cuotas_detalle.ultimo_atraso
    , cuotas_detalle.cuota 
    , cuotas_detalle.ultimo_nro_recibo 
    , cuotas_detalle.ultimo_importe 
    , cuotas_detalle.ultima_Fecha_pago 
    , cuotas_detalle.saldo_cuota AS saldo
    , cuotas_detalle.ultimo_interes_calcu AS ultimo_interes
    ,@n_atraso:=IF(cuotas_detalle.Estado="CAN",DATEDIFF(cuotas_detalle.ultima_Fecha_pago,cuotas_detalle.fecha_vto),DATEDIFF(NOW(),cuotas_detalle.fecha_vto)) AS  atraso
    , cuotas_detalle.ultimo_descuento
    , calc_interes(@n_atraso,cuotas_detalle.saldo_cuota,cod_suc) AS interes
    , cliente.apellido
    , cliente.nombre
    , cliente.ci
    , cliente.ruc
    , cliente.telefono
    , cuotas.obs
    , cliente.celular
	, zona.zona
	, barrio.barrio
	, cuotas_detalle.estado
FROM cuotas 
		join cuotas_detalle on cuotas.idcuotas=cuotas_detalle.idcuotas
		join venta on  cuotas.idventa=venta.idventa
		join cliente on venta.idcliente=cliente.idcliente
		join zona  on cliente.idzona=zona.idzona
		join barrio on cliente.idbarrio=barrio.idbarrio
where cuotas.idcuotas=cod_cuota and cuotas.estado="PEN" and venta.estado="F";
end */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
