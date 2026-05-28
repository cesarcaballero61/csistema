/*
SQLyog Ultimate v12.4.3 (64 bit)
MySQL - 5.6.51 : Database - db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`db` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `db`;

/*Table structure for table `ajuste_inventario` */

DROP TABLE IF EXISTS `ajuste_inventario`;

CREATE TABLE `ajuste_inventario` (
  `idajuste_inventario` int(10) NOT NULL AUTO_INCREMENT,
  `idempresa` int(11) DEFAULT NULL,
  `idsucursal` int(10) DEFAULT NULL,
  `nro_ajuste` varchar(10) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idmotivo_ajuste` int(11) DEFAULT NULL,
  `iddeposito` int(10) DEFAULT NULL,
  `tipo_ajuste` enum('ENTRADAS','SALIDAS') DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idajuste_inventario`),
  KEY `idusuario` (`idusuario`),
  KEY `idmotivo_ajuste` (`idmotivo_ajuste`),
  KEY `iddeposito` (`iddeposito`),
  KEY `idempresa` (`idempresa`),
  KEY `idsucursal` (`idsucursal`),
  CONSTRAINT `ajuste_inventario_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  CONSTRAINT `ajuste_inventario_ibfk_2` FOREIGN KEY (`idmotivo_ajuste`) REFERENCES `motivo_ajuste` (`idmotivo`),
  CONSTRAINT `ajuste_inventario_ibfk_3` FOREIGN KEY (`iddeposito`) REFERENCES `deposito` (`iddeposito`),
  CONSTRAINT `ajuste_inventario_ibfk_4` FOREIGN KEY (`idempresa`) REFERENCES `empresa` (`idEmpresa`),
  CONSTRAINT `ajuste_inventario_ibfk_5` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `ajuste_inventario_detalle` */

DROP TABLE IF EXISTS `ajuste_inventario_detalle`;

CREATE TABLE `ajuste_inventario_detalle` (
  `idajuste_inventario_detalle` int(10) NOT NULL AUTO_INCREMENT,
  `idajuste_inventario` int(10) DEFAULT NULL,
  `idarticulo` int(11) DEFAULT NULL,
  `marca` varchar(45) DEFAULT NULL,
  `grupo_subgrupo` varchar(45) DEFAULT NULL,
  `precio_costo` decimal(10,2) DEFAULT NULL,
  `cantidad` int(10) DEFAULT NULL,
  PRIMARY KEY (`idajuste_inventario_detalle`),
  KEY `idarticulo` (`idarticulo`),
  KEY `idajuste_inventario` (`idajuste_inventario`),
  CONSTRAINT `ajuste_inventario_detalle_ibfk_1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`),
  CONSTRAINT `ajuste_inventario_detalle_ibfk_2` FOREIGN KEY (`idajuste_inventario`) REFERENCES `ajuste_inventario` (`idajuste_inventario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `anulacion_compra` */

DROP TABLE IF EXISTS `anulacion_compra`;

CREATE TABLE `anulacion_compra` (
  `idanulacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT NULL,
  `motivo` varchar(200) DEFAULT NULL,
  `idcompra` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idanulacion`),
  KEY `fk_anulacion_compra_compra1_idx` (`idcompra`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `anulacion_compra_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  CONSTRAINT `fk_anulacion_compra_compra1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `anulacion_recibo` */

DROP TABLE IF EXISTS `anulacion_recibo`;

CREATE TABLE `anulacion_recibo` (
  `idanulacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT NULL,
  `motivo` varchar(100) DEFAULT NULL,
  `idpago` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idanulacion`),
  KEY `fk_anulacio_recibo_pagos_cuotas1_idx` (`idpago`),
  KEY `idsuaurio` (`idusuario`),
  CONSTRAINT `anulacion_recibo_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  CONSTRAINT `fk_anulacio_recibo_pagos_cuotas1` FOREIGN KEY (`idpago`) REFERENCES `pagos_cuotas` (`idpago`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `anulacion_venta` */

DROP TABLE IF EXISTS `anulacion_venta`;

CREATE TABLE `anulacion_venta` (
  `idanulacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` timestamp NULL DEFAULT NULL,
  `motivo` varchar(200) DEFAULT NULL,
  `idVenta` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  PRIMARY KEY (`idanulacion`),
  KEY `fk_anulacion_venta_Venta1_idx` (`idVenta`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `anulacion_venta_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  CONSTRAINT `fk_anulacion_venta_Venta1` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `apecierrecaja` */

DROP TABLE IF EXISTS `apecierrecaja`;

CREATE TABLE `apecierrecaja` (
  `idapecierre` int(11) NOT NULL AUTO_INCREMENT,
  `fechaape` date DEFAULT NULL,
  `horaape` varchar(15) DEFAULT NULL,
  `montoape` decimal(10,0) DEFAULT NULL,
  `fechacierre` date DEFAULT NULL,
  `horacierre` varchar(15) DEFAULT NULL,
  `montocierre` decimal(10,0) DEFAULT NULL,
  `estado` char(1) DEFAULT NULL COMMENT 'A - Abierta, C - cerrada, R - Reapertura.',
  `idpersonal` int(10) DEFAULT NULL,
  `ingreso` decimal(10,0) DEFAULT NULL,
  `egreso` decimal(10,0) DEFAULT NULL,
  `diferencia` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`idapecierre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `articulo` */

DROP TABLE IF EXISTS `articulo`;

CREATE TABLE `articulo` (
  `idarticulo` int(11) NOT NULL AUTO_INCREMENT,
  `descripcion` varchar(100) DEFAULT NULL,
  `codbarra` varchar(45) DEFAULT NULL,
  `idplan_cuota` int(11) DEFAULT NULL,
  `idMarca` int(11) NOT NULL,
  `idgrupo` int(11) NOT NULL,
  `idsubgrupo` int(11) NOT NULL,
  `idproveedor` int(11) NOT NULL,
  `unidad` varchar(45) DEFAULT NULL,
  `ultima_fecha_compra` date DEFAULT NULL,
  `ultima_fecha_venta` date DEFAULT NULL,
  `ultima_fecha_ajuste` date DEFAULT NULL COMMENT 'SE UTILIZA PARA AVERIGUAR LA ULTIMA FECHA DE INGRESO DE UN ARTICULO.',
  `impuesto` enum('10','5','0') DEFAULT NULL COMMENT '0 = excenta',
  `margen_contado` decimal(10,2) DEFAULT NULL COMMENT 'porcentaje de margen para calcular en precio contado sobre costo',
  `interes_mensual` decimal(10,2) DEFAULT NULL COMMENT 'interes mensual para calcular cuotas',
  `limite_cuota` decimal(10,0) DEFAULT NULL COMMENT 'limite de cuota',
  `precio_costo` decimal(10,2) DEFAULT NULL COMMENT 'precio costo del producto',
  `precio_contado` decimal(10,2) DEFAULT NULL COMMENT 'precio contado',
  `stockminimo` int(11) DEFAULT NULL,
  `tipo_imagen` enum('LOCAL','URL') DEFAULT NULL COMMENT 'DETERMINA SI LA IMAGEN ES LOCAL O URL',
  `foto` text,
  `detalle` text,
  PRIMARY KEY (`idarticulo`),
  KEY `fk_articulo_Marca1_idx` (`idMarca`),
  KEY `fk_articulo_grupo1_idx` (`idgrupo`),
  KEY `fk_articulo_subgrupo1_idx` (`idsubgrupo`),
  KEY `fk_articulo_proveedor1_idx` (`idproveedor`),
  KEY `articulo_ibfk_1` (`idplan_cuota`),
  KEY `idx_articulo_descripcion` (`descripcion`),
  KEY `idx_articulo_descripcion_prefix` (`descripcion`(10)),
  KEY `idx_articulo_codbarra_unique` (`codbarra`),
  CONSTRAINT `articulo_ibfk_1` FOREIGN KEY (`idplan_cuota`) REFERENCES `plan_cuota` (`idplan_cuota`),
  CONSTRAINT `fk_articulo_Marca1` FOREIGN KEY (`idMarca`) REFERENCES `marca` (`idMarca`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_grupo1` FOREIGN KEY (`idgrupo`) REFERENCES `grupo` (`idgrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_proveedor1` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_articulo_subgrupo1` FOREIGN KEY (`idsubgrupo`) REFERENCES `subgrupo` (`idsubgrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `barrio` */

DROP TABLE IF EXISTS `barrio`;

CREATE TABLE `barrio` (
  `idbarrio` int(11) NOT NULL AUTO_INCREMENT,
  `barrio` varchar(45) DEFAULT NULL,
  `idzona` int(11) DEFAULT NULL,
  PRIMARY KEY (`idbarrio`),
  KEY `idzona` (`idzona`),
  CONSTRAINT `barrio_ibfk_1` FOREIGN KEY (`idzona`) REFERENCES `zona` (`idzona`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `cliente` */

DROP TABLE IF EXISTS `cliente`;

CREATE TABLE `cliente` (
  `idcliente` int(11) NOT NULL AUTO_INCREMENT,
  `idzona` int(11) NOT NULL,
  `idbarrio` int(11) NOT NULL,
  `idprofesion` int(11) NOT NULL,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `ruc` varchar(45) DEFAULT NULL,
  `ci` varchar(45) NOT NULL,
  `celular` varchar(20) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `referencia` text,
  `trabajo_lugar` varchar(45) DEFAULT NULL,
  `trabajo_telefono` varchar(20) DEFAULT NULL,
  `ref1` varchar(45) DEFAULT NULL,
  `ref2` varchar(45) DEFAULT NULL,
  `ref3` varchar(45) DEFAULT NULL,
  `reftel1` varchar(45) DEFAULT NULL,
  `reftel2` varchar(45) DEFAULT NULL,
  `reftel3` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `idx_cliente_ci` (`ci`),
  KEY `fk_cliente_zona_idx` (`idzona`),
  KEY `fk_cliente_barrio1_idx` (`idbarrio`),
  KEY `fk_cliente_profesion1_idx` (`idprofesion`),
  KEY `idx_cliente_nombre_apellido` (`nombre`,`apellido`),
  CONSTRAINT `fk_cliente_barrio1` FOREIGN KEY (`idbarrio`) REFERENCES `barrio` (`idbarrio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_profesion1` FOREIGN KEY (`idprofesion`) REFERENCES `profesion` (`idprofesion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_zona` FOREIGN KEY (`idzona`) REFERENCES `zona` (`idzona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `cobrador` */

DROP TABLE IF EXISTS `cobrador`;

CREATE TABLE `cobrador` (
  `idcobrador` int(11) NOT NULL AUTO_INCREMENT,
  `idPersonal` int(11) NOT NULL,
  `idzona` int(11) NOT NULL,
  PRIMARY KEY (`idcobrador`),
  KEY `fk_cobrador_Presonal1_idx` (`idPersonal`),
  KEY `fk_cobrador_zona1_idx` (`idzona`),
  CONSTRAINT `fk_cobrador_Presonal1` FOREIGN KEY (`idPersonal`) REFERENCES `personal` (`idPersonal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cobrador_zona1` FOREIGN KEY (`idzona`) REFERENCES `zona` (`idzona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `compra` */

DROP TABLE IF EXISTS `compra`;

CREATE TABLE `compra` (
  `idcompra` int(11) NOT NULL AUTO_INCREMENT,
  `idproveedor` int(11) NOT NULL,
  `iddeposito` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `fecha` date DEFAULT NULL,
  `nro_est` varchar(3) DEFAULT '001' COMMENT 'numero de establecimiento de la factura ej. 001',
  `nro_exp` varchar(3) DEFAULT '001' COMMENT 'numero de punto de expedicion de la factura ej. 001',
  `nro_factura` varchar(7) DEFAULT NULL,
  `plazo` int(10) DEFAULT NULL COMMENT 'plazo dias de vto ej. 30 dias',
  `fecha_vto` date DEFAULT NULL COMMENT 'fecha de vencimiento de la factura',
  `tipo` enum('CONTADO','CREDITO') DEFAULT 'CONTADO' COMMENT 'tipo de factura',
  `estado` enum('PENDIENTE','FACTURADO','ANULADO') DEFAULT 'PENDIENTE' COMMENT 'estado de la factura',
  `total_gravadas_excenta` decimal(10,0) DEFAULT '0',
  `total_gravadas_cinco` decimal(10,0) DEFAULT '0',
  `total_gravadas_diez` decimal(10,0) DEFAULT '0',
  `liqui_iva_cinco` int(11) DEFAULT NULL,
  `liqui_iva_diez` decimal(10,0) DEFAULT '0',
  `total_liqui_iva` decimal(10,0) DEFAULT '0',
  `total` decimal(10,0) DEFAULT '0',
  PRIMARY KEY (`idcompra`),
  KEY `fk_compra_deposito1_idx` (`iddeposito`),
  KEY `fk_compra_sucursal1_idx` (`idsucursal`),
  KEY `fk_compra_Empresa1_idx` (`idEmpresa`),
  KEY `fk_compra_proveedor1_idx` (`idproveedor`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `compra_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`),
  CONSTRAINT `fk_compra_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_deposito1` FOREIGN KEY (`iddeposito`) REFERENCES `deposito` (`iddeposito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_proveedor1` FOREIGN KEY (`idproveedor`) REFERENCES `proveedor` (`idproveedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_compra_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `compra_detalle` */

DROP TABLE IF EXISTS `compra_detalle`;

CREATE TABLE `compra_detalle` (
  `idcompra_detalle` int(10) NOT NULL AUTO_INCREMENT,
  `idcompra` int(11) NOT NULL,
  `idarticulo` int(11) DEFAULT NULL,
  `iva` enum('0','10','5') DEFAULT NULL COMMENT '0 = excenta',
  `precio_costo` decimal(10,0) DEFAULT NULL,
  `cantidad` int(11) DEFAULT NULL,
  `gravada_excenta` decimal(10,0) DEFAULT NULL,
  `gravada_cinco` decimal(10,0) DEFAULT NULL,
  `gravada_diez` decimal(10,0) DEFAULT NULL,
  `subtotal` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`idcompra_detalle`),
  KEY `idcompra` (`idcompra`),
  KEY `idarticulo` (`idarticulo`),
  CONSTRAINT `compra_detalle_ibfk_1` FOREIGN KEY (`idcompra`) REFERENCES `compra` (`idcompra`),
  CONSTRAINT `compra_detalle_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `concepto_caja` */

DROP TABLE IF EXISTS `concepto_caja`;

CREATE TABLE `concepto_caja` (
  `idconcepto` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(45) DEFAULT NULL,
  `tipo` enum('E','I') DEFAULT NULL COMMENT 'I Ingresos E Egreso',
  PRIMARY KEY (`idconcepto`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `conteo_inventario` */

DROP TABLE IF EXISTS `conteo_inventario`;

CREATE TABLE `conteo_inventario` (
  `idconteo_inventario` int(10) NOT NULL AUTO_INCREMENT,
  `nro_conteo` varchar(10) DEFAULT NULL,
  `fecha` datetime DEFAULT NULL,
  `idusuario` int(10) DEFAULT NULL,
  `fecha_procesamiento` datetime DEFAULT NULL,
  `estado` enum('PENDIENTE','PROCESADO') DEFAULT 'PENDIENTE',
  `cant_item` int(11) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idconteo_inventario`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `conteo_inventario_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `conteo_inventario_detalle` */

DROP TABLE IF EXISTS `conteo_inventario_detalle`;

CREATE TABLE `conteo_inventario_detalle` (
  `idconteo_inventario_detalle` int(10) NOT NULL AUTO_INCREMENT,
  `idconteo_inventario` int(11) DEFAULT NULL,
  `idarticulo` int(10) NOT NULL,
  `stock_sistema` int(11) DEFAULT NULL,
  `cant_conteo` int(11) DEFAULT NULL,
  `diferencia` int(11) DEFAULT NULL,
  `observacion` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idconteo_inventario_detalle`),
  KEY `idconteo_inventario` (`idconteo_inventario`),
  KEY `idarticulo` (`idarticulo`),
  CONSTRAINT `conteo_inventario_detalle_ibfk_1` FOREIGN KEY (`idconteo_inventario`) REFERENCES `conteo_inventario` (`idconteo_inventario`),
  CONSTRAINT `conteo_inventario_detalle_ibfk_2` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `control_numeracion_timbrado` */

DROP TABLE IF EXISTS `control_numeracion_timbrado`;

CREATE TABLE `control_numeracion_timbrado` (
  `idcontrol` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `establecimiento` varchar(3) NOT NULL COMMENT 'Código de establecimiento',
  `nro_expedicion` varchar(3) NOT NULL COMMENT 'Punto de expedición (001, 002, etc.)',
  `timbrado` varchar(15) NOT NULL,
  `timb_desde` date NOT NULL,
  `timb_hasta` date NOT NULL,
  `contador` int(11) NOT NULL DEFAULT '0' COMMENT 'contador de documento',
  `tipo_documento` enum('FACTURA','RECIBO') NOT NULL,
  `fecha_ultima_actualizacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `activo` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`idcontrol`),
  UNIQUE KEY `uk_sucursal_expedicion_tipo` (`idsucursal`,`nro_expedicion`,`tipo_documento`),
  KEY `fk_control_numeracion_empresa` (`idEmpresa`),
  KEY `fk_control_numeracion_sucursal` (`idsucursal`),
  CONSTRAINT `fk_control_numeracion_empresa` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_control_numeracion_sucursal` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Control de numeración y timbrados por punto de expedición';

/*Table structure for table `cuotas` */

DROP TABLE IF EXISTS `cuotas`;

CREATE TABLE `cuotas` (
  `idcuotas` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL COMMENT 'fecha de registro',
  `fecha_cancela` date DEFAULT NULL COMMENT 'fecha de cancelacion',
  `nrofactura` varchar(45) DEFAULT NULL,
  `cantidad_cuota` int(11) DEFAULT NULL,
  `primera_fecha_vto` date DEFAULT NULL,
  `total_venta` decimal(10,0) DEFAULT NULL,
  `saldo_actual` decimal(10,2) DEFAULT NULL COMMENT 'LLEVA EL SALDO ACTUAL DE LA CUOTA',
  `ultimo_fecha_pago` date DEFAULT NULL,
  `ultimo_importe` decimal(10,2) DEFAULT '0.00',
  `ultimo_interes_calc` decimal(10,2) DEFAULT '0.00',
  `ultimo_descuento` decimal(10,2) DEFAULT '0.00',
  `ultimo_totalac` decimal(10,2) DEFAULT '0.00',
  `estado` enum('PEN','CAN') DEFAULT NULL COMMENT 'CAN CANCELADOS PEN PENDIENTES',
  `idVenta` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `anulado` enum('SI','NO') DEFAULT 'NO' COMMENT 'BANDERA PARA MARCAR CUANDO SE ANULA UN CUOTA',
  PRIMARY KEY (`idcuotas`),
  KEY `fk_cuotas_Venta1_idx` (`idVenta`),
  KEY `fk_cuotas_cliente1_idx` (`idcliente`),
  CONSTRAINT `fk_cuotas_Venta1` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cuotas_cliente1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `cuotas_detalle` */

DROP TABLE IF EXISTS `cuotas_detalle`;

CREATE TABLE `cuotas_detalle` (
  `idcuotas_detalle` int(11) NOT NULL AUTO_INCREMENT,
  `orden_char` varchar(10) DEFAULT NULL,
  `orden_cuota` int(11) DEFAULT NULL,
  `fecha_vto` date DEFAULT NULL,
  `cuota` decimal(10,2) DEFAULT '0.00' COMMENT 'monto de cuotas',
  `saldo_cuota` decimal(10,2) DEFAULT '0.00',
  `ultimo_nro_recibo` varchar(11) DEFAULT NULL,
  `ultimo_atraso` int(11) DEFAULT '0',
  `ultimo_importe` decimal(10,2) DEFAULT '0.00',
  `ultima_Fecha_pago` date DEFAULT NULL,
  `ultimo_interes_calcu` decimal(10,2) DEFAULT '0.00',
  `ultimo_descuento` decimal(10,2) DEFAULT '0.00',
  `ultimo_totalac` decimal(10,2) DEFAULT '0.00',
  `estado` enum('PEN','CAN') DEFAULT 'PEN' COMMENT 'CAN - PEN',
  `idcuotas` int(11) NOT NULL,
  PRIMARY KEY (`idcuotas_detalle`),
  KEY `fk_cuotas_detalle_cuotas1_idx` (`idcuotas`),
  CONSTRAINT `fk_cuotas_detalle_cuotas1` FOREIGN KEY (`idcuotas`) REFERENCES `cuotas` (`idcuotas`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=31 DEFAULT CHARSET=utf8;

/*Table structure for table `deposito` */

DROP TABLE IF EXISTS `deposito`;

CREATE TABLE `deposito` (
  `iddeposito` int(11) NOT NULL AUTO_INCREMENT,
  `deposito` varchar(45) DEFAULT NULL,
  `idsucursal` int(11) NOT NULL,
  PRIMARY KEY (`iddeposito`),
  KEY `fk_deposito_sucursal1_idx` (`idsucursal`),
  CONSTRAINT `fk_deposito_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `detalle_pagos_cuotas` */

DROP TABLE IF EXISTS `detalle_pagos_cuotas`;

CREATE TABLE `detalle_pagos_cuotas` (
  `iddetalle_pagos_cuotas` int(11) NOT NULL AUTO_INCREMENT,
  `idpago` int(11) NOT NULL,
  `idcuotas_detalle` int(11) DEFAULT NULL COMMENT 'fk de detalle cuota',
  `tipo_pago` enum('CUOTA','OTRO') DEFAULT 'CUOTA' COMMENT 'CUOTA,OTRO',
  `idconcepto` int(11) DEFAULT NULL,
  `concepto` varchar(45) DEFAULT NULL,
  `orden` int(11) DEFAULT NULL,
  `orden_char` varchar(10) DEFAULT NULL,
  `fecha_vto` date DEFAULT NULL,
  `atraso` int(11) DEFAULT NULL,
  `cuota` decimal(10,2) DEFAULT NULL,
  `importe` decimal(10,2) DEFAULT NULL,
  `saldo` decimal(10,0) DEFAULT NULL,
  PRIMARY KEY (`iddetalle_pagos_cuotas`),
  KEY `fk_Pagos_cuotas_pago_cuota1_idx` (`idpago`),
  KEY `fk_detalle_Pagos_cuotas_cuotas_detalle1_idx` (`idcuotas_detalle`),
  KEY `idconcepto` (`idconcepto`),
  CONSTRAINT `detalle_pagos_cuotas_ibfk_1` FOREIGN KEY (`idconcepto`) REFERENCES `concepto_caja` (`idconcepto`),
  CONSTRAINT `fk_Pagos_cuotas_pago_cuota1` FOREIGN KEY (`idpago`) REFERENCES `pagos_cuotas` (`idpago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_Pagos_cuotas_cuotas_detalle1` FOREIGN KEY (`idcuotas_detalle`) REFERENCES `cuotas_detalle` (`idcuotas_detalle`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `detalle_traslado` */

DROP TABLE IF EXISTS `detalle_traslado`;

CREATE TABLE `detalle_traslado` (
  `cantidad` int(11) DEFAULT NULL,
  `idtraslado` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  KEY `fk_detalle_traslado_traslado1_idx` (`idtraslado`),
  KEY `fk_detalle_traslado_articulo1_idx` (`idarticulo`),
  CONSTRAINT `fk_detalle_traslado_articulo1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_detalle_traslado_traslado1` FOREIGN KEY (`idtraslado`) REFERENCES `traslado` (`idtraslado`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `detalle_venta` */

DROP TABLE IF EXISTS `detalle_venta`;

CREATE TABLE `detalle_venta` (
  `idDetalle` int(11) NOT NULL AUTO_INCREMENT,
  `idVenta` int(11) NOT NULL,
  `tipo_cuota` enum('CUOTA','CONTADO') DEFAULT NULL COMMENT 'DETERMINA SI SE FINANCIO A PRECIO CONTADO O CUOTA CON INTERES',
  `plan_cuota` varchar(45) DEFAULT NULL,
  `cant_cuota` int(10) DEFAULT NULL COMMENT 'cantidad de cuota',
  `interes_mensual` decimal(10,2) DEFAULT NULL COMMENT 'porcentaje interes mensual',
  `margen_conta` decimal(10,2) DEFAULT NULL COMMENT 'porcentaje de margen de precio contado',
  `monto_cuota` decimal(10,2) DEFAULT NULL COMMENT 'monto de la cuota',
  `precosto` decimal(10,2) DEFAULT NULL COMMENT 'precio costo del articulo',
  `cantidad` int(11) DEFAULT NULL,
  `preventa` decimal(10,2) DEFAULT NULL COMMENT 'precio venta financiado',
  `subtotal` decimal(10,2) DEFAULT NULL,
  `iva` enum('0','5','10') DEFAULT NULL,
  `gravada_excenta` decimal(10,2) DEFAULT NULL,
  `gravada_cinco` decimal(10,2) DEFAULT NULL,
  `gravada_diez` decimal(10,2) DEFAULT NULL,
  `idarticulo` int(11) NOT NULL,
  `iddeposito` int(11) NOT NULL,
  PRIMARY KEY (`idDetalle`),
  KEY `fk_Detalle_venta_Venta1_idx` (`idVenta`),
  KEY `fk_Detalle_venta_articulo1_idx` (`idarticulo`),
  CONSTRAINT `fk_Detalle_venta_Venta1` FOREIGN KEY (`idVenta`) REFERENCES `venta` (`idVenta`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `empresa` */

DROP TABLE IF EXISTS `empresa`;

CREATE TABLE `empresa` (
  `idEmpresa` int(11) NOT NULL AUTO_INCREMENT,
  `empresa` varchar(45) DEFAULT NULL,
  `ruc` varchar(10) DEFAULT NULL,
  `descrip` varchar(45) DEFAULT NULL,
  `telefono` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`idEmpresa`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `grupo` */

DROP TABLE IF EXISTS `grupo`;

CREATE TABLE `grupo` (
  `idgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `grupo` char(45) DEFAULT NULL,
  PRIMARY KEY (`idgrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `kardex` */

DROP TABLE IF EXISTS `kardex`;

CREATE TABLE `kardex` (
  `idkardex` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `Nro_comprobante` varchar(45) DEFAULT NULL,
  `iddeposito` int(11) NOT NULL,
  `idmotivo` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `costo` decimal(10,2) DEFAULT '0.00',
  `cantidad` int(11) DEFAULT NULL,
  `operacion` enum('COMPRA','VENTA','AJUSTE','S/D') DEFAULT 'S/D',
  `tipo` enum('ENTRADA','SALIDA') DEFAULT NULL,
  `descripcion` varchar(255) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  PRIMARY KEY (`idkardex`),
  KEY `fk_kardex_articulo1_idx` (`idarticulo`),
  KEY `fk_kardex_motivo_ajuste1_idx` (`idmotivo`),
  KEY `fk_kardex_Empresa1_idx` (`idEmpresa`),
  KEY `fk_kardex_sucursal1_idx` (`idsucursal`),
  KEY `fk_kardex_deposito1_idx` (`iddeposito`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `fk_kardex_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kardex_articulo1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kardex_deposito1` FOREIGN KEY (`iddeposito`) REFERENCES `deposito` (`iddeposito`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kardex_motivo_ajuste1` FOREIGN KEY (`idmotivo`) REFERENCES `motivo_ajuste` (`idmotivo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_kardex_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `kardex_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `marca` */

DROP TABLE IF EXISTS `marca`;

CREATE TABLE `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `Marca` char(45) DEFAULT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

/*Table structure for table `motivo_ajuste` */

DROP TABLE IF EXISTS `motivo_ajuste`;

CREATE TABLE `motivo_ajuste` (
  `idmotivo` int(11) NOT NULL AUTO_INCREMENT,
  `motivo` varchar(45) DEFAULT NULL,
  `tipo` enum('E','S') DEFAULT NULL COMMENT 'E entradas S salidas',
  PRIMARY KEY (`idmotivo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

/*Table structure for table `mov_operacion` */

DROP TABLE IF EXISTS `mov_operacion`;

CREATE TABLE `mov_operacion` (
  `idMov` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `operacion` enum('VENTA','COBRO_CUOTA','COMPRA','ANULACION_VENTA','ANULACION_COMPRA','ANULACION_RECIBO') DEFAULT NULL,
  `tipo_op` enum('CONTADO','CREDITO','N/D') DEFAULT 'N/D',
  `tipo_mov` enum('EGRESOS','INGRESOS') DEFAULT NULL COMMENT 'TIPO DE MOVIMIENTO',
  `idconcepto` int(11) NOT NULL,
  `Nro_comprobante` varchar(45) DEFAULT NULL,
  `monto` int(11) DEFAULT NULL,
  `descripcion` varchar(250) DEFAULT NULL,
  `idapecierre` int(11) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idsucursal` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`idMov`),
  KEY `fk_Mov_operacion_concepto_caja1_idx` (`idconcepto`),
  KEY `fk_Mov_operacion_sucursal1_idx` (`idsucursal`),
  KEY `fk_Mov_operacion_Empresa1_idx` (`idEmpresa`),
  KEY `fk_Mov_operacion_usuario1_idx` (`idusuario`),
  CONSTRAINT `fk_Mov_operacion_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mov_operacion_concepto_caja1` FOREIGN KEY (`idconcepto`) REFERENCES `concepto_caja` (`idconcepto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mov_operacion_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mov_operacion_usuario1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `pagos_cuotas` */

DROP TABLE IF EXISTS `pagos_cuotas`;

CREATE TABLE `pagos_cuotas` (
  `idpago` int(11) NOT NULL AUTO_INCREMENT,
  `idusuario` int(11) DEFAULT NULL,
  `idcobrador` int(11) NOT NULL,
  `idcliente` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idTipo_pago` int(11) NOT NULL,
  `idcuotas` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `nro_recibo` varchar(45) NOT NULL DEFAULT '''SIN-NUMERO''',
  `total_importe` decimal(10,2) DEFAULT NULL,
  `estado` enum('COB','ANU') DEFAULT NULL COMMENT '"COB" -cobrado "ANU" anulado',
  PRIMARY KEY (`idpago`),
  KEY `fk_pago_cuota_Tipo_pago1_idx` (`idTipo_pago`),
  KEY `fk_pagos_cuotas_cliente1_idx` (`idcliente`),
  KEY `fk_pagos_cuotas_sucursal1_idx` (`idsucursal`),
  KEY `fk_pagos_cuotas_Empresa1_idx` (`idEmpresa`),
  KEY `fk_pagos_cuotas_cobrador1_idx` (`idcobrador`),
  KEY `fk_pagos_cuotas_cuotas1_idx` (`idcuotas`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `fk_pago_cuota_Tipo_pago1` FOREIGN KEY (`idTipo_pago`) REFERENCES `tipo_pago` (`idTipo_pago`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_cuotas_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_cuotas_cliente1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_cuotas_cobrador1` FOREIGN KEY (`idcobrador`) REFERENCES `cobrador` (`idcobrador`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_cuotas_cuotas1` FOREIGN KEY (`idcuotas`) REFERENCES `cuotas` (`idcuotas`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_pagos_cuotas_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `pagos_cuotas_ibfk_1` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `parametros_sistema` */

DROP TABLE IF EXISTS `parametros_sistema`;

CREATE TABLE `parametros_sistema` (
  `idparametros_sistema` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `tabla` varchar(45) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idparametros_sistema`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

/*Table structure for table `personal` */

DROP TABLE IF EXISTS `personal`;

CREATE TABLE `personal` (
  `idPersonal` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `apellido` varchar(45) DEFAULT NULL,
  `ci` varchar(25) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `Direccion` varchar(45) DEFAULT NULL,
  `idsucursal` int(11) NOT NULL,
  PRIMARY KEY (`idPersonal`),
  KEY `fk_Presonal_sucursal1_idx` (`idsucursal`),
  CONSTRAINT `fk_Presonal_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

/*Table structure for table `plan_cuota` */

DROP TABLE IF EXISTS `plan_cuota`;

CREATE TABLE `plan_cuota` (
  `idplan_cuota` int(10) NOT NULL AUTO_INCREMENT,
  `nombre_plan` varchar(45) DEFAULT NULL,
  `margen_contado` decimal(10,2) DEFAULT NULL,
  `interes_mensual` decimal(10,2) DEFAULT NULL,
  `limite_cuota` int(11) DEFAULT NULL,
  PRIMARY KEY (`idplan_cuota`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `profesion` */

DROP TABLE IF EXISTS `profesion`;

CREATE TABLE `profesion` (
  `idprofesion` int(11) NOT NULL AUTO_INCREMENT,
  `profesion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idprofesion`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Table structure for table `proveedor` */

DROP TABLE IF EXISTS `proveedor`;

CREATE TABLE `proveedor` (
  `idproveedor` int(11) NOT NULL AUTO_INCREMENT,
  `proveedor` char(45) DEFAULT NULL,
  `direccion` char(45) DEFAULT NULL,
  `propietario` char(45) DEFAULT NULL,
  `telefono` char(15) DEFAULT NULL,
  `ruc` char(20) DEFAULT NULL,
  `ci` int(11) DEFAULT NULL,
  `observacion` char(100) DEFAULT NULL,
  PRIMARY KEY (`idproveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `secuencias` */

DROP TABLE IF EXISTS `secuencias`;

CREATE TABLE `secuencias` (
  `nombre` varchar(50) NOT NULL,
  `valor` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `stockarticulo` */

DROP TABLE IF EXISTS `stockarticulo`;

CREATE TABLE `stockarticulo` (
  `idstock` int(11) NOT NULL AUTO_INCREMENT,
  `stock` int(11) DEFAULT NULL,
  `iddeposito` int(11) NOT NULL,
  `idarticulo` int(11) NOT NULL,
  `idsucursal` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  PRIMARY KEY (`idstock`),
  KEY `fk_stockarticulo_articulo1_idx` (`idarticulo`),
  KEY `fk_stockarticulo_deposito1_idx` (`iddeposito`),
  KEY `fk_stockarticulo_sucursal1_idx` (`idsucursal`),
  KEY `fk_stockarticulo_Empresa1_idx` (`idEmpresa`),
  CONSTRAINT `fk_stockarticulo_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stockarticulo_articulo1` FOREIGN KEY (`idarticulo`) REFERENCES `articulo` (`idarticulo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_stockarticulo_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `subgrupo` */

DROP TABLE IF EXISTS `subgrupo`;

CREATE TABLE `subgrupo` (
  `idsubgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `subgrupo` varchar(45) DEFAULT NULL,
  `idgrupo` int(11) NOT NULL,
  PRIMARY KEY (`idsubgrupo`),
  KEY `fk_subgrupo_grupo1_idx` (`idgrupo`),
  CONSTRAINT `fk_subgrupo_grupo1` FOREIGN KEY (`idgrupo`) REFERENCES `grupo` (`idgrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `sucursal` */

DROP TABLE IF EXISTS `sucursal`;

CREATE TABLE `sucursal` (
  `idsucursal` int(11) NOT NULL AUTO_INCREMENT,
  `idEmpresa` int(11) NOT NULL,
  `sucursal` varchar(45) DEFAULT NULL,
  `ciudad` varchar(45) DEFAULT NULL,
  `direccion` varchar(45) DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idsucursal`),
  KEY `fk_sucursal_Empresa1_idx` (`idEmpresa`),
  CONSTRAINT `fk_sucursal_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `tipo_pago` */

DROP TABLE IF EXISTS `tipo_pago`;

CREATE TABLE `tipo_pago` (
  `idTipo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Table structure for table `traslado` */

DROP TABLE IF EXISTS `traslado`;

CREATE TABLE `traslado` (
  `idtraslado` int(11) NOT NULL,
  `fecha` date DEFAULT NULL,
  `suc_origen` int(11) DEFAULT NULL,
  `dep_origen` int(11) DEFAULT NULL,
  `suc_destino` int(11) DEFAULT NULL,
  `dep_destino` int(11) DEFAULT NULL,
  PRIMARY KEY (`idtraslado`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Table structure for table `usuario` */

DROP TABLE IF EXISTS `usuario`;

CREATE TABLE `usuario` (
  `idusuario` int(11) NOT NULL AUTO_INCREMENT,
  `nick` varchar(48) DEFAULT NULL COMMENT 'usuario de mysql',
  `clave` varchar(48) DEFAULT NULL,
  `idPersonal` int(11) NOT NULL,
  `nventa` int(1) DEFAULT NULL,
  `tipo` int(1) DEFAULT NULL COMMENT '1 administrador , 2 vendedor, 3 cobrador',
  PRIMARY KEY (`idusuario`),
  KEY `fk_usuario_Personal1_idx` (`idPersonal`),
  CONSTRAINT `fk_usuario_Personal1` FOREIGN KEY (`idPersonal`) REFERENCES `personal` (`idPersonal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `vendedor` */

DROP TABLE IF EXISTS `vendedor`;

CREATE TABLE `vendedor` (
  `idVendedor` int(11) NOT NULL AUTO_INCREMENT,
  `idPersonal` int(11) NOT NULL,
  `tipo_vendedor` enum('INTERNO','EXTERNO') DEFAULT NULL,
  PRIMARY KEY (`idVendedor`),
  KEY `fk_Vendedor_Presonal1_idx` (`idPersonal`),
  CONSTRAINT `fk_Vendedor_Personal1` FOREIGN KEY (`idPersonal`) REFERENCES `personal` (`idPersonal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

/*Table structure for table `venta` */

DROP TABLE IF EXISTS `venta`;

CREATE TABLE `venta` (
  `idVenta` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `fecha_vto_pagare` date DEFAULT NULL COMMENT 'es la ultima fecha de vto, en caso de venta a credito',
  `hora` time DEFAULT NULL,
  `tipo` enum('CON','CRE') DEFAULT NULL COMMENT 'tipo de venta CON - CONTADO , CRE -CREDITO',
  `nrosuc` varchar(5) DEFAULT '''001''' COMMENT 'cod sucursal para factura',
  `nroexp` varchar(5) DEFAULT '''001''' COMMENT 'punto de expedicion para factura',
  `nrofactura` varchar(20) NOT NULL DEFAULT '''SIN-NUMERO''' COMMENT 'nro_documento',
  `estado` enum('F','A') DEFAULT NULL COMMENT 'A anulado F Facturado',
  `total_gravada_excenta` decimal(11,0) DEFAULT NULL,
  `total_gravada_cinco` decimal(11,0) DEFAULT NULL,
  `total_gravada_diez` decimal(11,0) DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `liqui_iva_5` decimal(10,2) DEFAULT NULL,
  `liqui_iva_10` decimal(10,2) DEFAULT NULL,
  `total_liqui_iva` decimal(10,2) DEFAULT NULL,
  `idusuario` int(11) DEFAULT NULL,
  `idcliente` int(11) NOT NULL,
  `idVendedor` int(11) NOT NULL,
  `idcobrador` int(11) DEFAULT NULL,
  `iddeposito` int(11) DEFAULT NULL,
  `idsucursal` int(11) NOT NULL,
  `idEmpresa` int(11) NOT NULL,
  `idformapago` int(11) DEFAULT NULL,
  PRIMARY KEY (`idVenta`),
  KEY `fk_Venta_Vendedor1_idx` (`idVendedor`),
  KEY `fk_Venta_cliente1_idx` (`idcliente`),
  KEY `fk_Venta_sucursal1_idx` (`idsucursal`),
  KEY `fk_Venta_Empresa1_idx` (`idEmpresa`),
  KEY `iddeposito` (`iddeposito`),
  KEY `idusuario` (`idusuario`),
  CONSTRAINT `fk_Venta_Empresa1` FOREIGN KEY (`idEmpresa`) REFERENCES `empresa` (`idEmpresa`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_Vendedor1` FOREIGN KEY (`idVendedor`) REFERENCES `vendedor` (`idVendedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_cliente1` FOREIGN KEY (`idcliente`) REFERENCES `cliente` (`idcliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_Venta_sucursal1` FOREIGN KEY (`idsucursal`) REFERENCES `sucursal` (`idsucursal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`iddeposito`) REFERENCES `deposito` (`iddeposito`),
  CONSTRAINT `venta_ibfk_2` FOREIGN KEY (`idusuario`) REFERENCES `usuario` (`idusuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/*Table structure for table `zona` */

DROP TABLE IF EXISTS `zona`;

CREATE TABLE `zona` (
  `idzona` int(11) NOT NULL AUTO_INCREMENT,
  `zona` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idzona`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

/* Trigger structure for table `ajuste_inventario_detalle` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tr_ajuste_inventario_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `tr_ajuste_inventario_after_insert` AFTER INSERT ON `ajuste_inventario_detalle` FOR EACH ROW 
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_nro_ajuste VARCHAR(10);
    DECLARE v_fecha DATE;
    DECLARE v_idusuario INT;
    DECLARE v_tipo_ajuste ENUM('ENTRADAS','SALIDAS');
    DECLARE v_observacion VARCHAR(100);
    DECLARE v_tipo_kardex ENUM('ENTRADA','SALIDA');
    DECLARE v_operacion_kardex ENUM('COMPRA','VENTA','AJUSTE','S/D');
    DECLARE v_stock_actual INT;
    DECLARE v_nuevo_stock INT;
    
    -- Obtener datos del ajuste principal
    SELECT 
        ai.idempresa,
        ai.idsucursal,
        ai.nro_ajuste,
        ai.fecha,
        ai.idusuario,
        ai.tipo_ajuste,
        ai.observacion
    INTO 
        v_idempresa,
        v_idsucursal,
        v_nro_ajuste,
        v_fecha,
        v_idusuario,
        v_tipo_ajuste,
        v_observacion
    FROM ajuste_inventario ai
    WHERE ai.idajuste_inventario = NEW.idajuste_inventario;
    
    -- Determinar tipo de kardex basado en el tipo de ajuste
    IF v_tipo_ajuste = 'ENTRADAS' THEN
        SET v_tipo_kardex = 'ENTRADA';
        SET v_operacion_kardex = 'AJUSTE';
    ELSE
        SET v_tipo_kardex = 'SALIDA';
        SET v_operacion_kardex = 'AJUSTE';
    END IF;
    
    -- 1. ACTUALIZAR O INSERTAR STOCK (CON LOGICA PARA STOCK NEGATIVO)
    IF EXISTS (SELECT 1 FROM stockarticulo 
               WHERE idarticulo = NEW.idarticulo 
               AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
               AND idsucursal = v_idsucursal
               AND idEmpresa = v_idempresa) THEN
               
        -- Obtener stock actual
        SELECT stock INTO v_stock_actual
        FROM stockarticulo 
        WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- Calcular nuevo stock según la lógica requerida
        IF v_tipo_ajuste = 'ENTRADAS' THEN
            -- Si es ENTRADA y el stock actual es negativo, el nuevo stock será la cantidad de entrada
            IF v_stock_actual < 0 THEN
                SET v_nuevo_stock = NEW.cantidad;
            ELSE
                -- Si el stock es positivo, hacer la suma normal
                SET v_nuevo_stock = v_stock_actual + NEW.cantidad;
            END IF;
        ELSE
            -- Para SALIDAS, lógica normal (restar)
            SET v_nuevo_stock = v_stock_actual - NEW.cantidad;
        END IF;
        
        -- Actualizar stock
        UPDATE stockarticulo 
        SET stock = v_nuevo_stock
        WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario)
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
    ELSE
        -- Insertar nuevo registro de stock (solo para ENTRADAS)
        IF v_tipo_ajuste = 'ENTRADAS' THEN
            INSERT INTO stockarticulo (
                stock,
                iddeposito,
                idarticulo,
                idsucursal,
                idEmpresa
            ) VALUES (
                NEW.cantidad,
                (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
                NEW.idarticulo,
                v_idsucursal,
                v_idempresa
            );
        END IF;
    END IF;
    
    -- 2. REGISTRAR EN KARDEX
    INSERT INTO kardex (
        fecha,
        Nro_comprobante,
        iddeposito,
        idmotivo,
        idarticulo,
        costo,
        cantidad,
        operacion,
        tipo,
        descripcion,
        idusuario,
        idEmpresa,
        idsucursal
    ) VALUES (
        v_fecha,
        CONCAT('AJ-', v_nro_ajuste),
        (SELECT iddeposito FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
        (SELECT idmotivo_ajuste FROM ajuste_inventario WHERE idajuste_inventario = NEW.idajuste_inventario),
        NEW.idarticulo,
        NEW.precio_costo,
        NEW.cantidad,
        v_operacion_kardex,
        v_tipo_kardex,
        CONCAT('AJUSTE DE INVENTARIO - ', v_observacion),
        v_idusuario,
        v_idempresa,
        v_idsucursal
    );
    
    -- 3. ACTUALIZAR ULTIMA FECHA DE AJUSTE EN ARTICULO
    UPDATE articulo 
    SET ultima_fecha_ajuste = v_fecha
    WHERE idarticulo = NEW.idarticulo;
    
END */$$


DELIMITER ;

/* Trigger structure for table `anulacion_recibo` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tr_after_anulacion_recibo` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `tr_after_anulacion_recibo` AFTER INSERT ON `anulacion_recibo` FOR EACH ROW 
BEGIN
    DECLARE v_idcuotas INT;
    DECLARE v_idcliente INT;
    DECLARE v_idsucursal INT;
    DECLARE v_idEmpresa INT;
    DECLARE v_total_importe DECIMAL(10,2);
    DECLARE v_importe_cuotas DECIMAL(10,2);
    DECLARE v_idconcepto INT;
    DECLARE v_nrorecibo varchar(7);
    
    -- Obtener datos básicos del pago anulado
    SELECT 
        pc.idcuotas,
        pc.idcliente,
        pc.idsucursal,
        pc.idEmpresa,
        pc.total_importe,
        pc.nro_recibo
    INTO 
        v_idcuotas,
        v_idcliente,
        v_idsucursal,
        v_idEmpresa,
        v_total_importe,
        v_nrorecibo
    FROM pagos_cuotas pc
    WHERE pc.idpago = NEW.idpago;
    
    -- Obtener el importe total de CUOTAS (excluyendo OTROS)
    SELECT COALESCE(SUM(importe), 0) INTO v_importe_cuotas
    FROM detalle_pagos_cuotas 
    WHERE idpago = NEW.idpago AND tipo_pago = 'CUOTA';
    
    -- Obtener concepto para anulación
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
	FROM parametros_sistema
	WHERE nombre = 'ANULACION_RECIBO'
	AND tabla ='concepto_caja'
	LIMIT 1;
    
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- Reestablecer SOLO las cuotas_detalle de tipo CUOTA
    UPDATE cuotas_detalle cd
    INNER JOIN detalle_pagos_cuotas dpc ON cd.idcuotas_detalle = dpc.idcuotas_detalle
    SET 
        -- INVERSA: Sumar el importe al saldo (solo para CUOTAS)
        cd.saldo_cuota = cd.saldo_cuota + dpc.importe,
        
        cd.estado = CASE 
                       WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 'PEN'
                       WHEN (cd.saldo_cuota + dpc.importe) > 0 THEN 'PEN'
                       ELSE cd.estado 
                    END,
        
        -- Limpiar datos del último recibo si la cuota queda completamente pendiente
        cd.ultimo_nro_recibo = CASE 
                                  WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN NULL 
                                  ELSE cd.ultimo_nro_recibo 
                               END,
        cd.ultimo_atraso = CASE 
                              WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0 
                              ELSE cd.ultimo_atraso 
                           END,
        
        -- OPERACIÓN INVERSA: Restar el importe del último importe acumulado
        cd.ultimo_importe = CASE 
                               WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0.00 
                               ELSE GREATEST(COALESCE(cd.ultimo_importe, 0) - dpc.importe, 0)
                            END,
        
        cd.ultima_Fecha_pago = CASE 
                                  WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN NULL 
                                  ELSE cd.ultima_Fecha_pago 
                               END,
        
        -- ESTABLECER EN CERO por defecto
        cd.ultimo_interes_calcu = 0.00,
        
        -- ESTABLECER EN CERO por defecto
        cd.ultimo_descuento = 0.00,
        
        -- OPERACIÓN INVERSA: Restar del total acumulado
        cd.ultimo_totalac = CASE 
                               WHEN (cd.saldo_cuota + dpc.importe) = cd.cuota THEN 0.00 
                               ELSE GREATEST(COALESCE(cd.ultimo_totalac, 0) - dpc.importe, 0)
                            END
    WHERE dpc.idpago = NEW.idpago AND dpc.tipo_pago = 'CUOTA';
    
    -- Recalcular el saldo actual de la cuota principal (solo con importe de CUOTAS)
    UPDATE cuotas 
    SET 
        -- INVERSA: Sumar SOLO el importe de CUOTAS al saldo actual
        saldo_actual = saldo_actual + v_importe_cuotas,
        
        -- OPERACIÓN INVERSA: Restar SOLO de los acumulados de CUOTAS
        ultimo_importe = GREATEST(COALESCE(ultimo_importe, 0) - v_importe_cuotas, 0),
        
        -- ESTABLECER EN CERO por defecto
        ultimo_interes_calc = 0.00,
        
        -- ESTABLECER EN CERO por defecto
        ultimo_descuento = 0.00,
        
        ultimo_totalac = GREATEST(COALESCE(ultimo_totalac, 0) - v_importe_cuotas, 0),
        
        estado = CASE 
                    WHEN (saldo_actual + v_importe_cuotas) = total_venta THEN 'PEN'
                    WHEN (saldo_actual + v_importe_cuotas) > 0 THEN 'PEN'
                    ELSE 'CAN'
                 END
    WHERE idcuotas = v_idcuotas;
    
    
    -- Registrar en mov_operacion (con el TOTAL completo del recibo)
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_op,
        tipo_mov,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idusuario,
        idsucursal,
        idEmpresa
    )
    VALUES (
        NEW.fecha,
        'ANULACION_RECIBO',
        'N/D',
        'EGRESOS',
        v_idconcepto,
        CONCAT('ANU-', v_nrorecibo),
        v_total_importe,  -- Total completo del recibo
        CONCAT('ANULACION RECIBO #', v_nrorecibo, ' - ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idEmpresa
    );
    
END */$$


DELIMITER ;

/* Trigger structure for table `apecierrecaja` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_apecierrecaja_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_apecierrecaja_after_insert` AFTER INSERT ON `apecierrecaja` FOR EACH ROW 
BEGIN
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_personal_nombre VARCHAR(90);
    DECLARE v_concepto_id INT;
    
    -- Solo procesar si es una apertura (estado = 'A')
    IF NEW.estado = 'A' THEN
        -- Obtener nombre del personal
        SELECT COALESCE(CONCAT(nombre, ' ', apellido), 'PERSONAL NO ENCONTRADO')
        INTO v_personal_nombre
        FROM personal 
        WHERE idPersonal = NEW.idpersonal;
        
        -- Construir descripción detallada
        SET v_descripcion_mov = CONCAT(
            'APERTURA DE CAJA - ',
            v_personal_nombre,
            ' - Monto: Gs. ', FORMAT(NEW.montoape, 0),
            ' - Fecha: ', NEW.fechaape,
            ' - Hora: ', NEW.horaape
        );
        
        -- Insertar en mov_operacion
        INSERT INTO mov_operacion (
            fecha,
            operacion,
            Nro_comprobante,
            monto,
            tipo,
            descripcion,
            idconcepto,
            idpersonal,
            idsucursal,
            idEmpresa,
            idformapago,
            tipo_venta,
            idapecierre
        ) VALUES (
            CURDATE(),
            'APERTURA.CAJA',
            CONCAT('APETURA -', NEW.idapecierre),
            NEW.montoape,
            'I',  -- Ingreso (apertura de caja)
            v_descripcion_mov,
            12,   -- concepto_caja para APERTURA.CAJA
            NEW.idpersonal,
            1,    -- idsucursal (ajustar según tu sistema)
            1,    -- idEmpresa (ajustar según tu sistema)
            1,    -- idformapago (efectivo)
            NULL  -- No aplica para aperturas
            ,new.idapecierre
        );
    END IF;
    
END */$$


DELIMITER ;

/* Trigger structure for table `articulo` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_insertar_articulo` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_insertar_articulo` AFTER INSERT ON `articulo` FOR EACH ROW begin
insert into stockarticulo
            (stock,
             iddeposito,
             idarticulo,
             idsucursal,
             idEmpresa)
values (0,
        1,
        new.idarticulo,
        1,
        1);
end */$$


DELIMITER ;

/* Trigger structure for table `articulo` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_delete_articulo` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_delete_articulo` BEFORE DELETE ON `articulo` FOR EACH ROW begin
	delete from stockarticulo where stockarticulo.idarticulo = old.idarticulo;
end */$$


DELIMITER ;

/* Trigger structure for table `compra` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tr_compra_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `tr_compra_after_insert` AFTER INSERT ON `compra` FOR EACH ROW 
BEGIN
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion VARCHAR(250);
    DECLARE v_tipo_mov ENUM('EGRESOS','INGRESOS');
    DECLARE v_tipo_op ENUM('CONTADO','CREDITO','N/D');
    DECLARE v_valor_parametro VARCHAR(100);
    DECLARE v_nombre_proveedor VARCHAR(45);
    
    -- OBTENER NOMBRE DEL PROVEEDOR
    SELECT proveedor INTO v_nombre_proveedor
    FROM proveedor
    WHERE idproveedor = NEW.idproveedor;
    
    -- OBTENER EL CONCEPTO DESDE PARAMETROS_SISTEMA (USANDO SOLO UN PARÁMETRO)
    SELECT valor INTO v_valor_parametro
    FROM parametros_sistema
    WHERE nombre = 'COMPRA_CONCEPTO'
    LIMIT 1;
    
    -- ASIGNAR VALOR POR DEFECTO SI NO EXISTE EL PARÁMETRO
    IF v_valor_parametro IS NOT NULL AND v_valor_parametro != '' THEN
        SET v_idconcepto = CAST(v_valor_parametro AS UNSIGNED);
    ELSE
        SET v_idconcepto = 1; -- Valor por defecto único
    END IF;
    
    -- CONFIGURAR TIPOS
    SET v_tipo_mov = 'EGRESOS';
    SET v_tipo_op = NEW.tipo; -- Usa el mismo tipo de la compra
    
    -- CREAR DESCRIPCIÓN DETALLADA
    SET v_descripcion = CONCAT(
        'COMPRA ', NEW.tipo,
        ' - Fact: ', NEW.nro_est, '-', NEW.nro_exp, '-', NEW.nro_factura,
        ' | Proveedor: ', COALESCE(v_nombre_proveedor, 'N/A'),
        ' | Total: ', NEW.total,
        ' | Depósito: ', NEW.iddeposito
    );
    
    -- INSERTAR EN MOV_OPERACION PARA AMBOS TIPOS (CONTADO Y CRÉDITO)
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_op,
        tipo_mov,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idusuario,
        idsucursal,
        idEmpresa
    ) VALUES (
        NEW.fecha,
        'COMPRA',
        v_tipo_op,
        v_tipo_mov,
        v_idconcepto,
        CONCAT(NEW.nro_est, '-', NEW.nro_exp, '-', NEW.nro_factura),
        NEW.total,
        v_descripcion,
        NEW.idusuario,
        NEW.idsucursal,
        NEW.idEmpresa
    );
    
END */$$


DELIMITER ;

/* Trigger structure for table `compra_detalle` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `tr_compra_detalle_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `tr_compra_detalle_after_insert` AFTER INSERT ON `compra_detalle` FOR EACH ROW 
BEGIN
    DECLARE v_iddeposito INT;
    DECLARE v_idsucursal INT;
    DECLARE v_idEmpresa INT;
    DECLARE v_idusuario INT;
    DECLARE v_fecha DATE;
    DECLARE v_nro_comprobante VARCHAR(45);
    DECLARE v_idmotivo INT;
    DECLARE v_descripcion VARCHAR(255);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    DECLARE v_nombre_proveedor VARCHAR(45);
    DECLARE v_ruc_proveedor VARCHAR(20);
    DECLARE v_valor_parametro VARCHAR(100);
    DECLARE v_existe_stock INT DEFAULT 0;
    DECLARE v_stock_actual INT DEFAULT 0;
    
    -- Obtener datos de la cabecera de compra y proveedor
    SELECT 
        c.iddeposito, 
        c.idsucursal, 
        c.idEmpresa, 
        c.idusuario,
        c.fecha,
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura),
        c.tipo,
        p.proveedor,
        p.ruc
    INTO 
        v_iddeposito, 
        v_idsucursal, 
        v_idEmpresa, 
        v_idusuario,
        v_fecha,
        v_nro_comprobante,
        v_tipo_compra,
        v_nombre_proveedor,
        v_ruc_proveedor
    FROM compra c
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    WHERE c.idcompra = NEW.idcompra;
    
    -- OBTENER EL ID MOTIVO DESDE PARAMETROS_SISTEMA
    SELECT valor INTO v_valor_parametro
    FROM parametros_sistema
    WHERE nombre = 'KARDEX_COMPRA'
    LIMIT 1;
    
    -- Validar y convertir el parámetro
    IF v_valor_parametro IS NOT NULL AND v_valor_parametro != '' THEN
        SET v_idmotivo = CAST(v_valor_parametro AS UNSIGNED);
    ELSE
        SET v_idmotivo = 1;
    END IF;
    
    -- CREAR DESCRIPCIÓN DETALLADA
    SET v_descripcion = CONCAT(
        'COMPRA - Fact: ', v_nro_comprobante,
        '  Tipo: ', v_tipo_compra,
        '  Prov: ', LEFT(v_nombre_proveedor, 20),
        ' (', v_ruc_proveedor, ')'
        );
    
    -- 1. INSERTAR EN KARDEX
    INSERT INTO kardex (
        fecha, 
        Nro_comprobante, 
        iddeposito, 
        idmotivo, 
        idarticulo, 
        costo, 
        cantidad, 
        operacion, 
        tipo, 
        descripcion, 
        idusuario, 
        idEmpresa, 
        idsucursal
    ) VALUES (
        v_fecha,
        v_nro_comprobante,
        v_iddeposito,
        v_idmotivo,
        NEW.idarticulo,
        NEW.precio_costo,
        NEW.cantidad,
        'COMPRA',
        'ENTRADA',
        v_descripcion,
        v_idusuario,
        v_idEmpresa,
        v_idsucursal
    );
    
    -- 2. VERIFICAR SI EXISTE STOCK Y OBTENER STOCK ACTUAL
    SELECT COUNT(*), COALESCE(stock, 0) INTO v_existe_stock, v_stock_actual
    FROM stockarticulo 
    WHERE idarticulo = NEW.idarticulo 
    AND iddeposito = v_iddeposito 
    AND idsucursal = v_idsucursal 
    AND idEmpresa = v_idEmpresa;
    
    -- ACTUALIZAR O INSERTAR STOCK (RESETEAR SI ES NEGATIVO)
    IF v_existe_stock > 0 THEN
        -- Si el stock actual es negativo, resetear a la cantidad comprada
        IF v_stock_actual < 0 THEN
            UPDATE stockarticulo 
            SET stock = NEW.cantidad
            WHERE idarticulo = NEW.idarticulo 
            AND iddeposito = v_iddeposito 
            AND idsucursal = v_idsucursal 
            AND idEmpresa = v_idEmpresa;
        ELSE
            -- Si el stock es positivo, hacer suma normal
            UPDATE stockarticulo 
            SET stock = stock + NEW.cantidad
            WHERE idarticulo = NEW.idarticulo 
            AND iddeposito = v_iddeposito 
            AND idsucursal = v_idsucursal 
            AND idEmpresa = v_idEmpresa;
        END IF;
    ELSE
        -- Insertar nuevo registro de stock
        INSERT INTO stockarticulo (
            stock, 
            iddeposito, 
            idarticulo, 
            idsucursal, 
            idEmpresa
        ) VALUES (
            NEW.cantidad,
            v_iddeposito,
            NEW.idarticulo,
            v_idsucursal,
            v_idEmpresa
        );
    END IF;
    
    -- 3. ACTUALIZAR PRECIO COSTO Y FECHA DE ÚLTIMA COMPRA
    UPDATE articulo 
    SET precio_costo = NEW.precio_costo,
        ultima_fecha_compra = v_fecha
    WHERE idarticulo = NEW.idarticulo;
    
END */$$


DELIMITER ;

/* Trigger structure for table `detalle_venta` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_detalle_venta_kardex` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_detalle_venta_kardex` AFTER INSERT ON `detalle_venta` FOR EACH ROW 
BEGIN
    DECLARE v_venta_fecha DATE;
    DECLARE v_venta_nro_factura VARCHAR(20);
    DECLARE v_venta_idsucursal INT;
    DECLARE v_venta_idEmpresa INT;
    DECLARE v_venta_iddeposito INT;
    DECLARE v_venta_tipo ENUM('CON','CRE');
    DECLARE v_venta_idcliente INT;
    DECLARE v_idmotivo INT;
    DECLARE v_operacion_kardex ENUM('COMPRA','VENTA','AJUSTE','S/D');
    DECLARE v_tipo_kardex ENUM('ENTRADA','SALIDA');
    DECLARE v_descripcion_kardex VARCHAR(255);
    DECLARE v_articulo_descripcion VARCHAR(100);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_establecimiento VARCHAR(3);
    DECLARE v_puntoExpedicion VARCHAR(3);
    DECLARE v_nro_factura_unificado VARCHAR(45);
    DECLARE v_idusuario_venta INT;
    
    -- Obtener datos de la venta
    SELECT 
        v.fecha,
        v.nrosuc,
        v.nroexp,
        v.nrofactura,
        v.idsucursal,
        v.idEmpresa,
        v.iddeposito,
        v.tipo,
        v.idcliente,
        v.idusuario
    INTO 
        v_venta_fecha,
        v_establecimiento,
        v_puntoExpedicion,
        v_venta_nro_factura,
        v_venta_idsucursal,
        v_venta_idEmpresa,
        v_venta_iddeposito,
        v_venta_tipo,
        v_venta_idcliente,
        v_idusuario_venta
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- Nro. factura unificado
    SET v_nro_factura_unificado = CONCAT(v_establecimiento,'-',v_puntoExpedicion,'-',v_venta_nro_factura);
    
    -- Obtener descripción del artículo
    SELECT descripcion INTO v_articulo_descripcion
    FROM articulo 
    WHERE idarticulo = NEW.idarticulo;
    
    -- Obtener nombre del cliente
    SELECT CONCAT(nombre, ' ', apellido) INTO v_cliente_nombre
    FROM cliente 
    WHERE idcliente = v_venta_idcliente;
    
    -- Determinar parámetros según el tipo de venta
    SET v_operacion_kardex = 'VENTA';
    SET v_tipo_kardex = 'SALIDA';
	
    -- Obtener el idconcepto.
	SELECT CAST(valor AS SIGNED) INTO v_idmotivo
	FROM parametros_sistema
	WHERE nombre = 'KADEX_VENTA'
	and tabla='motivo_ajuste'
	LIMIT 1;

    
    -- Construir descripción
    SET v_descripcion_kardex = CONCAT('VENTA. ', v_articulo_descripcion, ' ', v_cliente_nombre, ' FACT: ', v_nro_factura_unificado);
    
    -- Actualizar última fecha de venta del artículo
    UPDATE articulo 
    SET ultima_fecha_venta = v_venta_fecha
    WHERE idarticulo = NEW.idarticulo;
    
    -- Insertar en KARDEX (nueva estructura)
    INSERT INTO kardex (
        fecha,
        Nro_comprobante,
        iddeposito,
        idmotivo,
        idarticulo,
        costo,
        cantidad,
        operacion,
        tipo,
        descripcion,
        idusuario,
        idEmpresa,
        idsucursal
    ) VALUES (
        v_venta_fecha,
        v_nro_factura_unificado,
        NEW.iddeposito,
        v_idmotivo,
        NEW.idarticulo,
        NEW.precosto,
        NEW.cantidad,
        v_operacion_kardex,
        v_tipo_kardex,
        v_descripcion_kardex,
        v_idusuario_venta,
        v_venta_idEmpresa,
        v_venta_idsucursal
    );
    
    -- Actualizar stock
    UPDATE stockarticulo 
    SET stock = stock - NEW.cantidad 
    WHERE idarticulo = NEW.idarticulo 
        AND iddeposito = NEW.iddeposito
        AND idsucursal = v_venta_idsucursal
        AND idEmpresa = v_venta_idEmpresa;
    
END */$$


DELIMITER ;

/* Trigger structure for table `pagos_cuotas` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_pagos_cuotas_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_pagos_cuotas_after_insert` AFTER INSERT ON `pagos_cuotas` FOR EACH ROW 
BEGIN
    DECLARE v_descripcion_mov VARCHAR(250);
    DECLARE v_cliente_nombre VARCHAR(120) DEFAULT 'CLIENTE NO ENCONTRADO';
    DECLARE v_cliente_ci VARCHAR(20) DEFAULT 'N/D';
    DECLARE v_nrofactura VARCHAR(20) DEFAULT 'N/D';
    DECLARE v_tipo_pago_desc VARCHAR(45) DEFAULT 'EFECTIVO';
    DECLARE v_idapecierre INT;
    DECLARE v_idpersonal_cobrador INT;
    DECLARE v_idconcepto INT;

    -- Solo procesar si el estado es COB (Cobrado)
    IF NEW.estado = 'COB' THEN

        -- Obtener datos del cliente y cuota
        SELECT 
            COALESCE(CONCAT(c.nombre, ' ', c.apellido), 'CLIENTE NO ENCONTRADO'),
            COALESCE(c.ci, 'N/D'),
            COALESCE(cu.nrofactura, 'N/D'),
            COALESCE(tp.tipo, 'EFECTIVO')
        INTO 
            v_cliente_nombre,
            v_cliente_ci,
            v_nrofactura,
            v_tipo_pago_desc
        FROM cliente c
        INNER JOIN cuotas cu ON cu.idcliente = c.idcliente AND cu.idcuotas = NEW.idcuotas
        INNER JOIN tipo_pago tp ON tp.idTipo_pago = NEW.idTipo_pago
        WHERE c.idcliente = NEW.idcliente
        LIMIT 1;

        -- Obtener personal del cobrador y apertura activa
        SELECT cb.idPersonal INTO v_idpersonal_cobrador 
        FROM cobrador cb 
        WHERE cb.idcobrador = NEW.idcobrador;


        SET v_idapecierre = f_get_apertura_activa(v_idpersonal_cobrador);

        -- Obtener el idconcepto dinámico configurado
        SELECT CAST(valor AS SIGNED) INTO v_idconcepto
	FROM parametros_sistema
	WHERE nombre = 'CONCEPTO_PAGO_CUOTA'
	and tabla = 'concepto_caja'
	LIMIT 1;


        -- Construir descripción detallada
        SET v_descripcion_mov = CONCAT(
            'RECIBO CUOTA - ',
            v_cliente_nombre,
            ' CI. ', v_cliente_ci,
            ' - Factura: ', v_nrofactura,
            ' - Recibo.Nº ', NEW.nro_recibo,
            ' - Forma Pago: ', v_tipo_pago_desc,
            ' - Monto: Gs. ', FORMAT(NEW.total_importe, 0)
        );

        -- Insertar en mov_operacion
        INSERT INTO mov_operacion (
            fecha,
            operacion,
            tipo_mov,
            idconcepto,
            Nro_comprobante,
            monto,
            descripcion,
            idsucursal,
            idEmpresa,
            idapecierre,
            idusuario  
        ) VALUES (
            NEW.fecha,
            'COBRO_CUOTA',
            'INGRESOS',  -- Ingreso
            v_idconcepto,
            CONCAT('REC-', NEW.nro_recibo),
            NEW.total_importe,
            v_descripcion_mov,
            NEW.idsucursal,
            NEW.idEmpresa,
            COALESCE(v_idapecierre,0),
            NEW.idusuario  
        );
    END IF;
END */$$


DELIMITER ;

/* Trigger structure for table `venta` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_venta_after_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_venta_after_insert` AFTER INSERT ON `venta` FOR EACH ROW 
BEGIN
    DECLARE v_idconcepto INT;
    DECLARE v_descripcion_mov VARCHAR(500);
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_cliente_ci VARCHAR(20);
    DECLARE v_vendedor_nombre VARCHAR(90);
    DECLARE v_idapecierre INT;
    DECLARE v_nrofactura VARCHAR(45);
    DECLARE v_idpersonal_vendedor INT;

    -- Obtener datos del cliente
    SELECT 
        COALESCE(CONCAT(nombre, ' ', apellido), 'CLIENTE NO ENCONTRADO'),
        COALESCE(ci, 'N/D')
    INTO 
        v_cliente_nombre,
        v_cliente_ci
    FROM cliente 
    WHERE idcliente = NEW.idcliente;

    -- Obtener datos del vendedor
    SELECT 
        COALESCE(CONCAT(trim(p.nombre), ' ', trim(p.apellido)), 'VENDEDOR NO ENCONTRADO')
    INTO 
        v_vendedor_nombre
    FROM vendedor v
    INNER JOIN personal p ON p.idPersonal = v.idPersonal
    WHERE v.idVendedor = NEW.idVendedor;

    -- Obtener personal del vendedor para la apertura de caja
    SELECT vd.idPersonal INTO v_idpersonal_vendedor 
    FROM vendedor vd WHERE vd.idVendedor = NEW.idVendedor;
    
    -- Obtener id apertura cierre caja.
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_vendedor);

    -- Nro_factura formateado
    SET v_nrofactura = CONCAT(TRIM(NEW.nrosuc), '-', TRIM(NEW.nroexp), '-', TRIM(NEW.nrofactura));

    -- Obtener el id concepto
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
	FROM parametros_sistema
	WHERE nombre = 'CONCEPTO_VENTA'
	and tabla ='concepto_caja'
	LIMIT 1;

    -- Construir descripción detallada
    SET v_descripcion_mov = CONCAT(
        'VENTA ', NEW.tipo, ' - ',
        v_cliente_nombre,
        ' CI. ', v_cliente_ci,
        ' - Factura: ', COALESCE(v_nrofactura, 'SIN-NUMERO'),
        ' - Vendedor: ', v_vendedor_nombre,
        ' - Monto: Gs. ', FORMAT(NEW.total, 0)
    );

    -- Insertar en mov_operacion
    INSERT INTO mov_operacion (
        fecha,
        operacion,
        tipo_mov,
        tipo_op,
        idconcepto,
        Nro_comprobante,
        monto,
        descripcion,
        idsucursal,
        idEmpresa,
        idapecierre,
        idusuario 
    ) VALUES (
        NEW.fecha,
        'VENTA',
        'INGRESOS',  -- Ingreso
        CASE new.tipo WHEN  'CON' THEN 'CONTADO' ELSE 'CREDITO' END,
        v_idconcepto,
        COALESCE(v_nrofactura, 'SIN-NUMERO'),
        NEW.total,
        v_descripcion_mov,
        NEW.idsucursal,
        NEW.idEmpresa,
        coalesce(v_idapecierre,0),
        NEW.idusuario  
    );
END */$$


DELIMITER ;

/* Function  structure for function  `f_get_apertura_activa` */

/*!50003 DROP FUNCTION IF EXISTS `f_get_apertura_activa` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `f_get_apertura_activa`(p_idpersonal INT) RETURNS int(11)
    READS SQL DATA
    DETERMINISTIC
BEGIN
    DECLARE v_idapecierre INT;
    
    SELECT idapecierre INTO v_idapecierre
    FROM apecierrecaja 
    WHERE idpersonal = p_idpersonal 
        AND estado = 'A'
    ORDER BY idapecierre DESC 
    LIMIT 1;
    
    RETURN v_idapecierre;
END */$$
DELIMITER ;

/* Function  structure for function  `generar_nro_factura` */

/*!50003 DROP FUNCTION IF EXISTS `generar_nro_factura` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `generar_nro_factura`(cod_exp int,cod_sucursal int) RETURNS char(17) CHARSET utf8
begin
declare punto_expedicion,sucursal,contador_sucursal,contador_punto,ultimo_recibo_gen,contador_ultimo_recibo_gen int;
declare char_sucursal,char_punto_expendio,char_ultimo_recibo char(17);
SET char_sucursal= 	CAST(cod_sucursal AS CHAR);
SET char_punto_expendio=CAST(cod_exp AS CHAR);
SET contador_sucursal=LENGTH(char_sucursal);
SET contador_punto= length(char_punto_expendio);
if contador_sucursal=1 then
	set char_sucursal=concat("00","",char_sucursal);
else
	if contador_sucursal=2 then
		set char_sucursal=concat("0","",char_sucursal);
	end if;
end if;
if char_punto_expendio=1 then
	set char_punto_expendio=concat("00","",char_punto_expendio);
else
	if char_punto_expendio=2 then
		set char_punto_expendio=concat("0","",char_punto_expendio);
	end if;
end if;
select max(idventa) from venta into ultimo_recibo_gen;
if ultimo_recibo_gen=0 then
	set ultimo_recibo_gen=1;
else
	set ultimo_recibo_gen=ultimo_recibo_gen+1;
end if;
set char_ultimo_recibo=cast(ultimo_recibo_gen as char);
set contador_ultimo_recibo_gen=length(char_ultimo_recibo);
if contador_ultimo_recibo_gen=1 then
	set char_ultimo_recibo=concat("000000","",char_ultimo_recibo);
else
	if contador_ultimo_recibo_gen=2 then
		set char_ultimo_recibo=concat("00000","",char_ultimo_recibo);
	else
		if contador_ultimo_recibo_gen=3 then
			set char_ultimo_recibo=concat("0000","",char_ultimo_recibo);
		else
			if contador_ultimo_recibo_gen=4 then
				set char_ultimo_recibo=concat("000","",char_ultimo_recibo);
			else
				if contador_ultimo_recibo_gen=5 then
					set char_ultimo_recibo=concat("00","",char_ultimo_recibo);
				else
					if contador_ultimo_recibo_gen=6 then
						set char_ultimo_recibo=concat("0","",char_ultimo_recibo);
					end if;
				end if;
			end if;
		end if;
	end if;
end if;
	set char_ultimo_recibo= CONCAT_WS("-",char_sucursal,char_punto_expendio,char_ultimo_recibo);
	return char_ultimo_recibo;
end */$$
DELIMITER ;

/* Function  structure for function  `Numeros_a_Letras` */

/*!50003 DROP FUNCTION IF EXISTS `Numeros_a_Letras` */;
DELIMITER $$

/*!50003 CREATE FUNCTION `Numeros_a_Letras`(lnEntero BIGINT) RETURNS varchar(512) CHARSET utf8
    DETERMINISTIC
BEGIN
    DECLARE lcRetorno VARCHAR(512) DEFAULT '';
    DECLARE lnTerna INT DEFAULT 1;
    DECLARE lcCadena VARCHAR(512) DEFAULT '';
    DECLARE lnUnidades INT;
    DECLARE lnDecenas INT;
    DECLARE lnCentenas INT;
    IF lnEntero > 0 THEN
        WHILE lnEntero > 0 DO
            SET lcCadena = '';
            -- Extraer unidades, decenas, centenas
            SET lnUnidades = lnEntero % 10;
            SET lnEntero = FLOOR(lnEntero / 10);
            SET lnDecenas = lnEntero % 10;
            SET lnEntero = FLOOR(lnEntero / 10);
            SET lnCentenas = lnEntero % 10;
            SET lnEntero = FLOOR(lnEntero / 10);
            -- Convertir unidades
            SET lcCadena = 
            CASE
                WHEN lnUnidades = 1 AND lnTerna = 1 THEN CONCAT('UNO ', lcCadena)
                WHEN lnUnidades = 1 THEN CONCAT('UN ', lcCadena)
                WHEN lnUnidades = 2 THEN CONCAT('DOS ', lcCadena)
                WHEN lnUnidades = 3 THEN CONCAT('TRES ', lcCadena)
                WHEN lnUnidades = 4 THEN CONCAT('CUATRO ', lcCadena)
                WHEN lnUnidades = 5 THEN CONCAT('CINCO ', lcCadena)
                WHEN lnUnidades = 6 THEN CONCAT('SEIS ', lcCadena)
                WHEN lnUnidades = 7 THEN CONCAT('SIETE ', lcCadena)
                WHEN lnUnidades = 8 THEN CONCAT('OCHO ', lcCadena)
                WHEN lnUnidades = 9 THEN CONCAT('NUEVE ', lcCadena)
                ELSE lcCadena
            END;
            -- Convertir decenas
            IF lnDecenas = 1 THEN
                SET lcCadena = 
                CASE
                    WHEN lnUnidades = 0 THEN 'DIEZ '
                    WHEN lnUnidades = 1 THEN 'ONCE '
                    WHEN lnUnidades = 2 THEN 'DOCE '
                    WHEN lnUnidades = 3 THEN 'TRECE '
                    WHEN lnUnidades = 4 THEN 'CATORCE '
                    WHEN lnUnidades = 5 THEN 'QUINCE '
                    ELSE CONCAT('DIECI', lcCadena)
                END;
            ELSEIF lnDecenas = 2 THEN
                SET lcCadena = 
                CASE
                    WHEN lnUnidades = 0 THEN 'VEINTE '
                    ELSE CONCAT('VEINTI', lcCadena)
                END;
            ELSEIF lnDecenas > 2 THEN
                SET lcCadena = 
                CASE
                    WHEN lnDecenas = 3 THEN CONCAT('TREINTA ', lcCadena)
                    WHEN lnDecenas = 4 THEN CONCAT('CUARENTA ', lcCadena)
                    WHEN lnDecenas = 5 THEN CONCAT('CINCUENTA ', lcCadena)
                    WHEN lnDecenas = 6 THEN CONCAT('SESENTA ', lcCadena)
                    WHEN lnDecenas = 7 THEN CONCAT('SETENTA ', lcCadena)
                    WHEN lnDecenas = 8 THEN CONCAT('OCHENTA ', lcCadena)
                    WHEN lnDecenas = 9 THEN CONCAT('NOVENTA ', lcCadena)
                    ELSE lcCadena
                END;
            END IF;
            -- Convertir centenas
            SET lcCadena = 
            CASE
                WHEN lnCentenas = 1 AND lnUnidades = 0 AND lnDecenas = 0 THEN CONCAT('CIEN ', lcCadena)
                WHEN lnCentenas = 1 THEN CONCAT('CIENTO ', lcCadena)
                WHEN lnCentenas = 2 THEN CONCAT('DOSCIENTOS ', lcCadena)
                WHEN lnCentenas = 3 THEN CONCAT('TRESCIENTOS ', lcCadena)
                WHEN lnCentenas = 4 THEN CONCAT('CUATROCIENTOS ', lcCadena)
                WHEN lnCentenas = 5 THEN CONCAT('QUINIENTOS ', lcCadena)
                WHEN lnCentenas = 6 THEN CONCAT('SEISCIENTOS ', lcCadena)
                WHEN lnCentenas = 7 THEN CONCAT('SETECIENTOS ', lcCadena)
                WHEN lnCentenas = 8 THEN CONCAT('OCHOCIENTOS ', lcCadena)
                WHEN lnCentenas = 9 THEN CONCAT('NOVECIENTOS ', lcCadena)
                ELSE lcCadena
            END;
            -- Agregar millares y millones
            SET lcCadena = 
            CASE
                WHEN lnTerna = 2 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN CONCAT(lcCadena, 'MIL ')
                WHEN lnTerna = 3 AND (lnUnidades + lnDecenas + lnCentenas <> 0) THEN 
                    IF (lnUnidades = 1 AND lnDecenas = 0 AND lnCentenas = 0, CONCAT(lcCadena, 'MILLÓN '), CONCAT(lcCadena, 'MILLONES '))
                ELSE lcCadena
            END;
            SET lcRetorno = CONCAT(lcCadena, lcRetorno);
            SET lnTerna = lnTerna + 1;
        END WHILE;
    ELSE
        SET lcRetorno = 'CERO';
    END IF;
    RETURN RTRIM(lcRetorno);
END */$$
DELIMITER ;

/* Procedure structure for procedure `abm_articulo` */

/*!50003 DROP PROCEDURE IF EXISTS  `abm_articulo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `abm_articulo`(
    IN p_operacion CHAR(1),
    IN p_idarticulo INT,
    IN p_descripcion VARCHAR(100),
    IN p_codbarra CHAR(45),
    IN p_idplan_cuota INT,
    IN p_idMarca INT,
    IN p_idgrupo INT,
    IN p_idsubgrupo INT,
    IN p_idproveedor INT,
    IN p_unidad VARCHAR(45),
    IN p_ultima_fecha_compra DATE,
    IN p_ultima_fecha_venta DATE,
    IN p_ultima_fecha_ajuste DATE,
    IN p_impuesto ENUM('10','5'),
    IN p_margen_contado DECIMAL(10,2),
    IN p_interes_mensual DECIMAL(10,2),
    IN p_limite_cuota DECIMAL(10,0),
    IN p_precio_costo INT,
    IN p_precio_contado INT,
    IN p_stockminimo INT,
    IN p_tipo_imagen ENUM('LOCAL','URL'),
    IN p_foto TEXT,
    IN p_detalle TEXT,
    OUT p_codigo_generado VARCHAR(45),
    OUT p_error_code INT,
    OUT p_error_message VARCHAR(255)
)
BEGIN
    -- DECLARACIÓN DE VARIABLES
    DECLARE v_nuevo_codigo VARCHAR(45);
    DECLARE v_secuencia INT;
    DECLARE v_codigo_existente INT;
    DECLARE v_codigo_actual VARCHAR(45);
    
    -- HANDLER PARA CUALQUIER ERROR SQL (compatible con MySQL 5.6)
    DECLARE EXIT HANDLER FOR SQLSTATE '23000'
    BEGIN
        SET p_error_code = 23000;
        SET p_error_message = 'Error de integridad: clave duplicada o restricción violada';
    END;
    
    DECLARE EXIT HANDLER FOR SQLSTATE '45000'
    BEGIN
        SET p_error_code = 45000;
        SET p_error_message = 'Error de validación';
    END;
    
    -- Inicializar parámetros de error
    SET p_error_code = 0;
    SET p_error_message = '';

    -- OPERACIÓN: NUEVO ARTÍCULO
    IF p_operacion = 'N' THEN
        IF p_codbarra IS NULL OR p_codbarra = '' THEN
            UPDATE secuencias SET valor = valor + 1 WHERE nombre = 'articulos';
            SELECT valor INTO v_secuencia FROM secuencias WHERE nombre = 'articulos';
            SET v_nuevo_codigo = LPAD(v_secuencia, 5, '0');
            
            WHILE EXISTS (SELECT 1 FROM articulo WHERE codbarra = v_nuevo_codigo) DO
                UPDATE secuencias SET valor = valor + 1 WHERE nombre = 'articulos';
                SELECT valor INTO v_secuencia FROM secuencias WHERE nombre = 'articulos';
                SET v_nuevo_codigo = LPAD(v_secuencia, 5, '0');
            END WHILE;
        ELSE
            SET v_nuevo_codigo = p_codbarra;
            
            SELECT COUNT(*) INTO v_codigo_existente 
            FROM articulo 
            WHERE codbarra = v_nuevo_codigo;
            
            IF v_codigo_existente > 0 THEN
                SET p_error_code = 45000;
                SET p_error_message = 'El código de barras ya existe en la base de datos';
                SET p_codigo_generado = '';
            END IF;
        END IF;

        -- Solo insertar si no hubo error
        IF p_error_code = 0 THEN
            INSERT INTO articulo (
                descripcion, codbarra, idplan_cuota, idMarca, idgrupo, idsubgrupo, 
                idproveedor, unidad, ultima_fecha_compra, ultima_fecha_venta, 
                ultima_fecha_ajuste, impuesto, margen_contado, interes_mensual, 
                limite_cuota, precio_costo, precio_contado, stockminimo, 
                tipo_imagen, foto, detalle
            ) VALUES (
                p_descripcion, v_nuevo_codigo, p_idplan_cuota, p_idMarca, p_idgrupo, 
                p_idsubgrupo, p_idproveedor, p_unidad, p_ultima_fecha_compra, 
                p_ultima_fecha_venta, p_ultima_fecha_ajuste, p_impuesto, 
                p_margen_contado, p_interes_mensual, p_limite_cuota, 
                p_precio_costo, p_precio_contado, p_stockminimo, p_tipo_imagen, 
                p_foto, p_detalle
            );
            
            SET p_codigo_generado = v_nuevo_codigo;
        END IF;

    -- OPERACIÓN: MODIFICAR ARTÍCULO
    ELSEIF p_operacion = 'M' THEN
        SELECT codbarra INTO v_codigo_actual 
        FROM articulo 
        WHERE idarticulo = p_idarticulo;
        
        IF p_codbarra IS NOT NULL AND p_codbarra != '' AND p_codbarra != v_codigo_actual THEN
            SELECT COUNT(*) INTO v_codigo_existente 
            FROM articulo 
            WHERE codbarra = p_codbarra AND idarticulo != p_idarticulo;
            
            IF v_codigo_existente > 0 THEN
                SET p_error_code = 45000;
                SET p_error_message = 'El código de barras ya existe en otro artículo';
                SET p_codigo_generado = v_codigo_actual;
            ELSE
                SET p_codigo_generado = p_codbarra;
            END IF;
        ELSE
            SET p_codigo_generado = v_codigo_actual;
        END IF;

        -- Solo actualizar si no hubo error
        IF p_error_code = 0 THEN
            UPDATE articulo 
            SET 
                descripcion = p_descripcion,
                codbarra = p_codigo_generado,
                idplan_cuota = p_idplan_cuota,
                idMarca = p_idMarca,
                idgrupo = p_idgrupo,
                idsubgrupo = p_idsubgrupo,
                idproveedor = p_idproveedor,
                unidad = p_unidad,
                impuesto = p_impuesto,
                margen_contado = p_margen_contado,
                interes_mensual = p_interes_mensual,
                limite_cuota = p_limite_cuota,
                precio_costo = p_precio_costo,
                precio_contado = p_precio_contado,
                stockminimo = p_stockminimo,
                tipo_imagen = p_tipo_imagen,
                foto = p_foto,
                detalle = p_detalle
            WHERE idarticulo = p_idarticulo;
        END IF;

    -- OPERACIÓN: ELIMINAR ARTÍCULO
    ELSEIF p_operacion = 'B' THEN
        SELECT codbarra INTO p_codigo_generado 
        FROM articulo 
        WHERE idarticulo = p_idarticulo;
        
        DELETE FROM articulo 
        WHERE idarticulo = p_idarticulo;

    ELSE
        SET p_error_code = 45000;
        SET p_error_message = 'Operación no válida. Use N, M o B.';
    END IF;

END */$$
DELIMITER ;

/* Procedure structure for procedure `actu_cabcuota` */

/*!50003 DROP PROCEDURE IF EXISTS  `actu_cabcuota` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `actu_cabcuota`(
    IN cod_cuota INT,
    IN cap_fecha DATE,
    IN cap_total_importe INT,
    IN cap_total_interes INT,
    IN cap_total_descuento INT,
    IN cap_ultimo_totalac INT
)
BEGIN
    DECLARE v_saldo INT;

    -- Obtener el saldo actual (ya será calculado por el trigger)
    SELECT SALDO_ACTUAL INTO v_saldo
    FROM cuotas 
    WHERE idcuotas = cod_cuota;

    -- Solo actualizar estado si el saldo es cero o negativo
    IF v_saldo <= 0 THEN
        UPDATE cuotas 
        SET estado = 'CAN', 
            fecha_cancela = cap_fecha 
        WHERE idcuotas = cod_cuota;
    END IF;
     
END */$$
DELIMITER ;

/* Procedure structure for procedure `act_det_cuota` */

/*!50003 DROP PROCEDURE IF EXISTS  `act_det_cuota` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `act_det_cuota`(cod_det_cuota INT,vto_cuota DATE,fecha_pg DATE)
BEGIN
	UPDATE cuotas_detalle 
		SET fecha_vto=vto_cuota,ultima_Fecha_pago=fecha_pg 
	WHERE idcuotas_detalle=cod_det_cuota;
END */$$
DELIMITER ;

/* Procedure structure for procedure `act_venta_cab` */

/*!50003 DROP PROCEDURE IF EXISTS  `act_venta_cab` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `act_venta_cab`(cod_venta INT,cod_cuota INT ,primera_fecha_vtos DATE,dia_entr_pago INT,fecha_ven DATE,cod_vendedor INT,cod_cobrador INT)
BEGIN
		UPDATE venta SET fecha = fecha_ven, idVendedor = cod_vendedor,idcobrador=cod_cobrador WHERE idVenta = cod_venta;		
		UPDATE cuotas SET fecha_alta=fecha_ven,primera_fecha_vto=primera_fecha_vtos,dias_entre_pago=dia_entr_pago WHERE idcuotas=cod_cuota;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ajuste_inventario` */

/*!50003 DROP PROCEDURE IF EXISTS  `ajuste_inventario` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ajuste_inventario`(
    IN p_idempresa INT,
    IN p_idsucursal INT,
    IN p_fecha DATE,
    IN p_idusuario INT,
    IN p_idmotivo_ajuste INT,
    IN p_iddeposito INT,
    IN p_tipo_ajuste ENUM('ENTRADAS','SALIDAS'),
    IN p_observacion VARCHAR(100)
)
BEGIN
    DECLARE v_nro_ajuste VARCHAR(10);
    DECLARE v_ultimo_numero INT;

    -- Obtener el último número de ajuste para esta empresa/sucursal
    SELECT COALESCE(MAX(CAST(SUBSTRING(nro_ajuste, 4) AS UNSIGNED)), 0) + 1 
    INTO v_ultimo_numero
    FROM ajuste_inventario 
    WHERE idempresa = p_idempresa 
    AND idsucursal = p_idsucursal;

    -- Generar número de ajuste automático (formato: AJ-0001, AJ-0002, etc.)
    SET v_nro_ajuste = CONCAT('AJ-', LPAD(v_ultimo_numero, 4, '0'));

    -- Insertar nuevo ajuste
    INSERT INTO ajuste_inventario (
        idempresa,
        idsucursal,
        nro_ajuste,
        fecha,
        idusuario,
        idmotivo_ajuste,
        iddeposito,
        tipo_ajuste,
        observacion
    ) VALUES (
        p_idempresa,
        p_idsucursal,
        v_nro_ajuste,
        p_fecha,
        p_idusuario,
        p_idmotivo_ajuste,
        p_iddeposito,
        p_tipo_ajuste,
        p_observacion
    );

    -- Devolver solo el último ID generado
    SELECT LAST_INSERT_ID() AS id_generado;

END */$$
DELIMITER ;

/* Procedure structure for procedure `ajuste_inventario_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `ajuste_inventario_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ajuste_inventario_detalle`(
    IN p_idajuste_inventario INT,
    IN p_idarticulo INT,
    IN p_marca VARCHAR(45),
    IN p_grupo_subgrupo VARCHAR(45),
    IN p_precio_costo DECIMAL(10,2),
    IN p_cantidad INT
)
BEGIN
    -- Insertar detalle del ajuste
    INSERT INTO ajuste_inventario_detalle (
        idajuste_inventario,
        idarticulo,
        marca,
        grupo_subgrupo,
        precio_costo,
        cantidad
    ) VALUES (
        p_idajuste_inventario,
        p_idarticulo,
        p_marca,
        p_grupo_subgrupo,
        p_precio_costo,
        p_cantidad
    );


END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_articulo` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_articulo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_articulo`(tipo CHAR(1)
,n_codigo INT
,c_descripcion CHAR(100)
,c_barra CHAR(45)
,n_impuesto INT
,n_precio_costo INT
,n_precio_contado INT
,n_activo BOOL
,n_stockminimo INT
,n_idmarca INT
,n_idgrupo INT
,n_idsubgrupo INT
,n_idproveedor INT)
BEGIN
	DECLARE codigo INT;
	SELECT MAX(idarticulo) FROM articulo INTO codigo;
	IF ISNULL(codigo) THEN
		SET codigo=1;
	ELSE
		SET codigo=codigo+1;
	END IF;
IF tipo="N" THEN
	INSERT INTO articulo VALUES(codigo,c_descripcion,c_barra,CURDATE(),CURDATE(),CURDATE(),
	n_impuesto,n_precio_costo,n_precio_contado,n_activo,n_stockminimo,n_idmarca,n_idgrupo,
	n_idsubgrupo,n_idproveedor);
ELSE
	UPDATE articulo SET descripcion = c_descripcion,
					codbarra = c_barra,
					impuesto =n_impuesto,
					precio_costo=n_precio_costo,
					precio_contado=n_precio_contado,
					activo =n_activo,
					stockminimo=n_stockminimo,
					idMarca =n_idmarca,
					idgrupo = n_idgrupo,
					idsubgrupo = n_idsubgrupo,
					idproveedor =n_idproveedor 
	WHERE idarticulo = n_codigo;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_barrio` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_barrio` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_barrio`(
	IN tipo CHAR(1),
	IN n_cod INT, 
	IN n_cod_zona INT,
	IN c_barrio VARCHAR(45)
)
BEGIN


	IF tipo="N" THEN
		INSERT INTO barrio(barrio,idzona) VALUES(c_barrio,n_cod_zona);
	ELSEIF tipo = "M" THEN
		UPDATE barrio SET barrio = c_barrio, idzona = n_cod_zona WHERE idbarrio=n_cod;
	ELSE
		DELETE FROM barrio WHERE idbarrio = n_cod;
	END IF ;

END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_cliente` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_cliente`(
    tipo CHAR(1),
    IN n_codigo INT,
    IN n_idzona INT,
    IN n_idbarrio INT,
    IN n_idprofesion INT,
    IN c_nombre VARCHAR(45),
    IN c_apellido VARCHAR(45),
    IN c_ruc VARCHAR(45),
    IN c_ci VARCHAR(45),
    IN c_celular VARCHAR(20),
    IN c_telefono VARCHAR(20),
    IN c_referencia TEXT,
    IN c_trabajo_lugar VARCHAR(45),
    IN c_trabajo_telefono VARCHAR(20),
    IN c_ref1 VARCHAR(45),
    IN c_ref2 VARCHAR(45),
    IN c_ref3 VARCHAR(45),
    IN c_reftel1 VARCHAR(45),
    IN c_reftel2 VARCHAR(45),
    IN c_reftel3 VARCHAR(45)
)
BEGIN
    DECLARE v_existe INT DEFAULT 0;
    DECLARE v_tiene_creditos INT DEFAULT 0;
    DECLARE v_mensaje VARCHAR(255);
    
    -- Validar tipo de operación
    IF tipo NOT IN ('N', 'M', 'B') THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tipo de operación no válido. Use: N (Nuevo), M (Modificar), B (Borrar)';
    END IF;
    
    -- Validaciones para MODIFICAR y BORRAR
    IF tipo IN ('M', 'B') THEN
        -- Verificar que el cliente existe
        SELECT COUNT(*) INTO v_existe 
        FROM cliente 
        WHERE idcliente = n_codigo;
        
        IF v_existe = 0 THEN
            SET v_mensaje = CONCAT('El cliente con ID ', n_codigo, ' no existe.');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
    END IF;
    
    -- Para BORRAR: verificar que no tenga créditos pendientes
    IF tipo = 'B' THEN
        SELECT COUNT(*) INTO v_tiene_creditos 
        FROM cuotas 
        WHERE idcliente = n_codigo AND estado = 'PEN' AND ANULADO = 'NO';
        
        IF v_tiene_creditos > 0 THEN
            SET v_mensaje = CONCAT('No se puede eliminar el cliente. Tiene ', v_tiene_creditos, ' crédito(s) pendiente(s).');
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
        
        -- Verificar que no tenga ventas asociadas
        SELECT COUNT(*) INTO v_tiene_creditos 
        FROM venta 
        WHERE idcliente = n_codigo AND estado = 'F';
        
        IF v_tiene_creditos > 0 THEN
            SET v_mensaje = 'No se puede eliminar el cliente. Tiene ventas asociadas.';
            SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = v_mensaje;
        END IF;
    END IF;

    -- Ejecutar operación según el tipo
    CASE tipo
        WHEN 'N' THEN
            -- Validar datos obligatorios para nuevo cliente
            IF c_nombre IS NULL OR TRIM(c_nombre) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del cliente es obligatorio.';
            END IF;
            
            IF c_apellido IS NULL OR TRIM(c_apellido) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido del cliente es obligatorio.';
            END IF;
            
            -- Insertar nuevo cliente (sin especificar idcliente, para que se autoincremente)
            INSERT INTO cliente(
                idzona, idbarrio, idprofesion, nombre, apellido, 
                ruc, ci, celular, telefono, referencia, trabajo_lugar, 
                trabajo_telefono, ref1, ref2, ref3, reftel1, reftel2, reftel3
            ) VALUES (
                NULLIF(n_idzona, 0),
                NULLIF(n_idbarrio, 0),
                NULLIF(n_idprofesion, 0),
                c_nombre,
                c_apellido,
                NULLIF(c_ruc, ''),
                NULLIF(c_ci, ''),
                NULLIF(c_celular, ''),
                NULLIF(c_telefono, ''),
                NULLIF(c_referencia, ''),
                NULLIF(c_trabajo_lugar, ''),
                NULLIF(c_trabajo_telefono, ''),
                NULLIF(c_ref1, ''),
                NULLIF(c_ref2, ''),
                NULLIF(c_ref3, ''),
                NULLIF(c_reftel1, ''),
                NULLIF(c_reftel2, ''),
                NULLIF(c_reftel3, '')
            );
            
            -- Obtener el último ID insertado
            SELECT 
                LAST_INSERT_ID() AS nuevo_id, 
                'Cliente creado exitosamente' AS mensaje,
                CONCAT('ID: ', LAST_INSERT_ID(), ' - ', TRIM(c_nombre), ' ', TRIM(c_apellido)) AS detalle;
            
        WHEN 'M' THEN
            -- Validar datos obligatorios para modificación
            IF c_nombre IS NULL OR TRIM(c_nombre) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El nombre del cliente es obligatorio.';
            END IF;
            
            IF c_apellido IS NULL OR TRIM(c_apellido) = '' THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El apellido del cliente es obligatorio.';
            END IF;
            
            -- Actualizar cliente existente
            UPDATE cliente 
            SET 
                idzona = NULLIF(n_idzona, 0),
                idbarrio = NULLIF(n_idbarrio, 0),
                idprofesion = NULLIF(n_idprofesion, 0),
                nombre = c_nombre,
                apellido = c_apellido,
                ruc = NULLIF(c_ruc, ''),
                ci = NULLIF(c_ci, ''),
                celular = NULLIF(c_celular, ''),
                telefono = NULLIF(c_telefono, ''),
                referencia = NULLIF(c_referencia, ''),
                trabajo_lugar = NULLIF(c_trabajo_lugar, ''),
                trabajo_telefono = NULLIF(c_trabajo_telefono, ''),
                ref1 = NULLIF(c_ref1, ''),
                ref2 = NULLIF(c_ref2, ''),
                ref3 = NULLIF(c_ref3, ''),
                reftel1 = NULLIF(c_reftel1, ''),
                reftel2 = NULLIF(c_reftel2, ''),
                reftel3 = NULLIF(c_reftel3, '')
            WHERE idcliente = n_codigo;
            
            SELECT 
                n_codigo AS id_actualizado, 
                'Cliente actualizado exitosamente' AS mensaje,
                CONCAT('ID: ', n_codigo, ' - ', trim(c_nombre), ' ', trim(c_apellido)) AS detalle;
            
        WHEN 'B' THEN
            -- Eliminar cliente (solo si pasa todas las validaciones)
            DELETE FROM cliente 
            WHERE idcliente = n_codigo;
            
            SELECT 
                n_codigo AS id_eliminado, 
                'Cliente eliminado exitosamente' AS mensaje,
                CONCAT('ID: ', n_codigo,'CI: ',TRIM(c_ci)) AS detalle;
    END CASE;

END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_cobrador` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_cobrador` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_cobrador`(
	IN tipo CHAR(1),
	IN n_codigo INT, 
	IN n_cod_personal INT,
	IN cod_zona INT
	)
BEGIN

	IF tipo ="N" THEN
		INSERT INTO cobrador(idpersonal, idzona) VALUES(n_cod_personal, cod_zona);
	ELSEif tipo = "M" then
	
		UPDATE cobrador 
		SET 
			idPersonal=n_cod_personal, 
			idzona	=cod_zona
		 WHERE idcobrador=n_codigo;
		 
	elseif tipo = "B" then
	
		DELETE FROM cobrador  WHERE idcobrador=n_codigo;
		
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_concepto` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_concepto` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_concepto`(
in tipo CHAR(1),
in n_codigo INT,
in c_concepto varCHAR(45),
in c_tipo CHAR(1)
)
BEGIN	
	IF tipo="N" THEN
		INSERT INTO concepto_caja (concepto, tipo)
			VALUES (c_concepto, c_tipo);
	ELSEif tipo ="M" then
			UPDATE concepto_caja 
			SET 
				concepto = c_concepto,
				tipo = c_tipo 
			WHERE idconcepto = n_codigo;
	elseif tipo = "B" then
		DELETE FROM concepto_caja 
		where idconcepto = n_codigo;
	END IF; 
END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_deposito` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_deposito` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_deposito`(tipo char(1),n_cod int, c_deposito char(45),cod_sucursal int)
begin
	if tipo="N" then
		INSERT INTO deposito(deposito,idsucursal) 
			VALUES(c_deposito,cod_sucursal);
	elseif tipo ="M" then
		update deposito set deposito=c_deposito,idsucursal=cod_sucursal where iddeposito=n_cod;
	elseif tipo = "B" then
		DELETE FROM DEPOSITO WHERE IDDEPOSITO = n_cod;
	end if ;
end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_empresa` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_empresa` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_empresa`(
	tipo varchar(1),
	cod_empresa int,
	c_empresa varchar(45),
	c_ruc varchar(20),
	c_telefono varchar(15))
begin

if tipo="N" then


	INSERT INTO empresa( 
		     empresa,
		     ruc,
		     telefono)
	VALUES (c_empresa,
		c_ruc,
		c_telefono);
        
elseif tipo ='M' then 

	UPDATE empresa SET
		empresa = c_empresa,
		ruc = c_ruc,
		telefono = c_telefono
	WHERE idEmpresa = cod_empresa;
else
	-- tipo = "B"
	delete from empresa where idEmpresa = cod_empresa;

end if;
end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_formapago` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_formapago` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_formapago`(
	in tipo char(1),
	in cap_cod int, 
	in cap_forma varchar(45)
	)
begin

if tipo ="N" then

	insert into tipo_pago(tipo) values(cap_forma);
elseif tipo = "M" then

	update tipo_pago set tipo=cap_forma where  idtipo_pago = cap_cod;

elseif tipo = "B" then 

	delete from tipo_pago where idTipo_pago = cap_cod;
 
end if;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_grupo` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_grupo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_grupo`(
in tipo char(1),
in n_codgrupo int, 
in c_grupo varchar(45))
begin

if tipo="N" then
	INSERT INTO grupo(grupo) VALUES(c_grupo);
elseif tipo ="M" then
	update grupo set grupo=c_grupo where idgrupo=n_codgrupo;
else
	delete from grupo where idgrupo = n_codgrupo;
end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_marca` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_marca` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_marca`(
	in tipo char(1),
	in n_codmarca int, 
	in c_marca varchar(45)
)
begin
	if tipo="N" then
		INSERT INTO marca(marca) VALUES(c_marca);
	elseif tipo = "M" then
		update marca set marca=c_marca where idmarca=n_codmarca;
	else
		delete from marca where idmarca = n_codmarca;
	end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_menu` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_menu` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_menu`(tipo int,cod_menu int,cod_parent int,cap_menu char(45),cap_comando char(200),cap_nd_carpeta int(1))
begin
declare codigo int;
select max(idmenu) from menu into codigo;
if isnull(codigo) then
	set codigo=1;
else
	set codigo=codigo+1;
end if;
case tipo
	when 1 then
		insert into menu values(codigo,cod_parent,cap_menu,cap_comando,cap_nd_carpeta);
	when 2 then
		UPDATE menu
			SET
			texto =cap_menu,
			comando =cap_comando,
			nd_carpeta =cap_nd_carpeta
			WHERE idmenu =cod_menu;
	when 3 then 
		DELETE FROM menu WHERE  parent =cod_menu;
		DELETE FROM menu WHERE  idmenu =cod_menu;
end case;	
end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_motivo_ajuste` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_motivo_ajuste` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_motivo_ajuste`(
	in tipo varchar(1),
	in n_cod int,
	in c_ajuste varchar(45),
	in c_tipo enum('E','S')
 )
begin
	if tipo="N" then
		INSERT INTO motivo_ajuste(motivo,tipo) VALUES(c_ajuste,c_tipo);
	elseif tipo ="M" then
		update motivo_ajuste set motivo=c_ajuste,tipo=c_tipo where idmotivo=n_cod;
	elseif tipo ="B" then
		delete from motivo_ajuste where idmotivo = n_cod;
	end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_personal` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_personal` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_personal`(

	in tipo CHAR(1),
	in n_codigo int, 
	in c_nombre varchar(45),
	in c_apellido VARCHAR(45),
	in c_ci VARCHAR(25), 
	in c_telefono VARCHAR(20),
	in c_direccion VARCHAR(45),
	in n_cod_sucursal INT
)
BEGIN

IF tipo="N" THEN

	insert into personal (
	  nombre,
	  apellido,
	  ci,
	  telefono,
	  Direccion,
	  idsucursal
	)
	values
	  (
	    c_nombre,
	    c_apellido,
	    c_ci,
	    c_telefono,
	    c_direccion,
	    n_cod_sucursal
	  );

ELSEif tipo = "M" then 

	update
	  personal
	set
	  nombre = c_nombre,
	  apellido = c_apellido,
	  ci = c_ci,
	  telefono = c_telefono,
	  Direccion = c_direccion,
	  idsucursal = n_cod_sucursal
	where idPersonal = n_codigo;
	
elseif tipo ="B" then
	delete from personal where idPersonal = n_codigo;
END IF ;

END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_plan_cuota` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_plan_cuota` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_plan_cuota`(
    tipo CHAR(1),
    IN n_cod INT,
    IN c_nombre_plan VARCHAR(45),
    IN n_margen_contado DECIMAL(10,2),
    IN n_interes_mensual DECIMAL(10,2),
    IN n_limite_cuota INT
)
BEGIN

    IF tipo = 'N' THEN
        INSERT INTO plan_cuota(
            nombre_plan, 
            margen_contado, 
            interes_mensual, 
            limite_cuota
        ) VALUES (
            c_nombre_plan,
            n_margen_contado,
            n_interes_mensual,
            n_limite_cuota
        );
        
    ELSEIF tipo = 'M' THEN
        UPDATE plan_cuota 
        SET nombre_plan = c_nombre_plan,
            margen_contado = n_margen_contado,
            interes_mensual = n_interes_mensual,
            limite_cuota = n_limite_cuota
        WHERE idplan_cuota = n_cod;
        
        
    ELSEIF tipo = 'B' THEN
        DELETE FROM plan_cuota 
        WHERE idplan_cuota = n_cod;
    
    ELSE
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Tipo de operación no válido. Use N (Nuevo), M (Modificar) o B (Borrar).';
    END IF;

END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_profesion` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_profesion` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_profesion`(
	in tipo char(1),
	in n_cod int, 
	in c_pro varchar(45)
)
begin

	if tipo='N' then
	
		INSERT INTO profesion(
		profesion
		) 
		VALUES(c_pro);
		
	elseif  tipo ='M' then
	
		update profesion 
		set profesion=c_pro 
		where idprofesion=n_cod;
		
	elseif tipo = 'B' then
	
		delete from profesion 
		where idprofesion = n_cod;
	else
		signal sqlstate '45000'
		SET MESSAGE_TEXT = 'Tipo de operación no válido. Use N (Nuevo), M (Modificar) o B (Borrar).';
	end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_proveedor` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_proveedor` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_proveedor`(
	tipo char(1)
	,in n_cod int
	,in c_proveedor varchar(45)
	,in c_propietario varchar(45)
	,in c_direccion varchar(45)
	,in c_telefono varchar(45)
	,in c_ruc varchar(45)
	,in n_ci int
	,in c_obs varchar(100))
begin

	if tipo="N" then
		INSERT INTO proveedor(proveedor, direccion, propietario, telefono,ruc,ci,observacion)
				VALUES(c_proveedor,c_direccion,c_propietario,c_telefono,c_ruc,n_ci,c_obs);
	elseif tipo="M" then
				update proveedor set proveedor=c_proveedor
					,direccion=c_direccion
					,propietario=c_propietario
					,telefono=c_telefono
					,ruc=c_ruc
					,ci=n_ci
					,observacion=c_obs 
					where idproveedor=n_cod;
	else
		delete from proveedor where idproveedor = n_cod;
	end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_subgrupo` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_subgrupo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_subgrupo`(

	in tipo varchar(1),
	in n_codsubgrupo int, 
	in c_subgrupo varchar(45),
	in n_cod_grupo int
)
begin

	if tipo="N" then
	
		INSERT INTO subgrupo(subgrupo, idgrupo) VALUES(c_subgrupo,n_cod_grupo);
		
	elseif tipo = "M" then
	
		update subgrupo set subgrupo = c_subgrupo, idgrupo = n_cod_grupo 
		where idsubgrupo = n_codsubgrupo;
	else
		delete from subgrupo where idsubgrupo = n_codsubgrupo;
	end if ;

end */$$
DELIMITER ;

/* Procedure structure for procedure `amb_sucursal` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_sucursal` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_sucursal`(
	in tipo CHAR(1),
	in n_cod INT,
	in cod_empresa INT, 
	in c_sucursal CHAR(45),
	in c_direccion CHAR(45),
	in c_telefono CHAR(20)
)
BEGIN

	IF tipo="N" THEN
		insert into sucursal (
		  idEmpresa,
		  sucursal,
		  direccion,
		  telefono
		)
		values
		  (
		    cod_empresa,
		    c_sucursal,
		    c_direccion,
		    c_telefono
		  );

	ELSEif tipo = "M" then
	
		update
		  sucursal
		set
		  idEmpresa = cod_empresa,
		  sucursal = c_sucursal,
		  direccion = c_direccion,
		  telefono = c_telefono
		where idsucursal = n_cod;

	else
		delete from sucursal where idsucursal = n_cod;
	END IF ;

END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_usuario` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_usuario`(
    tipo CHAR(1),
    cap_tipo_usuario int,
    cap_codigo INT, 
    cap_cod_personal INT, 
    cap_user varCHAR(45), 
    cap_clave varCHAR(45)
)
BEGIN
    IF tipo = "N" THEN
        -- NUEVO USUARIO
        INSERT INTO usuario (nick, clave, idPersonal,tipo)
        VALUES (cap_user, cap_clave, cap_cod_personal,cap_tipo_usuario);
        
    ELSEIF tipo = "M" THEN
        -- MODIFICAR USUARIO
        UPDATE usuario
        SET 
            nick = cap_user,
            tipo = cap_tipo_usuario,
            idPersonal = cap_cod_personal
        WHERE idusuario = cap_codigo;
        
    ELSEIF tipo = "B" THEN
        -- ELIMINAR USUARIO
        DELETE FROM usuario 
        WHERE idusuario = cap_codigo;
        
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_vendedor` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_vendedor` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_vendedor`(
	 in tipo CHAR(1),
	 in n_codigo INT, 
	 in n_cod_personal INT,
	 in c_tipo varchar(20)
 )
BEGIN
	
	IF tipo ="N" THEN
	
		INSERT INTO vendedor(idpersonal,tipo_vendedor) VALUES(n_cod_personal,c_tipo);
	ELSEif tipo = "M" then
	 
		update vendedor
		set idPersonal = n_cod_personal, tipo_vendedor = c_tipo
		where idVendedor = n_codigo;
		
	elseif tipo = "B" then
		delete from vendedor where idVendedor = n_codigo;
	END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `amb_zona` */

/*!50003 DROP PROCEDURE IF EXISTS  `amb_zona` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `amb_zona`(tipo char(1),n_codzona int, c_zona char(60))
begin
	if tipo="N" then
		INSERT INTO zona(zona) VALUES(c_zona);
	elseif tipo = "M" then
		update zona set zona=c_zona where idzona=n_codzona;
	else
		delete from zona where idzona = n_codzona;
	end if;

end */$$
DELIMITER ;

/* Procedure structure for procedure `cab_pagos_cuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `cab_pagos_cuotas` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `cab_pagos_cuotas`(
cod_cuota INT,
cap_fecha DATE,
cap_total_interes INT,
cap_total_descuento INT,
cap_total_importe INT,
cap_totaac INT,
cap_cod_cliente INT,
cap_tipo_pago INT,
cap_cod_sucursal INT,
cap_cod_empresa INT,
cap_cod_cobrador INT,
cap_cod_usuario int
)
BEGIN


DECLARE codigo INT;
DECLARE nro_recibo_formateado VARCHAR(8);

SELECT COALESCE(MAX(idpago), 0) + 1 INTO codigo FROM pagos_cuotas;

-- Formatear el número de recibo con ceros a la izquierda.
SET nro_recibo_formateado = LPAD(codigo, 8, '0');

INSERT INTO pagos_cuotas
            (idpago,
             fecha,
             nro_recibo,
             total_interes,
             total_descuento,
             total_ac,
	     total_importe,
             idcliente,
             idTipo_pago,
             idsucursal,
             idEmpresa,
             idcobrador,
	     idcuotas,
	     idusuario,
             estado)
VALUES (codigo,
	cap_fecha,
	nro_recibo_formateado,
        cap_total_interes,
        cap_total_descuento,
        cap_totaac,
	cap_total_importe,
	cap_cod_cliente,
	cap_tipo_pago,
	cap_cod_sucursal,
        cap_cod_empresa,
        cap_cod_cobrador,
	cod_cuota,
	cap_cod_usuario,
        "COB");

SELECT codigo;
END */$$
DELIMITER ;

/* Procedure structure for procedure `CalcularPrecioCuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `CalcularPrecioCuotas` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `CalcularPrecioCuotas`(
    IN p_nombre_producto VARCHAR(100),
    IN p_precio_costo DECIMAL(10,2),
    IN p_porcentaje_contado DECIMAL(5,2),
    IN p_interes_anual DECIMAL(5,2),
    IN p_cantidad_cuota INT
)
BEGIN
    DECLARE v_porcentaje_mensual DECIMAL(10,4);
    DECLARE v_precio_contado DECIMAL(10,2);
    DECLARE v_interes DECIMAL(10,2);
    DECLARE v_cuota DECIMAL(10,2);
    DECLARE v_resultado TEXT;
    DECLARE v_contador INT DEFAULT 1;
    
    -- Validaciones básicas
    IF p_precio_costo IS NULL OR p_precio_costo <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de costo debe ser mayor a 0';
    END IF;
    
    IF p_porcentaje_contado IS NULL OR p_porcentaje_contado <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El porcentaje para contado debe ser mayor a 0';
    END IF;
    
    IF p_interes_anual IS NULL OR p_interes_anual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El interés anual debe ser mayor a 0';
    END IF;
    
    IF p_cantidad_cuota IS NULL OR p_cantidad_cuota <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de cuotas debe ser mayor a 0';
    END IF;
    
    -- Calcular porcentaje mensual
    SET v_porcentaje_mensual = p_interes_anual / 12;
    
    -- Calcular precio de contado
    SET v_precio_contado = ROUND(p_precio_costo * (p_porcentaje_contado / 100) + p_precio_costo);
    
    -- Inicializar resultado
    IF p_nombre_producto IS NULL OR p_nombre_producto = '' THEN
        SET v_resultado = CONCAT('*PRODUCTO SIN NOMBRE*', CHAR(10));
    ELSE
        SET v_resultado = CONCAT('*', UPPER(p_nombre_producto), '*', CHAR(10));
    END IF;
    
    -- Calcular cuotas
    WHILE v_contador <= p_cantidad_cuota DO
        IF v_contador = 1 THEN
            -- Precio de contado
            SET v_resultado = CONCAT(v_resultado, 'Contado: ', FORMAT(CEIL(v_precio_contado/1000)*1000, 0), ' Gs.', CHAR(10));
        ELSE
            -- Calcular cuotas
            SET v_interes = v_porcentaje_mensual * v_contador;
            SET v_cuota = ROUND((v_precio_contado * (v_interes / 100) + v_precio_contado) / v_contador);
            SET v_cuota = CEIL(v_cuota/1000)*1000; -- Redondear al millar superior
            
            SET v_resultado = CONCAT(v_resultado, 
                                    v_contador, ' cuotas x ', 
                                    FORMAT(v_cuota, 0), ' Gs.', CHAR(10));
        END IF;
        
        SET v_contador = v_contador + 1;
    END WHILE;
    
    -- Agregar separador final
    SET v_resultado = CONCAT(v_resultado, '***************************************');
    
    -- Retornar resultado
    SELECT v_resultado AS resultado;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `CalcularPrecioCuotasDetallado` */

/*!50003 DROP PROCEDURE IF EXISTS  `CalcularPrecioCuotasDetallado` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `CalcularPrecioCuotasDetallado`(
    IN p_nombre_producto VARCHAR(100),
    IN p_precio_contado DECIMAL(10,2),
    IN p_interes_anual DECIMAL(5,2),
    IN p_cantidad_cuota INT
)
BEGIN
    DECLARE v_porcentaje_mensual DECIMAL(10,4);
    DECLARE v_interes DECIMAL(10,2);
    DECLARE v_cuota DECIMAL(10,2);
    DECLARE v_contador INT DEFAULT 2; -- Empezamos desde 2 porque 1 es contado
    DECLARE v_monto_formateado VARCHAR(50);
    
    -- Crear tabla temporal para resultados
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_resultados (
        tipo VARCHAR(20),
        descripcion VARCHAR(100),
        monto DECIMAL(15,2),
        orden INT
    );
    
    TRUNCATE TABLE temp_resultados;
    
    -- Validaciones
    IF p_precio_contado IS NULL OR p_precio_contado <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El precio de contado debe ser mayor a 0';
    END IF;
    
    IF p_interes_anual IS NULL OR p_interes_anual <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El interés anual debe ser mayor a 0';
    END IF;
    
    IF p_cantidad_cuota IS NULL OR p_cantidad_cuota <= 0 THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'La cantidad de cuotas debe ser mayor a 0';
    END IF;
    
    -- Calcular porcentaje mensual
    SET v_porcentaje_mensual = p_interes_anual;
    
    -- Redondear precio de contado al millar superior
    SET p_precio_contado = CEIL(p_precio_contado/1000)*1000;
    
    -- Insertar producto (opcional, si quieres mantenerlo)
    IF p_nombre_producto IS NOT NULL AND p_nombre_producto != '' THEN
        INSERT INTO temp_resultados VALUES 
        ('PRODUCTO', UPPER(p_nombre_producto), NULL, 0);
    END IF;
    
    -- Insertar contado (PRIMERA FILA) - Formato especial para contado
    INSERT INTO temp_resultados VALUES 
    ('CONTADO', 
     CONCAT('Precio Contado: ', REPLACE(FORMAT(p_precio_contado, 0), ',', '.'), ' Gs.'), 
     p_precio_contado, 1);
    
    -- Calcular y insertar cuotas (desde 2 hasta p_cantidad_cuota)
    WHILE v_contador <= p_cantidad_cuota DO
        -- Calcular interés para esta cantidad de cuotas
        SET v_interes = v_porcentaje_mensual * v_contador;
        
        -- Calcular valor de la cuota
        SET v_cuota = ROUND((p_precio_contado * (v_interes / 100) + p_precio_contado) / v_contador);
        SET v_cuota = CEIL(v_cuota/1000)*1000; -- Redondear al millar superior
        
        -- Insertar en resultados con nuevo formato
        INSERT INTO temp_resultados VALUES 
        ('CUOTA', 
         CONCAT(v_contador, ' Cuotas x ', REPLACE(FORMAT(v_cuota, 0), ',', '.'), ' Gs.'), 
         v_cuota, 
         v_contador);
        
        SET v_contador = v_contador + 1;
    END WHILE;
    
    -- Retornar resultados
    SELECT 
        descripcion AS 'Descripcion',
        tipo,
        CASE 
            WHEN monto IS NOT NULL THEN CONCAT(REPLACE(FORMAT(monto, 0), ',', '.'), ' Gs.') 
            ELSE ''
        END AS 'Monto',
        orden,
        IFNULL(monto, 0) AS cuota
    FROM temp_resultados 
    ORDER BY orden;
    
    DROP TEMPORARY TABLE temp_resultados;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `compra` */

/*!50003 DROP PROCEDURE IF EXISTS  `compra` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `compra`(
    IN p_idproveedor INT,
    IN p_iddeposito INT,
    IN p_idsucursal INT,
    IN p_idEmpresa INT,
    IN p_idusuario INT,
    IN p_fecha DATE,
    IN p_nro_est VARCHAR(3),
    IN p_nro_exp VARCHAR(3),
    IN p_nro_factura VARCHAR(7),
    IN p_plazo INT,
    IN p_fecha_vto DATE,
    IN p_tipo ENUM('CONTADO','CREDITO'),
    IN p_estado enum('PENDIENTE','FACTURADO','ANULADO'),
    IN p_total_gravadas_excenta DECIMAL(10,0),
    IN p_total_gravadas_cinco DECIMAL(10,0),
    IN p_total_gravadas_diez DECIMAL(10,0),
    IN p_liqui_iva_cinco DECIMAL(10,0),
    IN p_liqui_iva_diez DECIMAL(10,0),
    IN p_total_liqui_iva DECIMAL(10,0),
    IN p_total DECIMAL(10,0)
)
BEGIN
    DECLARE v_idcompra INT;
    
    -- Insertar en la tabla compra
    INSERT INTO compra (
        idproveedor, iddeposito, idsucursal, idEmpresa, idusuario,
        fecha, nro_est, nro_exp, nro_factura, plazo, fecha_vto,
        tipo, estado, total_gravadas_excenta, total_gravadas_cinco,
        total_gravadas_diez, liqui_iva_cinco, liqui_iva_diez,
        total_liqui_iva, total
    ) VALUES (
        p_idproveedor, p_iddeposito, p_idsucursal, p_idEmpresa, p_idusuario,
        p_fecha, p_nro_est, p_nro_exp, p_nro_factura, p_plazo, p_fecha_vto,
        p_tipo, p_estado, p_total_gravadas_excenta, p_total_gravadas_cinco,
        p_total_gravadas_diez, p_liqui_iva_cinco, p_liqui_iva_diez,
        p_total_liqui_iva, p_total
    );
    
    -- Obtener el ID de la compra insertada
    SET v_idcompra = LAST_INSERT_ID();
    
    -- Devolver el ID de la compra
    SELECT v_idcompra AS id_compra;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `compra_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `compra_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `compra_detalle`(
    IN p_idcompra INT,
    IN p_idarticulo INT,
    IN p_iva ENUM('0','10','5'),
    IN p_precio_costo DECIMAL(10,0),
    IN p_cantidad INT,
    IN p_gravada_excenta DECIMAL(10,0),
    IN p_gravada_cinco DECIMAL(10,0),
    IN p_gravada_diez DECIMAL(10,0),
    IN p_subtotal DECIMAL(10,0)
)
BEGIN
    -- Insertar en la tabla compra_detalle
    INSERT INTO compra_detalle (
        idcompra, idarticulo, iva, precio_costo, cantidad,
        gravada_excenta, gravada_cinco, gravada_diez, subtotal
    ) VALUES (
        p_idcompra, p_idarticulo, p_iva, p_precio_costo, p_cantidad,
        p_gravada_excenta, p_gravada_cinco, p_gravada_diez, p_subtotal
    );
END */$$
DELIMITER ;

/* Procedure structure for procedure `confirmar_nro_factura` */

/*!50003 DROP PROCEDURE IF EXISTS  `confirmar_nro_factura` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `confirmar_nro_factura`(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT
)
BEGIN
    -- Actualizar el contador incrementándolo en 1
    UPDATE control_numeracion_timbrado 
    SET contador = contador + 1,
        fecha_ultima_actualizacion = NOW()
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'FACTURA'
        AND idsucursal = p_idsucursal;
END */$$
DELIMITER ;

/* Procedure structure for procedure `confirmar_nro_recibo` */

/*!50003 DROP PROCEDURE IF EXISTS  `confirmar_nro_recibo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `confirmar_nro_recibo`(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT
)
BEGIN
    -- Actualizar el contador incrementándolo en 1
    UPDATE control_numeracion_timbrado 
    SET contador = contador + 1,
        fecha_ultima_actualizacion = NOW()
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'RECIBO'
        AND idsucursal = p_idsucursal;
END */$$
DELIMITER ;

/* Procedure structure for procedure `cuotas_cabecera` */

/*!50003 DROP PROCEDURE IF EXISTS  `cuotas_cabecera` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `cuotas_cabecera`(
    IN p_fecha DATE,
    IN p_nrofactura VARCHAR(45),
    IN p_cantidad_cuota INT,
    IN p_primera_fecha_vto DATE,
    IN p_total_venta DECIMAL(10,2),
    IN p_saldo_actual DECIMAL(10,2),
    IN p_idVenta INT,
    IN p_idcliente INT
)
BEGIN
    DECLARE v_idcuotas INT;
    
    
    INSERT INTO cuotas (
        fecha,
        nrofactura,
        cantidad_cuota,
        primera_fecha_vto,
        total_venta,
        saldo_actual,
        estado,
        idVenta,
        idcliente,
        anulado
    ) VALUES (
        p_fecha,
        p_nrofactura,
        p_cantidad_cuota,
        p_primera_fecha_vto,
        p_total_venta,
        p_saldo_actual,
        'PEN',
        p_idVenta,
        p_idcliente,
        'NO'
    );
    
    SET v_idcuotas = LAST_INSERT_ID();
    
    SELECT v_idcuotas AS idcuotas;
END */$$
DELIMITER ;

/* Procedure structure for procedure `cuotas_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `cuotas_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `cuotas_detalle`(
    IN p_orden_char VARCHAR(10),
    IN p_orden_cuota INT,
    IN p_fecha_vto DATE,
    IN p_cuota DECIMAL(10,2),
    IN p_saldo_cuota DECIMAL(10,2),
    IN p_idcuotas INT
)
BEGIN

    
    INSERT INTO cuotas_detalle (
        orden_char,
        orden_cuota,
        fecha_vto,
        cuota,
        saldo_cuota,
        estado,
        idcuotas
    ) VALUES (
        p_orden_char,
        p_orden_cuota,
        p_fecha_vto,
        p_cuota,
        p_saldo_cuota,
        'PEN',
        p_idcuotas
    );
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `detalle_pago` */

/*!50003 DROP PROCEDURE IF EXISTS  `detalle_pago` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `detalle_pago`(
    IN cod_pago INT,
    IN cod_det_cuo INT,
    IN n_orden INT,
    IN c_orden varchar(10),
    IN d_fecha_vto DATE,
    IN n_atraso INT,
    IN n_cuota INT,
    IN n_importe decimal(10,2),
    IN n_interes decimal(10,2),
    IN n_descuento decimal(10,2),
    IN n_totalac decimal(10,2),
    in n_saldo decimal(10,2)
)
BEGIN

    -- Solo insertar en detalle_pagos_cuotas
    -- La actualización de cuotas_detalle ahora la hará el trigger
    INSERT INTO detalle_pagos_cuotas (
        orden,
        orden_char,
        fecha_vto,
        atraso,
        cuota,
        importe,
        saldo,
        interes,
        descuento,
        totalac,
        idpago,
        idcuotas_detalle
    ) VALUES (
        n_orden,
        c_orden,
        d_fecha_vto,
        n_atraso,
        n_cuota,
        n_importe,
        n_saldo,
        n_interes,
        n_descuento,
        n_totalac,
        cod_pago,
        cod_det_cuo
    );

END */$$
DELIMITER ;

/* Procedure structure for procedure `det_compra` */

/*!50003 DROP PROCEDURE IF EXISTS  `det_compra` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `det_compra`(
n_cantidad INT,
n_pre_costo decimal(10,2),
n_iva INT,
n_excenta DECIMAL(10,2),
n_gravada5 DECIMAL(10,2),
n_gravada10 DECIMAL(10,2),
cod_compra INT,
cod_articulo INT,
n_subtotal DECIMAL(10,2)
)
BEGIN 
INSERT INTO detalle_compra
            (cantidad,
             preciocosto,
             iva,
             iva_exenta,
             iva_cinco,
             iva_diez,
             idcompra,
             idarticulo,
             subtotal)
VALUES (n_cantidad,
        n_pre_costo,
        n_iva,
        n_excenta,
        n_gravada5,
        n_gravada10,
        cod_compra,
        cod_articulo,
        n_subtotal);
END */$$
DELIMITER ;

/* Procedure structure for procedure `det_traslado` */

/*!50003 DROP PROCEDURE IF EXISTS  `det_traslado` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `det_traslado`(
n_cant int,
cod_traslado int,
cod_articulo int
)
begin
INSERT INTO detalle_traslado
            (cantidad,
             idtraslado,
             idarticulo)
VALUES (n_cant,
        cod_traslado,
        cod_articulo);
end */$$
DELIMITER ;

/* Procedure structure for procedure `obtener_nro_factura` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtener_nro_factura` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `obtener_nro_factura`(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT,
    OUT p_nro_factura VARCHAR(7)
)
BEGIN
    DECLARE v_contador_actual INT;
    
    -- Obtener el contador actual
    SELECT contador INTO v_contador_actual
    FROM control_numeracion_timbrado
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'FACTURA'
        AND idsucursal = p_idsucursal
        AND activo = 1;
    
    -- Calcular próximo número y formatear
    SET v_contador_actual = v_contador_actual + 1;
    SET p_nro_factura = LPAD(v_contador_actual, 7, '0');
END */$$
DELIMITER ;

/* Procedure structure for procedure `obtener_nro_recibo` */

/*!50003 DROP PROCEDURE IF EXISTS  `obtener_nro_recibo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `obtener_nro_recibo`(
    IN p_establecimiento VARCHAR(3),
    IN p_nro_expedicion VARCHAR(3),
    IN p_idsucursal INT,
    OUT p_nro_recibo VARCHAR(7)
)
BEGIN
    DECLARE v_contador_actual INT;
    
    -- Obtener el contador actual
    SELECT contador INTO v_contador_actual
    FROM control_numeracion_timbrado
    WHERE establecimiento = p_establecimiento
        AND nro_expedicion = p_nro_expedicion
        AND tipo_documento = 'RECIBO'
        AND idsucursal = p_idsucursal
        AND activo = 1;
    
    -- Calcular próximo número y formatear
    SET v_contador_actual = v_contador_actual + 1;
    SET p_nro_recibo = LPAD(v_contador_actual, 7, '0');
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `pagos_cabecera` */

/*!50003 DROP PROCEDURE IF EXISTS  `pagos_cabecera` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `pagos_cabecera`(
    IN p_nro_recibo VARCHAR(45),
    IN p_fecha DATE,
    IN p_total_importe DECIMAL(10,2),
    IN p_idcliente INT,
    IN p_idTipo_pago INT,
    IN p_idsucursal INT,
    IN p_idEmpresa INT,
    IN p_idcobrador INT,
    IN p_idcuotas INT,
    IN p_idusuario int,
    OUT p_idpago_generado INT
)
BEGIN
    
    -- Insertar en la cabecera de pagos (idpago es autoincrement)
    INSERT INTO pagos_cuotas (
        fecha,
        nro_recibo,
        total_importe,
        idusuario,
        idcliente,
        idTipo_pago,
        idsucursal,
        idEmpresa,
        idcobrador,
        idcuotas,
        estado
    ) VALUES (
        p_fecha,
        p_nro_recibo,
        p_total_importe,
        p_idusuario,
        p_idcliente,
        p_idTipo_pago,
        p_idsucursal,
        p_idEmpresa,
        p_idcobrador,
        p_idcuotas,
        'COB'  -- COB = Cobrado
    );
    
    -- Obtener el ID generado automáticamente
    SET p_idpago_generado = LAST_INSERT_ID();
    
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `pagos_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `pagos_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `pagos_detalle`(
    IN p_idpago INT,
    IN p_idcuotas_detalle INT,
    IN p_tipo_pago ENUM('CUOTA','OTRO'),
    IN p_idconcepto INT,
    IN p_concepto VARCHAR(45),
    IN p_orden INT,
    IN p_orden_char VARCHAR(10),
    IN p_fecha_vto DATE,
    IN p_atraso INT,
    IN p_cuota DECIMAL(10,2),
    IN p_importe DECIMAL(10,2),
    IN p_saldo DECIMAL(10,2)
)
BEGIN
    DECLARE v_saldo_actual DECIMAL(10,2);
    DECLARE v_nro_recibo VARCHAR(45);
    DECLARE v_fecha_pago DATE;
    DECLARE v_idcuotas INT;
    DECLARE v_total_saldo DECIMAL(10,2);
    DECLARE v_saldo_cabecera DECIMAL(10,2);
    
    -- Obtener datos del pago principal
    SELECT nro_recibo, fecha INTO v_nro_recibo, v_fecha_pago
    FROM pagos_cuotas 
    WHERE idpago = p_idpago;
    
    -- Insertar el detalle del pago
    INSERT INTO detalle_pagos_cuotas (
        idpago,
        idcuotas_detalle,
        tipo_pago,
        idconcepto,
        concepto,
        orden,
        orden_char,
        fecha_vto,
        atraso,
        cuota,
        importe,
        saldo
    ) VALUES (
        p_idpago,
        p_idcuotas_detalle,
        p_tipo_pago,
        p_idconcepto,
        p_concepto,
        p_orden,
        p_orden_char,
        p_fecha_vto,
        p_atraso,
        p_cuota,
        p_importe,
        p_saldo
    );
    
    IF p_tipo_pago = 'CUOTA' THEN
        -- Obtener el idcuotas para actualizar la cabecera
        SELECT idcuotas INTO v_idcuotas
        FROM cuotas_detalle 
        WHERE idcuotas_detalle = p_idcuotas_detalle;
        
        -- Actualizar el detalle de la cuota
        UPDATE cuotas_detalle 
        SET 
            saldo_cuota = saldo_cuota - p_importe,
            ultimo_nro_recibo = v_nro_recibo,
            ultimo_atraso = p_atraso,
            ultimo_importe = COALESCE(ultimo_importe, 0) + p_importe,
            ultima_Fecha_pago = v_fecha_pago,
            ultimo_interes_calcu = COALESCE(ultimo_interes_calcu, 0) + (p_importe - (p_cuota - p_saldo)), -- Cálculo del interés
            ultimo_descuento = COALESCE(ultimo_descuento, 0) + (p_cuota - p_saldo - p_importe), -- Cálculo del descuento
            ultimo_totalac = COALESCE(ultimo_totalac, 0) + p_importe,
            estado = CASE WHEN saldo_cuota  <= 0 THEN 'CAN' ELSE 'PEN' END
        WHERE idcuotas_detalle = p_idcuotas_detalle;
       
        
        -- LÓGICA PARA ACTUALIZAR CABECERA DE CUOTAS
        -- Calcular el saldo total sumando todos los saldos_cuota de esta cuota.
        
        SELECT COALESCE(SUM(saldo_cuota), 0) INTO v_total_saldo
        FROM cuotas_detalle 
        WHERE idcuotas = v_idcuotas;
        
        -- Obtener el saldo actual de la cabecera
        SELECT saldo_actual INTO v_saldo_cabecera
        FROM cuotas 
        WHERE idcuotas = v_idcuotas;
        
        -- Actualizar la cabecera de cuotas
        UPDATE cuotas 
        SET 
            saldo_actual = v_total_saldo,
            -- Mantener los últimos valores de pago (estos se actualizan desde pagos_cuotas)
            estado = CASE WHEN v_total_saldo <= 0 THEN 'CAN' ELSE 'PEN' END,
            fecha_cancela = CASE WHEN v_total_saldo <= 0 THEN v_fecha_pago ELSE fecha_cancela END,
            -- Actualizar campos de último pago si este pago es más reciente
            ultimo_fecha_pago = CASE WHEN v_fecha_pago > COALESCE(ultimo_fecha_pago, '1900-01-01') THEN v_fecha_pago ELSE ultimo_fecha_pago END,
            ultimo_importe = CASE WHEN v_fecha_pago > COALESCE(ultimo_fecha_pago, '1900-01-01') THEN p_importe ELSE ultimo_importe END
        WHERE idcuotas = v_idcuotas;
        
    END IF;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `reporte_cierre_caja_detallado` */

/*!50003 DROP PROCEDURE IF EXISTS  `reporte_cierre_caja_detallado` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `reporte_cierre_caja_detallado`(
    IN fecha_cierre DATE,
    IN id_personal INT,
    IN id_sucursal INT
)
BEGIN
    DECLARE total_ingresos DECIMAL(15,2);
    DECLARE total_egresos DECIMAL(15,2);
    DECLARE saldo_final DECIMAL(15,2);
    DECLARE monto_apertura DECIMAL(15,2);
    DECLARE diferencia DECIMAL(15,2);
    
    -- 1. INFORMACIÓN DE APERTURA DE CAJA
    SELECT '=== INFORMACIÓN DE APERTURA ===' as seccion;
    
    SELECT 
        ac.idapecierre,
        ac.fechaape,
        ac.horaape,
        ac.montoape as monto_apertura,
        p.nombre,
        p.apellido,
        s.sucursal
    FROM apecierrecaja ac
    INNER JOIN personal p ON ac.idpersonal = p.idPersonal
    INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
    WHERE DATE(ac.fechaape) = fecha_cierre
        AND ac.estado = 'C'
        AND (id_personal = 0 OR ac.idpersonal = id_personal)
        AND (id_sucursal = 0 OR s.idsucursal = id_sucursal);
    
    -- 2. DETALLE DE INGRESOS POR CONCEPTO
    SELECT '=== INGRESOS DETALLADOS ===' as seccion;
    
    SELECT 
        cc.concepto,
        COUNT(*) as cantidad_operaciones,
        SUM(m.monto) as total_concepto,
        GROUP_CONCAT(CONCAT(m.operacion, ' - ', m.Nro_comprobante, ' - Gs. ', FORMAT(m.monto, 0)) SEPARATOR ' | ') as detalle_operaciones
    FROM mov_operacion m
    INNER JOIN concepto_caja cc ON m.idconcepto = cc.idconcepto
    WHERE DATE(m.fecha) = fecha_cierre
        AND m.tipo = 'I'
        AND (id_sucursal = 0 OR m.idsucursal = id_sucursal)
    GROUP BY cc.concepto, cc.idconcepto
    ORDER BY total_concepto DESC;
    
    -- 3. DETALLE DE EGRESOS POR CONCEPTO
    SELECT '=== EGRESOS DETALLADOS ===' as seccion;
    
    SELECT 
        cc.concepto,
        COUNT(*) as cantidad_operaciones,
        SUM(m.monto) as total_concepto,
        GROUP_CONCAT(CONCAT(m.operacion, ' - ', m.Nro_comprobante, ' - Gs. ', FORMAT(m.monto, 0)) SEPARATOR ' | ') as detalle_operaciones
    FROM mov_operacion m
    INNER JOIN concepto_caja cc ON m.idconcepto = cc.idconcepto
    WHERE DATE(m.fecha) = fecha_cierre
        AND m.tipo = 'E'
        AND (id_sucursal = 0 OR m.idsucursal = id_sucursal)
    GROUP BY cc.concepto, cc.idconcepto
    ORDER BY total_concepto DESC;
    
    -- 4. VENTAS DETALLADAS
    SELECT '=== VENTAS DEL DÍA ===' as seccion;
    
    SELECT 
        v.tipo,
        CASE 
            WHEN v.tipo = 0 THEN 'CONTADO'
            WHEN v.tipo = 2 THEN 'CRÉDITO'
            ELSE 'OTRO'
        END as tipo_venta,
        COUNT(*) as cantidad_ventas,
        SUM(v.total) as total_ventas,
        SUM(v.total_liqui_iva) as total_iva,
        GROUP_CONCAT(CONCAT(v.nrofactura, ' - Gs. ', FORMAT(v.total, 0)) SEPARATOR ' | ') as detalle_facturas
    FROM venta v
    WHERE DATE(v.fecha) = fecha_cierre
        AND v.estado = 'F'
        AND (id_sucursal = 0 OR v.idsucursal = id_sucursal)
    GROUP BY v.tipo
    ORDER BY total_ventas DESC;
    
    -- 5. COBROS DETALLADOS
    SELECT '=== COBROS DE CUOTAS ===' as seccion;
    
    SELECT 
        COUNT(*) as cantidad_recibos,
        SUM(pc.total_importe) as total_cobrado,
        SUM(pc.total_interes) as total_interes,
        SUM(pc.total_descuento) as total_descuento,
        SUM(pc.total_ac) as total_ac,
        GROUP_CONCAT(CONCAT('Recibo ', pc.nro_recibo, ' - Gs. ', FORMAT(pc.total_ac, 0)) SEPARATOR ' | ') as detalle_recibos
    FROM pagos_cuotas pc
    WHERE DATE(pc.fecha) = fecha_cierre
        AND pc.estado = 'COB'
        AND (id_sucursal = 0 OR pc.idsucursal = id_sucursal);
    
    -- 6. COMPRAS DETALLADAS
    SELECT '=== COMPRAS DEL DÍA ===' as seccion;
    
    SELECT 
        c.tipo,
        CASE 
            WHEN c.tipo = 1 THEN 'CONTADO'
            WHEN c.tipo = 2 THEN 'CRÉDITO'
            ELSE 'OTRO'
        END as tipo_compra,
        COUNT(*) as cantidad_compras,
        SUM(c.total) as total_compras,
        SUM(c.total_liqui_iva) as total_iva,
        pr.proveedor,
        GROUP_CONCAT(CONCAT(c.nro_factura, ' - Gs. ', FORMAT(c.total, 0)) SEPARATOR ' | ') as detalle_facturas
    FROM compra c
    INNER JOIN proveedor pr ON c.idproveedor = pr.idproveedor
    WHERE DATE(c.fecha) = fecha_cierre
        AND c.estado = 'F'
        AND (id_sucursal = 0 OR c.idsucursal = id_sucursal)
    GROUP BY c.tipo, pr.proveedor
    ORDER BY total_compras DESC;
    
    -- 7. RESUMEN FINAL
    SELECT '=== RESUMEN FINAL ===' as seccion;
    
    -- Calcular totales
    SELECT COALESCE(SUM(monto), 0) INTO total_ingresos
    FROM mov_operacion 
    WHERE DATE(fecha) = fecha_cierre 
        AND tipo = 'I'
        AND (id_sucursal = 0 OR idsucursal = id_sucursal);
    
    SELECT COALESCE(SUM(monto), 0) INTO total_egresos
    FROM mov_operacion 
    WHERE DATE(fecha) = fecha_cierre 
        AND tipo = 'E'
        AND (id_sucursal = 0 OR idsucursal = id_sucursal);
    
    -- Obtener monto de apertura
    SELECT COALESCE(montoape, 0) INTO monto_apertura
    FROM apecierrecaja 
    WHERE DATE(fechaape) = fecha_cierre 
        AND estado = 'C'
        AND (id_personal = 0 OR idpersonal = id_personal)
    ORDER BY idapecierre DESC 
    LIMIT 1;
    
    -- Calcular saldo final y diferencia
    SET saldo_final = monto_apertura + total_ingresos - total_egresos;
    SET diferencia = saldo_final - monto_apertura; -- Diferencia entre lo teórico y lo real
    
    -- Mostrar resumen
    SELECT 
        fecha_cierre as fecha,
        monto_apertura as monto_inicial,
        total_ingresos as total_ingresos,
        total_egresos as total_egresos,
        saldo_final as saldo_final_teorico,
        diferencia as diferencia,
        CASE 
            WHEN diferencia > 0 THEN 'SOBRANTE'
            WHEN diferencia < 0 THEN 'FALTANTE'
            ELSE 'CUADRADO'
        END as estado_caja,
        ROUND((diferencia / NULLIF(monto_apertura, 0)) * 100, 2) as porcentaje_diferencia;
        
    -- 8. MOVIMIENTOS POR FORMA DE PAGO
    SELECT '=== MOVIMIENTOS POR FORMA DE PAGO ===' as seccion;
    
    SELECT 
        tp.tipo as forma_pago,
        COUNT(*) as cantidad_operaciones,
        SUM(m.monto) as total_forma_pago,
        m.tipo as tipo_movimiento
    FROM mov_operacion m
    INNER JOIN tipo_pago tp ON m.idformapago = tp.idTipo_pago
    WHERE DATE(m.fecha) = fecha_cierre
        AND (id_sucursal = 0 OR m.idsucursal = id_sucursal)
        AND m.idformapago > 0
    GROUP BY tp.tipo, m.tipo
    ORDER BY m.tipo, total_forma_pago DESC;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `reporte_movimientos_caja_detallado` */

/*!50003 DROP PROCEDURE IF EXISTS  `reporte_movimientos_caja_detallado` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `reporte_movimientos_caja_detallado`(
    IN fecha_desde DATE,
    IN fecha_hasta DATE,
    IN id_sucursal INT,
    IN id_concepto INT,
    IN tipo_movimiento CHAR(1)  -- 'I'=Ingresos, 'E'=Egresos, 'T'=Todos
)
BEGIN
    SELECT 
        -- INFORMACIÓN BÁSICA DEL MOVIMIENTO
        m.idMov as id_movimiento,
        m.fecha,
        m.operacion,
        m.Nro_comprobante,
        m.monto,
        m.tipo,
        CASE 
            WHEN m.tipo = 'I' THEN 'INGRESO'
            WHEN m.tipo = 'E' THEN 'EGRESO'
            ELSE m.tipo
        END as tipo_descripcion,
        
        -- CONCEPTO
        cc.idconcepto,
        cc.concepto,
        cc.tipo as tipo_concepto,
        
        -- INFORMACIÓN DE CLIENTE/PROVEEDOR
        CASE 
            WHEN m.idcliente IS NOT NULL AND m.idcliente > 0 THEN 'CLIENTE'
            WHEN m.idproveedor IS NOT NULL AND m.idproveedor > 0 THEN 'PROVEEDOR'
            ELSE 'SIN RELACIÓN'
        END as tipo_entidad,
        
        COALESCE(
            CASE 
                WHEN m.idcliente IS NOT NULL AND m.idcliente > 0 THEN 
                    CONCAT(cli.nombre, ' ', cli.apellido, ' (CI: ', cli.ci, ')')
                WHEN m.idproveedor IS NOT NULL AND m.idproveedor > 0 THEN 
                    CONCAT(prov.proveedor, ' (RUC: ', prov.ruc, ')')
                ELSE 'N/A'
            END, 'N/A'
        ) as entidad_nombre,
        
        COALESCE(
            CASE 
                WHEN m.idcliente IS NOT NULL AND m.idcliente > 0 THEN cli.ci
                WHEN m.idproveedor IS NOT NULL AND m.idproveedor > 0 THEN prov.ruc
                ELSE NULL
            END, 'N/A'
        ) as documento_entidad,
        
        -- INFORMACIÓN DE PERSONAL
        COALESCE(CONCAT(p.nombre, ' ', p.apellido), 'SIN ASIGNAR') as personal_nombre,
        
        -- FORMA DE PAGO
        COALESCE(tp.tipo, 'NO ESPECIFICADO') as forma_pago,
        
        -- INFORMACIÓN ADICIONAL
        m.descripcion,
        s.sucursal,
        e.empresa,
        m.tipo_venta,
        
        -- CLASIFICACIÓN PARA REPORTES
        CASE 
            WHEN m.tipo = 'I' THEN m.monto
            ELSE 0
        END as monto_ingreso,
        
        CASE 
            WHEN m.tipo = 'E' THEN m.monto
            ELSE 0
        END as monto_egreso,
        
        -- DETALLE COMPLETO PARA FILTRAR
        CONCAT(
            'Mov: ', m.operacion, 
            ' | Comp: ', COALESCE(m.Nro_comprobante, 'SIN COMPROBANTE'),
            ' | Monto: Gs. ', FORMAT(m.monto, 0),
            ' | Tipo: ', CASE WHEN m.tipo = 'I' THEN 'INGRESO' ELSE 'EGRESO' END,
            ' | Concepto: ', cc.concepto,
            CASE 
                WHEN m.idcliente IS NOT NULL AND m.idcliente > 0 THEN 
                    CONCAT(' | Cliente: ', cli.nombre, ' ', cli.apellido)
                WHEN m.idproveedor IS NOT NULL AND m.idproveedor > 0 THEN 
                    CONCAT(' | Proveedor: ', prov.proveedor)
                ELSE ''
            END
        ) as detalle_completo
        
    FROM mov_operacion m
    INNER JOIN concepto_caja cc ON m.idconcepto = cc.idconcepto
    INNER JOIN sucursal s ON m.idsucursal = s.idsucursal
    INNER JOIN empresa e ON m.idEmpresa = e.idEmpresa
    LEFT JOIN cliente cli ON m.idcliente = cli.idcliente
    LEFT JOIN proveedor prov ON m.idproveedor = prov.idproveedor
    LEFT JOIN personal p ON m.idpersonal = p.idPersonal
    LEFT JOIN tipo_pago tp ON m.idformapago = tp.idTipo_pago
    
    WHERE m.fecha BETWEEN fecha_desde AND fecha_hasta
        -- FILTROS
        AND (id_sucursal = 0 OR m.idsucursal = id_sucursal)
        AND (id_concepto = 0 OR m.idconcepto = id_concepto)
        AND (
            tipo_movimiento = 'T' OR  -- Todos
            (tipo_movimiento = 'I' AND m.tipo = 'I') OR  -- Solo ingresos
            (tipo_movimiento = 'E' AND m.tipo = 'E')     -- Solo egresos
        )
    
    ORDER BY 
        m.fecha DESC,
        m.tipo DESC,
        m.monto DESC;
        
    -- RESUMEN AL FINAL
    SELECT 
        'RESUMEN' as tipo,
        COUNT(*) as cantidad_movimientos,
        SUM(CASE WHEN m.tipo = 'I' THEN m.monto ELSE 0 END) as total_ingresos,
        SUM(CASE WHEN m.tipo = 'E' THEN m.monto ELSE 0 END) as total_egresos,
        SUM(CASE WHEN m.tipo = 'I' THEN m.monto ELSE -m.monto END) as saldo_neto,
        fecha_desde as periodo_desde,
        fecha_hasta as periodo_hasta
    FROM mov_operacion m
    WHERE m.fecha BETWEEN fecha_desde AND fecha_hasta
        AND (id_sucursal = 0 OR m.idsucursal = id_sucursal)
        AND (id_concepto = 0 OR m.idconcepto = id_concepto)
        AND (
            tipo_movimiento = 'T' OR
            (tipo_movimiento = 'I' AND m.tipo = 'I') OR
            (tipo_movimiento = 'E' AND m.tipo = 'E')
        );
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_actualizar_clave_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_actualizar_clave_usuario` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_actualizar_clave_usuario`(
    IN p_idusuario INT,
    IN p_nueva_clave VARCHAR(48)
)
BEGIN
    UPDATE usuario 
    SET clave = p_nueva_clave
    WHERE idusuario = p_idusuario;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_antiguedad_cuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_antiguedad_cuotas` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_antiguedad_cuotas`(
    IN p_fecha_corte DATE,
    IN p_idvendedor INT,
    IN p_idplan_cuota INT
)
BEGIN
    -- Consulta principal de antigüedad de cuotas
    SELECT 
        CONCAT(cli.ci, ' ', cli.nombre, ' ', cli.apellido) AS Cliente,
        COALESCE(cli.telefono, cli.celular, '') AS Telefono,
        
        -- A Vencer (cuotas con vencimiento futuro)
        SUM(CASE WHEN cd.fecha_vto > p_fecha_corte THEN cd.saldo_cuota ELSE 0 END) AS 'A_vencer',
        
        -- 0-30 Días
        SUM(CASE WHEN cd.fecha_vto <= p_fecha_corte 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 30 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS '0_30_Dias',
        
        -- 31-60 Días
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 30 DAY) 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 60 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS '31_60_Dias',
        
        -- 61-90 Días
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 60 DAY) 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 90 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS '61_90_Dias',
        
        -- +90 Días
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 90 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS 'Mas_90_Dias',
        
        -- Total Estado
        SUM(cd.saldo_cuota) AS Total_Estado,
        
        -- Estado fijo como en la imagen
        'Activo' AS Estado
        
    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cli ON c.idcliente = cli.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN articulo art ON v.idVenta = c.idVenta
    INNER JOIN empresa emp ON v.idEmpresa = emp.idEmpresa
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    
    WHERE cd.estado = 'PEN'  -- Solo cuotas pendientes
      AND cd.saldo_cuota > 0 -- Con saldo pendiente
      
      -- Filtros opcionales
      AND (p_idvendedor IS NULL OR v.idVendedor = p_idvendedor)
      
      AND (p_idplan_cuota IS NULL OR art.idplan_cuota = p_idplan_cuota)
    
    GROUP BY cli.idcliente
    
    HAVING SUM(cd.saldo_cuota) > 0  -- Solo clientes con saldo pendiente
    
    ORDER BY cli.nombre, cli.apellido;
    
    -- Totales generales
    SELECT 
        SUM(CASE WHEN cd.fecha_vto > p_fecha_corte THEN cd.saldo_cuota ELSE 0 END) AS Total_A_vencer,
        SUM(CASE WHEN cd.fecha_vto <= p_fecha_corte 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 30 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS Total_0_30_Dias,
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 30 DAY) 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 60 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS Total_31_60_Dias,
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 60 DAY) 
                 AND cd.fecha_vto >= DATE_SUB(p_fecha_corte, INTERVAL 90 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS Total_61_90_Dias,
        SUM(CASE WHEN cd.fecha_vto < DATE_SUB(p_fecha_corte, INTERVAL 90 DAY) 
                 THEN cd.saldo_cuota ELSE 0 END) AS Total_Mas_90_Dias,
        SUM(cd.saldo_cuota) AS Total_General
    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cli ON c.idcliente = cli.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN articulo art ON v.idVenta = c.idVenta
    WHERE cd.estado = 'PEN'
      AND cd.saldo_cuota > 0
      AND (p_idvendedor IS NULL OR v.idVendedor = p_idvendedor)
      AND (p_idplan_cuota IS NULL OR art.idplan_cuota = p_idplan_cuota);
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_antiguedad_saldos` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_antiguedad_saldos` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_antiguedad_saldos`(
    IN p_idcobrador INT,
    IN p_fecha_corte DATE
)
BEGIN
    SELECT 
        e.empresa,
        s.sucursal AS nombre_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        c.ci AS ci_cliente,
        CONCAT(c.nombre, ' ', c.apellido)                      AS cliente,
        c.celular               			       AS telefonos,
        z.idzona					       AS idzona,
        z.zona                                                 AS zona,
        -- Datos del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pers.nombre), ' ', TRIM(pers.apellido))    AS nombre_cobrador,
        pers.ci                                                AS ci_cobrador,
        -- Antigüedad de saldos
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 0 AND 30 THEN cd.saldo_cuota ELSE 0 END) AS _0_30_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 31 AND 60 THEN cd.saldo_cuota ELSE 0 END) AS _31_60_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 61 AND 90 THEN cd.saldo_cuota ELSE 0 END) AS _61_90_dias,
        SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) > 90 THEN cd.saldo_cuota ELSE 0 END) AS mas_90_dias,
        -- SUMA TOTAL DE TODAS LAS ANTIGÜEDADES
        (SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 0 AND 30 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 31 AND 60 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) BETWEEN 61 AND 90 THEN cd.saldo_cuota ELSE 0 END) +
         SUM(CASE WHEN DATEDIFF(p_fecha_corte, cd.fecha_vto) > 90 THEN cd.saldo_cuota ELSE 0 END)) AS total_antiguedades,
        SUM(cd.saldo_cuota)                                     AS total_pendiente,
        SUM(CASE WHEN cd.fecha_vto >= p_fecha_corte THEN cd.saldo_cuota ELSE 0 END) AS cuotas_a_vencer,
        'Activo'                                                AS estado
    FROM cliente c
    INNER JOIN zona z ON z.idzona = c.idzona
    INNER JOIN cuotas cu ON cu.idcliente = c.idcliente
    INNER JOIN venta v ON v.idVenta = cu.idVenta
    INNER JOIN cuotas_detalle cd ON cd.idcuotas = cu.idcuotas
    INNER JOIN empresa e ON e.idEmpresa = v.idEmpresa
    INNER JOIN sucursal s ON s.idsucursal = v.idsucursal
    -- JOIN para cobrador
    LEFT JOIN cobrador cob ON cob.idcobrador = v.idcobrador
    LEFT JOIN personal pers ON pers.idPersonal = cob.idPersonal
    WHERE cd.estado = 'PEN'
      AND (p_idcobrador = 0 OR v.idcobrador = p_idcobrador)
    GROUP BY c.idcliente, cob.idcobrador, pers.nombre, pers.apellido, pers.ci
    ORDER BY nombre_cobrador, cliente;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_anular_recibo` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_anular_recibo` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_anular_recibo`(
    IN p_idpago INT,
    IN p_motivo VARCHAR(100),
    IN p_idusuario INT
)
BEGIN
    DECLARE v_existe_pago INT DEFAULT 0;
    
    SELECT COUNT(*) INTO v_existe_pago 
    FROM pagos_cuotas 
    WHERE idpago = p_idpago AND estado = 'COB';
    
    IF v_existe_pago = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El recibo no existe o ya está anulado';
    ELSE
        -- Usando el nombre correcto del campo si lo corriges
        INSERT INTO anulacion_recibo (fecha, motivo, idpago, idusuario)
        VALUES (NOW(), p_motivo, p_idpago, p_idusuario);
        
        UPDATE pagos_cuotas 
        SET estado = 'ANU' 
        WHERE idpago = p_idpago;
        
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_consultar_estado_cuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_consultar_estado_cuotas` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_consultar_estado_cuotas`(
    IN p_tipo_consulta ENUM('VENCIDAS', 'POR_VENCER', 'AL_DIA', 'TODAS'),
    IN p_dias_vencimiento INT,
    IN p_idsucursal INT,
    IN p_idcliente INT
)
BEGIN
    SELECT 
        -- Datos de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        e.telefono AS telefono_empresa,
        
        -- Datos de la sucursal
        s.idsucursal,
        s.sucursal AS nombre_sucursal,
        s.ciudad AS ciudad_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Datos del cliente
        c.idcliente,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        z.zona AS zona_cliente,
        b.barrio AS barrio_cliente,
        
        -- Datos de la venta
        v.idVenta,
        v.fecha AS fecha_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.total AS total_venta,
        
        -- Datos de la cuota general
        cu.idcuotas,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_pendiente,
        cu.cantidad_cuota AS total_cuotas,
        
        -- Datos del detalle de cuota específico
        cd.idcuotas_detalle,
        cd.orden_cuota,
        cd.orden_char,
        cd.fecha_vto,
        cd.cuota AS monto_cuota,
        cd.saldo_cuota AS saldo_cuota,
        cd.estado AS estado_cuota,
        
        -- Cálculos de vencimiento
        DATEDIFF(CURDATE(), cd.fecha_vto) AS dias_vencido,
        DATEDIFF(cd.fecha_vto, CURDATE()) AS dias_para_vencer,
        
        -- Clasificación
        CASE 
            WHEN cd.estado = 'CAN' THEN 'CANCELADA'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' THEN 'VENCIDA'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' THEN 'POR VENCER'
            ELSE 'INDEFINIDO'
        END AS situacion,
        
        -- Estado del cliente (AL DÍA o MOROSO)
        CASE 
            WHEN NOT EXISTS (
                SELECT 1 
                FROM cuotas_detalle cd2 
                INNER JOIN cuotas cu2 ON cd2.idcuotas = cu2.idcuotas
                INNER JOIN venta v2 ON cu2.idVenta = v2.idVenta
                WHERE cd2.estado = 'PEN'
                AND cu2.anulado = 'NO'
                AND v2.estado = 'F'
                AND cd2.fecha_vto < CURDATE()  -- Tiene cuotas vencidas
                AND v2.idcliente = c.idcliente
                AND (p_idsucursal IS NULL OR v2.idsucursal = p_idsucursal)
            ) THEN 'AL DÍA'
            ELSE 'MOROSO'
        END AS estado_cliente,
        
        -- Nivel de mora
        CASE 
            WHEN cd.estado = 'CAN' THEN 'PAGADA'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) <= 15 THEN 'MORA LEVE (1-15 días)'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) BETWEEN 16 AND 30 THEN 'MORA MODERADA (16-30 días)'
            WHEN cd.fecha_vto < CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(CURDATE(), cd.fecha_vto) > 30 THEN 'MORA GRAVE (+30 días)'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' AND DATEDIFF(cd.fecha_vto, CURDATE()) <= 7 THEN 'POR VENCER (<= 7 días)'
            WHEN cd.fecha_vto >= CURDATE() AND cd.estado = 'PEN' THEN 'AL DÍA'
            ELSE 'SIN CLASIFICAR'
        END AS nivel_mora,
        
        -- Datos del cobrador
        cob.idcobrador,
        CONCAT(pc.nombre, ' ', pc.apellido) AS cobrador_nombre,
        pc.ci AS cobrador_ci,
        pc.telefono AS cobrador_telefono
        
    FROM cuotas_detalle cd
    INNER JOIN cuotas cu ON cd.idcuotas = cu.idcuotas
    INNER JOIN venta v ON cu.idVenta = v.idVenta
    INNER JOIN cliente c ON v.idcliente = c.idcliente
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa  -- JOIN con empresa
    INNER JOIN zona z ON c.idzona = z.idzona
    INNER JOIN barrio b ON c.idbarrio = b.idbarrio
    LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
    LEFT JOIN personal pc ON cob.idPersonal = pc.idPersonal
    WHERE cd.estado = 'PEN'  -- Solo cuotas pendientes
    AND cu.anulado = 'NO'    -- Cuotas no anuladas
    AND v.estado = 'F'       -- Ventas facturadas
    AND (p_idsucursal IS NULL OR v.idsucursal = p_idsucursal)
    AND (p_idcliente IS NULL OR v.idcliente = p_idcliente)
    AND (
        (p_tipo_consulta = 'VENCIDAS' AND cd.fecha_vto < CURDATE()) OR
        (p_tipo_consulta = 'POR_VENCER' AND cd.fecha_vto >= CURDATE()) OR
        (p_tipo_consulta = 'AL_DIA' AND NOT EXISTS (
            SELECT 1 
            FROM cuotas_detalle cd3 
            INNER JOIN cuotas cu3 ON cd3.idcuotas = cu3.idcuotas
            INNER JOIN venta v3 ON cu3.idVenta = v3.idVenta
            WHERE cd3.estado = 'PEN'
            AND cu3.anulado = 'NO'
            AND v3.estado = 'F'
            AND cd3.fecha_vto < CURDATE()
            AND v3.idcliente = c.idcliente
            AND (p_idsucursal IS NULL OR v3.idsucursal = p_idsucursal)
        )) OR
        (p_tipo_consulta = 'TODAS')
    )
    AND (
        p_dias_vencimiento IS NULL OR
        (p_tipo_consulta = 'VENCIDAS' AND DATEDIFF(CURDATE(), cd.fecha_vto) <= p_dias_vencimiento) OR
        (p_tipo_consulta = 'POR_VENCER' AND DATEDIFF(cd.fecha_vto, CURDATE()) <= p_dias_vencimiento) OR
        (p_tipo_consulta = 'AL_DIA')
    )
    ORDER BY 
        DATEDIFF(CURDATE(), cd.fecha_vto) DESC,  -- Vencidas: más días de mora primero
        c.nombre, c.apellido,                    -- Cliente
        cd.fecha_vto,                            -- Fecha vencimiento
        v.idVenta;                               -- ID venta
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_consultar_pagare` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_consultar_pagare` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_consultar_pagare`(
    IN p_idventa INT
)
BEGIN
    DECLARE v_productos TEXT;
    DECLARE v_monto_total DECIMAL(10,2);
    DECLARE v_interes_mensual DECIMAL(10,2);
    
    -- Obtener datos de productos y montos
    SELECT 
        GROUP_CONCAT(
            CONCAT(
                dv.cantidad, 'x ',
                a.descripcion,
                ' (', m.Marca, ')'
            ) SEPARATOR '; '
        ),
        SUM(dv.subtotal),
        MAX(a.interes_mensual)
    INTO 
        v_productos,
        v_monto_total,
        v_interes_mensual
    FROM detalle_venta dv
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    INNER JOIN marca m ON a.idMarca = m.idMarca
    WHERE dv.idVenta = p_idventa;
    
    
    -- Consulta principal
    SELECT 
        -- Encabezado del pagaré
        CONCAT('PAG-', v.idVenta) AS numero_pagare,
        
        -- Formato con puntos para separadores de unidades
        REPLACE(FORMAT(v.total, 0), ',', '.') AS monto_total_formateado,
        v.total AS monto_total,
        
        DATE_FORMAT(v.fecha_vto_pagare, '%d/%m/%Y') AS vencimiento_formateado,
        COALESCE(s.ciudad, 'Asunción') AS ciudad_emision,
        DATE_FORMAT(v.fecha, '%d') AS dia_emision,
        CASE 
            WHEN DATE_FORMAT(v.fecha, '%M') = 'January' THEN 'Enero'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'February' THEN 'Febrero'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'March' THEN 'Marzo'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'April' THEN 'Abril'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'May' THEN 'Mayo'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'June' THEN 'Junio'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'July' THEN 'Julio'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'August' THEN 'Agosto'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'September' THEN 'Septiembre'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'October' THEN 'Octubre'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'November' THEN 'Noviembre'
            WHEN DATE_FORMAT(v.fecha, '%M') = 'December' THEN 'Diciembre'
            ELSE 'Indefinido'
        END AS mes_emision,
        DATE_FORMAT(v.fecha, '%Y') AS ano_emision,
        
        -- Texto del cuerpo del pagaré
        DATE_FORMAT(v.fecha_vto_pagare, '%d') AS dia_vencimiento_texto,
        CASE 
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'January' THEN 'Enero'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'February' THEN 'Febrero'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'March' THEN 'Marzo'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'April' THEN 'Abril'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'May' THEN 'Mayo'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'June' THEN 'Junio'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'July' THEN 'Julio'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'August' THEN 'Agosto'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'September' THEN 'Septiembre'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'October' THEN 'Octubre'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'November' THEN 'Noviembre'
            WHEN DATE_FORMAT(v.fecha_vto_pagare, '%M') = 'December' THEN 'Diciembre'
            ELSE 'Indefinido'
        END AS mes_vencimiento_texto,
        DATE_FORMAT(v.fecha_vto_pagare, '%Y') AS ano_vencimiento_texto,  -- AÑO DE VENCIMIENTO AGREGADO
        
        e.empresa AS nombre_empresa,
        
        -- Monto en guaraníes formateado con puntos
        REPLACE(FORMAT(v.total, 0), ',', '.') AS monto_guaranies_formateado,
        v_productos AS descripcion_valor_recibido,
        
        -- Intereses
        COALESCE(v_interes_mensual, 3.0) AS interes_compensatorio,
        COALESCE(v_interes_mensual, 3.0) AS interes_moratorio,
        2.0 AS comision_retardo,
        
        -- Datos del deudor (PRIMERA FIRMA)
        CONCAT(TRIM(c.nombre), ' ', TRIM(c.apellido)) AS deudor_nombre,
        CONCAT(TRIM(b.barrio), ' - ', TRIM(z.zona)) AS deudor_domicilio,
        c.ci AS deudor_cedula,
        COALESCE(c.celular, c.telefono, 'No tiene') AS deudor_telefono,
        
        -- Datos del codeudor (SEGUNDA FIRMA - vacíos por defecto)
        '' AS codeudor_nombre,
        '' AS codeudor_domicilio,
        '' AS codeudor_cedula,
        '' AS codeudor_telefono2,
        
        
        -- Datos adicionales
        v.idVenta,
        v.fecha AS fecha_venta,
        v.fecha_vto_pagare AS fecha_vencimiento_pagare,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        cu.cantidad_cuota,
        (SELECT cuota FROM cuotas_detalle WHERE idcuotas = cu.idcuotas ORDER BY orden_cuota LIMIT 1) AS monto_cuota,
        
        -- Campos adicionales para mayor flexibilidad
        DATE_FORMAT(v.fecha_vto_pagare, '%d/%m/%Y') AS fecha_vencimiento_completa,
        DATE_FORMAT(v.fecha, '%d/%m/%Y') AS fecha_emision_completa
        
    FROM venta v
    INNER JOIN cliente c ON v.idcliente = c.idcliente
    INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN cuotas cu ON v.idVenta = cu.idVenta
    INNER JOIN zona z ON c.idzona = z.idzona
    INNER JOIN barrio b ON c.idbarrio = b.idbarrio
    WHERE v.idVenta = p_idventa;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_consultar_pagos_cuotas_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_consultar_pagos_cuotas_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_consultar_pagos_cuotas_detalle`(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idcobrador INT,
    IN p_idcliente INT,
    IN p_idsucursal INT
)
BEGIN
    -- Convertir 0 a NULL para los filtros
    SET p_fecha_desde = NULLIF(p_fecha_desde, '0000-00-00');
    SET p_fecha_hasta = NULLIF(p_fecha_hasta, '0000-00-00');
    SET p_idcobrador = NULLIF(p_idcobrador, 0);
    SET p_idcliente = NULLIF(p_idcliente, 0);
    SET p_idsucursal = NULLIF(p_idsucursal, 0);

    SELECT 
        -- Información del pago
        pc.idpago,
        pc.fecha AS fecha_pago,
        pc.nro_recibo,
        pc.total_importe AS total_pagado,
        pc.estado AS estado_pago,
        CASE pc.estado 
            WHEN 'COB' THEN 'COBRADO' 
            WHEN 'ANU' THEN 'ANULADO' 
        END AS estado_pago_descripcion,
        
        -- Información del cliente
        c.idcliente,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información de la venta y cuota
        v.idVenta,
        v.fecha AS fecha_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_venta,
        v.total AS total_venta,
        
        cu.idcuotas,
        cu.nrofactura AS factura_cuota,
        cu.cantidad_cuota,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_actual_cuota,
        
        -- Información del detalle del pago
        dpc.iddetalle_pagos_cuotas,
        dpc.tipo_pago,
        dpc.importe,
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 'PAGO DE CUOTA' 
            WHEN 'OTRO' THEN 'OTRO CONCEPTO' 
        END AS tipo_pago_descripcion,
        
        -- Información de la cuota específica pagada
        cd.idcuotas_detalle,
        cd.orden_cuota,
        cd.orden_char,
        cd.fecha_vto,
        CASE 
            WHEN dpc.tipo_pago = 'OTRO' THEN 0
            ELSE cd.cuota 
        END AS monto_cuota_original,
        dpc.importe AS monto_pagado,
        dpc.saldo AS saldo_despues_pago,
        dpc.atraso AS dias_atraso_pago,
        
        -- Concepto del pago
        cc.idconcepto,
        COALESCE(cc.concepto, dpc.concepto) AS concepto_pago,
        cc.tipo AS tipo_concepto,
        CASE cc.tipo 
            WHEN 'I' THEN 'INGRESO' 
            WHEN 'E' THEN 'EGRESO' 
        END AS tipo_concepto_descripcion,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', (pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la forma de pago
        tp.idTipo_pago,
        tp.tipo AS forma_pago,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal,
        s.direccion AS direccion_sucursal,
        
        -- Información de la empresa
        e.idEmpresa,
        e.empresa,
        e.ruc AS ruc_empresa,
        
        -- Información del usuario que registró el pago
        u.idusuario,
        u.nick AS usuario_registro,
        CONCAT(TRIM(pu.nombre), ' ', TRIM(pu.apellido)) AS personal_registro,
        
        -- Cálculos adicionales
        (cd.cuota - dpc.saldo) AS diferencia_pagada,
        ROUND(((cd.cuota - dpc.saldo) / cd.cuota * 100), 2) AS porcentaje_pagado,
        
        -- Datos de ubicación del cliente
        z.zona,
        b.barrio,
        CONCAT(TRIM(b.barrio), ' - ', TRIM(z.zona)) AS ubicacion_cliente
        
    FROM pagos_cuotas pc
    INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago
    INNER JOIN cliente c ON pc.idcliente = c.idcliente
    INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
    INNER JOIN personal pcob ON cob.idPersonal = pcob.idPersonal
    INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago
    INNER JOIN cuotas cu ON pc.idcuotas = cu.idcuotas
    INNER JOIN venta v ON cu.idVenta = v.idVenta
    INNER JOIN sucursal s ON pc.idsucursal = s.idsucursal
    INNER JOIN empresa e ON pc.idEmpresa = e.idEmpresa
    LEFT JOIN cuotas_detalle cd ON dpc.idcuotas_detalle = cd.idcuotas_detalle
    LEFT JOIN concepto_caja cc ON dpc.idconcepto = cc.idconcepto
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    LEFT JOIN personal pu ON u.idPersonal = pu.idPersonal
    LEFT JOIN zona z ON c.idzona = z.idzona
    LEFT JOIN barrio b ON c.idbarrio = b.idbarrio
    WHERE pc.estado = 'COB'  -- Solo pagos cobrados (no anulados)
    AND (p_fecha_desde IS NULL OR pc.fecha >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR pc.fecha <= p_fecha_hasta)
    AND (p_idcobrador IS NULL OR cob.idcobrador = p_idcobrador)
    AND (p_idcliente IS NULL OR c.idcliente = p_idcliente)
    AND (p_idsucursal IS NULL OR s.idsucursal = p_idsucursal)
    ORDER BY 
        CASE 
            WHEN dpc.tipo_pago = 'CUOTA' THEN 1
            WHEN dpc.tipo_pago = 'OTRO' THEN 2
            ELSE 3
        END,        
        pc.fecha DESC,
        c.nombre, c.apellido,
        cd.orden_cuota;
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_consultar_pago_cuotas_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_consultar_pago_cuotas_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_consultar_pago_cuotas_detalle`(
    IN p_idpago INT
)
BEGIN
    SELECT 
        -- Información del pago
        pc.idpago,
        pc.fecha AS fecha_pago,
        pc.nro_recibo,
        pc.total_importe AS total_pagado,
        pc.estado AS estado_pago,
        CASE pc.estado 
            WHEN 'COB' THEN 'COBRADO' 
            WHEN 'ANU' THEN 'ANULADO' 
        END AS estado_pago_descripcion,
        
        -- Información del cliente
        c.idcliente,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(TRIM(c.nombre), ' ', TRIM(c.apellido)) AS cliente_nombre_completo,
        c.ci AS cliente_ci,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', (pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la forma de pago
        tp.idTipo_pago,
        tp.tipo AS forma_pago,
        
        -- Información de la venta y cuota
        cu.idcuotas,
        cu.nrofactura AS factura_cuota,
        v.idVenta,
        v.nrofactura AS nro_factura_venta,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.fecha AS fecha_venta,
        v.total AS total_venta,
        cu.total_venta AS total_financiado,
        cu.saldo_actual AS saldo_actual_cuota,
        
        -- Información del detalle del pago
        dpc.iddetalle_pagos_cuotas,
        dpc.tipo_pago,
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 'PAGO DE CUOTA' 
            WHEN 'OTRO' THEN 'OTRO CONCEPTO' 
        END AS tipo_pago_descripcion,
        dpc.orden AS numero_cuota,
        dpc.orden_char AS numero_cuota_char,
        dpc.fecha_vto AS fecha_vencimiento,
        dpc.atraso AS dias_atraso,
        dpc.cuota AS monto_cuota_original,
        dpc.importe AS monto_pagado,
        dpc.saldo AS saldo_despues_pago,
        
        -- Información del concepto
        cc.idconcepto,
        COALESCE(cc.concepto, dpc.concepto) AS concepto_pago,
        cc.tipo AS tipo_concepto,
        CASE cc.tipo 
            WHEN 'I' THEN 'INGRESO' 
            WHEN 'E' THEN 'EGRESO' 
        END AS tipo_concepto_descripcion,
        
        -- Información de la sucursal y empresa
        s.idsucursal,
        s.sucursal,
        COALESCE(s.direccion, 'S/D') AS direccion_sucursal,
        COALESCE(s.telefono, 'S/D') AS telefono_sucursal,
        e.idEmpresa,
        e.empresa,
        e.descrip as descripcion_empresa,
        
        -- Información del usuario que registró el pago
        u.idusuario,
        u.nick AS usuario_registro,
        CONCAT(TRIM(pu.nombre), ' ', TRIM(pu.apellido)) AS personal_registro,
        
        -- Campo para ordenación (1 = CUOTA, 2 = OTRO)
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 1 
            WHEN 'OTRO' THEN 2 
        END AS orden_tipo_pago
        
    FROM pagos_cuotas pc
    INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago
    INNER JOIN cliente c ON pc.idcliente = c.idcliente
    INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
    INNER JOIN personal pcob ON cob.idPersonal = pcob.idPersonal
    INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago
    INNER JOIN cuotas cu ON pc.idcuotas = cu.idcuotas
    INNER JOIN venta v ON cu.idVenta = v.idVenta
    INNER JOIN sucursal s ON pc.idsucursal = s.idsucursal
    INNER JOIN empresa e ON pc.idEmpresa = e.idEmpresa
    LEFT JOIN concepto_caja cc ON dpc.idconcepto = cc.idconcepto
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    LEFT JOIN personal pu ON u.idPersonal = pu.idPersonal
    WHERE pc.idpago = p_idpago
    ORDER BY 
        CASE dpc.tipo_pago 
            WHEN 'CUOTA' THEN 1 
            WHEN 'OTRO' THEN 2 
        END,  -- Primero CUOTA, luego OTRO
        dpc.orden;  -- Luego por orden de cuota (si es tipo CUOTA)
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_consultar_venta` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_consultar_venta` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_consultar_venta`(
    IN p_idventa INT
)
BEGIN
    SELECT 
        -- Información de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal AS nombre_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Información del timbrado
        cnt.timbrado,
        cnt.timb_desde,
        cnt.timb_hasta,
        cnt.establecimiento,
        cnt.nro_expedicion,
        
        -- Información de la venta
        v.idVenta,
        v.fecha AS fecha_venta,
        v.hora AS hora_venta,
        v.tipo AS tipo_venta,
        CASE v.tipo 
            WHEN 'CON' THEN 'CONTADO' 
            WHEN 'CRE' THEN 'CRÉDITO' 
        END AS tipo_venta_descripcion,
        v.nrosuc,
        v.nroexp,
        v.nrofactura,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS factura_completa,
        v.estado AS estado_venta,
        CASE v.estado 
            WHEN 'F' THEN 'FACTURADO' 
            WHEN 'A' THEN 'ANULADO' 
        END AS estado_venta_descripcion,
        
        -- Totales de la venta
        v.total_gravada_excenta,
        v.total_gravada_cinco,
        v.total_gravada_diez,
        v.total AS total_venta,
        v.liqui_iva_5,
        v.liqui_iva_10,
        v.total_liqui_iva,
        
        -- Información del cliente
        c.idcliente,
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente_nombre_completo,
        COALESCE(c.ruc, c.ci) AS documento_cliente,
        c.ci AS cedula_cliente,
        c.ruc AS ruc_cliente,
        c.celular AS cliente_celular,
        c.telefono AS cliente_telefono,
        
        -- Información del vendedor
        ven.idVendedor,
        CONCAT(TRIM(pv.nombre), ' ', TRIM(pv.apellido)) AS vendedor_nombre,
        
        -- Información del detalle de venta
        dv.idDetalle,
        dv.cantidad,
        a.idarticulo,
        a.descripcion AS descripcion_articulo,
        a.codbarra AS codigo_barras,
        dv.precosto AS precio_costo,
        dv.preventa AS precio_venta,
        dv.subtotal,
        dv.iva AS iva_porcentaje,
        CASE dv.iva 
            WHEN '0' THEN 'EXENTA' 
            WHEN '5' THEN '5%' 
            WHEN '10' THEN '10%' 
        END AS iva_descripcion,
        dv.gravada_excenta,
        dv.gravada_cinco,
        dv.gravada_diez,
        dv.tipo_cuota,
        dv.plan_cuota,
        dv.cant_cuota,
        dv.monto_cuota,
        
        -- Información del artículo
        m.Marca AS marca_articulo,
        g.grupo AS grupo_articulo,
        sg.subgrupo AS subgrupo_articulo,
        a.unidad,
        
        -- Cálculos por línea
        (dv.cantidad * dv.preventa) AS total_linea,
        ROUND(((dv.preventa - dv.precosto) / dv.precosto * 100), 2) AS margen_porcentaje
        
    FROM venta v
    INNER JOIN detalle_venta dv ON v.idVenta = dv.idVenta
    INNER JOIN cliente c ON v.idcliente = c.idcliente
    INNER JOIN empresa e ON v.idEmpresa = e.idEmpresa
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN vendedor ven ON v.idVendedor = ven.idVendedor
    INNER JOIN personal pv ON ven.idPersonal = pv.idPersonal
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    LEFT JOIN marca m ON a.idMarca = m.idMarca
    LEFT JOIN grupo g ON a.idgrupo = g.idgrupo
    LEFT JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    LEFT JOIN control_numeracion_timbrado cnt ON (
        s.idsucursal = cnt.idsucursal 
        and cnt.establecimiento = v.nrosuc
        and cnt.nro_expedicion =v.nroexp
        AND cnt.tipo_documento = 'FACTURA'
        AND cnt.activo = 1
    )
    WHERE v.idVenta = p_idventa
    ORDER BY dv.idDetalle;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_dashboard_mes` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_dashboard_mes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_dashboard_mes`(
    IN pEmpresa  INT,
    IN pSucursal INT,
    IN pFecha    DATE
)
BEGIN
    DECLARE vDesde DATE;
    DECLARE vHasta DATE;

    DECLARE vTotVentasMes      DECIMAL(18,2);
    DECLARE vTotContado        DECIMAL(18,2);
    DECLARE vTotCredito        DECIMAL(18,2);

    DECLARE vTotalMesCuotas    DECIMAL(18,2);
    DECLARE vTotalCobradoMes   DECIMAL(18,2);
    DECLARE vTotalPendienteMes DECIMAL(18,2);
    DECLARE vPorcCobranza      DECIMAL(9,2);

    DECLARE vCantCuotasPendMes INT;
    DECLARE vCantCuotastotalcMes INT;
    DECLARE vCantCuotasCobMes  INT;

    /* Rango del mes de pFecha */
    SET vDesde = DATE_FORMAT(pFecha, '%Y-%m-01');
    SET vHasta = LAST_DAY(pFecha);

    /* 1) VENTAS DEL MES (TOTAL / CONTADO / CREDITO) */
    SELECT 
        IFNULL(SUM(v.total),0),
        IFNULL(SUM(CASE WHEN v.tipo='CON' THEN v.total ELSE 0 END),0),
        IFNULL(SUM(CASE WHEN v.tipo='CRE' THEN v.total ELSE 0 END),0)
    INTO
        vTotVentasMes,
        vTotContado,
        vTotCredito
    FROM venta v
    WHERE v.fecha BETWEEN vDesde AND vHasta
      AND v.estado = 'F'
      AND v.idEmpresa = pEmpresa
      AND v.idsucursal = pSucursal;

    /* 2) COBRANZAS DEL MES */
    /* Total de cuotas con vencimiento en el mes */
    SELECT IFNULL(SUM(cd.cuota),0)
    INTO vTotalMesCuotas
    FROM cuotas_detalle cd
    JOIN cuotas c ON c.idcuotas = cd.idcuotas
    WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
      AND c.anulado = 'NO';

    /* Total cobrado de esas cuotas en el mes */
    SELECT IFNULL(SUM(dpc.importe),0)
    INTO vTotalCobradoMes
    FROM detalle_pagos_cuotas dpc
    JOIN pagos_cuotas pc ON pc.idpago = dpc.idpago
    WHERE dpc.tipo_pago = 'CUOTA'
      AND dpc.fecha_vto BETWEEN vDesde AND vHasta
      AND pc.estado = 'COB'
      AND pc.idEmpresa = pEmpresa
      AND pc.idsucursal = pSucursal;

    SET vTotalPendienteMes = vTotalMesCuotas - vTotalCobradoMes;
    IF vTotalPendienteMes < 0 THEN
        SET vTotalPendienteMes = 0;
    END IF;

    IF vTotalMesCuotas > 0 THEN
        SET vPorcCobranza = (vTotalCobradoMes / vTotalMesCuotas) * 100;
    ELSE
        SET vPorcCobranza = 0;
    END IF;

    /* 3) CUOTAS PENDIENTES / VENCIDAS / COBRADAS DEL MES */

	/* 3.1) Cantidad de cuotas PENDIENTES del mes (estado PEN) */
	SELECT COUNT(*)
	INTO vCantCuotasPendMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND cd.estado = 'PEN'
	  AND c.anulado = 'NO';

	/* 3.2) Cantidad de cuotas del mes  
		(vto en el mes, ya vencidas hoy, estado PEN o CAN) */
	SELECT COUNT(*)
	INTO vCantCuotastotalcMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND c.anulado = 'NO';

	/* 3.3) Cantidad de cuotas COBRADAS del mes */
	SELECT COUNT(*)
	INTO vCantCuotasCobMes
	FROM cuotas_detalle cd
	JOIN cuotas c ON c.idcuotas = cd.idcuotas
	WHERE cd.fecha_vto BETWEEN vDesde AND vHasta
	  AND cd.estado = 'CAN'
	  AND c.anulado = 'NO';


    /* RESULTADO ÚNICO PARA EL DASHBOARD */
    SELECT
        vTotVentasMes      AS total_ventas_mes,
        vTotContado        AS total_ventas_contado,
        vTotCredito        AS total_ventas_credito,

        vTotalMesCuotas    AS total_cuotas_mes,
        vTotalCobradoMes   AS total_cobrado_mes,
        vTotalPendienteMes AS total_pendiente_mes,
        vPorcCobranza      AS porcentaje_cobranza,

        vCantCuotasPendMes   AS cantidad_cuotas_pendientes_mes,
        vCantCuotastotalcMes AS cantidad_cuotas_total_mes,
        vCantCuotasCobMes    AS cantidad_cuotas_cobradas_mes;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_extracto_cliente` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_extracto_cliente` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_extracto_cliente`(p_idventa INT)
BEGIN
    -- Variables para almacenar totales
    DECLARE v_total_venta DECIMAL(10,2);
    DECLARE v_total_pagado DECIMAL(10,2);
    DECLARE v_total_pendiente DECIMAL(10,2);
    
    -- Calcular totales primero
    SELECT 
        SUM(cd.cuota),
        SUM(CASE WHEN cd.estado = 'PEN' THEN cd.saldo_cuota ELSE 0 END)
    INTO 
        v_total_venta,
        v_total_pendiente
    FROM venta v
    INNER JOIN cuotas c ON v.idVenta = c.idVenta
    INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
    WHERE v.idVenta = p_idventa;
    
    set v_total_pagado = (v_total_venta - v_total_pendiente);
    
    -- Consulta principal con todos los datos
    SELECT 
        -- Datos de Empresa
        emp.empresa,
        emp.ruc AS empresa_ruc,
        emp.telefono AS empresa_telefono,
        
        -- Datos de Sucursal
        suc.sucursal,
        suc.direccion AS sucursal_direccion,
        suc.ciudad AS sucursal_ciudad,
        
        -- Datos del Cliente
        CONCAT(cli.ci, ' - ', cli.apellido, ', ', cli.nombre) AS cliente_info,
        CONCAT(IFNULL(TRIM(b.barrio), ''), ' - ', IFNULL(TRIM(z.zona), '')) AS direccion_cliente,
        CONCAT('Tel. ', IFNULL(cli.telefono, '-'), ' - Cel. ', IFNULL(cli.celular, '-')) AS contacto_cliente,
        
        -- Detalle de Cuotas
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS 'nro_factura',
        DATE_FORMAT(v.fecha, '%d/%m/%y') AS 'fecha_venta',
        CONCAT(cd.orden_cuota, '/', c.cantidad_cuota) AS 'orden_cuota',
        DATE_FORMAT(cd.fecha_vto, '%d/%m/%y') AS 'vto',
        CASE 
            WHEN cd.estado = 'CAN' THEN cd.ultimo_atraso
            WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto)
            ELSE 0
        END AS 'atraso',
        FORMAT(cd.cuota, 0) AS 'cuota',
        COALESCE(cd.ultimo_nro_recibo, '') AS 'ultimo_recibo',
        CASE 
            WHEN cd.ultima_Fecha_pago IS NOT NULL THEN DATE_FORMAT(cd.ultima_Fecha_pago, '%d/%m/%y')
            ELSE ''
        END AS 'fecha_pago',
        CASE 
            WHEN cd.ultimo_importe > 0 THEN FORMAT(cd.ultimo_importe, 0)
            ELSE ''
        END AS 'importe',
        FORMAT(cd.saldo_cuota, 0) AS 'saldo',
        
        -- Totales (solo en la primera fila)
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_venta, 0) ELSE '' END AS 'total_venta',
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_pagado, 0) ELSE '' END AS 'total_pagado',
        CASE WHEN cd.orden_cuota = 1 THEN FORMAT(v_total_pendiente, 0) ELSE '' END AS 'total_pendiente'
        
    FROM venta v
    INNER JOIN empresa emp ON v.idEmpresa = emp.idEmpresa
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN cliente cli ON v.idcliente = cli.idcliente
    LEFT JOIN barrio b ON cli.idbarrio = b.idbarrio
    LEFT JOIN zona z ON cli.idzona = z.idzona
    INNER JOIN cuotas c ON v.idVenta = c.idVenta
    INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
    WHERE v.idVenta = p_idventa
    ORDER BY cd.orden_cuota;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_get_apertura_caja_usuario` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_get_apertura_caja_usuario` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_get_apertura_caja_usuario`(
    IN p_idpersonal INT
)
BEGIN
    DECLARE v_count INT;
    
    -- Verificar si existe apertura activa
    SELECT COUNT(*) INTO v_count
    FROM apecierrecaja 
    WHERE idpersonal = p_idpersonal AND estado = 'A';
    
    IF v_count > 0 THEN
        SELECT 
            ac.idapecierre,
            ac.fechaape,
            ac.horaape,
            ac.montoape,
            ac.fechacierre,
            ac.horacierre,
            ac.montocierre,
            ac.estado,
            ac.idpersonal,
            ac.ingreso,
            ac.egreso,
            ac.diferencia,
            p.nombre,
            p.apellido,
            p.ci,
            s.sucursal,
            e.empresa,
            'APERTURA_ENCONTRADA' AS resultado
        FROM apecierrecaja ac
        INNER JOIN personal p ON ac.idpersonal = p.idPersonal
        INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
        INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
        WHERE ac.idpersonal = p_idpersonal
            AND ac.estado = 'A'
        ORDER BY ac.idapecierre DESC
        LIMIT 1;
    ELSE
        SELECT 
            NULL AS idapecierre,
            NULL AS fechaape,
            NULL AS horaape,
            NULL AS montoape,
            NULL AS fechacierre,
            NULL AS horacierre,
            NULL AS montocierre,
            NULL AS estado,
            p.idPersonal AS idpersonal,
            NULL AS ingreso,
            NULL AS egreso,
            NULL AS diferencia,
            p.nombre,
            p.apellido,
            p.ci,
            s.sucursal,
            e.empresa,
            'SIN_APERTURA' AS resultado
        FROM personal p
        INNER JOIN sucursal s ON p.idsucursal = s.idsucursal
        INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
        WHERE p.idPersonal = p_idpersonal;
    END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_get_concepto_dinamico` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_get_concepto_dinamico` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_get_concepto_dinamico`(
    IN p_nombre_parametro VARCHAR(100),
    OUT p_idconcepto INT
)
BEGIN
    DECLARE v_sql TEXT;
    DECLARE v_sql_exec TEXT;

    -- Obtener la consulta almacenada en la tabla parametros_sistema
    SELECT valor INTO v_sql
    FROM parametros_sistema
    WHERE nombre = p_nombre_parametro
    LIMIT 1;

    -- Ejecutar la consulta dinámica (debe devolver un solo idconcepto)
    SET @dynsql = CONCAT('SELECT idconcepto INTO @resultado FROM (', v_sql, ') AS tmp LIMIT 1');
    PREPARE stmt FROM @dynsql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET p_idconcepto = @resultado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_get_motivoajuste_dinamico` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_get_motivoajuste_dinamico` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_get_motivoajuste_dinamico`(
    IN p_nombre_parametro VARCHAR(100),
    OUT p_idmotivo INT
)
BEGIN
    DECLARE v_sql TEXT;
    DECLARE v_sql_exec TEXT;

    -- Obtener la consulta almacenada en la tabla parametros_sistema
    SELECT valor INTO v_sql
    FROM parametros_sistema
    WHERE nombre = p_nombre_parametro
    LIMIT 1;

    -- Ejecutar la consulta dinámica (debe devolver un solo idmotivo)
    SET @dynsql = CONCAT('SELECT idmotivo INTO @resultado FROM (', v_sql, ') AS tmp LIMIT 1');
    PREPARE stmt FROM @dynsql;
    EXECUTE stmt;
    DEALLOCATE PREPARE stmt;

    SET p_idmotivo = @resultado;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_movimientos_cierre_caja` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_movimientos_cierre_caja` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_movimientos_cierre_caja`(
    IN p_idapecierre INT  -- ID de la apertura de caja
)
BEGIN
    SELECT 
        mo.idMov,
        mo.fecha,
        mo.operacion,
        mo.Nro_comprobante,
        mo.monto,
        mo.tipo,
        -- Leyenda para tipo de movimiento
        CASE 
            WHEN mo.tipo = 'I' THEN 'INGRESO'
            WHEN mo.tipo = 'E' THEN 'EGRESO'
            ELSE 'INDEFINIDO'
        END AS tipo_movimiento,
        mo.descripcion,
        cc.concepto,
        -- Información de clientes/proveedores
        CASE 
            WHEN mo.idcliente IS NOT NULL THEN c.nombre
            WHEN mo.idproveedor IS NOT NULL THEN p.proveedor
            ELSE 'VARIOS'
        END AS nombre_cliente_proveedor,
        -- Información de forma de pago
        fp.tipo AS forma_pago,
        -- Información de sucursal y empresa
        s.sucursal,
        e.empresa,
        -- Campos para cierre de caja
        CASE 
            WHEN mo.tipo = 'I' THEN mo.monto
            ELSE 0
        END AS ingreso,
        CASE 
            WHEN mo.tipo = 'E' THEN mo.monto
            ELSE 0
        END AS egreso,
        -- Estado del movimiento con leyenda descriptiva
        CASE 
            WHEN ac.estado = 'C' THEN 'CAJA CERRADA'
            WHEN ac.estado = 'A' THEN 'CAJA ABIERTA'
            ELSE 'ESTADO DESCONOCIDO'
        END AS estado_cierre,
        -- Datos de la apertura/cierre de caja
        ac.fechaape,
        ac.horaape,
        ac.montoape,
        IFNULL(DATE_FORMAT(ac.fechacierre, '%Y-%m-%d'), '-') AS fechacierre,
        IFNULL(TIME_FORMAT(ac.horacierre, '%H:%i:%s'), '-') AS horacierre,
        ac.estado as estado_original
    FROM mov_operacion mo
    LEFT JOIN concepto_caja cc ON mo.idconcepto = cc.idconcepto
    LEFT JOIN cliente c ON mo.idcliente = c.idcliente
    LEFT JOIN proveedor p ON mo.idproveedor = p.idproveedor
    LEFT JOIN tipo_pago fp ON mo.idformapago = fp.idTipo_pago
    LEFT JOIN sucursal s ON mo.idsucursal = s.idsucursal
    LEFT JOIN empresa e ON mo.idEmpresa = e.idEmpresa
    INNER JOIN apecierrecaja ac ON mo.idapecierre = ac.idapecierre   -- JOIN con la tabla de apertura/cierre
    WHERE mo.idapecierre = p_idapecierre
    ORDER BY 
        mo.tipo DESC,  -- Primero ingresos, luego egresos
        cc.concepto,
        mo.fecha;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_ranking_articulos_vendidos` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_ranking_articulos_vendidos` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_ranking_articulos_vendidos`(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE,
    IN p_tipo_ranking ENUM('CANTIDAD', 'MONTO', 'UTILIDAD'),
    IN p_top INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    -- Variable para el límite
    DECLARE v_limit INT DEFAULT 1000;
    
    -- Si p_top es mayor que 0, usar ese valor, sino usar 1000 como límite por defecto
    IF p_top > 0 THEN
        SET v_limit = p_top;
    END IF;

    SELECT 
        -- Datos de Empresa y Sucursal
        e.empresa AS nombre_empresa,
        s.sucursal AS nombre_sucursal,
        s.direccion as direccion_sucursal,
        
        -- Datos del Artículo
        a.idarticulo,
        a.descripcion AS nombre_articulo,
        a.codbarra AS codigo_barras,
        m.Marca AS marca,
        g.grupo AS categoria,
        sg.subgrupo AS subcategoria,
        prov.proveedor AS proveedor,
        
        -- Métricas de Ventas
        SUM(dv.cantidad) AS total_unidades_vendidas,
        COUNT(DISTINCT v.idVenta) AS total_ventas,
        SUM(dv.subtotal) AS total_monto_vendido,
        ROUND(AVG(dv.preventa), 2) AS precio_promedio_venta,
        
        -- Métricas de Costo y Utilidad
        ROUND(AVG(dv.precosto), 2) AS costo_promedio,
        SUM(dv.subtotal - (dv.precosto * dv.cantidad)) AS utilidad_total,
        ROUND(((SUM(dv.subtotal) - SUM(dv.precosto * dv.cantidad)) / NULLIF(SUM(dv.subtotal), 0)) * 100, 2) AS margen_utilidad_porcentaje,
        
        -- Porcentaje de participación
        ROUND((SUM(dv.subtotal) / NULLIF((SELECT SUM(dv2.subtotal) 
                                  FROM detalle_venta dv2 
                                  JOIN venta v2 ON dv2.idVenta = v2.idVenta
                                  WHERE v2.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
                                    AND v2.estado = 'F'
                                    AND (p_idempresa = 0 OR v2.idEmpresa = p_idempresa)
                                    AND (p_idsucursal = 0 OR v2.idsucursal = p_idsucursal)), 0)) * 100, 2) AS participacion_porcentaje,
        
        -- Fechas de movimiento
        MIN(v.fecha) AS primera_venta,
        MAX(v.fecha) AS ultima_venta,
        
        -- Tipos de venta
        COUNT(DISTINCT CASE WHEN v.tipo = 'CON' THEN v.idVenta END) AS ventas_contado,
        COUNT(DISTINCT CASE WHEN v.tipo = 'CRE' THEN v.idVenta END) AS ventas_credito,
        
        -- Stock actual (si existe)
        (SELECT stock FROM stockarticulo WHERE idarticulo = a.idarticulo AND idsucursal = s.idsucursal LIMIT 1) AS stock_actual

    FROM detalle_venta dv
    INNER JOIN venta v ON dv.idVenta = v.idVenta
    INNER JOIN articulo a ON dv.idarticulo = a.idarticulo
    INNER JOIN marca m ON a.idMarca = m.idMarca
    INNER JOIN grupo g ON a.idgrupo = g.idgrupo
    INNER JOIN subgrupo sg ON a.idsubgrupo = sg.idsubgrupo
    INNER JOIN proveedor prov ON a.idproveedor = prov.idproveedor
    INNER JOIN sucursal s ON v.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
    
    WHERE v.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
      AND v.estado = 'F'  -- Solo ventas facturadas, no anuladas
      AND (p_idempresa = 0 OR e.idEmpresa = p_idempresa)
      AND (p_idsucursal = 0 OR s.idsucursal = p_idsucursal)
    
    GROUP BY 
        a.idarticulo, a.descripcion, a.codbarra, m.Marca, g.grupo, sg.subgrupo, prov.proveedor,
        e.empresa, s.sucursal
    
    ORDER BY 
        CASE 
            WHEN p_tipo_ranking = 'CANTIDAD' THEN SUM(dv.cantidad)
            WHEN p_tipo_ranking = 'MONTO' THEN SUM(dv.subtotal)
            WHEN p_tipo_ranking = 'UTILIDAD' THEN SUM(dv.subtotal - (dv.precosto * dv.cantidad))
        END DESC
        
    LIMIT v_limit;

END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_RegistrarPagoCabecera` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_RegistrarPagoCabecera` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_RegistrarPagoCabecera`(
    IN p_fecha DATE,
    IN p_total_interes DECIMAL(10,2),
    IN p_total_descuento DECIMAL(10,2),
    IN p_total_importe DECIMAL(10,2),
    IN p_total_ac DECIMAL(10,2),
    IN p_nro_recibo VARCHAR(45),
    IN p_idcliente INT,
    IN p_idTipo_pago INT,
    IN p_idsucursal INT,
    IN p_idEmpresa INT,
    IN p_idcobrador INT,
    IN p_idcuotas INT,
    OUT p_idpago INT
)
BEGIN
    -- Insertar cabecera del pago (idpago es AUTOINCREMENT)
    INSERT INTO pagos_cuotas (
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
        estado
    ) VALUES (
        p_fecha,
        p_total_interes,
        p_total_descuento,
        p_total_importe,
        p_total_ac,
        p_nro_recibo,
        p_idcliente,
        p_idTipo_pago,
        p_idsucursal,
        p_idEmpresa,
        p_idcobrador,
        p_idcuotas,
        'COB'
    );
    
    -- Obtener el ID generado automáticamente
    SET p_idpago = LAST_INSERT_ID();
    
    -- Actualizar numeración en control_numeracion_timbrado si es necesario
    UPDATE control_numeracion_timbrado 
    SET contador = contador + 1,
        fecha_ultima_actualizacion = NOW()
    WHERE idsucursal = p_idsucursal 
        AND tipo_documento = 'RECIBO'
        AND activo = 1;
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_reporte_ventas_detallado` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_reporte_ventas_detallado` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_reporte_ventas_detallado`(
    IN p_fecha_ini DATE,
    IN p_fecha_fin DATE,
    IN p_idcliente INT,
    IN p_idvendedor INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- DATOS DE EMPRESA (YA ESTÁN INCLUIDOS)
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.telefono AS telefono_empresa,
        
        -- DATOS DE SUCURSAL
        s.sucursal AS nombre_sucursal,
        s.ciudad AS ciudad_sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- DATOS DE VENTA
        v.idVenta,
        v.fecha,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura) AS nro_factura_completo,
        v.tipo AS tipo_venta,
        -- Campo adicional para ordenamiento
        CASE 
            WHEN v.tipo = 'CON' THEN 1  -- Contado primero
            WHEN v.tipo = 'CRE' THEN 2  -- Crédito después
            ELSE 3
        END AS orden_tipo_venta,
        v.estado,
        v.total AS total_venta,

        -- DATOS DE CLIENTE
        c.nombre AS cliente_nombre,
        c.apellido AS cliente_apellido,
        concat(trim(c.nombre), ' ',trim(c.apellido)) as cliente_completo,
        c.ci AS cliente_ci,
        c.ruc AS cliente_ruc,

        -- DATOS DE VENDEDOR
        ven.idvendedor,
        CONCAT(trim(p.nombre), ' ', trim(p.apellido)) AS vendedor_nombre,

        -- DATOS DE PRODUCTO
        a.codbarra,
        a.descripcion AS producto,
        dv.cantidad,
        dv.precosto AS precio_costo,
        dv.preventa AS precio_venta,
        dv.subtotal,
        
        -- CÁLCULO DE UTILIDAD
        (dv.preventa - dv.precosto) AS utilidad_bruta,
        ROUND(((dv.preventa - dv.precosto) / NULLIF(dv.precosto, 0)) * 100, 2) AS margen_utilidad_porcentaje,
        (dv.subtotal - (dv.precosto * dv.cantidad)) AS utilidad_total_linea,
        
        -- DATOS DE FINANCIAMIENTO
        dv.tipo_cuota,
        dv.plan_cuota,
        dv.cant_cuota,
        dv.monto_cuota,
        dv.interes_mensual

    FROM venta v
    JOIN cliente c ON v.idcliente = c.idcliente
    JOIN vendedor ven ON v.idVendedor = ven.idVendedor
    JOIN personal p ON ven.idPersonal = p.idPersonal
    JOIN sucursal s ON v.idsucursal = s.idsucursal
    JOIN empresa e ON s.idEmpresa = e.idEmpresa 
    JOIN detalle_venta dv ON v.idVenta = dv.idVenta
    JOIN articulo a ON dv.idarticulo = a.idarticulo
    WHERE v.fecha BETWEEN p_fecha_ini AND p_fecha_fin
      AND (p_idcliente = 0 OR v.idcliente = p_idcliente)
      AND (p_idvendedor = 0 OR v.idVendedor = p_idvendedor)
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal)
    ORDER BY  
	    orden_tipo_venta ASC,
	    v.fecha,
	    v.idVenta, 
	    dv.idDetalle, 
	    v.tipo;
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_resumen_cobranza_mes` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_resumen_cobranza_mes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_resumen_cobranza_mes`(
    IN p_mes INT,
    IN p_anio INT,
    IN p_idcobrador INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- Datos de la empresa y sucursal
        emp.idEmpresa,
        emp.empresa AS nombre_empresa,
        emp.ruc AS ruc_empresa,
        suc.idsucursal,
        suc.sucursal AS nombre_sucursal,
        suc.ciudad,
        suc.direccion AS direccion_sucursal,
        
        -- Datos del cobrador
        co.idcobrador,
        CONCAT(TRIM(pe.nombre), ' ', TRIM(pe.apellido)) AS cobrador,
        z.zona,
        pe.ci AS ci_cobrador,
        pe.telefono AS telefono_cobrador,
        
        -- Resumen de cuotas (CORREGIDO)
        COUNT(DISTINCT c.idcuotas) AS total_financiaciones,
        COUNT(cd.idcuotas_detalle) AS total_cuotas,
        SUM(cd.cuota) AS total_monto_original,
        
        -- Estado de cobranza (CORREGIDO - usa saldo_cuota)
        SUM(cd.cuota - cd.saldo_cuota) AS total_efectivamente_cobrado,
        SUM(cd.saldo_cuota) AS total_pendiente_real,
        SUM(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN cd.saldo_cuota ELSE 0 END) AS total_vencido_real,
        
        -- Porcentajes (CORREGIDOS)
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.cuota - cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_efectividad_real,
        
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_pendiente_real,
        
        -- Detalle de vencimientos (CORREGIDO)
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN 1 END) AS cuotas_vencidas,
        COUNT(CASE WHEN cd.estado = 'PEN' THEN 1 END) AS cuotas_pendientes,
        COUNT(CASE WHEN cd.estado = 'CAN' THEN 1 END) AS cuotas_cobradas,
        
        -- Información adicional sobre pagos parciales (NUEVO)
        COUNT(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 1 END) AS cuotas_con_pago_parcial,
        SUM(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN (cd.cuota - cd.saldo_cuota) ELSE 0 END) AS monto_pagos_parciales,
        
        -- Clientes activos
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN cl.idcliente END) AS clientes_con_saldo,
        COUNT(DISTINCT cl.idcliente) AS total_clientes_mes,
        
        -- Promedios (CORREGIDOS)
        ROUND(AVG(cd.cuota), 2) AS promedio_cuota_original,
        ROUND(AVG(cd.saldo_cuota), 2) AS promedio_saldo_pendiente,
        ROUND(AVG(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
                  THEN DATEDIFF(CURDATE(), cd.fecha_vto) END), 0) AS promedio_dias_vencido,
        
        -- Estadísticas de mora (NUEVO)
        MAX(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
            THEN DATEDIFF(CURDATE(), cd.fecha_vto) END) AS max_dias_vencido,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() AND DATEDIFF(CURDATE(), cd.fecha_vto) > 30 THEN 1 END) AS cuotas_mas_30_dias,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() AND DATEDIFF(CURDATE(), cd.fecha_vto) > 60 THEN 1 END) AS cuotas_mas_60_dias,
        
        -- Fechas de consulta
        CONCAT(p_mes, '/', p_anio) AS periodo_consulta,
        CURDATE() AS fecha_consulta,
        CONCAT('Del 01/', LPAD(p_mes, 2, '0'), '/', p_anio, ' al ', 
               DATE_FORMAT(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01')), '%d/%m/%Y')) AS rango_consulta

    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cl ON c.idcliente = cl.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN cobrador co ON v.idcobrador = co.idcobrador
    INNER JOIN personal pe ON co.idPersonal = pe.idPersonal
    INNER JOIN zona z ON co.idzona = z.idzona
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN empresa emp ON suc.idEmpresa = emp.idEmpresa
    
    WHERE MONTH(cd.fecha_vto) = p_mes 
        AND YEAR(cd.fecha_vto) = p_anio
        AND (p_idcobrador = 0 OR co.idcobrador = p_idcobrador)
        AND (p_idempresa = 0 OR emp.idEmpresa = p_idempresa)
        AND (p_idsucursal = 0 OR suc.idsucursal = p_idsucursal)
        AND c.anulado = 'NO'
    
    GROUP BY 
        emp.idEmpresa, emp.empresa, emp.ruc,
        suc.idsucursal, suc.sucursal, suc.ciudad, suc.direccion,
        co.idcobrador, cobrador, z.zona, pe.ci, pe.telefono
        
    ORDER BY 
        emp.empresa, 
        suc.sucursal, 
        total_pendiente_real DESC;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_resumen_general_cobranza_mes` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_resumen_general_cobranza_mes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_resumen_general_cobranza_mes`(
    IN p_mes INT,
    IN p_anio INT,
    IN p_idempresa INT,
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        -- Datos de la empresa
        emp.idEmpresa,
        emp.empresa AS nombre_empresa,
        emp.ruc AS ruc_empresa,
        emp.descrip AS descripcion_empresa,
        emp.telefono AS telefono_empresa,
        
        -- Datos de la sucursal
        suc.idsucursal,
        suc.sucursal AS nombre_sucursal,
        suc.ciudad,
        suc.direccion AS direccion_sucursal,
        suc.telefono AS telefono_sucursal,
        
        -- Totales generales (CORREGIDOS)
        COUNT(DISTINCT c.idcuotas) AS total_financiaciones,
        COUNT(cd.idcuotas_detalle) AS total_cuotas_mes,
        SUM(cd.cuota) AS total_monto_original,  -- Monto original de las cuotas
        
        -- Estado de cobranza (CORREGIDO - usa saldo_cuota)
        SUM(cd.cuota - cd.saldo_cuota) AS total_efectivamente_cobrado,
        SUM(cd.saldo_cuota) AS total_pendiente_real,
        SUM(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN cd.saldo_cuota ELSE 0 END) AS total_vencido_real,
        
        -- Desglose por estado de cuotas
        COUNT(CASE WHEN cd.estado = 'CAN' THEN 1 END) AS cuotas_cobradas,
        COUNT(CASE WHEN cd.estado = 'PEN' THEN 1 END) AS cuotas_pendientes,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() THEN 1 END) AS cuotas_vencidas,
        COUNT(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto >= CURDATE() THEN 1 END) AS cuotas_por_vencer,
        
        -- Montos por estado (NUEVO - para comparación)
        SUM(CASE WHEN cd.estado = 'CAN' THEN cd.cuota ELSE 0 END) AS total_original_cobrado,
        SUM(CASE WHEN cd.estado = 'PEN' THEN cd.cuota ELSE 0 END) AS total_original_pendiente,
        
        -- Porcentajes de gestión (CORREGIDOS)
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.cuota - cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_efectividad_real,
        
        CASE 
            WHEN SUM(cd.cuota) > 0 THEN 
                ROUND((SUM(cd.saldo_cuota) / SUM(cd.cuota)) * 100, 2)
            ELSE 0 
        END AS porcentaje_pendiente_real,
        
        -- Diferencia por pagos parciales (NUEVO)
        SUM(cd.cuota) - SUM(cd.saldo_cuota) AS diferencia_pagos_parciales,
        COUNT(CASE WHEN cd.saldo_cuota > 0 AND cd.saldo_cuota < cd.cuota THEN 1 END) AS cuotas_con_pago_parcial,
        
        -- Clientes involucrados
        COUNT(DISTINCT cl.idcliente) AS total_clientes,
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN cl.idcliente END) AS clientes_con_deuda,
        COUNT(DISTINCT CASE WHEN cd.estado = 'CAN' THEN cl.idcliente END) AS clientes_al_dia,
        
        -- Cobradores involucrados
        COUNT(DISTINCT co.idcobrador) AS total_cobradores,
        COUNT(DISTINCT CASE WHEN cd.estado = 'PEN' THEN co.idcobrador END) AS cobradores_con_cartera,
        
        -- Estadísticas financieras (ACTUALIZADAS)
        ROUND(AVG(cd.cuota), 2) AS promedio_valor_cuota_original,
        ROUND(AVG(cd.saldo_cuota), 2) AS promedio_saldo_pendiente,
        ROUND(MAX(cd.cuota), 2) AS cuota_mas_alta,
        ROUND(MIN(cd.cuota), 2) AS cuota_mas_baja,
        
        -- Estadísticas de vencimiento
        ROUND(AVG(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
                  THEN DATEDIFF(CURDATE(), cd.fecha_vto) END), 0) AS promedio_dias_vencido,
        
        MAX(CASE WHEN cd.estado = 'PEN' AND cd.fecha_vto < CURDATE() 
            THEN DATEDIFF(CURDATE(), cd.fecha_vto) END) AS max_dias_vencido,
        
        -- Información del período consultado
        CONCAT(p_mes, '/', p_anio) AS periodo_consulta,
        DATE_FORMAT(CONCAT(p_anio, '-', p_mes, '-01'), '%M %Y') AS periodo_descripcion,
        DATE_FORMAT(CURDATE(), '%d/%m/%Y %H:%i:%s') AS fecha_generacion_reporte,
        DAY(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01'))) AS dias_del_mes,
        DAY(CURDATE()) AS dia_actual,
        
        -- Rangos de fechas para el período
        DATE_FORMAT(CONCAT(p_anio, '-', p_mes, '-01'), '%d/%m/%Y') AS inicio_periodo,
        DATE_FORMAT(LAST_DAY(CONCAT(p_anio, '-', p_mes, '-01')), '%d/%m/%Y') AS fin_periodo

    FROM cuotas_detalle cd
    INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
    INNER JOIN cliente cl ON c.idcliente = cl.idcliente
    INNER JOIN venta v ON c.idVenta = v.idVenta
    INNER JOIN cobrador co ON v.idcobrador = co.idcobrador
    INNER JOIN sucursal suc ON v.idsucursal = suc.idsucursal
    INNER JOIN empresa emp ON suc.idEmpresa = emp.idEmpresa
    
    WHERE MONTH(cd.fecha_vto) = p_mes 
        AND YEAR(cd.fecha_vto) = p_anio
        AND (p_idempresa = 0 OR emp.idEmpresa = p_idempresa)
        AND (p_idsucursal = 0 OR suc.idsucursal = p_idsucursal)
        AND c.anulado = 'NO'
    
    GROUP BY 
        emp.idEmpresa, emp.empresa, emp.ruc, emp.descrip, emp.telefono,
        suc.idsucursal, suc.sucursal, suc.ciudad, suc.direccion, suc.telefono;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_resumen_morosidad_clientes` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_resumen_morosidad_clientes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_resumen_morosidad_clientes`(
    IN p_idsucursal INT
)
BEGIN
    SELECT 
        c.idcliente,
        CONCAT(c.nombre, ' ', c.apellido) AS cliente,
        c.ci,
        c.celular,
        z.zona,
        b.barrio,
        
        -- Totales
        COUNT(DISTINCT cu.idcuotas) AS total_creditos,
        COUNT(cd.idcuotas_detalle) AS total_cuotas_pendientes,
        
        -- Cuotas vencidas
        SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN 1 ELSE 0 END) AS cuotas_vencidas,
        MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) AS max_dias_vencido,
        
        -- Montos
        SUM(cd.cuota) AS total_deuda,
        SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN cd.cuota ELSE 0 END) AS total_vencido,
        
        -- Clasificación de morosidad
        CASE 
            WHEN MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) > 30 THEN 'MOROSO GRAVE'
            WHEN MAX(CASE WHEN cd.fecha_vto < CURDATE() THEN DATEDIFF(CURDATE(), cd.fecha_vto) ELSE 0 END) > 15 THEN 'MOROSO MODERADO'
            WHEN SUM(CASE WHEN cd.fecha_vto < CURDATE() THEN 1 ELSE 0 END) > 0 THEN 'MOROSO LEVE'
            ELSE 'AL DÍA'
        END AS estado_morosidad,
        
        -- Próximo vencimiento
        MIN(CASE WHEN cd.fecha_vto >= CURDATE() THEN cd.fecha_vto ELSE NULL END) AS proximo_vencimiento,
        
        -- Cobrador asignado
        CONCAT(trim(pc.nombre), ' ', trim(pc.apellido)) AS cobrador_asignado
        
    FROM cliente c
    INNER JOIN venta v ON c.idcliente = v.idcliente
    INNER JOIN cuotas cu ON v.idVenta = cu.idVenta
    INNER JOIN cuotas_detalle cd ON cu.idcuotas = cd.idcuotas
    INNER JOIN zona z ON c.idzona = z.idzona
    INNER JOIN barrio b ON c.idbarrio = b.idbarrio
    LEFT JOIN cobrador cob ON v.idcobrador = cob.idcobrador
    LEFT JOIN personal pc ON cob.idPersonal = pc.idPersonal
    WHERE cd.estado = 'PEN'
    AND cu.anulado = 'NO'
    AND v.estado = 'F'
    AND (p_idsucursal IS NULL OR v.idsucursal = p_idsucursal)
    GROUP BY c.idcliente
    HAVING total_cuotas_pendientes > 0
    ORDER BY max_dias_vencido DESC, total_vencido DESC;
    
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_resumen_pagos_cuotas` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_resumen_pagos_cuotas` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_resumen_pagos_cuotas`(
    IN p_fecha_desde DATE,
    IN p_fecha_hasta DATE,
    IN p_idcobrador INT,
    IN p_idsucursal INT
)
BEGIN
    -- Convertir 0 a NULL para los filtros
    SET p_fecha_desde = NULLIF(p_fecha_desde, '0000-00-00');
    SET p_fecha_hasta = NULLIF(p_fecha_hasta, '0000-00-00');
    SET p_idcobrador = NULLIF(p_idcobrador, 0);
    SET p_idsucursal = NULLIF(p_idsucursal, 0);

    SELECT 
        -- Fechas y agrupaciones
        pc.fecha,
        DATE_FORMAT(pc.fecha, '%Y-%m') AS mes_anio,
        DATE_FORMAT(pc.fecha, '%M %Y') AS mes_anio_texto,
        
        -- Información del cobrador
        cob.idcobrador,
        CONCAT(TRIM(pcob.nombre), ' ', TRIM(pcob.apellido)) AS cobrador_nombre,
        pcob.ci AS cobrador_ci,
        
        -- Información de la sucursal
        s.idsucursal,
        s.sucursal,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        
        -- Información de la empresa
        e.idEmpresa,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.descrip AS descripcion_empresa,
        e.telefono AS telefono_empresa,
        
        -- Totales y conteos
        COUNT(DISTINCT pc.idpago) AS cantidad_recibos,
        COUNT(dpc.iddetalle_pagos_cuotas) AS cantidad_conceptos,
        SUM(dpc.importe) AS total_cobrado,
        
        -- Desglose por tipo de pago
        SUM(CASE WHEN dpc.tipo_pago = 'CUOTA' THEN dpc.importe ELSE 0 END) AS total_cuotas,
        SUM(CASE WHEN dpc.tipo_pago = 'OTRO' THEN dpc.importe ELSE 0 END) AS total_otros,
        
        -- Desglose por concepto
        COUNT(DISTINCT c.idcliente) AS cantidad_clientes,
        
        -- Promedios y cálculos adicionales
        ROUND(AVG(dpc.importe), 2) AS promedio_por_concepto,
        ROUND(SUM(dpc.importe) / COUNT(DISTINCT c.idcliente), 2) AS promedio_por_cliente,
        
        -- Formas de pago más utilizadas
        GROUP_CONCAT(DISTINCT tp.tipo) AS formas_pago_utilizadas,
        COUNT(DISTINCT tp.idTipo_pago) AS cantidad_formas_pago,
        
        -- Información del usuario que registró los pagos
        GROUP_CONCAT(DISTINCT u.nick) AS usuarios_registro,
        COUNT(DISTINCT u.idusuario) AS cantidad_usuarios
        
    FROM pagos_cuotas pc
    INNER JOIN detalle_pagos_cuotas dpc ON pc.idpago = dpc.idpago
    INNER JOIN cliente c ON pc.idcliente = c.idcliente
    INNER JOIN cobrador cob ON pc.idcobrador = cob.idcobrador
    INNER JOIN personal pcob ON cob.idPersonal = pcob.idPersonal
    INNER JOIN tipo_pago tp ON pc.idTipo_pago = tp.idTipo_pago
    INNER JOIN sucursal s ON pc.idsucursal = s.idsucursal
    INNER JOIN empresa e ON s.idEmpresa = e.idEmpresa
    LEFT JOIN usuario u ON pc.idusuario = u.idusuario
    WHERE pc.estado = 'COB'
    AND (p_fecha_desde IS NULL OR pc.fecha >= p_fecha_desde)
    AND (p_fecha_hasta IS NULL OR pc.fecha <= p_fecha_hasta)
    AND (p_idcobrador IS NULL OR cob.idcobrador = p_idcobrador)
    AND (p_idsucursal IS NULL OR s.idsucursal = p_idsucursal)
    GROUP BY 
        pc.fecha,
        cob.idcobrador,
        s.idsucursal,
        e.idEmpresa
    ORDER BY 
        pc.fecha DESC,
        total_cobrado DESC;
        
END */$$
DELIMITER ;

/* Procedure structure for procedure `sp_resumen_ventas_por_mes` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_resumen_ventas_por_mes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_resumen_ventas_por_mes`(
    IN p_anio INT,
    IN p_mes INT,
    IN p_idsucursal INT
)
BEGIN
    -- Crear tabla temporal para ventas agrupadas
    CREATE TEMPORARY TABLE tmp_ventas_agrupadas AS
    SELECT 
        v.idVenta,
        v.fecha,
        v.tipo,
        v.total,
        v.idsucursal,
        s.sucursal,
        s.ciudad,
        s.direccion AS direccion_sucursal,
        s.telefono AS telefono_sucursal,
        e.empresa AS nombre_empresa,
        e.ruc AS ruc_empresa,
        e.telefono AS telefono_empresa,
        YEAR(v.fecha) AS anio,
        MONTH(v.fecha) AS mes,
        MONTHNAME(v.fecha) AS nombre_mes
    FROM venta v
    JOIN sucursal s ON v.idsucursal = s.idsucursal
    JOIN empresa e ON s.idEmpresa = e.idEmpresa
    WHERE YEAR(v.fecha) = p_anio
      AND (p_mes = 0 OR MONTH(v.fecha) = p_mes)
      AND v.estado = 'F'
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal);

    -- Crear tabla temporal para productos y utilidad
    CREATE TEMPORARY TABLE tmp_productos_utilidad AS
    SELECT 
        dv.idVenta,
        SUM((dv.preventa - dv.precosto) * dv.cantidad) AS utilidad,
        COUNT(dv.idDetalle) AS lineas_detalle,
        SUM(dv.cantidad) AS cantidad_productos
    FROM detalle_venta dv
    JOIN venta v ON dv.idVenta = v.idVenta
    WHERE YEAR(v.fecha) = p_anio
      AND (p_mes = 0 OR MONTH(v.fecha) = p_mes)
      AND v.estado = 'F'
      AND (p_idsucursal = 0 OR v.idsucursal = p_idsucursal)
    GROUP BY dv.idVenta;

    -- Consulta principal con los datos correctos
    SELECT 
        -- Datos de Empresa y Sucursal
        va.nombre_empresa,
        va.ruc_empresa,
        va.telefono_empresa,
        va.sucursal AS nombre_sucursal,
        va.ciudad AS ciudad_sucursal,
        va.direccion_sucursal,
        va.telefono_sucursal,
        
        -- Periodo
        va.anio,
        va.mes,
        CONCAT(va.anio, '-', LPAD(va.mes, 2, '0')) AS periodo,
        va.nombre_mes,
        
        -- Métricas de Ventas (SIN DUPLICACIÓN)
        COUNT(va.idVenta) AS cantidad_ventas,
        SUM(CASE WHEN va.tipo = 'CON' THEN 1 ELSE 0 END) AS cantidad_ventas_contado,
        SUM(CASE WHEN va.tipo = 'CRE' THEN 1 ELSE 0 END) AS cantidad_ventas_credito,
        
        -- Totales monetarios (SIN DUPLICACIÓN)
        SUM(va.total) AS total_ventas,
        SUM(CASE WHEN va.tipo = 'CON' THEN va.total ELSE 0 END) AS ventas_contado,
        SUM(CASE WHEN va.tipo = 'CRE' THEN va.total ELSE 0 END) AS ventas_credito,
        
        -- Utilidad y productos desde la tabla temporal
        SUM(COALESCE(pu.utilidad, 0)) AS utilidad_total,
        ROUND((SUM(COALESCE(pu.utilidad, 0)) / NULLIF(SUM(va.total), 0)) * 100, 2) AS margen_utilidad_porcentaje,
        
        -- Promedios y Totales de productos
        ROUND(AVG(va.total), 2) AS ticket_promedio,
        SUM(COALESCE(pu.lineas_detalle, 0)) AS total_productos_vendidos,
        SUM(COALESCE(pu.cantidad_productos, 0)) AS cantidad_total_productos,
        
        -- Porcentajes de distribución
        ROUND((SUM(CASE WHEN va.tipo = 'CON' THEN va.total ELSE 0 END) / NULLIF(SUM(va.total), 0)) * 100, 2) AS porcentaje_contado,
        ROUND((SUM(CASE WHEN va.tipo = 'CRE' THEN va.total ELSE 0 END) / NULLIF(SUM(va.total), 0)) * 100, 2) AS porcentaje_credito

    FROM tmp_ventas_agrupadas va
    LEFT JOIN tmp_productos_utilidad pu ON va.idVenta = pu.idVenta
    GROUP BY 
        va.nombre_empresa, 
        va.ruc_empresa, 
        va.telefono_empresa,
        va.sucursal, 
        va.ciudad, 
        va.direccion_sucursal, 
        va.telefono_sucursal,
        va.anio, 
        va.mes,
        va.nombre_mes
    ORDER BY 
        va.anio DESC, 
        va.mes DESC;

    -- Limpiar tablas temporales
    DROP TEMPORARY TABLE IF EXISTS tmp_ventas_agrupadas;
    DROP TEMPORARY TABLE IF EXISTS tmp_productos_utilidad;
END */$$
DELIMITER ;

/* Procedure structure for procedure `ventas_cabecera` */

/*!50003 DROP PROCEDURE IF EXISTS  `ventas_cabecera` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ventas_cabecera`(
	IN p_fecha DATE,
	in p_fecha_vto date,
	IN p_tipo ENUM('CON','CRE'),
	IN p_nrosuc VARCHAR(5),
	IN p_nroexp VARCHAR(5),
	IN p_nrofactura VARCHAR(20),
	IN p_estado ENUM('A','F'),

	-- GRAVAMEN IVA
	IN p_exenta DECIMAL(10,2),
	IN p_gravada_cinco DECIMAL(10,2),
	IN p_gravada_diez DECIMAL(10,2),

	-- LIQUIDACION DE IVA
	IN p_liqui_iva_cinco DECIMAL(10,2),
	IN p_liqui_iva_diez DECIMAL(10,2),
	IN p_total_liqui_iva DECIMAL(10,2),

	-- TOTAL
	IN n_total DECIMAL(10,2),

	-- REFERENCIALES
	IN p_cod_vendedor INT,
	IN p_cod_cliente  INT,
	IN p_cod_sucursal INT,
	IN p_cod_empresa  INT,
	IN p_cod_deposito INT,
	IN p_cod_cobrador INT,
	IN p_cod_formapago INT,
	IN p_cod_usuario INT
)
BEGIN
	-- DECLARACION
	DECLARE v_nro_factura VARCHAR(20);
	DECLARE v_secuencia INT;
	
	
	IF p_nrofactura IS NULL OR p_nrofactura ='' THEN
		SELECT contador INTO v_secuencia FROM control_numeracion_timbrado
		WHERE tipo_documento = "FACTURA";
		SET v_nro_factura = LPAD(v_secuencia, 5, '0');
	ELSE
		SET v_nro_factura = p_nrofactura;
	END IF;
	
	
	INSERT INTO venta (
	  fecha,
	  fecha_vto_pagare,
	  hora,
	  tipo,
	  nrosuc,
	  nroexp,
	  nrofactura,
	  estado,
	  total_gravada_excenta,
	  total_gravada_cinco,
	  total_gravada_diez,
	  total,
	  liqui_iva_5,
	  liqui_iva_10,
	  total_liqui_iva,
	  idVendedor,
	  idcliente,
	  idsucursal,
	  idEmpresa,
	  iddeposito,
	  idcobrador,
	  idformapago,
	  idusuario
	)
	VALUES
	  (
	    p_fecha,
	    p_fecha_vto,
	    TIME(NOW()),
	    p_tipo,
	    p_nrosuc,
	    p_nroexp,
	    v_nro_factura,
	    p_estado,
	    p_exenta,
	    p_gravada_cinco,
	    p_gravada_diez,
	    n_total,
	    p_liqui_iva_cinco,
	    p_liqui_iva_diez,
	    p_total_liqui_iva,
	    p_cod_vendedor,
	    p_cod_cliente,
	    p_cod_sucursal,
	    p_cod_empresa,
	    p_cod_deposito,
	    p_cod_cobrador,
	    p_cod_formapago,
	    p_cod_usuario
	  );
		
	SELECT LAST_INSERT_ID() AS codigo;
	

END */$$
DELIMITER ;

/* Procedure structure for procedure `ventas_detalle` */

/*!50003 DROP PROCEDURE IF EXISTS  `ventas_detalle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ventas_detalle`(
		  in p_codventa int,
		  in p_tipo_cuota enum('CUOTA','CONTADO'),
		  in p_plan_cuota VARCHAR(45),
		  in p_interes_mensual decimal(10),
		  in p_cant_cuota int,
		  in p_margen_conta decimal(10),
		  in p_monto_cuota decimal(10,2),
		  in p_precosto decimal(10,2),
		  in p_cantidad int,
		  in p_preventa decimal(10,2),
		  in p_subtotal decimal(10,2),
		  in p_iva enum('0','10','5'),
		  in p_gravada_excenta decimal(10,2),
		  in p_gravada_cinco decimal(10,2),
		  in p_gravada_diez decimal(10,2),
		  in p_idarticulo int,
		  in p_iddeposito int
)
begin

		insert into detalle_venta (
		  idVenta,
		  tipo_cuota,
		  plan_cuota,
		  interes_mensual,
		  cant_cuota,
		  margen_conta,
		  monto_cuota,
		  precosto,
		  cantidad,
		  preventa,
		  subtotal,
		  iva,
		  gravada_excenta,
		  gravada_cinco,
		  gravada_diez,
		  idarticulo,
		  iddeposito
		)	
		values
		  (
		   p_codventa ,
		   p_tipo_cuota,
		   p_plan_cuota ,
		   p_interes_mensual ,
		   p_cant_cuota ,
		   p_margen_conta ,
		   p_monto_cuota ,
		   p_precosto ,
		   p_cantidad ,
		   p_preventa ,
		   p_subtotal ,
		   p_iva,
		   p_gravada_excenta ,
		   p_gravada_cinco ,
		   p_gravada_diez ,
		   p_idarticulo ,
		   p_iddeposito 
		  );

end */$$
DELIMITER ;

/*Table structure for table `v_articulo` */

DROP TABLE IF EXISTS `v_articulo`;

/*!50001 DROP VIEW IF EXISTS `v_articulo` */;
/*!50001 DROP TABLE IF EXISTS `v_articulo` */;

/*!50001 CREATE TABLE  `v_articulo`(
 `idarticulo` int(11) ,
 `descripcion` varchar(100) ,
 `codbarra` varchar(45) ,
 `idplan_cuota` int(11) ,
 `idMarca` int(11) ,
 `idgrupo` int(11) ,
 `idsubgrupo` int(11) ,
 `idproveedor` int(11) ,
 `unidad` varchar(45) ,
 `ultima_fecha_compra` date ,
 `ultima_fecha_venta` date ,
 `ultima_fecha_ajuste` date ,
 `impuesto` enum('10','5','0') ,
 `margen_contado` decimal(10,2) ,
 `interes_mensual` decimal(10,2) ,
 `limite_cuota` decimal(10,0) ,
 `precio_costo` decimal(10,2) ,
 `precio_contado` decimal(10,2) ,
 `stock_minimo` int(11) ,
 `tipo_imagen` enum('LOCAL','URL') ,
 `foto` text ,
 `detalle` text ,
 `nombre_marca` char(45) ,
 `nombre_grupo` char(45) ,
 `nombre_subgrupo` varchar(45) ,
 `nombre_proveedor` char(45) ,
 `ruc_proveedor` char(20) ,
 `nombre_plan_cuota` varchar(45) ,
 `margen_plan` decimal(10,2) ,
 `interes_plan` decimal(10,2) ,
 `limite_plan` int(11) ,
 `stock_actual` bigint(11) ,
 `iddeposito` int(11) ,
 `nombre_deposito` varchar(45) ,
 `idsucursal` int(11) ,
 `nombre_sucursal` varchar(45) 
)*/;

/*Table structure for table `v_barrio_zona` */

DROP TABLE IF EXISTS `v_barrio_zona`;

/*!50001 DROP VIEW IF EXISTS `v_barrio_zona` */;
/*!50001 DROP TABLE IF EXISTS `v_barrio_zona` */;

/*!50001 CREATE TABLE  `v_barrio_zona`(
 `idbarrio` int(11) ,
 `barrio` varchar(45) ,
 `idzona` int(11) ,
 `zona` varchar(45) 
)*/;

/*Table structure for table `v_clientes` */

DROP TABLE IF EXISTS `v_clientes`;

/*!50001 DROP VIEW IF EXISTS `v_clientes` */;
/*!50001 DROP TABLE IF EXISTS `v_clientes` */;

/*!50001 CREATE TABLE  `v_clientes`(
 `idcliente` int(11) ,
 `nombre` varchar(45) ,
 `apellido` varchar(45) ,
 `nombre_completo` varchar(91) ,
 `ci` varchar(45) ,
 `ruc` varchar(45) ,
 `celular` varchar(20) ,
 `telefono` varchar(20) ,
 `idzona` int(11) ,
 `zona` varchar(45) ,
 `idbarrio` int(11) ,
 `barrio` varchar(45) ,
 `idprofesion` int(11) ,
 `profesion` varchar(45) ,
 `referencia` text ,
 `trabajo_lugar` varchar(45) ,
 `trabajo_telefono` varchar(20) ,
 `ref1` varchar(45) ,
 `ref2` varchar(45) ,
 `ref3` varchar(45) ,
 `reftel1` varchar(45) ,
 `reftel2` varchar(45) ,
 `reftel3` varchar(45) ,
 `ubicacion_completa` varchar(93) 
)*/;

/*Table structure for table `v_cobradores` */

DROP TABLE IF EXISTS `v_cobradores`;

/*!50001 DROP VIEW IF EXISTS `v_cobradores` */;
/*!50001 DROP TABLE IF EXISTS `v_cobradores` */;

/*!50001 CREATE TABLE  `v_cobradores`(
 `idcobrador` int(11) ,
 `idPersonal` int(11) ,
 `nombre_completo` varchar(91) ,
 `ci` varchar(25) ,
 `telefono` varchar(20) ,
 `idzona` int(11) ,
 `zona` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) 
)*/;

/*Table structure for table `v_compra` */

DROP TABLE IF EXISTS `v_compra`;

/*!50001 DROP VIEW IF EXISTS `v_compra` */;
/*!50001 DROP TABLE IF EXISTS `v_compra` */;

/*!50001 CREATE TABLE  `v_compra`(
 `nro_factura` varchar(7) ,
 `fecha` date ,
 `proveedor` char(45) ,
 `idcompra` int(11) ,
 `idproveedor` int(11) 
)*/;

/*Table structure for table `v_cuotas_ventas_clientes` */

DROP TABLE IF EXISTS `v_cuotas_ventas_clientes`;

/*!50001 DROP VIEW IF EXISTS `v_cuotas_ventas_clientes` */;
/*!50001 DROP TABLE IF EXISTS `v_cuotas_ventas_clientes` */;

/*!50001 CREATE TABLE  `v_cuotas_ventas_clientes`(
 `idcliente` int(11) ,
 `cliente_nombre` varchar(45) ,
 `cliente_apellido` varchar(45) ,
 `cliente_nombre_completo` varchar(91) ,
 `cliente_ci` varchar(45) ,
 `cliente_ruc` varchar(45) ,
 `celular` varchar(20) ,
 `telefono` varchar(20) ,
 `referencia` text ,
 `trabajo_lugar` varchar(45) ,
 `trabajo_telefono` varchar(20) ,
 `zona` varchar(45) ,
 `barrio` varchar(45) ,
 `profesion` varchar(45) ,
 `idVenta` int(11) ,
 `fecha_venta` date ,
 `hora` time ,
 `tipo_venta` enum('CON','CRE') ,
 `tipo_venta_descripcion` varchar(7) ,
 `nrosuc` varchar(5) ,
 `nroexp` varchar(5) ,
 `nrofactura` varchar(20) ,
 `factura_completa` varchar(32) ,
 `total_gravada_excenta` decimal(11,0) ,
 `total_gravada_cinco` decimal(11,0) ,
 `total_gravada_diez` decimal(11,0) ,
 `total_venta` decimal(10,2) ,
 `liqui_iva_5` decimal(10,2) ,
 `liqui_iva_10` decimal(10,2) ,
 `total_liqui_iva` decimal(10,2) ,
 `idcuotas` int(11) ,
 `fecha_cuota` date ,
 `fecha_cancela` date ,
 `factura_cuota` varchar(45) ,
 `cantidad_cuota` int(11) ,
 `primera_fecha_vto` date ,
 `total_cuota` decimal(10,0) ,
 `saldo_actual` decimal(10,2) ,
 `ultimo_fecha_pago` date ,
 `ultimo_importe` decimal(10,2) ,
 `ultimo_interes_calc` decimal(10,2) ,
 `ultimo_descuento` decimal(10,2) ,
 `ultimo_totalac` decimal(10,2) ,
 `estado_cuota` enum('PEN','CAN') ,
 `estado_cuota_descripcion` varchar(9) ,
 `anulado` enum('SI','NO') ,
 `cuotas_pagadas` bigint(21) ,
 `cuotas_pendientes` bigint(21) ,
 `porcentaje_cuotas_pagadas` decimal(26,2) ,
 `idVendedor` int(11) ,
 `vendedor_nombre` varchar(91) ,
 `idcobrador` int(11) ,
 `cobrador_nombre` varchar(91) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `empresa` varchar(45) ,
 `total_pagado` decimal(13,2) ,
 `porcentaje_pendiente` decimal(14,2) ,
 `dias_desde_primer_vencimiento` int(7) 
)*/;

/*Table structure for table `v_deposito` */

DROP TABLE IF EXISTS `v_deposito`;

/*!50001 DROP VIEW IF EXISTS `v_deposito` */;
/*!50001 DROP TABLE IF EXISTS `v_deposito` */;

/*!50001 CREATE TABLE  `v_deposito`(
 `iddeposito` int(11) ,
 `deposito` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `empresa` varchar(45) 
)*/;

/*Table structure for table `v_detalle_cuotas` */

DROP TABLE IF EXISTS `v_detalle_cuotas`;

/*!50001 DROP VIEW IF EXISTS `v_detalle_cuotas` */;
/*!50001 DROP TABLE IF EXISTS `v_detalle_cuotas` */;

/*!50001 CREATE TABLE  `v_detalle_cuotas`(
 `idcuotas_detalle` int(11) ,
 `orden_char` varchar(10) ,
 `orden_cuota` int(11) ,
 `fecha_vto` date ,
 `cuota` decimal(10,2) ,
 `saldo_cuota` decimal(10,2) ,
 `ultimo_nro_recibo` varchar(11) ,
 `ultimo_atraso` int(11) ,
 `ultimo_importe` decimal(10,2) ,
 `ultima_Fecha_pago` date ,
 `ultimo_interes_calcu` decimal(10,2) ,
 `ultimo_descuento` decimal(10,2) ,
 `ultimo_totalac` decimal(10,2) ,
 `estado_detalle` enum('PEN','CAN') ,
 `estado_detalle_descripcion` varchar(9) ,
 `dias_atraso_actual` int(7) ,
 `dias_atraso_efectivo` int(7) ,
 `idcuotas` int(11) ,
 `fecha_cuota` date ,
 `factura_cuota` varchar(45) ,
 `cantidad_cuota` int(11) ,
 `primera_fecha_vto` date ,
 `total_cuota` decimal(10,0) ,
 `saldo_cuota_cabecera` decimal(10,2) ,
 `ultimo_fecha_pago` date ,
 `ultimo_importe_cabecera` decimal(10,2) ,
 `ultimo_interes_cabecera` decimal(10,2) ,
 `ultimo_descuento_cabecera` decimal(10,2) ,
 `ultimo_totalac_cabecera` decimal(10,2) ,
 `estado_cuota` enum('PEN','CAN') ,
 `estado_cuota_descripcion` varchar(9) ,
 `anulado` enum('SI','NO') ,
 `idVenta` int(11) ,
 `fecha_venta` date ,
 `nrofactura` varchar(20) ,
 `factura_completa` varchar(32) ,
 `total_venta` decimal(10,2) ,
 `total_gravada_excenta` decimal(11,0) ,
 `total_gravada_cinco` decimal(11,0) ,
 `total_gravada_diez` decimal(11,0) ,
 `liqui_iva_5` decimal(10,2) ,
 `liqui_iva_10` decimal(10,2) ,
 `total_liqui_iva` decimal(10,2) ,
 `idcliente` int(11) ,
 `cliente_nombre` varchar(45) ,
 `cliente_apellido` varchar(45) ,
 `cliente_nombre_completo` varchar(91) ,
 `cliente_ci` varchar(45) ,
 `cliente_ruc` varchar(45) ,
 `celular` varchar(20) ,
 `telefono` varchar(20) ,
 `referencia` text ,
 `trabajo_lugar` varchar(45) ,
 `trabajo_telefono` varchar(20) ,
 `zona` varchar(45) ,
 `barrio` varchar(45) ,
 `profesion` varchar(45) ,
 `idVendedor` int(11) ,
 `vendedor_nombre` varchar(91) ,
 `idcobrador` int(11) ,
 `cobrador_nombre` varchar(91) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `empresa` varchar(45) ,
 `total_pagado_detalle` decimal(11,2) ,
 `porcentaje_pagado_detalle` decimal(17,2) ,
 `situacion_pago` varchar(20) ,
 `nivel_mora` varchar(13) 
)*/;

/*Table structure for table `v_detalle_ventas_simple` */

DROP TABLE IF EXISTS `v_detalle_ventas_simple`;

/*!50001 DROP VIEW IF EXISTS `v_detalle_ventas_simple` */;
/*!50001 DROP TABLE IF EXISTS `v_detalle_ventas_simple` */;

/*!50001 CREATE TABLE  `v_detalle_ventas_simple`(
 `idVenta` int(11) ,
 `fecha_venta` date ,
 `hora` time ,
 `factura_completa` varchar(32) ,
 `tipo_venta` enum('CON','CRE') ,
 `tipo_venta_descripcion` varchar(7) ,
 `total_venta` decimal(10,2) ,
 `total_gravada_excenta` decimal(11,0) ,
 `total_gravada_cinco` decimal(11,0) ,
 `total_gravada_diez` decimal(11,0) ,
 `liqui_iva_5` decimal(10,2) ,
 `liqui_iva_10` decimal(10,2) ,
 `total_liqui_iva` decimal(10,2) ,
 `estado_venta` enum('F','A') ,
 `idcliente` int(11) ,
 `cliente_nombre_completo` varchar(91) ,
 `cliente_ci` varchar(45) ,
 `celular` varchar(20) ,
 `idDetalle` int(11) ,
 `cantidad` int(11) ,
 `precio_costo` decimal(10,2) ,
 `precio_venta` decimal(10,2) ,
 `subtotal` decimal(10,2) ,
 `iva` enum('0','5','10') ,
 `gravada_excenta` decimal(10,2) ,
 `gravada_cinco` decimal(10,2) ,
 `gravada_diez` decimal(10,2) ,
 `tipo_cuota` enum('CUOTA','CONTADO') ,
 `plan_cuota` varchar(45) ,
 `cant_cuota` int(10) ,
 `interes_mensual` decimal(10,2) ,
 `margen_conta` decimal(10,2) ,
 `monto_cuota` decimal(10,2) ,
 `idarticulo` int(11) ,
 `articulo_descripcion` varchar(100) ,
 `codbarra` varchar(45) ,
 `impuesto` enum('10','5','0') ,
 `costo_actual` decimal(10,2) ,
 `precio_contado` decimal(10,2) ,
 `idVendedor` int(11) ,
 `vendedor_nombre` varchar(91) ,
 `sucursal` varchar(45) ,
 `empresa` varchar(45) ,
 `deposito` varchar(45) 
)*/;

/*Table structure for table `v_personal` */

DROP TABLE IF EXISTS `v_personal`;

/*!50001 DROP VIEW IF EXISTS `v_personal` */;
/*!50001 DROP TABLE IF EXISTS `v_personal` */;

/*!50001 CREATE TABLE  `v_personal`(
 `idPersonal` int(11) ,
 `nombre` varchar(45) ,
 `apellido` varchar(45) ,
 `ci` varchar(25) ,
 `telefono` varchar(20) ,
 `Direccion` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) 
)*/;

/*Table structure for table `v_recibo` */

DROP TABLE IF EXISTS `v_recibo`;

/*!50001 DROP VIEW IF EXISTS `v_recibo` */;
/*!50001 DROP TABLE IF EXISTS `v_recibo` */;

/*!50001 CREATE TABLE  `v_recibo`(
 `idpago` int(11) ,
 `fecha` date ,
 `ci` varchar(45) ,
 `apellido` varchar(45) ,
 `nombre` varchar(45) ,
 `nro_recibo` varchar(45) ,
 `idcliente` int(11) ,
 `tota_importe` decimal(10,2) 
)*/;

/*Table structure for table `v_recibos_detallados` */

DROP TABLE IF EXISTS `v_recibos_detallados`;

/*!50001 DROP VIEW IF EXISTS `v_recibos_detallados` */;
/*!50001 DROP TABLE IF EXISTS `v_recibos_detallados` */;

/*!50001 CREATE TABLE  `v_recibos_detallados`(
 `idcuotas` int(11) ,
 `idpago` int(11) ,
 `fecha` date ,
 `nro_recibo` varchar(45) ,
 `orden_cuota` varchar(23) ,
 `orden_cuota_char` varchar(10) ,
 `factura` varchar(45) ,
 `concepto` varchar(64) ,
 `monto` decimal(10,2) ,
 `monto_cuota_original` decimal(10,2) ,
 `saldo_despues_pago` decimal(10,0) ,
 `tipo_pago` enum('CUOTA','OTRO') ,
 `fecha_vto` date ,
 `atraso` int(11) ,
 `idcliente` int(11) ,
 `cliente_nombre_completo` varchar(91) ,
 `cliente_ci` varchar(45) ,
 `cliente_celular` varchar(20) ,
 `fecha_venta` date ,
 `total_venta` decimal(10,2) ,
 `cobrador_nombre` varchar(91) ,
 `forma_pago` varchar(45) ,
 `estado_recibo` enum('COB','ANU') ,
 `estado_cuota` enum('PEN','CAN') 
)*/;

/*Table structure for table `v_subgrupo` */

DROP TABLE IF EXISTS `v_subgrupo`;

/*!50001 DROP VIEW IF EXISTS `v_subgrupo` */;
/*!50001 DROP TABLE IF EXISTS `v_subgrupo` */;

/*!50001 CREATE TABLE  `v_subgrupo`(
 `idgrupo` int(11) ,
 `grupo` char(45) ,
 `idsubgrupo` int(11) ,
 `subgrupo` varchar(45) 
)*/;

/*Table structure for table `v_sucursal` */

DROP TABLE IF EXISTS `v_sucursal`;

/*!50001 DROP VIEW IF EXISTS `v_sucursal` */;
/*!50001 DROP TABLE IF EXISTS `v_sucursal` */;

/*!50001 CREATE TABLE  `v_sucursal`(
 `idsucursal` int(11) ,
 `idEmpresa` int(11) ,
 `sucursal` varchar(45) ,
 `direccion` varchar(45) ,
 `telefono` varchar(20) ,
 `empresa` varchar(45) 
)*/;

/*Table structure for table `v_usuarios` */

DROP TABLE IF EXISTS `v_usuarios`;

/*!50001 DROP VIEW IF EXISTS `v_usuarios` */;
/*!50001 DROP TABLE IF EXISTS `v_usuarios` */;

/*!50001 CREATE TABLE  `v_usuarios`(
 `idusuario` int(11) ,
 `nick` varchar(48) ,
 `tipo` int(1) ,
 `clave` varchar(48) ,
 `tipo_descripcion` varchar(13) ,
 `nombre_completo` varchar(91) ,
 `idpersonal` int(11) ,
 `ci` varchar(25) ,
 `telefono` varchar(20) ,
 `Direccion` varchar(45) ,
 `sucursal` varchar(45) 
)*/;

/*Table structure for table `v_vendedores` */

DROP TABLE IF EXISTS `v_vendedores`;

/*!50001 DROP VIEW IF EXISTS `v_vendedores` */;
/*!50001 DROP TABLE IF EXISTS `v_vendedores` */;

/*!50001 CREATE TABLE  `v_vendedores`(
 `idVendedor` int(11) ,
 `tipo_vendedor` enum('INTERNO','EXTERNO') ,
 `idPersonal` int(11) ,
 `nombre` varchar(45) ,
 `apellido` varchar(45) ,
 `vendedor` varchar(91) ,
 `ci` varchar(25) ,
 `telefono` varchar(20) ,
 `direccion` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `empresa` varchar(45) 
)*/;

/*View structure for view v_articulo */

/*!50001 DROP TABLE IF EXISTS `v_articulo` */;
/*!50001 DROP VIEW IF EXISTS `v_articulo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_articulo` AS select `a`.`idarticulo` AS `idarticulo`,`a`.`descripcion` AS `descripcion`,`a`.`codbarra` AS `codbarra`,`a`.`idplan_cuota` AS `idplan_cuota`,`a`.`idMarca` AS `idMarca`,`a`.`idgrupo` AS `idgrupo`,`a`.`idsubgrupo` AS `idsubgrupo`,`a`.`idproveedor` AS `idproveedor`,`a`.`unidad` AS `unidad`,`a`.`ultima_fecha_compra` AS `ultima_fecha_compra`,`a`.`ultima_fecha_venta` AS `ultima_fecha_venta`,`a`.`ultima_fecha_ajuste` AS `ultima_fecha_ajuste`,`a`.`impuesto` AS `impuesto`,`a`.`margen_contado` AS `margen_contado`,`a`.`interes_mensual` AS `interes_mensual`,`a`.`limite_cuota` AS `limite_cuota`,`a`.`precio_costo` AS `precio_costo`,`a`.`precio_contado` AS `precio_contado`,`a`.`stockminimo` AS `stock_minimo`,`a`.`tipo_imagen` AS `tipo_imagen`,`a`.`foto` AS `foto`,`a`.`detalle` AS `detalle`,`m`.`Marca` AS `nombre_marca`,`g`.`grupo` AS `nombre_grupo`,`sg`.`subgrupo` AS `nombre_subgrupo`,`p`.`proveedor` AS `nombre_proveedor`,`p`.`ruc` AS `ruc_proveedor`,`pc`.`nombre_plan` AS `nombre_plan_cuota`,`pc`.`margen_contado` AS `margen_plan`,`pc`.`interes_mensual` AS `interes_plan`,`pc`.`limite_cuota` AS `limite_plan`,coalesce(`s`.`stock`,0) AS `stock_actual`,`s`.`iddeposito` AS `iddeposito`,`d`.`deposito` AS `nombre_deposito`,`s`.`idsucursal` AS `idsucursal`,`suc`.`sucursal` AS `nombre_sucursal` from ((((((((`articulo` `a` left join `marca` `m` on((`a`.`idMarca` = `m`.`idMarca`))) left join `grupo` `g` on((`a`.`idgrupo` = `g`.`idgrupo`))) left join `subgrupo` `sg` on((`a`.`idsubgrupo` = `sg`.`idsubgrupo`))) left join `proveedor` `p` on((`a`.`idproveedor` = `p`.`idproveedor`))) left join `plan_cuota` `pc` on((`a`.`idplan_cuota` = `pc`.`idplan_cuota`))) left join `stockarticulo` `s` on((`a`.`idarticulo` = `s`.`idarticulo`))) left join `deposito` `d` on((`s`.`iddeposito` = `d`.`iddeposito`))) left join `sucursal` `suc` on((`s`.`idsucursal` = `suc`.`idsucursal`))) */;

/*View structure for view v_barrio_zona */

/*!50001 DROP TABLE IF EXISTS `v_barrio_zona` */;
/*!50001 DROP VIEW IF EXISTS `v_barrio_zona` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_barrio_zona` AS select `b`.`idbarrio` AS `idbarrio`,`b`.`barrio` AS `barrio`,`b`.`idzona` AS `idzona`,`z`.`zona` AS `zona` from (`barrio` `b` join `zona` `z` on((`b`.`idzona` = `z`.`idzona`))) order by `b`.`idbarrio` */;

/*View structure for view v_clientes */

/*!50001 DROP TABLE IF EXISTS `v_clientes` */;
/*!50001 DROP VIEW IF EXISTS `v_clientes` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_clientes` AS select `c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `nombre_completo`,`c`.`ci` AS `ci`,`c`.`ruc` AS `ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`idzona` AS `idzona`,`z`.`zona` AS `zona`,`c`.`idbarrio` AS `idbarrio`,`b`.`barrio` AS `barrio`,`c`.`idprofesion` AS `idprofesion`,`p`.`profesion` AS `profesion`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`c`.`ref1` AS `ref1`,`c`.`ref2` AS `ref2`,`c`.`ref3` AS `ref3`,`c`.`reftel1` AS `reftel1`,`c`.`reftel2` AS `reftel2`,`c`.`reftel3` AS `reftel3`,concat(`b`.`barrio`,' - ',`z`.`zona`) AS `ubicacion_completa` from (((`cliente` `c` left join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) left join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) left join `profesion` `p` on((`c`.`idprofesion` = `p`.`idprofesion`))) */;

/*View structure for view v_cobradores */

/*!50001 DROP TABLE IF EXISTS `v_cobradores` */;
/*!50001 DROP VIEW IF EXISTS `v_cobradores` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_cobradores` AS select `cob`.`idcobrador` AS `idcobrador`,`p`.`idPersonal` AS `idPersonal`,concat(trim(`p`.`nombre`),' ',trim(`p`.`apellido`)) AS `nombre_completo`,`p`.`ci` AS `ci`,`p`.`telefono` AS `telefono`,`z`.`idzona` AS `idzona`,`z`.`zona` AS `zona`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal` from (((`cobrador` `cob` join `personal` `p` on((`cob`.`idPersonal` = `p`.`idPersonal`))) join `zona` `z` on((`cob`.`idzona` = `z`.`idzona`))) join `sucursal` `s` on((`p`.`idsucursal` = `s`.`idsucursal`))) order by `p`.`nombre`,`p`.`apellido` */;

/*View structure for view v_compra */

/*!50001 DROP TABLE IF EXISTS `v_compra` */;
/*!50001 DROP VIEW IF EXISTS `v_compra` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_compra` AS select `compra`.`nro_factura` AS `nro_factura`,`compra`.`fecha` AS `fecha`,`proveedor`.`proveedor` AS `proveedor`,`compra`.`idcompra` AS `idcompra`,`compra`.`idproveedor` AS `idproveedor` from (`compra` join `proveedor` on((`compra`.`idproveedor` = `proveedor`.`idproveedor`))) where (`compra`.`estado` = 'F') */;

/*View structure for view v_cuotas_ventas_clientes */

/*!50001 DROP TABLE IF EXISTS `v_cuotas_ventas_clientes` */;
/*!50001 DROP VIEW IF EXISTS `v_cuotas_ventas_clientes` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_cuotas_ventas_clientes` AS select `c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `cliente_nombre`,`c`.`apellido` AS `cliente_apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`ruc` AS `cliente_ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`z`.`zona` AS `zona`,`b`.`barrio` AS `barrio`,`prof`.`profesion` AS `profesion`,`v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,`v`.`hora` AS `hora`,`v`.`tipo` AS `tipo_venta`,(case `v`.`tipo` when 'CON' then 'CONTADO' when 'CRE' then 'CRÉDITO' end) AS `tipo_venta_descripcion`,`v`.`nrosuc` AS `nrosuc`,`v`.`nroexp` AS `nroexp`,`v`.`nrofactura` AS `nrofactura`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `factura_completa`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`total` AS `total_venta`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`cu`.`idcuotas` AS `idcuotas`,`cu`.`fecha` AS `fecha_cuota`,`cu`.`fecha_cancela` AS `fecha_cancela`,`cu`.`nrofactura` AS `factura_cuota`,`cu`.`cantidad_cuota` AS `cantidad_cuota`,`cu`.`primera_fecha_vto` AS `primera_fecha_vto`,`cu`.`total_venta` AS `total_cuota`,`cu`.`saldo_actual` AS `saldo_actual`,`cu`.`ultimo_fecha_pago` AS `ultimo_fecha_pago`,`cu`.`ultimo_importe` AS `ultimo_importe`,`cu`.`ultimo_interes_calc` AS `ultimo_interes_calc`,`cu`.`ultimo_descuento` AS `ultimo_descuento`,`cu`.`ultimo_totalac` AS `ultimo_totalac`,`cu`.`estado` AS `estado_cuota`,(case `cu`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_cuota_descripcion`,`cu`.`anulado` AS `anulado`,(select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'CAN'))) AS `cuotas_pagadas`,(select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'PEN'))) AS `cuotas_pendientes`,round((((select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'CAN'))) * 100.0) / `cu`.`cantidad_cuota`),2) AS `porcentaje_cuotas_pagadas`,`ven`.`idVendedor` AS `idVendedor`,concat(`pv`.`nombre`,' ',`pv`.`apellido`) AS `vendedor_nombre`,`cob`.`idcobrador` AS `idcobrador`,concat(`pc`.`nombre`,' ',`pc`.`apellido`) AS `cobrador_nombre`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa`,(`cu`.`total_venta` - `cu`.`saldo_actual`) AS `total_pagado`,round(((`cu`.`saldo_actual` / `cu`.`total_venta`) * 100),2) AS `porcentaje_pendiente`,(to_days(curdate()) - to_days(`cu`.`primera_fecha_vto`)) AS `dias_desde_primer_vencimiento` from (((((((((((`cliente` `c` join `venta` `v` on((`c`.`idcliente` = `v`.`idcliente`))) join `cuotas` `cu` on((`v`.`idVenta` = `cu`.`idVenta`))) join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) join `profesion` `prof` on((`c`.`idprofesion` = `prof`.`idprofesion`))) join `vendedor` `ven` on((`v`.`idVendedor` = `ven`.`idVendedor`))) join `personal` `pv` on((`ven`.`idPersonal` = `pv`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `pc` on((`cob`.`idPersonal` = `pc`.`idPersonal`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) where ((`v`.`estado` = 'F') and (`cu`.`anulado` = 'NO')) */;

/*View structure for view v_deposito */

/*!50001 DROP TABLE IF EXISTS `v_deposito` */;
/*!50001 DROP VIEW IF EXISTS `v_deposito` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_deposito` AS select `d`.`iddeposito` AS `iddeposito`,`d`.`deposito` AS `deposito`,`d`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa` from ((`deposito` `d` join `sucursal` `s` on((`d`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`s`.`idEmpresa` = `e`.`idEmpresa`))) */;

/*View structure for view v_detalle_cuotas */

/*!50001 DROP TABLE IF EXISTS `v_detalle_cuotas` */;
/*!50001 DROP VIEW IF EXISTS `v_detalle_cuotas` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_detalle_cuotas` AS select `cd`.`idcuotas_detalle` AS `idcuotas_detalle`,`cd`.`orden_char` AS `orden_char`,`cd`.`orden_cuota` AS `orden_cuota`,`cd`.`fecha_vto` AS `fecha_vto`,`cd`.`cuota` AS `cuota`,`cd`.`saldo_cuota` AS `saldo_cuota`,`cd`.`ultimo_nro_recibo` AS `ultimo_nro_recibo`,`cd`.`ultimo_atraso` AS `ultimo_atraso`,`cd`.`ultimo_importe` AS `ultimo_importe`,`cd`.`ultima_Fecha_pago` AS `ultima_Fecha_pago`,`cd`.`ultimo_interes_calcu` AS `ultimo_interes_calcu`,`cd`.`ultimo_descuento` AS `ultimo_descuento`,`cd`.`ultimo_totalac` AS `ultimo_totalac`,`cd`.`estado` AS `estado_detalle`,(case `cd`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_detalle_descripcion`,(to_days(curdate()) - to_days(`cd`.`fecha_vto`)) AS `dias_atraso_actual`,(case when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 0)) then (to_days(curdate()) - to_days(`cd`.`fecha_vto`)) else 0 end) AS `dias_atraso_efectivo`,`cu`.`idcuotas` AS `idcuotas`,`cu`.`fecha` AS `fecha_cuota`,`cu`.`nrofactura` AS `factura_cuota`,`cu`.`cantidad_cuota` AS `cantidad_cuota`,`cu`.`primera_fecha_vto` AS `primera_fecha_vto`,`cu`.`total_venta` AS `total_cuota`,`cu`.`saldo_actual` AS `saldo_cuota_cabecera`,`cu`.`ultimo_fecha_pago` AS `ultimo_fecha_pago`,`cu`.`ultimo_importe` AS `ultimo_importe_cabecera`,`cu`.`ultimo_interes_calc` AS `ultimo_interes_cabecera`,`cu`.`ultimo_descuento` AS `ultimo_descuento_cabecera`,`cu`.`ultimo_totalac` AS `ultimo_totalac_cabecera`,`cu`.`estado` AS `estado_cuota`,(case `cu`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_cuota_descripcion`,`cu`.`anulado` AS `anulado`,`v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,`v`.`nrofactura` AS `nrofactura`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `factura_completa`,`v`.`total` AS `total_venta`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `cliente_nombre`,`c`.`apellido` AS `cliente_apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`ruc` AS `cliente_ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`z`.`zona` AS `zona`,`b`.`barrio` AS `barrio`,`prof`.`profesion` AS `profesion`,`ven`.`idVendedor` AS `idVendedor`,concat(`pv`.`nombre`,' ',`pv`.`apellido`) AS `vendedor_nombre`,`cob`.`idcobrador` AS `idcobrador`,concat(`pc`.`nombre`,' ',`pc`.`apellido`) AS `cobrador_nombre`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa`,(`cd`.`cuota` - `cd`.`saldo_cuota`) AS `total_pagado_detalle`,round((((`cd`.`cuota` - `cd`.`saldo_cuota`) / `cd`.`cuota`) * 100),2) AS `porcentaje_pagado_detalle`,(case when (`cd`.`estado` = 'CAN') then 'COMPLETAMENTE PAGADO' when (`cd`.`saldo_cuota` = 0) then 'COMPLETAMENTE PAGADO' when ((`cd`.`saldo_cuota` < `cd`.`cuota`) and (`cd`.`saldo_cuota` > 0)) then 'PAGO PARCIAL' when (`cd`.`saldo_cuota` = `cd`.`cuota`) then 'SIN PAGOS' else 'ESTADO INDETERMINADO' end) AS `situacion_pago`,(case when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 30)) then 'MORA GRAVE' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 15)) then 'MORA MODERADA' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 0)) then 'MORA LEVE' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) <= 0)) then 'AL DÍA' else 'NO APLICA' end) AS `nivel_mora` from ((((((((((((`cuotas_detalle` `cd` join `cuotas` `cu` on((`cd`.`idcuotas` = `cu`.`idcuotas`))) join `venta` `v` on((`cu`.`idVenta` = `v`.`idVenta`))) join `cliente` `c` on((`v`.`idcliente` = `c`.`idcliente`))) join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) join `profesion` `prof` on((`c`.`idprofesion` = `prof`.`idprofesion`))) join `vendedor` `ven` on((`v`.`idVendedor` = `ven`.`idVendedor`))) join `personal` `pv` on((`ven`.`idPersonal` = `pv`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `pc` on((`cob`.`idPersonal` = `pc`.`idPersonal`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) where ((`v`.`estado` = 'F') and (`cu`.`anulado` = 'NO')) */;

/*View structure for view v_detalle_ventas_simple */

/*!50001 DROP TABLE IF EXISTS `v_detalle_ventas_simple` */;
/*!50001 DROP VIEW IF EXISTS `v_detalle_ventas_simple` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_detalle_ventas_simple` AS select `v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,`v`.`hora` AS `hora`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `factura_completa`,`v`.`tipo` AS `tipo_venta`,(case `v`.`tipo` when 'CON' then 'CONTADO' when 'CRE' then 'CRÉDITO' end) AS `tipo_venta_descripcion`,`v`.`total` AS `total_venta`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`v`.`estado` AS `estado_venta`,`c`.`idcliente` AS `idcliente`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`celular` AS `celular`,`dv`.`idDetalle` AS `idDetalle`,`dv`.`cantidad` AS `cantidad`,`dv`.`precosto` AS `precio_costo`,`dv`.`preventa` AS `precio_venta`,`dv`.`subtotal` AS `subtotal`,`dv`.`iva` AS `iva`,`dv`.`gravada_excenta` AS `gravada_excenta`,`dv`.`gravada_cinco` AS `gravada_cinco`,`dv`.`gravada_diez` AS `gravada_diez`,`dv`.`tipo_cuota` AS `tipo_cuota`,`dv`.`plan_cuota` AS `plan_cuota`,`dv`.`cant_cuota` AS `cant_cuota`,`dv`.`interes_mensual` AS `interes_mensual`,`dv`.`margen_conta` AS `margen_conta`,`dv`.`monto_cuota` AS `monto_cuota`,`a`.`idarticulo` AS `idarticulo`,`a`.`descripcion` AS `articulo_descripcion`,`a`.`codbarra` AS `codbarra`,`a`.`impuesto` AS `impuesto`,`a`.`precio_costo` AS `costo_actual`,`a`.`precio_contado` AS `precio_contado`,`ven`.`idVendedor` AS `idVendedor`,concat(`pv`.`nombre`,' ',`pv`.`apellido`) AS `vendedor_nombre`,`s`.`sucursal` AS `sucursal`,`e`.`empresa` AS `empresa`,`d`.`deposito` AS `deposito` from ((((((((`venta` `v` join `detalle_venta` `dv` on((`v`.`idVenta` = `dv`.`idVenta`))) join `cliente` `c` on((`v`.`idcliente` = `c`.`idcliente`))) join `articulo` `a` on((`dv`.`idarticulo` = `a`.`idarticulo`))) join `vendedor` `ven` on((`v`.`idVendedor` = `ven`.`idVendedor`))) join `personal` `pv` on((`ven`.`idPersonal` = `pv`.`idPersonal`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) left join `deposito` `d` on((`dv`.`iddeposito` = `d`.`iddeposito`))) where (`v`.`estado` = 'F') */;

/*View structure for view v_personal */

/*!50001 DROP TABLE IF EXISTS `v_personal` */;
/*!50001 DROP VIEW IF EXISTS `v_personal` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_personal` AS select `personal`.`idPersonal` AS `idPersonal`,`personal`.`nombre` AS `nombre`,`personal`.`apellido` AS `apellido`,`personal`.`ci` AS `ci`,`personal`.`telefono` AS `telefono`,`personal`.`Direccion` AS `Direccion`,`personal`.`idsucursal` AS `idsucursal`,`sucursal`.`sucursal` AS `sucursal` from (`personal` join `sucursal` on((`personal`.`idsucursal` = `sucursal`.`idsucursal`))) */;

/*View structure for view v_recibo */

/*!50001 DROP TABLE IF EXISTS `v_recibo` */;
/*!50001 DROP VIEW IF EXISTS `v_recibo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_recibo` AS select `pc`.`idpago` AS `idpago`,`pc`.`fecha` AS `fecha`,`c`.`ci` AS `ci`,`c`.`apellido` AS `apellido`,`c`.`nombre` AS `nombre`,`pc`.`nro_recibo` AS `nro_recibo`,`c`.`idcliente` AS `idcliente`,`pc`.`total_importe` AS `tota_importe` from (`pagos_cuotas` `pc` join `cliente` `c` on((`pc`.`idcliente` = `c`.`idcliente`))) where (`pc`.`estado` = 'COB') */;

/*View structure for view v_recibos_detallados */

/*!50001 DROP TABLE IF EXISTS `v_recibos_detallados` */;
/*!50001 DROP VIEW IF EXISTS `v_recibos_detallados` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_recibos_detallados` AS select `c`.`idcuotas` AS `idcuotas`,`pc`.`idpago` AS `idpago`,`pc`.`fecha` AS `fecha`,`pc`.`nro_recibo` AS `nro_recibo`,concat(`cd`.`orden_cuota`,'/',`c`.`cantidad_cuota`) AS `orden_cuota`,`cd`.`orden_char` AS `orden_cuota_char`,`c`.`nrofactura` AS `factura`,coalesce(`dpc`.`concepto`,concat('Cuota ',`cd`.`orden_char`,' - ',`c`.`nrofactura`)) AS `concepto`,`dpc`.`importe` AS `monto`,`dpc`.`cuota` AS `monto_cuota_original`,`dpc`.`saldo` AS `saldo_despues_pago`,`dpc`.`tipo_pago` AS `tipo_pago`,`dpc`.`fecha_vto` AS `fecha_vto`,`dpc`.`atraso` AS `atraso`,`cl`.`idcliente` AS `idcliente`,concat(`cl`.`nombre`,' ',`cl`.`apellido`) AS `cliente_nombre_completo`,`cl`.`ci` AS `cliente_ci`,`cl`.`celular` AS `cliente_celular`,`v`.`fecha` AS `fecha_venta`,`v`.`total` AS `total_venta`,concat(`p_cob`.`nombre`,' ',`p_cob`.`apellido`) AS `cobrador_nombre`,`tp`.`tipo` AS `forma_pago`,`pc`.`estado` AS `estado_recibo`,`cd`.`estado` AS `estado_cuota` from ((((((((`pagos_cuotas` `pc` join `detalle_pagos_cuotas` `dpc` on((`pc`.`idpago` = `dpc`.`idpago`))) join `cuotas_detalle` `cd` on((`dpc`.`idcuotas_detalle` = `cd`.`idcuotas_detalle`))) join `cuotas` `c` on((`cd`.`idcuotas` = `c`.`idcuotas`))) join `cliente` `cl` on((`pc`.`idcliente` = `cl`.`idcliente`))) join `venta` `v` on((`c`.`idVenta` = `v`.`idVenta`))) join `cobrador` `cob` on((`pc`.`idcobrador` = `cob`.`idcobrador`))) join `personal` `p_cob` on((`cob`.`idPersonal` = `p_cob`.`idPersonal`))) join `tipo_pago` `tp` on((`pc`.`idTipo_pago` = `tp`.`idTipo_pago`))) where (`pc`.`estado` = 'COB') order by `pc`.`fecha` desc,`pc`.`idpago` desc,`cd`.`orden_cuota` */;

/*View structure for view v_subgrupo */

/*!50001 DROP TABLE IF EXISTS `v_subgrupo` */;
/*!50001 DROP VIEW IF EXISTS `v_subgrupo` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_subgrupo` AS select `grupo`.`idgrupo` AS `idgrupo`,`grupo`.`grupo` AS `grupo`,`subgrupo`.`idsubgrupo` AS `idsubgrupo`,`subgrupo`.`subgrupo` AS `subgrupo` from (`subgrupo` join `grupo` on((`subgrupo`.`idgrupo` = `grupo`.`idgrupo`))) */;

/*View structure for view v_sucursal */

/*!50001 DROP TABLE IF EXISTS `v_sucursal` */;
/*!50001 DROP VIEW IF EXISTS `v_sucursal` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_sucursal` AS select `sucursal`.`idsucursal` AS `idsucursal`,`sucursal`.`idEmpresa` AS `idEmpresa`,`sucursal`.`sucursal` AS `sucursal`,`sucursal`.`direccion` AS `direccion`,`sucursal`.`telefono` AS `telefono`,`empresa`.`empresa` AS `empresa` from (`sucursal` join `empresa` on((`sucursal`.`idEmpresa` = `empresa`.`idEmpresa`))) */;

/*View structure for view v_usuarios */

/*!50001 DROP TABLE IF EXISTS `v_usuarios` */;
/*!50001 DROP VIEW IF EXISTS `v_usuarios` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_usuarios` AS select `u`.`idusuario` AS `idusuario`,`u`.`nick` AS `nick`,`u`.`tipo` AS `tipo`,`u`.`clave` AS `clave`,(case when (`u`.`tipo` = 1) then 'ADMINISTRADOR' when (`u`.`tipo` = 2) then 'VENDEDOR' when (`u`.`tipo` = 3) then 'COBRADOR' else 'Desconocido' end) AS `tipo_descripcion`,concat(trim(`p`.`nombre`),' ',trim(`p`.`apellido`)) AS `nombre_completo`,`p`.`idPersonal` AS `idpersonal`,`p`.`ci` AS `ci`,`p`.`telefono` AS `telefono`,`p`.`Direccion` AS `Direccion`,`s`.`sucursal` AS `sucursal` from ((`usuario` `u` join `personal` `p` on((`u`.`idPersonal` = `p`.`idPersonal`))) join `sucursal` `s` on((`p`.`idsucursal` = `s`.`idsucursal`))) where (`u`.`nick` is not null) */;

/*View structure for view v_vendedores */

/*!50001 DROP TABLE IF EXISTS `v_vendedores` */;
/*!50001 DROP VIEW IF EXISTS `v_vendedores` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_vendedores` AS select `v`.`idVendedor` AS `idVendedor`,`v`.`tipo_vendedor` AS `tipo_vendedor`,`p`.`idPersonal` AS `idPersonal`,`p`.`nombre` AS `nombre`,`p`.`apellido` AS `apellido`,concat(trim(`p`.`nombre`),' ',trim(`p`.`apellido`)) AS `vendedor`,`p`.`ci` AS `ci`,`p`.`telefono` AS `telefono`,`p`.`Direccion` AS `direccion`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`empresa` AS `empresa` from (((`vendedor` `v` join `personal` `p` on((`v`.`idPersonal` = `p`.`idPersonal`))) join `sucursal` `s` on((`p`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`s`.`idEmpresa` = `e`.`idEmpresa`))) */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
