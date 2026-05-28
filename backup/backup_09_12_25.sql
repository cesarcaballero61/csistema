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

/*Data for the table `ajuste_inventario` */

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

/*Data for the table `ajuste_inventario_detalle` */

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

/*Data for the table `anulacion_compra` */

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

/*Data for the table `anulacion_recibo` */

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

/*Data for the table `anulacion_venta` */

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

/*Data for the table `apecierrecaja` */

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
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8;

/*Data for the table `articulo` */

insert  into `articulo`(`idarticulo`,`descripcion`,`codbarra`,`idplan_cuota`,`idMarca`,`idgrupo`,`idsubgrupo`,`idproveedor`,`unidad`,`ultima_fecha_compra`,`ultima_fecha_venta`,`ultima_fecha_ajuste`,`impuesto`,`margen_contado`,`interes_mensual`,`limite_cuota`,`precio_costo`,`precio_contado`,`stockminimo`,`tipo_imagen`,`foto`,`detalle`) values 
(1,'AFEITADORA INALAMBRICA 3 EN 1 EB024 MULTILASE','00001',1,22,4,5,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://compumarket.com.py/storage/sku/HAFMUL001-3.jpg','Voltaje : Bivolt. Niveles de corte : 20. Resistencia : IPX5. Características : Recorta, hace contornos y afeita, Mango forrado de goma para mas seguridad, Batería recargable, Lamina de doble cara.'),
(2,'AFEITADORA PHILIPS ONEBLADE PRO QP6530/15','00002',1,23,4,5,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://www.efihogar.com.py/userfiles/images/productos/600/ph367.jpg','Batería de iones de litio recargable\r\nPeine preciso con 12 longitudes\r\nUso seco y húmedo\r\nIndicador de batería'),
(3,'AFEITADORA SEN 1 PREMIUN EB-11 MULTILASER','00003',1,21,4,5,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://artazasa.com.py/cdn/shop/files/77262.png?v=1699938091','Características destacadas:\r\nDiseño elegante en gris con negro y detalles naranjas.\r\nFunción bivolt para mayor versatilidad.\r\nMúltiples accesorios para diversas necesidades de afeitado y recorte.\r\nCuchillas y recortadores de varias medidas para precisión y personalización.\r\nIncluye micro afeitadora y recortador de detalles.\r\nBatería recargable con luz indicadora para un uso conveniente.\r\nBase organizadora para mantener los accesorios ordenados.\r\nDimensiones compactas de 170mm x 40mm x 40mm y peso ligero de 141g'),
(4,'AIRE ACONDICIONADOR CHIQ 12.000 BTU','00004',1,20,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://electrostock.com.py/assets/images/productos/c1e89bad_prod_102a1aeb4.jpg','Especificaciones: Respetuoso con el medio ambiente Gas ecológico R410A Filtro Lavable Pantalla Led Flujo de aire 3D'),
(5,'AIRE ACONDICIONADOR TOKYO 12.000BTU','00005',1,19,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://www.megared.com.py/storage/sku/tokyo-aires-split-btu-acond-de-aire-split-tokyo-xperience-12000-btu-fc-1-1-1725485053.jpg','Capacidad: 12.000 BTU\r\n3 niveles de filtración: Carbon activo, Ion de plata y Filtro Catalizador de frio.\r\nRango de temperatura: 16°C-30°C\r\nDisplay Led\r\nFunción Timer\r\nModo Turbo\r\nModo Silencio y Display Led Apagado\r\nModo Sueño\r\nAutolimpieza\r\nAuto restart\r\nBloqueo para niños\r\nFunción Swing Sway\r\nKit de Instalación: Cable de conexión de 3,5m, Tubería de cobre puro de 3m, Tubo de desagüe de 2m'),
(6,'AIRE CARRIER 12000 BTU','00006',1,18,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://pirapirepy.com.py/wp-content/uploads/2021/09/51237951_2483185698377389_8456205304860770304_n.jpg','12000 BTU\r\nGas ecologico\r\nFrio Calor\r\nSilencioso'),
(7,'AIRE GOODWEATHER 12.000 BTU','00007',1,11,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://inverfin.com.py/cdn/shop/files/99991627486306_AA.GW-12FO.12000BTU_0.jpg?v=1763560716&width=1946',''),
(8,'AIRE SPEED 12.000 BTU','00008',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://olier.com.py/storage/sku/speed-aire-split-aire-split-speed-st-pro-12000-btu-fc-1-1-1712753223.png',''),
(9,'AIRE SPEED 24000 BTU AIRE ACONDICIONADO TPRO','00009',1,17,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://www.matalon.com.py/6414-large_default/split-speed-24000-btu-aire-acondicionado-tpro-inverter-frio-calor-50-hz-con-soporte.jpg','• Marca: Speed\r\n• Modelo: SAT24B50H-TP3-INV.CS\r\n• Tipo: Split mural frío/calor Inverter\r\n• Capacidad: 24000 BTU/h\r\n• Potencia nominal: 2.4 HP aprox.\r\n• Alimentación: 220 V – 50 Hz\r\n• Gas refrigerante: R410A ecológico\r\n• Tecnología: Inverter de alta eficiencia energética\r\n• Funciones: Sleep, Turbo, Autolimpieza, Temporizador, Reinicio'),
(10,'AIRE SPEED18000 BTU','00010',1,17,2,2,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTIXFy2VPZsztnFgthEiExXwgaGy9EQ7A8c0w&s','• Marca: Speed\r\n• Modelo: SAT18B50H-G4 (Elite)\r\n• Tipo: Split mural frío/calor\r\n• Capacidad: 18000 BTU/h\r\n• Potencia nominal: 1.8 HP\r\n• Voltaje: 220 V – 50 Hz\r\n• Tecnología: Gas R410A ecológico\r\n• Funciones: Sleep, Turbo, Autolimpieza, Temporizador, Reinicio'),
(11,'AMOLADORA +3 DISCOS NAPPO NHA-055','00011',1,12,7,10,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://cdn.digi.com.py/storage/App/Models/ProductImage/000/000/403/image/large/NHA-055%20amoladora%20angular%2002.jpg','Potencia: 550W.\r\nVelocidad: 11.000RPM.\r\nDiámetro del disco: 115mm\r\nDiámetro de perforación del disco: 22.23 mm\r\nIncluye: 3 discos de corte'),
(12,'ANAFE VITROCERAMICO GAS Y ELECTRICO BEKO','00012',1,16,2,9,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://www.innovagame.com.py/24801-large_default/anafe-beko-4h-vitroceramico-hic64400e.jpg','El Anafe Vitrocerámico BEKO HIC64400E ofrece elegancia y eficiencia con su superficie de vidrio negro y cuatro zonas de cocción de alto rendimiento. Con controles táctiles y una potente zona de gran dimensión, facilita la preparación de tus platos favoritos. Sus funciones avanzadas, como el boost para calor rápido y el temporizador ajustable, garantizan una cocción precisa. Ideal para cualquier cocina moderna, combina diseño sofisticado con tecnología avanzada para una experiencia culinaria superior.'),
(13,'ASADERA DE VIDRIO FAMA OVALADAS 3X1','00013',1,8,6,6,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://cdn.shopify.com/s/files/1/0241/9487/5447/products/99991627127513_ASA.VID.FAM.OVA.3X1_0_350x@2x.jpg?v=1707852355',''),
(14,'ASADERA DE VIDRIO RECTANGULAR 4X1','00014',1,1,6,8,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://alboradastore.com.py/wp-content/uploads/2024/05/Captura-de-pantalla-2024-05-22-143809.png',''),
(15,'ASPIRADORA NAPPO  20LTS','00015',1,12,2,7,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://nissei.com/media/catalog/product/cache/24e3af3791642c18c52611620aeb2e21/n/l/nlai-028_1.jpg','Aspira polvo, líquido y funciona como soplador (de hojas)\r\nFiltro Hepa\r\nInterruptor On/Off waterproof (a prueba de agua).\r\nLigero y portátil\r\nIncluye manija ergonómica y 4 ruedas para mayor movilidad.\r\nCable de alimentación: 3.5 m.\r\nLugar para almacenamiento de accesorios\r\nEspacio de guardado del cable alrededor de la manija\r\nPresión de aspirado: > 17Kpa\r\nRuido: 80dBA.\r\nCertificado CE, ROHS, GS\r\nAccesorios incluidos: manguera flexible de 1.5m, 3 tubos metálicos, cepillo de piso (para piso seco y húmedo), boquilla.'),
(16,'AURICULAR INALAMBRICO KOLKE SENSE KBA-404','00016',1,9,5,6,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://cdn.digi.com.py/storage/App/Models/ProductImage/000/000/605/image/large/KAB-404_negro-2.jpg','Conexión inalámbrica V5.0 + EDR.\r\n-Batería recargable de 180mAh.\r\n-Slot para tarjeta Micro SD y conexión Aux 3,5mm.\r\n-Radio FM.\r\n-Incluye: Cable de audio y Cable de carga.\r\n-Disponible en color: Negro, Blanco, Azul y Rojo.'),
(17,'BALANZA ELECTRONICA NAPPO 40KG','00017',1,12,2,3,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://cdn.digi.com.py/storage/App/Models/ProductImage/000/001/376/image/large/Balanza%20Digital%20Nappo%20NEB-092.jpg',''),
(18,'BALCON ISIS MICRO HORNO CARVALHO','00018',1,13,3,4,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://www.saracomercial.com/storage/sku/nicioli-muebles-de-cocina-y-comedor-balcon-isis-micro-horno-carvalho-nature-1-1-1739219466.jpg','BALCON ISIS MICRO/HORNO CARVALHO NATURE MOVELMAX\r\nDescripción:\r\n - Para horno y microondas\r\n - Espacio para microondas (620x360) y horno (690x450).\r\n - Soporta hasta 40 kg de peso.\r\n - 2 puertas con divisoria interna\r\n - Manijas de plástico\r\n - Color Carvalho/Nature\r\nDimensiones:\r\n - Altura: 108,5cm\r\n - Largo o ancho: 69cm\r\n - Profundidad: 45cm'),
(19,'BALCON PIA ATLAS 120CM','00019',1,14,3,3,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://saracomercial.com/storage/sku/movelmax-muebles-de-cocina-y-comedor-balcon-pia-atlas-120-amendoaniagara-movelmax-1-1-1739391152.jpg','BALCON PIA ATLAS 1.20 AMENDOA/NIAGARA MOVELMAX\r\nDescripción:\r\n - 100% MDP\r\n - 3 Puertas\r\n - 1 cajón\r\n - Corredizas metálicas\r\n - Pies con altura regulable\r\n - 1 Estante interno\r\n - Manija de plástico\r\nMedidas:\r\n - Altura: 80 cm\r\n - Ancho: 120 cm\r\n - Profundidad: 51 cm\r\n - Medida de tapa 120 cm (Opcional, cotizar aparte)\r\n - Medida de pileta 1 cuba 120cm (Opcional, cotizar aparte)'),
(20,'BARBEADOR ECOPOWER EP388','00020',1,15,4,5,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,1.00,1.00,1,'URL','https://nissei.com/media/catalog/product/cache/b911b00b001dd445be642a5bd71957ac/c/o/corta_pelos_ecopower.jpg','Caracteristicas:\r\nMotor potente e de baixo ruído.\r\nLâmina cerâmica removível e lâmina revestida de titânio.\r\nAjuste fino de 1.0mm a 1.9mm.\r\nPente removível com 4 posições 3, 6, 9, 12mm.\r\nLED indicador de carga.'),
(21,'BATIDORA  ARNO MINI CHEFF','00021',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(22,'BATIDORA  PLANETARIA MOULINEX SUPER CHEF','00022',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(23,'BATIDORA BLACK+DECKER 2 LTS','00023',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(24,'BEBEDERO A PIE MIDEA ','00024',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(25,'BICICLETA CALOI  ARO 20','00025',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(26,'BICICLETA HOUSTON ARO 12','00026',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(27,'BICICLETA HOUSTON ARO 29 ','00027',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(28,'BICICLETA MILANO ACTION ARO 20','00028',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(29,'BICICLETA MILANO ACTION ARO 24','00029',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(30,'BICICLETA MILANO ACTION ARO 26','00030',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(31,'BICICLETA MILANO BAMBINO ARO 12','00031',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(32,'BICICLETA MILANO BAMBINO ARO 16','00032',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(33,'BICICLETA MILANO CHAMPIONE ARO 20','00033',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(34,'BICICLETA MILANO TORINO ARO 24','00034',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(35,'BICICLETA MILANO TORINO ARO 26','00035',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(36,'CAFETERA FAMA CF-1000','00036',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(37,'CAJA ACUSTICA GLB-15 GLOBE','00037',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(38,'CAJA ACUSTICA GLB-15R GLOBE','00038',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(39,'CAJA DE DINERO SPEED','00039',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(40,'CANDY CAMPANA PURIFICADOR 60CM','00040',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(41,'CARETA ELECTRONICA RESA ','00041',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(42,'CARTUCHERA BABYLISS PRO','00042',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(43,'CELULAR HONOR X7c 256gb','00043',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(44,'CELULAR SAMSUNG A04 128GB ','00044',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(45,'CELULAR SAMSUNG A15 128GB','00045',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(46,'CELULAR SAMSUNG A25 128GB','00046',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(47,'CENTRIFUGA 15 KG SUGGAR','00047',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(48,'CENTRIFUGA DRY MUELLER 8,8KG','00048',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(49,'CENTRIFUGA NINA MUELLER 8,8KG','00049',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(50,'CENTRIFUGA WANKE  9,9KG BELLA ECO','00050',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(51,'CENTRIFUGA WANKE SOFIA PREMIUM 20KG','00051',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(52,'CEPILLO DE PEINAR 6348 BABYLISS','00052',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(53,'COCINA  A GAS TOKYO 4 H NEGRO','00053',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(54,'COCINA 5H COOKTOP','00054',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(55,'COCINA A GAS 4H MUELLER FRATELLO VETRO','00055',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(56,'COCINA A GAS MUELLER 4H MODERATTO','00056',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(57,'COCINA REALCE IRIS GLASS 5 HORNALLAS ','00057',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(58,'COLCHON 140 NEO CONVENCIONAL','00058',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(59,'COLCHON NEO CONVENCIONAL 100X190','00059',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(60,'COLCHON NEO CONVENCIONAL 12X190','00060',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(61,'COLCHON PAR21 MAT 120x190','00061',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(62,'COLCHON PARANA PRIMAVERA 80X190 DENSIDAD 14','00062',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(63,'COLCHON PARD21 100x190','00063',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(64,'COLCHON PRIMAVERA 80X190','00064',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(65,'COMISION TIGO MONEY','00065',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(66,'COMODA 4 CAJON URSINO INFANTIL ','00066',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(67,'COMODA ASTRAL 4 CAJON','00067',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(68,'COMODA CAAGUAZU NACIONAL','00068',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(69,'COMODA VENEZA C/ ESPEJO ','00069',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(70,'COMPRESOR DE AIRE RESA 50 LTS','00070',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(71,'COMPRESOR RESA 100LTS 8BAR 3HP2P 220V','00071',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(72,'CONFITERA REFRIGERADA REFRIMATE 1.80','00072',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(73,'CONGELADOR CONSUL 220 LITROS','00073',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(74,'CONGELADOR CONSUL 310 LTS','00074',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(75,'CONGELADOR CONSUL 420 LITROS','00075',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(76,'CONGELADOR CONSUL 530 LITROS','00076',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(77,'CONGELADOR JET 117 LTS','00077',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(78,'CONSERVADORA COLEMAN 48QT','00078',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(79,'CONSERVADORA TERMICA ISOPOR 100 LTS ','00079',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(80,'CONSERVADORA TERMICA ISOPOR 170 LTS','00080',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(81,'CONSOLA DIGITAL SOUDCRAFT UI16 MIXER','00081',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(82,'CONSOLA SOUNDCRAF EON 6CH','00082',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(83,'CORTA BARBA PHILIPS BT3222/14','00083',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(84,'CORTA CABELLO BABYLISSPRO FX765','00084',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(85,'CORTA CABELLO FX880','00085',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(86,'CORTA CABELLO GOLD FERRARI BABYLISS','00086',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(87,'CORTA CABELLO PHILIPS ','00087',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(88,'CORTA CESPED  RESA 1300W SIN BOLSA','00088',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(89,'CORTA CESPED RESA 1050W SIN BOLSA','00089',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(90,'CORTA PELO PHILIPS HC7650/15 SERIE 7000','00090',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(91,'CORTA PELO WAHL A CABLE COLOR BLANCO SUPER TAPER','00091',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(92,'CORTA PELO WAHL LEGEND INALAMBRICO','00092',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(93,'CORTA PELO WAHL MAGIC CUP','00093',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(94,'CORTINA DE AIRE GOODWEATHER 1.5 METROS','00094',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(95,'CORTINA DE AIRE GOODWEATHER DE 1 METRO','00095',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(96,'CRISTAL PARA CELULAR','00096',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(97,'CUBIERTAS NEUPAR ','00097',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(98,'CUCHILLA REEMPLAZABLE ONEBLADE MODE QP210','00098',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(99,'CUNA CON COMODA','00099',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(100,'CUNA DE MADERA CARS CAAGUAZU C','00100',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(101,'DEPILADORA PHILIPS BRE225/  SATINELLE PIERNAS','00101',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(102,'DESMALEZADORA TRAPP A COMBUSTION 1.3','00102',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(103,'ELECTRODOMESTICOS','00103',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(104,'EQUIPO DE SOLDAR INVERTER ESTICK 200 CELLUSIC HUNGONG','00104',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(105,'EQUIPO DE SOLDAR INVERTER ESTICK 200 HUNGONG RESA','00105',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(106,'EQUIPO DE SOLDAR INVERTER RESA HUGONG','00106',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(107,'EQUIPO DE SONIDO LG 300W BT/USB','00107',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(108,'ESTANTE NINA','00108',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(109,'ESTUCHE PARA CELULAR','00109',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(110,'ESTUFA FAMA EF2012D','00110',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(111,'ESTUFA HALOGENA SPEED','00111',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(112,'EXIBIDOR FAMA 450LTS','00112',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(113,'EXIBIDOR GOODWEATHER 170LTS','00113',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(114,'EXIBIDOR GOODWEATHER 450 LTS','00114',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(115,'EXTRACTOR PURIFICADOR SUGGAR','00115',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(116,'FABRICADORA DE HIELO GOODWEATHER  15KG ','00116',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(117,'FIAMBRERA  3 PUERTAS PETEREVY','00117',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(118,'FIAMBRERA PETEREBY 2PTAS','00118',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(119,'FORRAJERA CID 1,5HP','00119',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(120,'FORRAJERA CID 7HP','00120',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(121,'FREIDORA SIN ACEITE NAPPO','00121',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(122,'GENERADOR RESA 6 KVA','00122',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(123,'HELADERA  MIDEA 300 LTS BLANCO','00123',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(124,'HELADERA CONSUL 300 LITROS','00124',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(125,'HELADERA CONSUL 360 LITROS','00125',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(126,'HELADERA ELECTROLUX FRIO SECO INOX 371LTS','00126',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(127,'HELADERA FRIGOBAR JAM 2 PTAS','00127',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(128,'HELADERA TOKYO 300LTS','00128',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(129,'HELADERA WHIRLPOOL 400/375 LTS','00129',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(130,'HIDROLAVADORA INDUSTRIAL LR28 ZM','00130',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(131,'HIDROLAVADORA SCHULZ 1400W','00131',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(132,'HIDROLAVADORA SPEED 1800W','00132',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(133,'HORNO ELECTRICO 50 LTS  JAM','00133',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(134,'HORNO ELECTRICO ATLAS 44LTS NEGRO 300000977','00134',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(135,'HORNO ELECTRICO INDUSTRIAL GASTROMAQ','00135',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(136,'HORNO ELECTRICO JAM 42LTS','00136',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(137,'HORNO ELECTRICO JAM SIRIUS 45 LTS','00137',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(138,'HORNO ELECTRICO MUELLER DELICCI','00138',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(139,'HORNO ELECTRICO MUELLER FRATELLO NEGRO','00139',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(140,'HORNO ELECTRICO MUELLER SONETTO','00140',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(141,'HORNO MICROONDAS WHIRLPOOL 30LTS ','00141',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(142,'iphone 11 128 gb','00142',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(143,'IPHONE 13 PRO ','00143',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(144,'JARRA ELECTRICA SPEED 1.5LTS BLANCO PLASTICO','00144',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(145,'JARRA ELECTRICA SPEED 2L NEGRO','00145',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(146,'JUEGO DE MESA 6 SILLAS GRANITO','00146',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(147,'JUEGO DE SILLON ARAÑA ','00147',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(148,'KIT CICINA MAGAZIN','00148',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(149,'KIT COCINA YARA BL NGRO','00149',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(150,'KIT DE HERRAMIENTAS NAPPO NHK 008','00150',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(151,'KIT DE HERRAMIENTAS NAPPO TALADRO INAL NHK 041','00151',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(152,'LAVARROPA AUTOMATICA TOKYO CECILIA 6 KG','00152',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(153,'LAVARROPA AUTOMATICO TOKYO CECILIA 8KG INVERTER','00153',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(154,'LAVARROPA BEKO 10,5 KG AUT','00154',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(155,'LAVARROPA MUELLER A PALETA 4.5 KG','00155',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(156,'LAVARROPA MUELLER ALLEGRA 10KG','00156',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(157,'LAVARROPA MUELLER FAMILY AQUATEC 10KG','00157',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(158,'LAVARROPA MUELLER POP TANK 5KG','00158',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(159,'LAVARROPA MUELLER SUPER POP 4KG','00159',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(160,'LAVARROPA MUELLER SUPERTANK 8KG','00160',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(161,'LAVARROPA SAMSUNG 13 KG AUTOMATICO','00161',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(162,'LAVARROPA WANKE CONFORT 12 KG','00162',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(163,'LAVARROPAS AUTOMATICO ELECTROLUX 12KG','00163',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(164,'LAVARROPAS WHIRLPOOL 13KG','00164',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(165,'LAVAVAJILLA BEKO','00165',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(166,'LICUADORA BEKO TBN8','00166',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(167,'LICUADORA OSTER 750WTS','00167',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(168,'LICUADORA PEABODY JARRA PLASTICO','00168',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(169,'LICUADORA PEABODY PS-SM181B','00169',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(170,'LICUADORA PHILIPS WALITA RI2110','00170',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(171,'LICUADORA PHILIS HR2105','00171',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(172,'MESA 4 SILLAS CAAGUAZU','00172',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(173,'MESA DE MADERA 10 SILLAS','00173',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(174,'MESA DE PLANCHAR ALTEZA','00174',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(175,'MESA DE PLANCHAR MOVEL MAX','00175',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(176,'MESA MADERA 6 SILLAS','00176',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(177,'MESA MADERA 8 SILLAS TAPIZADO','00177',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(178,'MESA PLEGABLE 4 SILLAS DE LAPACHO','00178',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(179,'METALCUBAS FREIDORA ELECTRICA 3LTS','00179',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(180,'METALCUBAS FREIDORA ELECTRICA 7LTS','00180',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(181,'MICROONDAS MIDEA 20LTS','00181',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(182,'MICROONDAS MIDEA 25LTS','00182',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(183,'MICROONDAS WHIRLPOOL 38LTS','00183',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(184,'MOLEDOR DE CARNE MOULINEX ','00184',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(185,'MOTOCICLETA KENTON GTR 150 CC','00185',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(186,'MULTIGROOM PHILIPS MG3731/15 DUAL CUT 8 ACC','00186',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(187,'MULTIPROCESADORA PHILIPS HR7301','00187',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(188,'MULTIUSO 1PTA CON ESPEJO ','00188',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(189,'MULTIUSO ROMA 2 PUERTAS','00189',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(190,'OLLA ELECTRICA ESTRELLA ','00190',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(191,'OLLA ELECTRICA SPEED ','00191',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(192,'PANTALON RI19 PARA HOMBRE','00192',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(193,'PANTALON VALENTIN ','00193',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(194,'PARLANTE AIWA S44 BT SWOOFER','00194',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(195,'PARLANTE JBL EON 715 PROFESIONAL','00195',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(196,'PARLANTE JBL MAX 15 PROFESIONAL','00196',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(197,'PARLANTE KOLKE KPB-372','00197',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(198,'PARLANTE KOLKE KPB-496','00198',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(199,'PARLANTE KOLKE KPB-498','00199',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(200,'PARLANTE KOLKE KPB 422','00200',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(201,'PARLANTE KOLKE KPB 433','00201',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(202,'PARLANTE KOLKE KPB 450','00202',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(203,'PARLANTE KOLKE KPB 490','00203',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(204,'PARLANTE KOLKE KPB 496','00204',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(205,'PARLANTE KOLKE KPB 515','00205',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(206,'PARLANTE KOLKE KPB 521','00206',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(207,'PARLANTE KOLKE LOOK KPM-438','00207',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(208,'PARRILLA DE TAMBOR 200lts','00208',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(209,'PARTYBOX JBL ENCORE ESSENTIAL C/MICROFONO','00209',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(210,'PERFUME MONIQUE HOMBRE ','00210',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(211,'PILETA 120X52 MDP 1 BACHA','00211',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(212,'PILETA 160X53 2 CUBAS CONCRETO','00212',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(213,'PILETA BESTWAY 4.678 LTS','00213',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(214,'PILETA BESTWAY 6.473 LTS','00214',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(215,'PILETA DE 1000LTS MOR CON ESTRUCTURA','00215',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(216,'PILETA DE 1500LTS MOR CON ESTRUCTURA','00216',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(217,'PILETA DE 400 LTS MOR INFANTIL','00217',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(218,'PILETA GHELL PLUS 120X53','00218',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(219,'PILETA GHELL PLUS 120X53 CONCRETADA','00219',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(220,'PISCINA INFLABLE INFANTIL 1000LTS','00220',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(221,'PLACA INFRAROJO DURABELLA','00221',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(222,'PLACA INFRARROJO TOKYO CON OLLA ','00222',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(223,'PLACA INFRARROJO TOKYO SIN  OLLA','00223',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(224,'PLACA VITROCERAMICA JAM','00224',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(225,'PLANCHA A VAPOR BEKO SIM3124D','00225',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(226,'PLANCHA JAM A VAPOR  VERTICAL','00226',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(227,'PLANCHA SECA PEABODY PE-PS30','00227',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(228,'PLANCHA VAPOR PEABODY PE-PVC33','00228',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(229,'PLANCHITA  BABYLISS ULTRA DELGADO ','00229',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(230,'PLANCHITA 2746 CONAIR','00230',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(231,'PLANCHITA CURL 2071 BABYLISS','00231',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(232,'PLANCHITA DE PELO FAMA LED PCF-2050','00232',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(233,'PLANCHITA DRY 4083 BABYLISS','00233',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(234,'PLANCHITA OPTIMA 3000 BABYLISS','00234',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(235,'PLAY STATION 5 1TB','00235',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(236,'PROYECTOR ACER 4000','00236',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(237,'RACK FIESTA','00237',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(238,'RACK FRANK','00238',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(239,'RACK ROYAL','00239',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(240,'RADIO ANALOGA BOLSILLO AIWA ','00240',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(241,'RADIO ANALOGA PORTATIL AIWA','00241',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(242,'RADIO ECOPOWER EP-F10','00242',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(243,'RADIO ECOPOWER EP F10B','00243',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(244,'RADIO JVC RD-N327','00244',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(245,'REDMI NOTE 10 5G','00245',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(246,'RELOJ AIWA SMART BAND MALLA FINO','00246',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(247,'RELOJ AIWATCH SPORT AW-SF6N','00247',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(248,'REMERA CON CUELLO DE HOMBRE','00248',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(249,'RIZADORA 3312 MIRACURL BABYLISS','00249',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(250,'ROPERO 1 PUERTA CAAGUAZU','00250',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(251,'ROPERO 3 PTAS  MADERA SEÑORITA PINTADO','00251',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(252,'ROPERO 3 PTAS PETEREVY','00252',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(253,'ROPERO COMODA CAPRI','00253',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(254,'ROPERO DE 3P PRINCE','00254',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(255,'ROPERO DE MADERA PETEREBY 2 PUERTAS','00255',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(256,'ROPERO ENCHAPADO 4 PUERTAS','00256',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(257,'ROPERO INFANTIL 4 P','00257',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(258,'ROPERO INFANTIL CAAGUAZU','00258',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(259,'ROPERO MONACO','00259',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(260,'ROPERO NEW SUICA 3PTAS DE PINO','00260',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(261,'ROPERO ROMA 3 PTAS','00261',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(262,'ROPERO ROMA 4 PUERTAS','00262',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(263,'SAMSUNG A 21S 128GB','00263',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(264,'SAMSUNG A01 16GB','00264',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(265,'SAMSUNG A01 32GB','00265',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(266,'SAMSUNG A02 32GB','00266',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(267,'SAMSUNG A21S DE 64GB','00267',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(268,'SAMSUNG A51 128GB','00268',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(269,'SAMSUNG S24 ULTRA 512 GB','00269',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(270,'SANDWICHERA FAMA SF-1006','00270',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(271,'SECADOR BLACK STAR B6200 BABYLISS','00271',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(272,'SECADOR DE PELO BABYLISS PRO BLACK ROSE','00272',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(273,'SECADOR DE PELO NAPPO ','00273',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(274,'SECADOR INFINITY PRO D6604 CONAIR','00274',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(275,'SECADOR INFITINI D361 CONAIR','00275',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(276,'SECARROPAS JAM 7KG','00276',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(277,'SHAVER DOUBLE FOIL FX02','00277',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(278,'SHAVER WAHL VANISH ','00278',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(279,'SIERRA CIRCULAR NAPPO SC-02','00279',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(280,'SIERRA FITA CARNICERO CON MOLINO MALTA','00280',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(281,'SILLA REPOSERA JAUMINA','00281',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(282,'SILLON 4 SILLAS MIMBRE REFORZADO','00282',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(283,'SILLON CABLE MINI CUADRADO','00283',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(284,'SILLON INFANTIL CUADRADITO','00284',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(285,'SILLON INFANTIL MIMBRE','00285',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(286,'SILLON INFANTIL REDONDO REFORZADO','00286',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(287,'SOFA 2 Y3 CON MESA ALTEZA','00287',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(288,'SOFA ESQUINERO BEIGE','00288',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(289,'SOFA MOVEL MAX  2 3','00289',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(290,'SOMIER IMPERIAL SUPER SPUMA 160','00290',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(291,'SOMIER PARANA CAPRICE 140','00291',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(292,'SOMIER PARANA CAPRICE 160','00292',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(293,'SOMIER PARANA ELEGANTE 200X200','00293',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(294,'SOMIER PARANA EXECUTIVE 100X190','00294',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(295,'SOMIER PARANA EXECUTIVE 160','00295',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(296,'SOMIER PARANA NEO CONVENCIONAL 140','00296',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(297,'SOMIER PARANA NEO CONVENCIONAL 160','00297',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(298,'SOMIER PLAY 100X190 UNICORNIO','00298',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(299,'SOMIER PLAY INFANTIL PARANA ','00299',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(300,'SOMIER SMILE PILLOW 160x200','00300',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(301,'SOMMIER EMOTION 140x190','00301',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(302,'SOMMIER EMOTION 160x200','00302',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(303,'SOMMIER SMILE PILLOW 140','00303',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(304,'SPEAKER ECOPOWER EP-2206','00304',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(305,'SPEAKER ECOPOWER EP-2213','00305',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(306,'SPEAKER ECOPOWER EP-2506','00306',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(307,'SPEAKER JBL CHARGE 5 ','00307',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(308,'SPEAKER JBL FLIP6','00308',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(309,'SPEAKER JBL GO4','00309',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(310,'SPEED COCINA INFRARROJO','00310',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(311,'SPEED PLANCHA SECA','00311',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(312,'SPRAY DESINF. ','00312',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(313,'TABLET SAMSUNG ','00313',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(314,'TELEVISOR AIWA LED DE 32','00314',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(315,'TELEVISOR KOLKE 425 LED SMART HDMI','00315',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(316,'TELEVISOR KONKA SMART DE 32','00316',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(317,'TELEVISOR WIN  32 SMART HD','00317',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(318,'TERMO FORRADO H MATTO','00318',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(319,'TITA ESTUFA 4 BANDEJAS','00319',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(320,'TITA ESTUFA P/ ALIMENTO 08 BANDEJAS','00320',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(321,'TOALET DE PELUQUERIA','00321',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(322,'TOCADOR  CAMARIN CARISMA','00322',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(323,'TOMASI HAMBUGESERA A GAS 90CM C 2.5m','00323',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(324,'TRIMMER WAHL DETAILER ','00324',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(325,'TV FAMA LED 32´´ TVF-32FS20 HD','00325',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(326,'TV FAMA SMART 40 ','00326',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(327,'TV JAM SMART 32 PULGADAS ','00327',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(328,'TV JAM SMART DE 50','00328',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(329,'TV KONKA DE 43 SMART','00329',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(330,'TV LED JAM 32','00330',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(331,'TV QUICK DE 22 PULGADAS','00331',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(332,'TV QUICK DE 24 PULGADAS','00332',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(333,'TV QUICK DE 26 PULGADAS','00333',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(334,'VENTILADOR DE PIE DURABELLA ALETA METAL','00334',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(335,'VENTILADOR DE PIE JAM FST-50','00335',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(336,'VENTILADOR DE TECHO RESA MOT PESADO','00336',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(337,'VENTILADOR DE TECHO WAHSON','00337',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(338,'VENTILADOR INDUSTRIAL A PIE TOKYO DE 30','00338',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(339,'VENTILADOR INDUSTRIAL DE PARED TOKYO DE 30','00339',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(340,'VITRINA CARNICERA GELOPAR 1.60MTS ','00340',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(341,'WANKE LAVARROPA 10KG','00341',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(342,'WANKE LAVARROPA 6 KG','00342',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(343,'XIAOMI NOTE 9 64GB','00343',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,''),
(344,'XIAOMI NOTE 9S 128','00344',1,1,1,1,1,'UNIDAD',NULL,NULL,NULL,'10',0.00,0.00,0,0.00,0.00,1,'LOCAL',NULL,'');

/*Table structure for table `barrio` */

DROP TABLE IF EXISTS `barrio`;

CREATE TABLE `barrio` (
  `idbarrio` int(11) NOT NULL AUTO_INCREMENT,
  `barrio` varchar(45) DEFAULT NULL,
  `idzona` int(11) DEFAULT NULL,
  PRIMARY KEY (`idbarrio`),
  KEY `idzona` (`idzona`),
  CONSTRAINT `barrio_ibfk_1` FOREIGN KEY (`idzona`) REFERENCES `zona` (`idzona`)
) ENGINE=InnoDB AUTO_INCREMENT=1725356 DEFAULT CHARSET=utf8;

/*Data for the table `barrio` */

insert  into `barrio`(`idbarrio`,`barrio`,`idzona`) values 
(1001,'NO INFORMADO',1),
(1002,'SAJONIA',1),
(1003,'SAN VICENTE',1),
(1004,'LAS MERCEDES',1),
(1005,'VILLA ANDRES RODRIGUEZ',1),
(1006,'SAN PABLO',1),
(1007,'LOMA PYTA',1),
(1008,'ITA ENRRAMADA',1),
(1009,'HIPODROMO',1),
(1010,'REPUBLICANO - OBRERO',1),
(1011,'VILLA AURELIA',1),
(1012,'VILLA MORRA',1),
(1013,'DR. G. R. DE FRANCIA',1),
(1014,'LA ENCARNACION',1),
(1015,'PETTIROSSI',1),
(1016,'TACUMBU',1),
(1017,'TRINIDAD',1),
(1018,'JARA',1),
(1019,'PINOZA',1),
(1020,'MBURICAO',1),
(1021,'CABALLERO',1),
(1022,'SAN ANTONIO',1),
(1023,'VISTA ALEGRE',1),
(1024,'MARIA AUXILIADORA',1),
(1025,'HERRERA',1),
(1026,'VILLA SOLEDAD',1),
(1027,'6TA COMPAÑIA MARAMBURE',1),
(1028,'BERNARDINO CABALLERO',1),
(1029,'SANTA MARIA',1),
(1030,'VILLA AURELIA',1),
(1031,'LA VICTORIA',1),
(1032,'IPVU',1),
(1033,'SAN RAFAEL',1),
(1034,'RECOLETA',1),
(1035,'LAS LOMAS',1),
(1036,'VILLA INDUSTRIAL II',1),
(1037,'VILLA POLICIAL',1),
(1038,'SANTA ANA',1),
(1039,'CAMPO GRANDE',1),
(1040,'MBURUCUYA',1),
(1041,'SAN BLAS',1),
(1042,'TEMBETARY',1),
(1043,'NAZARETH',1),
(1044,'NO CONFIRMADO',1),
(1045,'SAN FRANCISCO',1),
(1046,'NUESTRA SEÑORA DE ASUNCION',1),
(1047,'SAN JOSE',1),
(1048,'SINALCO',1),
(1049,'VILLA BONITA',1),
(1050,'CAÑADA',1),
(1052,'CALLE ULTIMA',1),
(1053,'SANTO DOMINGO',1),
(1054,'PUERTO PABLA',1),
(1055,'FRACCION EL BOSQUE',1),
(1056,'SAN JORGE',1),
(1057,'ROSEDAL',1),
(1058,'SAN PEDRO',1),
(1059,'GLORIA MARIA',1),
(1060,'LAGUNA SATI',1),
(1061,'3 DE MAYO',1),
(1062,'VILLA MIRTHA',1),
(1063,'SAN ROQUE',1),
(1064,'LA AMISTAD',1),
(1065,'UNIVERSO',1),
(1066,'SAN GERONIMO',1),
(1067,'LAS COLINAS',1),
(1068,'VILLA ALEGRE',1),
(1069,'LOS LAURELES',1),
(1070,'ITA PYTA PUNTA',1),
(1071,'MCAL. ESTIGARRIBIA',1),
(1072,'BARADERO',1),
(1073,'CRISTO REY',1),
(3001,'COCA COLA',1112),
(3002,'SAN ROQUE SANTACRUZ',1112),
(3003,'VILLA ANITA',1112),
(3004,'CAÑADITA',1112),
(3005,'CERRITO',1112),
(3006,'LAS NARANJAS',1112),
(3007,'PA-I ÑU',1112),
(3008,'FLORIDA',1112),
(3009,'WASHINGTON',1112),
(3010,'CENTRO',1112),
(3011,'CAAGUAZU',1112),
(3012,'SALONES DE ÑEMBY',1112),
(3013,'ACOSTA ÑU',1112),
(3014,'MBOKAJATY',1112),
(3015,'SAN CARLOS',1112),
(3016,'FRACCION LAS GOLONDRINAS',1112),
(3017,'SAN MIGUEL',1112),
(3018,'LA LOMITA',1112),
(3019,'SINALCO',1112),
(3021,'SOLARES',1112),
(101001,'SAN JOSE OBRERO',101),
(101002,'DEL BAÑADO',101),
(101003,'OBRERO',101),
(101004,'SAN LUIS',101),
(101005,'VILLA ALTA',101),
(101006,'INMACULADA',101),
(101007,'VILLA ARMANDO',101),
(101008,'FRACCION BERAUD',101),
(101009,'ITACURUBI',101),
(101010,'CENTRO',101),
(101011,'SAN ANTONIO',101),
(101012,'SECTOR POLIDEPORTIVO',101),
(101013,'SANTA MARIA',101),
(101014,'JARDIN DE EUROPA',101),
(101015,'PRIMAVERA',101),
(101016,'FATIMA',101),
(101017,'SAN FRANCISCO',101),
(101018,'SANTO DOMINGO DE GUZMAN',101),
(101019,'YVY JAÚ',101),
(101100,'CAACUPEMI 1',101),
(101110,'CIUDAD NUEVA',101),
(101120,'SALADILLO',101),
(101130,'SAN CARLOS',101),
(101140,'POTRERITO',101),
(101150,'CAACUPEMI 2',101),
(101160,'PANCHITO LOPEZ',101),
(101170,'EMILIO ROM',101),
(101180,'RIO 10 SAN NICOLAS',101),
(101190,'SAN BLAS',101),
(101200,'MARIA AUXILIADORA 1',101),
(101210,'SANTA ROSA',101),
(101220,'SAN JUAN YUI-Y',101),
(101230,'RINCON - I',101),
(101240,'POTRERO ROMERO',101),
(101250,'KOE PORA',101),
(101260,'COSTA PUCU',101),
(101270,'SAN RAMON',101),
(101280,'CURUZU ÑU',101),
(101300,'LAGUNA PLATILLO',101),
(101310,'JHUGUA GONZALEZ',101),
(101320,'PIRITY',101),
(101330,'PASO HORQUETA',101),
(101340,'PACURI',101),
(101350,'SAN ISIDRO',101),
(101360,'SAN VICENTE',101),
(101370,'JHUGUA RIVAS',101),
(101380,'CALLEJON FATIMA',101),
(101390,'COL. ROBERTO L. PETIT',101),
(101410,'PASO BARRETO',101),
(101420,'ISLA TUYU',101),
(101430,'ESTRIBO DE PLATA',101),
(101440,'COL. JUAN SEBASTIAN MIRANDA',101),
(101450,'VYA RENDA',101),
(101460,'EST. CLEMENTINA',101),
(101470,'EST. OLIVA SAN LIBERATO',101),
(101480,'PUENTEZIÑO',101),
(101490,'EST. PRIMAVERA',101),
(101500,'EST. ANTEBI',101),
(101510,'EST. CAMPITO',101),
(101520,'PUERTO FONCIERE',101),
(101530,'PUERTO ITACUA',101),
(101540,'PUERTO MBARIGUI',101),
(101550,'EST. GUERATI',101),
(101560,'PUERTO MAX',101),
(101570,'GAONA CUE',101),
(101580,'PEGUAJHO',101),
(101590,'COL. SAN ALFREDO',101),
(101600,'EST. NATALI',101),
(101610,'MARIA AUXILIADORA 2',101),
(101620,'BANCO CHACO-I',101),
(101630,'EST. ARRECIFE',101),
(101640,'LAUREL 1',101),
(101650,'EST. SAN LUIS',101),
(101660,'EST. MARUGAN',101),
(101670,'EST. SANTA HELENA',101),
(101680,'SAN ROQUE',101),
(101690,'FERREIRA CUE',101),
(101700,'LAUREL 2',101),
(101710,'URBANO',101),
(101999,'(NO INFORMADO)',101),
(102001,'VIRGEN DE LA PAZ',102),
(102002,'SALVADOR DEL MUNDO',102),
(102003,'SANTO DOMINGO',102),
(102004,'SAN RAFAEL',102),
(102100,'SANTO REY',102),
(102110,'KM 13',102),
(102120,'SAN LUIS 1',102),
(102130,'SAN FELIPE',102),
(102140,'CALLEJON SORIA',102),
(102150,'HIPICA',102),
(102160,'SAN ANTONIO',102),
(102170,'SAN LUIS 2',102),
(102180,'SAN ISIDRO',102),
(102190,'REQUEJO',102),
(102200,'POTRERITO',102),
(102210,'SAN MIGUEL',102),
(102220,'SANTA HELENA',102),
(102230,'URUNDEY',102),
(102240,'KM 25 A',102),
(102250,'NIÑO SALVADOR',102),
(102260,'MBOREBI YGUA',102),
(102270,'SANTA LUCIA',102),
(102280,'SANTO TOMAS',102),
(102290,'SANTA CRUZ',102),
(102300,'PEGUAJO MI',102),
(102310,'KM 25 B',102),
(102320,'SANTA LIBRADA',102),
(102330,'LEMOS',102),
(102999,'(NO INFORMADO)',102),
(103001,'SAN ROQUE',103),
(103002,'INMACULADA',103),
(103003,'FATIMA',103),
(103004,'LAS MERCEDES',103),
(103005,'LAS PALMAS',103),
(103006,'SAN ANTONIO',103),
(103100,'NARANJATY',103),
(103110,'YCUA HOVY',103),
(103120,'PIRITY',103),
(103130,'JUGUA OCAMPOS',103),
(103140,'SAN JORGE',103),
(103150,'PEGUAJHO MI',103),
(103160,'KM 28',103),
(103170,'SALINAS CUE',103),
(103180,'COSTA CLAVEL',103),
(103190,'BRASIL CUE',103),
(103200,'YBYRATY',103),
(103210,'EGUA',103),
(103220,'BELEN CUE',103),
(103230,'SANTO DOMINGO 1',103),
(103240,'MARIA AUXILIADORA',103),
(103250,'CRISTO REY',103),
(103260,'CURUZU SAN ROQUE',103),
(103270,'SAN FRANCISCO',103),
(103280,'CHINI',103),
(103290,'KM 30',103),
(103300,'KM 31',103),
(103310,'KM 34',103),
(103320,'PEGUAJHO LOMA',103),
(103330,'VILLA ALBA',103),
(103340,'SAN JOSE 1',103),
(103350,'PEGUAJHO BARRERO',103),
(103360,'PEGUAJHO GUAZU',103),
(103370,'SAGRADA FAMILIA',103),
(103380,'YCUA PORA',103),
(103390,'SAN MIGUEL',103),
(103400,'CABO CABRERA',103),
(103410,'CAPITAN SOSA',103),
(103420,'SANTO DOMINGO 2',103),
(103430,'PEGUAJHO POTY',103),
(103440,'PASO ITA',103),
(103450,'SANTA LIBRADA',103),
(103470,'SAN JOSE 2',103),
(103480,'CALLEJON BELEN',103),
(103490,'ESPAJIN',103),
(103500,'ARROYO PASITO',103),
(103510,'CARA CARA I',103),
(103520,'SAN FELIPE',103),
(103530,'LAGUNA 7',103),
(103540,'KM 44',103),
(103550,'COSTA ROMERO',103),
(103560,'SANTA ANA',103),
(103570,'CALLE 9 ORO VERDE',103),
(103580,'CALLE 8',103),
(103590,'CAPITAN GIMENEZ',103),
(103600,'TOLDO CUE',103),
(103610,'ALFONSO CUE',103),
(103620,'CEPINGO CAÐADA',103),
(103630,'TOTORA',103),
(103640,'CUARTELERO',103),
(103650,'PASO MBUTU',103),
(103660,'JHUGUA POI',103),
(103670,'CALLE 10 COLONIA ORO VERDE',103),
(103690,'25 DE ABRIL',103),
(103700,'CALLE 11',103),
(103710,'CUERO FRESCO',103),
(103720,'TACUARA',103),
(103730,'PRIMAVERA',103),
(103740,'ARROYO DE ORO',103),
(103750,'PASINO',103),
(103760,'COSTA AZUL',103),
(103770,'PASO TUYA',103),
(103780,'SAN RAFAEL',103),
(103790,'SAN BLAS',103),
(103800,'SAN ISIDRO',103),
(103810,'MILAGROSA',103),
(103820,'ASENTAMIENTO CAMPESINO',103),
(103830,'NUCLEO 4',103),
(103840,'NUCLEO 2',103),
(103850,'NUCLEO 3',103),
(103860,'NUCLEO 5',103),
(103880,'COL. CHOFERES DEL CHACO - FISC',103),
(103890,'CAÑADA SAN JUAN',103),
(103900,'ARROYITO',103),
(103910,'ESTANCIA SANTA SILVIA',103),
(103920,'8 DE DICIEMBRE',103),
(103930,'PEGUAJHO SAN FRANCISCO',103),
(103940,'PEGUAJHO POI',103),
(103950,'ARROYITO 2',103),
(103960,'ASOTEY',103),
(103999,'(NO INFORMADO)',103),
(104001,'FATIMA',104),
(104002,'SANTO DOMINGO',104),
(104003,'CENTRO',104),
(104004,'SAN FRANCISCO',104),
(104100,'LAS PALMAS',104),
(104110,'COL. CULANTRILLO',104),
(104120,'SAN JOSE MI',104),
(104130,'PIRITY',104),
(104140,'YCUA JHOVY',104),
(104150,'ZANJA CUE',104),
(104160,'VILLA DON BOSCO',104),
(104180,'SANTA LIBRADA',104),
(104190,'YCUA PORA',104),
(104200,'VIRGEN DEL CAMINO',104),
(104210,'JHUGUA POI',104),
(104220,'SAN MARCOS',104),
(104230,'JHUGUA TORALES SAN ROQUE',104),
(104240,'SAN VICENTE',104),
(104250,'DE LA ASUNCION',104),
(104260,'JHUGUA GUAZU',104),
(104270,'JHUGUA BONETE',104),
(104280,'ISLERIA',104),
(104290,'SANTO DOMINGO - PASO BARRETO',104),
(104300,'LAGUNA CRISTO REY',104),
(104310,'ANDERI',104),
(104320,'CAÐADA LA PAZ',104),
(104330,'COSTA FLORIDA',104),
(104999,'(NO INFORMADO)',104),
(106001,'URBANO',106),
(106100,'SANTO DOMINGO',106),
(106110,'ESTANCIA SANTA ANA',106),
(106120,'TRES CERROS',106),
(106130,'TAJAMAR 3 CERROS',106),
(106140,'YAGUARETE CUA',106),
(106150,'CERRO TIGRE',106),
(106160,'PLANCHADA 3',106),
(106170,'ESTANCIA 15 GANANDEROS',106),
(106180,'ESTANCIA YBYRANE',106),
(106190,'CALERIA SANTA ELENA',106),
(106200,'PUNTA',106),
(106210,'VIA PUNTA',106),
(106220,'SANTA ROSA',106),
(106230,'APA COSTA',106),
(106240,'CERRO CAMBA JHOPO',106),
(106250,'ZONA 1',106),
(106260,'CALERIA RISO',106),
(106270,'BARRIO SAN LAZARO SUR',106),
(106280,'BARRIO SAN LAZARO NORTE',106),
(106290,'ESTANCIA RISO',106),
(106300,'ESTANCIA ISLA PUCU',106),
(106310,'SANTA TERESITA',106),
(106320,'SAN RAMON',106),
(106330,'SAN ANTONIO',106),
(106340,'VIRGEN DE LORETO',106),
(106350,'SAN JUAN',106),
(106360,'SAN JOSE',106),
(106999,'(NO INFORMADO)',106),
(107001,'SAN RAMON',107),
(107002,'MARIA AUXILIADORA',107),
(107003,'VILLA REAL',107),
(107004,'SAN JUAN',107),
(107100,'BARRIO SAN PEDRO',107),
(107110,'SAN RAFAEL',107),
(107120,'TAPYTANGUA',107),
(107130,'VILLALBA CUE',107),
(107150,'NUEVA ESPERANZA',107),
(107160,'AZOTEY',107),
(107170,'ASENTAMIENTO JEPAYRA',107),
(107180,'CAAGATA',107),
(107190,'PASIÐO',107),
(107200,'ASENTAMIENTO 6 DE ENERO',107),
(107210,'CRISTO REY',107),
(107220,'SAN MIGUEL',107),
(107230,'EST. SANTA RITA',107),
(107240,'CAAGUY POTY RORY',107),
(107250,'LAGUNA 7',107),
(107260,'VILLA TORALES',107),
(107270,'SANTA LUCIA',107),
(107280,'SAN ROQUE GONZALEZ DE SANTA CR',107),
(107290,'MEDALLA MILAGROSA',107),
(107300,'SANTO DOMINGO',107),
(107310,'CRUCE BELLA VISTA',107),
(107320,'ESTABLECIMIENTO AQUIDABAN POTY',107),
(107330,'NARANJAY',107),
(107340,'CAÐADA AQUIDABAN',107),
(107350,'CIERVO POTRERO',107),
(107360,'CERRO APUA',107),
(107370,'CERRO CUPE',107),
(107380,'COL. BERNARDINO CABALLERO',107),
(107390,'CERRO MEMBY',107),
(107400,'SANTA ANA',107),
(107410,'PUNTA PORA ÐU',107),
(107420,'SAPUCAI',107),
(107430,'PASO JHU',107),
(107440,'MBARACAYAI',107),
(107450,'CERRO SARAMBI',107),
(107460,'COL. POMPEYA',107),
(107470,'BRAZOS UNIDOS',107),
(107480,'2DA ZONA SAPUCAI',107),
(107999,'(NO INFORMADO)',107),
(201001,'SAN RAFAEL',201),
(201002,'NUESTRA SEÐORA DE LA ASUNCION',201),
(201003,'INMACULADA CONCEPCION',201),
(201004,'SAN MIGUEL',201),
(201005,'SAN JOSE',201),
(201006,'ROQUE GONZALEZ',201),
(201007,'SANTA ANA',201),
(201008,'VIRGEN DE FATIMA',201),
(201009,'SAN RAMON',201),
(201010,'ZONA ALTA',201),
(201011,'LIMA',201),
(201100,'COSTA PUCU',201),
(201110,'PUERTO JEJUI',201),
(201120,'ESPARTILLAR',201),
(201130,'LOMA PYTA',201),
(201140,'TAPE CAAVY',201),
(201150,'ZOLABARRIETA',201),
(201160,'CAÐADA',201),
(201170,'PICADA FERNANDEZ',201),
(201180,'ROSARIO LOMA',201),
(201190,'ÐANDUCUA',201),
(201200,'CURUPAYTY',201),
(201210,'CHINGUI LOMA',201),
(201220,'YBAROTY',201),
(201230,'SAN JOSE 1',201),
(201240,'CORREA RUGUA',201),
(201250,'YATEBO',201),
(201260,'SGTO. LOMAS',201),
(201270,'VIRGEN DEL ROSARIO',201),
(201290,'YACARE ÐEE',201),
(201300,'AGUARAY SECO',201),
(201310,'SAN ROQUE',201),
(201320,'SAN JOSE 2',201),
(201330,'NARANJATY',201),
(201340,'JUGUA I',201),
(201350,'GARRIGOZA',201),
(201360,'AGUARAYMI',201),
(201370,'CORAZON DE JESUS',201),
(201390,'PIRI PUCU',201),
(201400,'CRUCE MBOCAYATY',201),
(201410,'CRUCE YPAYARE',201),
(201420,'JHUGUA GUAZU',201),
(201430,'JHUGUAI SOSA',201),
(201440,'CORPUS CRISTI',201),
(201450,'AGUARAY AMISTAD',201),
(201460,'SANTA CATALINA',201),
(201470,'PAZARET',201),
(201480,'SAN IGNACIO',201),
(201490,'COL. BARBERO',201),
(201500,'QUIINDY',201),
(201510,'SAGRADA FAMILIA',201),
(201520,'COSTA MARTINES',201),
(201540,'FONDO SAN BLAS',201),
(201550,'SAN PEDRO POTY',201),
(201560,'NARANJO',201),
(201570,'EST. BUEN TRAGO',201),
(201580,'INMACULADA',201),
(201590,'EST.ELIZABETH',201),
(201600,'EST. MONTANIA',201),
(201610,'EST. LOMA CLAVEL',201),
(201620,'PAU CUE',201),
(201630,'EST. GALIVE',201),
(201640,'PUERTO YVAPOBO',201),
(201650,'EST. SAN ISIDRO',201),
(201660,'SEGUNDA ZONA SAN ANTONIO',201),
(201670,'EST. NUEVA ESPERANZA',201),
(201680,'COL. SAN JUAN',201),
(201690,'YVAPOBO',201),
(201700,'PUERTO SANTA ROSA',201),
(201999,'(NO INFORMADO)',201),
(202001,'CURUZU CHICA',202),
(202002,'VIRGEN DE FATIMA',202),
(202003,'SANTO DOMINGO',202),
(202004,'SAN ROQUE GONZALEZ',202),
(202100,'EST. VIRADOLCE S.A.',202),
(202110,'KM 3',202),
(202120,'1RA VISTA',202),
(202130,'PICADA ANTEQUERA',202),
(202140,'LAGUNA VERA',202),
(202150,'ESTANCIA PY PORE',202),
(202160,'POROTO',202),
(202170,'PUERTO BARRANQUERITA',202),
(202999,'(NO INFORMADO)',202),
(203001,'SANTISIMA TRINIDAD',203),
(203002,'SANTA LUCIA',203),
(203003,'SAN VICENTE',203),
(203004,'SANTA ANA',203),
(203005,'SAN ROQUE GONZALEZ',203),
(203100,'NUCLEAR 2',203),
(203120,'CRUCE LIBERACION',203),
(203130,'BARRIO SANTA LIBRADA',203),
(203140,'BARRIO SAN JORGE OESTE',203),
(203150,'BARRIO SAN MIGUEL',203),
(203160,'KOE PYTA 1',203),
(203170,'BARRIO BOQUERON',203),
(203190,'BARRIO SAN JORGE ESTE',203),
(203200,'COLONIA FELICIDAD',203),
(203210,'SAN JORGE',203),
(203220,'SAN JORGE JEJUI',203),
(203230,'MBOCAYA',203),
(203240,'SANTA HELENA',203),
(203250,'BARRIO FATIMA',203),
(203260,'KOE PYTA 2',203),
(203280,'BARRIO SAN JOSE',203),
(203290,'BARRIO OVETENSE',203),
(203300,'1RO DE MARZO',203),
(203310,'JEJUI',203),
(203320,'BARRIO NIÐO JESUS',203),
(203330,'BARRIO SAN ISIDRO',203),
(203350,'BARRIO SAN ROQUE',203),
(203360,'COL. INDUSTRIAL CUE',203),
(203370,'BARRIO SAN AGUSTIN',203),
(203380,'CHORE 1',203),
(203390,'CHORE MI',203),
(203400,'PLACIDO',203),
(203410,'NARANJA HAI',203),
(203420,'ALFONSO LOMA',203),
(203430,'CALLE SAN ANTONIO',203),
(203440,'MONSEÐOR AQUINO',203),
(203450,'MARTILLO',203),
(203460,'NUCLEAR 3',203),
(203470,'NUCLEAR 1',203),
(203480,'SANTO DOMINGO',203),
(203490,'PANE CUE',203),
(203500,'BARRIO SAN ANTONIO',203),
(203510,'SAN LUIS',203),
(203520,'JHUGUA POTI',203),
(203530,'BARRIO 25 DE MAYO',203),
(203540,'CALLE PYTA',203),
(203550,'COL. COE POTI',203),
(203560,'YCUA PORA',203),
(203570,'NACIENTE AYALA CUE',203),
(203580,'COE POTI 2DA',203),
(203590,'2DA LINEA YCUA PORA',203),
(203600,'3RA LINEA YCUA PORA',203),
(203610,'SAN SEBASTIAN',203),
(203620,'RAIMUNDO CUE',203),
(203630,'PUERTO LA NIÐA',203),
(203640,'15 DE AGOSTO',203),
(203650,'COL. LIBERACION',203),
(203660,'SAN FRANCISCO',203),
(203670,'STA. ROSA',203),
(203680,'CAMPESINO I',203),
(203690,'MARIA AUXILIADORA KOKUERA',203),
(203700,'SANTA LUCIA KOKUERA',203),
(203710,'SAN BLAS KOKUERA',203),
(203720,'SAN ANTONIO KOKUERA',203),
(203730,'SAGRADA FAMILIA',203),
(203740,'SAN RAFAEL',203),
(203760,'SAN ANTONIO - COL. ALEGRIA',203),
(203999,'(NO INFORMADO)',203),
(204001,'SANTA LIBRADA',204),
(204002,'VILLA NUEVA',204),
(204003,'SAN JOSE',204),
(204004,'AEROPUERTO',204),
(204005,'SAN FRANCISCO',204),
(204006,'CAÐADA',204),
(204007,'FATIMA',204),
(204008,'SANTA ISABEL',204),
(204009,'SAN ANTONIO',204),
(204010,'SAN PEDRO',204),
(204011,'PROGRESO',204),
(204100,'MANDYJU TYGUE',204),
(204110,'REDONDO',204),
(204120,'SAN ROQUE',204),
(204130,'CHAMORRO CUE',204),
(204140,'ÐUMBUE',204),
(204150,'BARRIO PRIMERO DE MARZO',204),
(204160,'SARGENTO CASTIGLIONI',204),
(204170,'JHUGUA PO I',204),
(204190,'PIRAY',204),
(204200,'SANTA CLARA',204),
(204210,'LLANTEN',204),
(204220,'AGUILERA CUE',204),
(204230,'YCUA PINDO',204),
(204240,'CAMPO VIRGEN',204),
(204250,'SAN RAMON',204),
(204260,'SAN LUIS',204),
(204270,'SAN VICENTE',204),
(204280,'MARIA AUXILIADORA',204),
(204290,'YCUA RUGUA',204),
(204310,'ITAPE',204),
(204320,'SAN ISIDRO',204),
(204330,'CAMPO ARASA',204),
(204340,'CORRALES',204),
(204350,'JHURUHEY',204),
(204360,'NORTE POTY',204),
(204370,'PINDOTY',204),
(204380,'JHUGUA GUAZU',204),
(204390,'JHUGUA REY',204),
(204999,'(NO INFORMADO)',204),
(205001,'SAN JOSE',205),
(205002,'SAN RAFAEL',205),
(205003,'SAN ANTONIO',205),
(205004,'SAN FRANCISCO',205),
(205100,'YATEVU',205),
(205110,'PEGUAJHO',205),
(205120,'CAMPOS VIRGEN',205),
(205130,'SGTO. MOREL',205),
(205140,'JUGUA PORA',205),
(205150,'SGTO. CASTIGLIONI 1',205),
(205160,'CAPILLA JHUGUA',205),
(205170,'AGUAPEY',205),
(205180,'COL. GRAL CACERES',205),
(205190,'JHUGUA I',205),
(205200,'RAMOS',205),
(205210,'RIO RUGUA',205),
(205220,'LAGUNA MOJON',205),
(205230,'ISLA CARAYA',205),
(205240,'CAROLINA',205),
(205250,'SGTO. CASTIGLIONI 2',205),
(205260,'COL. SAN ALFREDO',205),
(205270,'COL. FRIESLAND',205),
(205280,'COL. TUYANGO',205),
(205290,'POTRERO YVATE',205),
(205999,'(NO INFORMADO)',205),
(206001,'INMACULADA CONCEPCION',206),
(206002,'SAN FRANCISCO',206),
(206003,'SAN JOSE',206),
(206100,'COSTA PUCU',206),
(206110,'CEDRAN CUE',206),
(206120,'CAÐADA',206),
(206130,'PASO TUNA',206),
(206140,'CARUMBEY 1',206),
(206150,'CARUMBEY 2',206),
(206160,'SGTO MONTANIA',206),
(206170,'VIERCI CUE ( NARANJA I )',206),
(206180,'LOMA CLAVEL',206),
(206190,'AMISTAD DEL NORTE ( YBYRA PETE',206),
(206200,'YBYPE',206),
(206210,'NIÐO MARTIR',206),
(206220,'MARISCAL LOPEZ',206),
(206230,'SAN LORENZO',206),
(206240,'PRIMAVERA',206),
(206250,'NARANJA TY',206),
(206260,'SANGUINA CUE',206),
(206999,'(NO INFORMADO)',206),
(207001,'URBANO',207),
(207002,'SALINA',207),
(207100,'PACOLO (RIO VERDE)',207),
(207110,'COL. RIO VERDE',207),
(207120,'NUEVO MEXICO',207),
(207130,'ASENTAMIENTO LA VICTORIA',207),
(207140,'25 DE DICIEMBRE',207),
(207150,'COSTA NORTE (ASENTAMIENTO  VYA',207),
(207160,'MARIA AUXILADORA',207),
(207170,'ASENTAMIENTO COLONIA',207),
(207180,'TACURUTY',207),
(207190,'CHAMORRO CUE (RINCON)',207),
(207200,'CERRITO',207),
(207210,'CHACO-I',207),
(207220,'COSTA AZUL',207),
(207999,'(NO INFORMADO)',207),
(208001,'SAN JOSE OBRERO',208),
(208002,'TAPIRACUAI',208),
(208003,'SANTA BARBARA',208),
(208004,'SAN ANTONIO',208),
(208005,'CORONEL MONGELOS',208),
(208006,'MONTE ALTO',208),
(208007,'DOS BOCAS',208),
(208100,'COLONIA PRIMAVERA',208),
(208110,'CERRO VERDE',208),
(208120,'NARANJA TY',208),
(208130,'BOLA CUA',208),
(208140,'3 DE FEBRERO',208),
(208150,'TRIGAL',208),
(208160,'YVU PORA',208),
(208170,'OGA LATA',208),
(208180,'YRYVU CUA',208),
(208190,'VY A RENDA',208),
(208200,'CALLE 12000 BERTONI',208),
(208210,'SANTA ISABEL',208),
(208220,'CALLE 10000 BERTONI',208),
(208230,'SAN ROQUE',208),
(208240,'CALLE 8000 BERTONI',208),
(208250,'CALLE 1o LINEA SANGUINA CUE',208),
(208260,'CALLE 2o LINEA SANGUINA CUE',208),
(208270,'CALLE 3o LINEA SANGUINA CUE',208),
(208280,'CALLE 4o LINEA SANGUINA CUE',208),
(208290,'CALLE 6000 MARENGO',208),
(208300,'CALLE 8000 MARENGO',208),
(208310,'CALLE 10000 MARENGO',208),
(208320,'ALEMAN CUE',208),
(208330,'2 DE MAYO ( ASENT ARA PYAJHU )',208),
(208340,'CALLE 6000 BERTONI',208),
(208350,'PALOMITA',208),
(208360,'CALLE 4000 BERTONI',208),
(208370,'TACURUTY (MARENGO)',208),
(208380,'CALLE 2000 BERTONI',208),
(208390,'CAÐADA SANTA ROSA',208),
(208400,'CALLE 16 DE JULIO',208),
(208410,'ACHITA',208),
(208420,'YBYCUI (CALLE 2000)',208),
(208430,'ORIENTAL',208),
(208440,'YHU RUGUA',208),
(208450,'CALLE 1000 BERTONI',208),
(208460,'VACA JHU',208),
(208470,'CALLE 6000',208),
(208480,'CURURU JHO',208),
(208490,'NOVIRETA (SAN ANTONIO)',208),
(208500,'CRUCE BERTONI',208),
(208510,'CALLE 8000',208),
(208520,'ARROYO GUAZU',208),
(208530,'YATAITY CORA',208),
(208540,'TAPIRACUAI',208),
(208550,'SAN JUAN',208),
(208560,'CALLE 10000',208),
(208570,'SAN BLAS',208),
(208580,'SAN ISIDRO',208),
(208590,'CALLE 12000',208),
(208600,'ITAPE BUY',208),
(208610,'SIRATY',208),
(208620,'REPUBLICANO',208),
(208630,'TACUARA',208),
(208640,'CONAVI',208),
(208650,'CALLE 1o DE MARZO',208),
(208660,'ÐU POI',208),
(208670,'CERRITO (CALLE 40)',208),
(208690,'LOURDES (CALLE LIMPIO)',208),
(208700,'COSTA PUCU',208),
(208710,'CALLE 40',208),
(208720,'GUAICA',208),
(208730,'LAS MERCEDES',208),
(208740,'TRAPICHE CUE',208),
(208750,'SAN ISIDRO SEGUNDA',208),
(208760,'ARROYO MOROTI',208),
(208770,'CALLE SAN FRANCISCO',208),
(208780,'CALLE 20 DE ENERO',208),
(208790,'SANTA ANA',208),
(208800,'6 DE ENERO',208),
(208810,'CAAGUY POTY',208),
(208820,'CALLE 1o DE MAYO',208),
(208830,'CALLE SAN PABLO',208),
(208840,'SAN FELIPE',208),
(208850,'CALLE SAN IGNACIO',208),
(208860,'CALLE ARROYENSE',208),
(208870,'CALLE SAN JORGE',208),
(208880,'SAN ANTONIO',208),
(208890,'SANTO DOMINGO',208),
(208900,'SAN VALENTIN',208),
(208910,'TAPIRACUAI LOMA',208),
(208999,'(NO INFORMADO)',208),
(209001,'URBANO',209),
(209100,'TATARE NORTE',209),
(209110,'RUTARA',209),
(209120,'TATARE SUR',209),
(209130,'SAN RAMON',209),
(209140,'SAN ANTONIO',209),
(209150,'CERRITO 1RO',209),
(209160,'CERRITO 2DO',209),
(209999,'(NO INFORMADO)',209),
(210001,'VIRGEN DEL CARMEN',210),
(210002,'AMAMBAY',210),
(210003,'SANTA ROSA',210),
(210004,'SAN PEDRO',210),
(210005,'MARIA AUXILIADORA',210),
(210006,'NUESTRA SEÐORA DE LA ASUNCION',210),
(210100,'PLANTA 1',210),
(210110,'SANTA MARIA',210),
(210120,'COLONIA SANTA CLARA',210),
(210130,'MBARACA',210),
(210140,'COLONIA MANITOBA',210),
(210150,'ESTANCIA PERONI',210),
(210160,'ESTANCIA ALEGRIA',210),
(210170,'CRUCE TACUATI',210),
(210180,'POTRERO OCULTO',210),
(210190,'LOMA PYTA',210),
(210200,'SEGUNDA LINEA',210),
(210210,'TORO ÐU',210),
(210220,'TERCERA ZONA',210),
(210230,'COSTA BARRIAL',210),
(210240,'COLONIA OÐONDIVEPA',210),
(210250,'SAN PEDRO POTY',210),
(210260,'SENDERO DEL NORTE',210),
(210270,'PLANTA 2',210),
(210999,'(NO INFORMADO)',210),
(211001,'MARIA GORETTI',211),
(211002,'SAN JOSE',211),
(211003,'SAN ROQUE',211),
(211004,'SANTA CATALINA',211),
(211100,'POTRERO JARDIN',211),
(211110,'COLONIA COBA CUE',211),
(211120,'CANADA SANTA MARIA',211),
(211130,'POTRERITO',211),
(211140,'CAMBAY',211),
(211150,'SANTO DOMINGO',211),
(211160,'SANTA CATALINA',211),
(211170,'SAN ANTONIO',211),
(211180,'SAN BLAS',211),
(211190,'CAÐADA',211),
(211200,'SAN MIGUEL',211),
(211999,'(NO INFORMADO)',211),
(212001,'URBANO',212),
(212002,'TRRTRT',212),
(212100,'SAN ISIDRO',212),
(212110,'SAN JOSE',212),
(212120,'SAN FRANCISCO (ISLA JOVY)',212),
(212130,'CAÐADA LOURDES',212),
(212140,'COLONIA NAVIDAD',212),
(212150,'SAN RAMON',212),
(212160,'SAN IGNACIO',212),
(212170,'MBOI Y',212),
(212180,'POTRERO YBATE',212),
(212190,'TORIN CUE',212),
(212200,'VIRGEN DEL CARMEN',212),
(212210,'CELADOR',212),
(212220,'COSTA NUEVA',212),
(212230,'SAN MIGUEL',212),
(212240,'SAN PABLO',212),
(212250,'VIRGEN DEL ROSARIO',212),
(212260,'SAN JUAN BOSCO',212),
(212270,'YCUA GUAZU (SANTA ROSA)',212),
(212999,'(NO INFORMADO)',212),
(213001,'SANTA TERESITA',213),
(213002,'SAN BLAS',213),
(213003,'INMACULADA',213),
(213004,'SANTA MARIA GORETTI',213),
(213005,'SAN LUIS',213),
(213006,'SAN JOSE',213),
(213007,'PUERTO ROSARIO',213),
(213100,'COL. ESCALERA',213),
(213110,'PUERTO AMISTAD',213),
(213120,'2DA. RECONSTRUCCION',213),
(213130,'KERAMBU',213),
(213140,'EST. LOMAS',213),
(213160,'VALLEMI',213),
(213170,'CAACUPE I',213),
(213180,'ÐANDUCUA I',213),
(213190,'COSTA PUCU DEL ROSARIO',213),
(213200,'SANTA ROSA',213),
(213210,'SAN JOSE DEL ROSARIO',213),
(213220,'SAN ANTONIO',213),
(213230,'MBOPICUA',213),
(213240,'MALVINAS',213),
(213250,'MURUKUY',213),
(213260,'COSTA PUCU DEL SAN JOSE',213),
(213270,'COL. VOLENDAN',213),
(213999,'(NO INFORMADO)',213),
(214001,'URBANO',214),
(214100,'COL ESTRELLITA',214),
(214110,'SANTA RITA',214),
(214120,'ISLA ALTA',214),
(214130,'AÐA RETA I (SAN JOSE)',214),
(214140,'SAN VICENTE (PANCHOLO)',214),
(214150,'SAN MIGUEL',214),
(214160,'KAATY I',214),
(214170,'8 DE DICIEMBRE',214),
(214180,'CALLE 1 DE MAYO',214),
(214190,'COSTA RICA',214),
(214200,'QUIINDY',214),
(214210,'SANTA LUCIA',214),
(214220,'6 DE ENERO',214),
(214230,'3 DE MAYO',214),
(214240,'25 DE DICIEMBRE',214),
(214250,'NARANJITO',214),
(214260,'LA VICTORIA',214),
(214270,'GRAL BERNARDINO CABALLERO',214),
(214280,'30 DE ABRIL',214),
(214290,'1 DE MAYO',214),
(214300,'SAN FRANCISCO',214),
(214310,'SANTA ANA',214),
(214320,'SANTA LIBRADA',214),
(214330,'CALLE SANTA LUCIA',214),
(214340,'CALLE UNION',214),
(214350,'KIRA Y',214),
(214360,'SAN JOSE',214),
(214370,'SAN JUAN',214),
(214380,'SAN JOSE DEL NORTE',214),
(214390,'14 DE FEBRERO',214),
(214400,'SAN FRANCISCO 2',214),
(214410,'SANTA CAROLINA',214),
(214420,'SAN SALVADOR',214),
(214999,'(NO INFORMADO)',214),
(215001,'SAGRADA FAMILIA',215),
(215002,'CENTRO',215),
(215003,'6 DE ENERO',215),
(215004,'SAN FRANCISCO',215),
(215005,'SAN JOSE',215),
(215100,'ITA CUATIA',215),
(215110,'CALLE ARROYENSE',215),
(215120,'CALLE SANTA LIBRADA',215),
(215130,'CALLE 8 DE DICIEMBRE',215),
(215140,'CALLE SAN JORGE',215),
(215150,'CERRITO',215),
(215160,'CALLE 1o DE MARZO (SAN BLAS)',215),
(215170,'SANTA LUCIA',215),
(215180,'CALLE MARIA AUXILIADORA',215),
(215190,'CALLE GUARANI',215),
(215200,'GUAVIRA',215),
(215210,'CALLE SAN JUAN',215),
(215220,'CALLE SAN MIGUEL',215),
(215230,'CRUCE UNION',215),
(215240,'CHORRO (SANTO DOMINGO)',215),
(215250,'YSAU',215),
(215260,'BERRERO PYTA',215),
(215270,'TUNA',215),
(215280,'SAN FELIPE',215),
(215290,'JAULA CUE',215),
(215300,'LAS MERCEDES',215),
(215310,'SANTO DOMINGO',215),
(215330,'CHACO I',215),
(215340,'YATAITY',215),
(215350,'ALIANZA',215),
(215360,'SAN ISIDRO',215),
(215380,'12 DE JUNIO',215),
(215390,'ROJAS SILVA',215),
(215400,'16 DE JUNIO',215),
(215410,'GUAZU RETA',215),
(215420,'TACUARA PUNTA',215),
(215430,'CERRO PYTA',215),
(215999,'(NO INFORMADO)',215),
(216001,'URBANO',216),
(216100,'ARROYO MOROTI',216),
(216110,'1 DE MAYO (COL LUZ BELLA)',216),
(216120,'BARRIO SAN FRANCISCO (COL LUZ',216),
(216130,'SAN RAMON',216),
(216140,'7 DE ABRIL (COL LUZ BELLA)',216),
(216150,'COL YOHAI JHU',216),
(216160,'CALLE SAN LORENZO',216),
(216170,'CALLE SAN JORGE',216),
(216180,'YOHA YU',216),
(216190,'CALLE CHOTO (SAN RAMON)',216),
(216200,'SAN ANTONIO',216),
(216210,'CALLE 25 DE DICIEMBRE',216),
(216230,'NATIVIDAD (COL LUZ BELLA)',216),
(216240,'SAN CARLOS',216),
(216250,'MALVINAS',216),
(216260,'COL NAVIDAD',216),
(216270,'1 DE MARZO (YOAYU)',216),
(216280,'PARAGUAY PYAJHU',216),
(216290,'CALLE SAN FRANCISCO',216),
(216300,'LUZ BELLA',216),
(216310,'SAN ISIDRO',216),
(216320,'MARTIN FIERRO',216),
(216330,'MARIA AUXILIADORA (COL NAVIDAD',216),
(216340,'SAN JOSE',216),
(216350,'TORO PIRU',216),
(216360,'AMISTAD',216),
(216370,'ÐU APUA',216),
(216380,'GUAVIRAMI (EVA)',216),
(216390,'YBY PYTÃ',216),
(216400,'BARRIO SAN PEDRO',216),
(216410,'8 DE DICIEMBRE',216),
(216420,'RESERVA FORESTAL (SAN JOSE KUP',216),
(216430,'CALLE MARIA AUXILIADORA',216),
(216440,'PRIMAVERA',216),
(216450,'CALLE ASUNCION',216),
(216460,'CALLE SAN MIGUEL',216),
(216470,'ALMEIDA CUE',216),
(216480,'SAN MARCOS',216),
(216490,'NARANJA JAI',216),
(216500,'BERTONI 12000',216),
(216510,'PRIMERA LINEA CHACHI',216),
(216520,'SEGUNDA LINEA CHACHI',216),
(216530,'DIOSESANO',216),
(216540,'SANTO DOMINGO',216),
(216550,'BERTONI 10000',216),
(216560,'CARAYAO I',216),
(216570,'CHACHI',216),
(216580,'TAVA I',216),
(216600,'CALLE 2000',216),
(216610,'CALLE 4000',216),
(216620,'CALLE 6000',216),
(216999,'(NO INFORMADO)',216),
(217001,'URBANO',217),
(217100,'19 DE MARZO',217),
(217110,'TAJY CARE',217),
(217120,'PAZ DEL CHACO',217),
(217130,'CALLE PRIMAVERA',217),
(217140,'24 DE MAYO',217),
(217150,'TAJY POTY',217),
(217160,'SAN MIGUEL',217),
(217170,'ARA PYAJHU',217),
(217180,'VIRGEN DE FATIMA',217),
(217190,'YVY PORA',217),
(217200,'CALLE ZABALA',217),
(217210,'CALLE BOQUERON',217),
(217220,'SAN ANTONIO',217),
(217230,'SAN FRANCISCO',217),
(217240,'9 DE JUNIO',217),
(217250,'1o de MAYO',217),
(217260,'CAÐETE CUE',217),
(217270,'11 DE NOVIEMBRE',217),
(217280,'26 DE FEBRERO',217),
(217290,'1o DE MARZO',217),
(217300,'1o DE NOVIEMBRE',217),
(217310,'25 DE DICIEMBRE',217),
(217320,'4 DE MAYO',217),
(217330,'3 DE NOVIEMBRE',217),
(217340,'POTRERITO',217),
(217350,'SAN ISIDRO',217),
(217360,'12 DE JUNIO',217),
(217370,'CABO CUE',217),
(217380,'CALLE 20 DE JULIO',217),
(217390,'11 DE SETIEMBRE',217),
(217400,'SAN BLAS (CAPIIBARY)',217),
(217410,'SANTO DOMINGO',217),
(217420,'AÐARETANGUE',217),
(217430,'FINAD',217),
(217440,'30 DE AGOSTO',217),
(217450,'CALLE 8 DE DICIEMBRE',217),
(217460,'TAPIRACUAI LOMA',217),
(217999,'(NO INFORMADO)',217),
(218001,'URBANO',218),
(218100,'ISLA SOLA',218),
(218110,'SAN BLAS',218),
(218120,'PROSPERIDAD',218),
(218130,'CORAZON DE JESUS',218),
(218140,'SANTA ANA',218),
(218150,'SANTA ROSA',218),
(218160,'ASENTAMIENTO LA VICTORIA',218),
(218170,'SAN RAMON (LA SANPEDRANA)',218),
(218180,'SAN MIGUEL',218),
(218190,'BARRIO SAN ISIDRO 2',218),
(218200,'LOMA PUCU',218),
(218210,'CALLE 7 DE SETIEMBRE',218),
(218220,'CAMBA YKUA',218),
(218230,'NUEVO MEXICO',218),
(218240,'CALLE MARIA AUXILIADORA',218),
(218250,'YBA JHAI',218),
(218260,'LOPEZ SALINAS',218),
(218270,'BARRIO SAN JORGE',218),
(218280,'ASENTAMIENTO SANTA LIBRADA',218),
(218290,'SAN ISIDRO',218),
(218300,'CALLE CENTRAL',218),
(218310,'SANTA LUCIA (KORORO I)',218),
(218320,'CALLE 3 MIL',218),
(218330,'5000 NORTE KORORO I',218),
(218340,'COLONIA RIO VERDE',218),
(218350,'SANTA BARBABA',218),
(218360,'PEDRO GIMENEZ',218),
(218370,'ASENTAMIENTO TAVA GUARANI',218),
(218380,'PAZO KURUZU',218),
(218390,'AGUERITO',218),
(218999,'(NO INFORMADO)',218),
(301001,'LOMA GUAZU',301),
(301002,'GENERAL DIAZ',301),
(301003,'LOMA',301),
(301004,'POZO DE LA VIRGEN',301),
(301005,'ALEGRE',301),
(301006,'DEFENSORES DEL CHACO',301),
(301007,'KENNEDY',301),
(301008,'CENTRO',301),
(301009,'BUENA VISTA',301),
(301010,'SAN MIGUEL',301),
(301011,'YBU',301),
(301012,'YBOTY',301),
(301013,'INDUSTRIAL',301),
(301014,'SAN BLAS',301),
(301015,'SANTA MARIA',301),
(301016,'DANIEL ESCURRA',301),
(301017,'SAN PABLO',301),
(301018,'SAN CAYETANO',301),
(301019,'SAN JUAN BAUTISTA',301),
(301020,'SANATA TERESITA',301),
(301100,'ALMADA',301),
(301110,'YPUCU',301),
(301130,'YTU GUAZU',301),
(301140,'COSTA PUCU',301),
(301150,'CABANAS',301),
(301160,'YTU MI',301),
(301170,'CERRO REAL',301),
(301180,'POTRERO POI',301),
(301190,'AQUINO CAÐADA',301),
(301200,'AZCURRA',301),
(301210,'ITA YBU MI',301),
(301220,'YHACA ROYSA',301),
(301230,'CORONEL MARTINEZ',301),
(301240,'ITA YBU GUAZU',301),
(301999,'(NO INFORMADO)',301),
(302001,'VIRGEN DEL ROSARIO',302),
(302002,'CORAZON DE JESUS',302),
(302003,'MARIA AUXILIADORA',302),
(302004,'SAN BLAS',302),
(302100,'ACUNA',302),
(302110,'PORARU',302),
(302120,'ITAGASA',302),
(302130,'CHOCHI',302),
(302140,'LOTE NUEVO',302),
(302150,'PASO ITAPE',302),
(302160,'PASO PELOTA',302),
(302170,'YACARE',302),
(302180,'ITAGUAZU',302),
(302190,'TUCANGUA',302),
(302200,'YBU',302),
(302210,'SAN MIGUEL',302),
(302220,'TAJY CAÐADA',302),
(302999,'(NO INFORMADO)',302),
(303001,'GENERAL AQUINO',303),
(303002,'CENTRO',303),
(303003,'URBANO',303),
(303100,'BANCO I',303),
(303110,'PIRAPO MI',303),
(303120,'ITA PIRU',303),
(303130,'EL CARMEN',303),
(303140,'SAN ANTONIO',303),
(303150,'ISLA GUAZU',303),
(303160,'EST SANTA LIBRADA',303),
(303170,'CERRITO',303),
(303180,'TACUARINDY',303),
(303190,'COSTA PUKU',303),
(303200,'GENERAL DIAZ',303),
(303210,'CAÐADA',303),
(303220,'CURUPAYTY',303),
(303230,'CAÐADA DOMINGUEZ',303),
(303240,'URUNDEY',303),
(303250,'MAINUMBY',303),
(303260,'ACEVEDO',303),
(303999,'(NO INFORMADO)',303),
(304001,'MARIA AUXILIADORA',304),
(304002,'LAS MERCEDES',304),
(304003,'SAN ANTONIO',304),
(304004,'SAN BLAS',304),
(304005,'VILLA CONAVI',304),
(304100,'BERNARDINO CABALLERO',304),
(304110,'CARUMBEY',304),
(304120,'LOTE NUEVO',304),
(304130,'POTRERO',304),
(304140,'MONTE ALTO',304),
(304150,'MBURURU',304),
(304160,'COMANDANTE OJEDA',304),
(304170,'CAACUPEMI',304),
(304180,'CAUGUA',304),
(304190,'CANDIA',304),
(304200,'SANJA JHU',304),
(304210,'SAN VICENTE',304),
(304999,'(NO INFORMADO)',304),
(305001,'SAN MIGUEL',305),
(305002,'CRISTO REY',305),
(305003,'CENTRO',305),
(305004,'SAN JUAN',305),
(305005,'LOMA,I',305),
(305100,'VAPOR CUE',305),
(305110,'VERA COSTA',305),
(305120,'ISLA PA\'U',305),
(305130,'GENERAL GENES',305),
(305140,'ALFONSO LOMA',305),
(305150,'JHUGUA POI',305),
(305160,'ROLON',305),
(305170,'INMACULADA',305),
(305180,'MARIA AUXILIADORA',305),
(305190,'COSTA YBATE',305),
(305210,'JHUGUA GUAZU',305),
(305220,'BOQUERON',305),
(305230,'ISLA GUAZU',305),
(305240,'FULGENCIO YEGROS',305),
(305250,'TENIENTE GONZALEZ',305),
(305260,'CAPELLANIA',305),
(305270,'TACUARY',305),
(305280,'VALLE-I',305),
(305999,'(NO INFORMADO)',305),
(306001,'URBANO',306),
(306002,'5TO TOMAS',306),
(306100,'KOKUE GUAZU',306),
(306110,'MINAS',306),
(306120,'KARANDAYTY',306),
(306130,'GUAYAIBITY',306),
(306140,'ISLA YOBAI',306),
(306150,'CORDILLERA GUY',306),
(306160,'ISLA ALTA',306),
(306170,'PASO PE',306),
(306999,'(NO INFORMADO)',306),
(307001,'INDUSTRIAL',307),
(307002,'SAN BLAS',307),
(307003,'SAN ROQUE',307),
(307004,'SANTA ROSA',307),
(307005,'SAN RAFAEL',307),
(307006,'SAGRADO CORAZON DE JESUS',307),
(307007,'INMACULADA',307),
(307008,'GRAL. BERNARDINO CABALLERO',307),
(307009,'SAN JUAN BAUTISTA',307),
(307010,'6 DE ENERO',307),
(307011,'CARMENCITA',307),
(307100,'ACOSTA ÐU',307),
(307110,'JHU YBATY',307),
(307120,'ISLA',307),
(307130,'YACAREY',307),
(307140,'AGUAITY',307),
(307150,'PUNTA',307),
(307160,'SANTA TERESITA',307),
(307170,'COSTA',307),
(307180,'JAULA CUE',307),
(307190,'TUYUCUA',307),
(307200,'POTRERO SAN JOSE',307),
(307210,'CAPI\'I PE',307),
(307220,'RUBIO ÐU',307),
(307230,'LAS INDIAS',307),
(307240,'TAVAI',307),
(307250,'CURUPAYTY',307),
(307260,'BOQUERON 1',307),
(307270,'CAPILLA LOMA 1',307),
(307280,'CAÐADA EL CARMEN',307),
(307290,'CAPILLA LOMA 2',307),
(307300,'BOQUERON 2',307),
(307310,'KAUNDY',307),
(307320,'CERRO PORTEÐO',307),
(307330,'MARISCAL FRANCISCO SOLANO LOPE',307),
(307340,'CABANAS CUE',307),
(307999,'(NO INFORMADO)',307),
(308001,'SAN FRANCISCO',308),
(308002,'CENTRO',308),
(308003,'MARIA AUXLIADORA',308),
(308004,'SAN ANTONIO',308),
(308005,'SANTA LUCIA',308),
(308100,'SAN JUAN',308),
(308120,'PINDOTY BARRIO SANTA MARIA',308),
(308130,'SAN JUAN BARRIO SANTA ROSA',308),
(308140,'PINDOTY BARRIO INMACULADA',308),
(308150,'PINDOTY BARRIO SANTO DOMINGO',308),
(308160,'29 DE SETIEMBRE',308),
(308170,'PINDOTY',308),
(308180,'TAPE POI',308),
(308190,'LOMA',308),
(308200,'TAPE GUAZU',308),
(308210,'LOMA MARIA AUXILIDAORA',308),
(308220,'ARROYO PORA',308),
(308240,'AGUARAY',308),
(308250,'LAGUNA YBYCUI',308),
(308260,'RUBIO ÐU',308),
(308270,'CAACUPE I',308),
(308280,'ITA YBATE',308),
(308999,'(NO INFORMADO)',308),
(309001,'SOL NACIENTE',309),
(309002,'VIRGEN DEL ROSARIO',309),
(309003,'SAN ANTONIO',309),
(309004,'3 DE MAYO',309),
(309005,'SANTA LUCIA',309),
(309006,'SAN BLAS',309),
(309007,'SAN CARLOS',309),
(309008,'SAN JOSE',309),
(309100,'TACUARA 40',309),
(309110,'COLONIA MENONITA',309),
(309120,'TACUARA OVIEDO',309),
(309130,'TACUARA 1 DE MARZO',309),
(309140,'LOMA MEDINA',309),
(309150,'POTRERO ANGELITO',309),
(309170,'CAAGUY CUPE',309),
(309180,'PIRAYU-I',309),
(309190,'CARYI LOMA',309),
(309200,'MINAS CUE',309),
(309210,'CARIY POTRERO',309),
(309999,'(NO INFORMADO)',309),
(310001,'URBANO',310),
(310100,'ESTANCIA JOSEFINA',310),
(310110,'SAN RAFAEL ÐUPY',310),
(310120,'SANTA LUCIA',310),
(310130,'NUEVA ASUNCION',310),
(310140,'MARIA AUXILIADORA',310),
(310160,'COLONIA FIDEL MAIZ',310),
(310170,'SAN MIGUEL 1',310),
(310180,'COLONIA REGINA MARECO',310),
(310190,'WIENGREEN',310),
(310200,'ESTANCIA CARACOL',310),
(310210,'SAN JUAN',310),
(310220,'ESTANCIA MAIZ CUE',310),
(310230,'SAN MIGUEL 2',310),
(310240,'8 DE DICIEMBRE',310),
(310250,'ESTANCIA GUYRATY',310),
(310260,'UNION PARAGUAYA',310),
(310270,'LA UNION',310),
(310280,'SAN ANTONIO',310),
(310290,'SANTO DOMINGO',310),
(310300,'GUIDO ALMADA ITANARA',310),
(310999,'(NO INFORMADO)',310),
(311001,'SAN FRANCISCO',311),
(311002,'MARIA AUXILIADORA',311),
(311003,'MARISCAL ESTIGARRIBIA',311),
(311004,'SAN MIGUEL',311),
(311100,'SANDIATY',311),
(311110,'YAGUARETE - CUA',311),
(311120,'VILLA FLOR',311),
(311130,'SAN ANTONIO',311),
(311140,'SALINAS',311),
(311170,'BOQUERON',311),
(311180,'AGUAI-Y',311),
(311999,'(NO INFORMADO)',311),
(312001,'URBANO',312),
(312100,'RIO NEGRO SANTA LUCIA',312),
(312110,'SAN MARCOS',312),
(312120,'RIO NEGRO POTRERO',312),
(312130,'RIO NEGRO ENSENADA',312),
(312140,'RIO NEGRO LLANES',312),
(312150,'LAGUNA',312),
(312160,'ISLA',312),
(312170,'PUNTA SACA',312),
(312180,'SAN ANTONIO',312),
(312190,'INMACULADA',312),
(312200,'VIRGEN DEL CARMEN',312),
(312210,'COLONIA ESPERANZA',312),
(312220,'SAN BLAS',312),
(312230,'PIRAY',312),
(312999,'(NO INFORMADO)',312),
(313001,'URBANO',313),
(313002,'CENTRO',313),
(313100,'SIRATY',313),
(313110,'QUIRAYTY',313),
(313120,'ISLA ALTA',313),
(313130,'BOQUERON CAACUPEMI',313),
(313140,'BOQUERON TRES REYES',313),
(313150,'INGLES CUE',313),
(313999,'(NO INFORMADO)',313),
(314001,'SAN BLAS I',314),
(314002,'SAN BLAS II',314),
(314003,'SANTA ANA',314),
(314004,'CENTRO',314),
(314005,'MARIA  AUXILIADORA',314),
(314006,'VIRGEN DEL ROSARIO',314),
(314100,'GUAZU ROCAI',314),
(314110,'YACAREY',314),
(314120,'ITA YBU',314),
(314130,'ITA GUYRA',314),
(314140,'MARISCAL LOPEZ',314),
(314150,'CAÐADA',314),
(314160,'BARRIO FATIMA',314),
(314170,'PASO JHU',314),
(314180,'TAPE GUAZU',314),
(314190,'CORDILLERA',314),
(314200,'YATAITY',314),
(314210,'OYOPOI',314),
(314220,'4 DE JULIO',314),
(314230,'YHAGUY MI',314),
(314240,'PRESIDENTE FRANCO',314),
(314250,'PASITO',314),
(314260,'YCUA PORA',314),
(314270,'NARANJO',314),
(314280,'ITA MOROTI',314),
(314999,'(NO INFORMADO)',314),
(315001,'URBANO - LIBERTAD',315),
(315100,'CAAGUY CUPE',315),
(315110,'GARAYO',315),
(315120,'ROJAS SILVA',315),
(315130,'POTRERITO',315),
(315140,'SARGENTO BAEZ',315),
(315150,'MARISCAL ESTIGARRIBIA',315),
(315160,'GENERAL DIAZ',315),
(315170,'CAÐADA DEL CARMEN',315),
(315180,'SAN BLAS',315),
(315190,'SARGENTO CABALLERO',315),
(315200,'SAN ANTONIO',315),
(315210,'BOQUERON',315),
(315220,'8 DE DICIEMBRE',315),
(315230,'SAN ISIDRO',315),
(315999,'(NO INFORMADO)',315),
(316001,'CRISTOBAL COLON',316),
(316002,'CASCO HISTORICO',316),
(316003,'SANTA CLARA URBANIZACION',316),
(316004,'SANTA ROSALINA',316),
(316005,'BARRIO 5',316),
(316006,'BARRIO 6',316),
(316100,'HERIBERTA MATIAUDA',316),
(316110,'ITA YBU',316),
(316120,'CIERVO CUA',316),
(316130,'YBYANGUY PRIMERA',316),
(316140,'YBYANGUY SEGUNDA',316),
(316150,'PIRAYU - I',316),
(316160,'VILLA REAL',316),
(316999,'(NO INFORMADO)',316),
(317001,'CENTRO',317),
(317002,'MERCADO',317),
(317100,'SAN ROQUE',317),
(317110,'SANTA CATALINA',317),
(317120,'RUBIO ÐU',317),
(317130,'PASO TRANQUERA',317),
(317140,'JHUGUA POI',317),
(317150,'MARIA AUXILIADORA',317),
(317160,'COSTA ELENA',317),
(317170,'PASO CABRAL',317),
(317180,'TOROPY LOMA',317),
(317190,'SAN ANTONIO',317),
(317200,'LOMA CLAVEL',317),
(317210,'TOROPY RUGUA',317),
(317220,'YCUA PORA',317),
(317999,'(NO INFORMADO)',317),
(318001,'SAN ROQUE',318),
(318002,'VIRGEN DE FATIMA',318),
(318003,'SAN FRANCISCO',318),
(318004,'SANTA TERESITA',318),
(318005,'INMACULADA CONCEPCION',318),
(318006,'MARIA AUXILIADORA',318),
(318007,'SAN JOSE',318),
(318008,'VIRGEN DE LOS REMEDIOS',318),
(318009,'SAN PEDRO',318),
(318010,'CENTRO',318),
(318011,'SANTA LUCIA',318),
(318012,'SAN BLAS',318),
(318013,'SAN ANTONIO',318),
(318100,'PEDRO JUAN CABALLERO',318),
(318110,'APARYPY',318),
(318120,'ISLA GUAZU',318),
(318130,'ISLA FLORIDA',318),
(318140,'ENSENADA',318),
(318150,'COSTA ALEGRE',318),
(318160,'SANTA ROSA',318),
(318170,'VILLA LAS MERCEDES',318),
(318180,'MOMPOX',318),
(318190,'JHUYBATY',318),
(318200,'POTRERO',318),
(318210,'21 DE JULIO',318),
(318220,'ROSADO',318),
(318230,'LOMA VERDE',318),
(318999,'(NO INFORMADO)',318),
(319001,'URBANO',319),
(319100,'TACUATI',319),
(319110,'PIRARETA (EX COL.STICA)',319),
(319120,'ÐU GUAZU',319),
(319130,'POTRERO OCULTO',319),
(319140,'JUAN CANCIO FLECHA',319),
(319150,'LOMA JHOVY',319),
(319160,'MARISCAL LOPEZ',319),
(319170,'GUAZU CUA',319),
(319180,'SAN FRANCISCO',319),
(319190,'CURUPAYTY',319),
(319200,'POTRERO YACAREY',319),
(319210,'POTRERITO',319),
(319220,'POTRERO PUCU',319),
(319230,'CERRO PERO',319),
(319240,'CERRO',319),
(319999,'(NO INFORMADO)',319),
(320001,'LIBERTAD',320),
(320100,'ESTANCIAS',320),
(320110,'ALFONSO CENTRAL',320),
(320120,'ALFONSO TRANQUERA',320),
(320130,'BARRIO SAN JOSE',320),
(320140,'SAN BLAS',320),
(320150,'SAN ANTONIO',320),
(320160,'SAN PEDRO',320),
(320170,'SAN JUAN BAUTISTA',320),
(320180,'LAS MERCEDES',320),
(320999,'(NO INFORMADO)',320),
(321001,'VILLA SAN JUAN',315),
(401001,'TUYUTI MI',401),
(401002,'YBAROTY',401),
(401003,'SAN MIGUEL',401),
(401004,'LOMAS VALENTINAS',401),
(401005,'CENTRO',401),
(401006,'ESTACION',401),
(401007,'SANTA LIBRADA',401),
(401008,'SANTA LUCIA',401),
(401009,'ITA YBU',401),
(401100,'TUYUTI MI',401),
(401110,'CAROVENI',401),
(401120,'POTRERO ISLA',401),
(401130,'POTRERO BAEZ',401),
(401150,'SULIMAN',401),
(401160,'RINCON',401),
(401170,'PISADERA',401),
(401180,'MBOPICUA',401),
(401190,'YTORORO',401),
(401200,'POTRERITO',401),
(401210,'DOÐA JUANA',401),
(401220,'LEMOS',401),
(401230,'14 DE MAYO',401),
(401240,'CAÐADA',401),
(401250,'ROSADO',401),
(401260,'CAAZAPAMI',401),
(401270,'LUCA MI',401),
(401280,'PUNTA CUPE',401),
(401290,'COSTO ESPINILLO',401),
(401300,'ESPINILLO',401),
(401310,'YVAROTY',401),
(401999,'(NO INFORMADO)',401),
(402001,'URBANO',402),
(402100,'ROJAS JHUGUA',402),
(402110,'BOQUERON',402),
(402120,'COLONIA 20 DE JUNIO',402),
(402130,'ISLA ALTA',402),
(402140,'MACARRO',402),
(402150,'COLONIA SAN AGUSTIN',402),
(402160,'CERRO MOROTI',402),
(402170,'LOMA I',402),
(402180,'COLONIA TACUARE',402),
(402190,'SAN PEDRO',402),
(402200,'VALLE PE',402),
(402210,'TTE ROJAS SILVA',402),
(402220,'RINCON',402),
(402230,'CORDILLERA / CORDILLERITA',402),
(402240,'COSTEADA',402),
(402250,'PASO CUE',402),
(402260,'YACA GUAZU',402),
(402270,'SAN ANTONIO',402),
(402999,'(NO INFORMADO)',402),
(403001,'JESUS MISERICORDIOSO',403),
(403002,'VIRGEN DEL HUERTO',403),
(403003,'SAN MIGUEL',403),
(403004,'CENTRO',403),
(403005,'SANTA ROSA',403),
(403006,'SAN BLAS',403),
(403007,'LOMA CLAVEL',403),
(403100,'ITACURUBI',403),
(403110,'GUAYAKI',403),
(403120,'BARRIO ALEGRE',403),
(403130,'CHACORE',403),
(403140,'ÐUMI',403),
(403170,'YJHOVY',403),
(403180,'ASENTAMIENTO NUEVA ESPERANZA',403),
(403190,'CERRO PUNTA',403),
(403210,'COSTA CABALLERO',403),
(403220,'CORA GUAZU',403),
(403999,'(NO INFORMADO)',403),
(404001,'URBANO',404),
(404100,'CHACRA NORTE',404),
(404110,'AVIACION',404),
(404120,'LOMA PINDO',404),
(404130,'CHACRA SUR',404),
(404140,'POTRERO RAMIREZ',404),
(404150,'COSTA I',404),
(404160,'POTRERO VILLAR',404),
(404170,'MONGES JHUGUA',404),
(404180,'MONGES PASO',404),
(404190,'COSTA BARRIOS',404),
(404200,'ARROYITO',404),
(404210,'TENIENTE BOGADO',404),
(404999,'(NO INFORMADO)',404),
(405001,'URBANO',405),
(405100,'POTRERO BENITEZ',405),
(405110,'TABAI',405),
(405120,'TORO CUA',405),
(405130,'AQUINO COSTA',405),
(405140,'BOMBILLA',405),
(405150,'POTRERO MELGAREJO',405),
(405160,'COSTA MERCADO',405),
(405170,'CAUNDY',405),
(405180,'CERRITO',405),
(405190,'COCUERE GUAZU',405),
(405200,'ESTACION COSTA',405),
(405999,'(NO INFORMADO)',405),
(406001,'SAN ISIDRO',406),
(406002,'CORAZON DE JESUS',406),
(406003,'SAN BLAS',406),
(406004,'SAN PATRICIO',406),
(406005,'KM 29',406),
(406006,'SAN ANTONIO',406),
(406100,'CIERVO CUA',406),
(406110,'ROQUE GONZALEZ DE SANTA CRUZ',406),
(406120,'ÐANDU CUA (KM 22)',406),
(406130,'KM 25',406),
(406140,'SAN BENITO',406),
(406150,'YATE I',406),
(406170,'MBOCAYA',406),
(406180,'SAN ROQUE',406),
(406190,'FLORIDO',406),
(406200,'CERRITO',406),
(406210,'KIRAY',406),
(406220,'SANTA CATALINA',406),
(406230,'ÐU PYAJHU',406),
(406999,'(NO INFORMADO)',406),
(407001,'URBANO',407),
(407100,'CALLE ALTA',407),
(407110,'CANETY',407),
(407120,'KURUSU PE',407),
(407130,'VIRGEN FATIMA',407),
(407140,'CRISTO REY',407),
(407150,'PLANTA URBANA',407),
(407160,'PRIMAVERA DE JESUS',407),
(407170,'CARLOS PFANNL',407),
(407180,'POTRERO DEL CARMEN',407),
(407190,'YROYSA 1RA LINEA',407),
(407200,'SAN ANATONIO',407),
(407210,'PIRECA',407),
(407220,'SANTA ROSA',407),
(407230,'SAN PEDRO',407),
(407240,'YROYSA 2DA  LINEA',407),
(407250,'YROYSA 3RA LINEA',407),
(407260,'SANTO DOMINGO',407),
(407270,'YROYSA 4TA LINEA',407),
(407280,'YROYSA  5TA LINEA',407),
(407290,'YROYSA 6TA LINEA',407),
(407300,'YROYSA 7TMA LINEA',407),
(407310,'YROYSA 8VA LINEA',407),
(407320,'YROYSA 9NA LINEA',407),
(407330,'YROYSA 10MA LINEA',407),
(407340,'YROYSA  LINEA 11',407),
(407350,'YROYSA LINEA 12',407),
(407360,'YROYSA LINEA 13',407),
(407370,'PIRECA ALTA LINEA 14',407),
(407380,'ZORRILLA CUE',407),
(407390,'CALLE FLORIDA',407),
(407400,'VISTA ALEGRE',407),
(407410,'CERRITO',407),
(407420,'TERCERA FRACCION',407),
(407430,'SAN GERVACIO',407),
(407440,'RANCHO CUATRO',407),
(407450,'CERRO CORA',407),
(407460,'CAMPITO',407),
(407470,'MARIA  AUXILIADORA',407),
(407480,'SANTA CECILIA',407),
(407490,'ITA AZUL',407),
(407500,'MAYOR CUE',407),
(407510,'SANTA CATALINA',407),
(407520,'CERRO LEON',407),
(407999,'(NO INFORMADO)',407),
(408001,'DULCE NOMBRE',408),
(408002,'SAN ISIDRO',408),
(408003,'INMACULADA',408),
(408004,'CORAZON DE JESUS',408),
(408005,'SAN ROQUE',408),
(408100,'CAAGUY GUAZU',408),
(408110,'POTRERO SOSA',408),
(408120,'ISLA VEGA',408),
(408130,'CAROVENI NUEVO',408),
(408140,'ITAPE POTRERO',408),
(408150,'ITAPE JHUGUA',408),
(408160,'POTRERO REDUCCION',408),
(408170,'COSTA JHU',408),
(408180,'CERRITO',408),
(408190,'CERRO GUY',408),
(408200,'POTRERO RAMIREZ',408),
(408210,'LOMA JHOVY',408),
(408999,'(NO INFORMADO)',408),
(409001,'SAN FRANCISCO',409),
(409002,'SAN JUAN',409),
(409003,'SAN ROQUE',409),
(409004,'SAN ANTONIO',409),
(409005,'SAN LUIS',409),
(409100,'CAPITAN BRIZUELA',409),
(409110,'ITACURUBI',409),
(409120,'CANDEA MI',409),
(409130,'SANTA LUCIA',409),
(409140,'CANDEA GUAZU',409),
(409150,'CONCEPCION MI',409),
(409160,'CA\'ATYMI',409),
(409170,'COSTA ALEGRE',409),
(409200,'YPAYERE',409),
(409210,'POTRERO',409),
(409999,'(NO INFORMADO)',409),
(410001,'URBANO',410),
(410100,'CAGUAREI',410),
(410110,'PIRECA',410),
(410120,'COLONIA GUARANI',410),
(410130,'SAN PEDRO',410),
(410140,'SAN ISIDRO',410),
(410150,'SAN CAYETANO',410),
(410160,'SANTA CATALINA',410),
(410170,'SAN JUAN',410),
(410180,'SANTA TERESITA',410),
(410190,'SAN ROQUE',410),
(410200,'SAN MIGUEL',410),
(410210,'SANTO DOMINGO',410),
(410220,'SANTA ROSA',410),
(410230,'SAN ANTONIO',410),
(410240,'SAN PABLO',410),
(410250,'SAN FRANCISCO',410),
(410260,'SANTA ANA',410),
(410999,'(NO INFORMADO)',410),
(411001,'VIRGEN DE LA ASUNCION',411),
(411002,'VIRGEN DEL ROSARIO',411),
(411003,'MARIA AUXILIADORA',411),
(411004,'SANTA LIBRADA',411),
(411100,'CARANDAYTY',411),
(411110,'SANTA BARBARA',411),
(411120,'LOMA BARRETO',411),
(411130,'GONDRA',411),
(411140,'JORGE NAVILLE',411),
(411150,'PIRITY',411),
(411160,'CAPITAN SAMUDIO',411),
(411170,'COSTA MBOCAYATY',411),
(411180,'TACUARITA',411),
(411190,'COSTA PISADERA',411),
(411200,'ITATI',411),
(411999,'(NO INFORMADO)',411),
(412001,'IGLESIA',412),
(412002,'VIRGEN DEL ROSARIO',412),
(412003,'ESCUELA',412),
(412004,'SAN PEDRO',412),
(412100,'COMPAÐIA ISLA',412),
(412110,'COMPAÐIA ARROYO COSTA',412),
(412120,'SAN ISIDRO',412),
(412130,'COMPAÐIA PRIMERA LINEA BARRERO',412),
(412140,'COMPAÐIA SEGUNDA LINEA',412),
(412150,'COMPAÐIA TERCERA LINEA',412),
(412160,'COMPAÐIA PANETEY',412),
(412170,'COMPAÐIA SAN JOSE',412),
(412180,'COMPAÐIA PASO ITA',412),
(412190,'ZANJA PYTA',412),
(412200,'COMPAÐIA POTRERITO',412),
(412210,'COMPAÐIA LOTE PAU',412),
(412220,'COMPAÐIA JHUGUA',412),
(412999,'(NO INFORMADO)',412),
(413001,'ARROYITO',413),
(413002,'CENTRAL',413),
(413003,'COLEGIAL',413),
(413004,'CRUZ DEL SUR',413),
(413100,'SAN AGUSTIN',413),
(413110,'MBARIGUI',413),
(413120,'SANTA ELENA',413),
(413130,'PERULERO GUAZU',413),
(413140,'SAN LUIS',413),
(413150,'CERRO CORA',413),
(413160,'POTRERO PERULERO',413),
(413170,'SANTA ROSA',413),
(413999,'(NO INFORMADO)',413),
(414001,'URBANO',414),
(414100,'TRANQUERA CUE',414),
(414110,'YHAKAMI',414),
(414120,'VIRGEN DE FATIMA',414),
(414130,'SAN MIGUEL',414),
(414140,'SAN CAYETANO',414),
(414150,'ITACURUBI',414),
(414160,'YUQUERI',414),
(414170,'ISLA VALLE',414),
(414180,'SAN RAFAEL',414),
(414190,'SAN GENARO',414),
(414999,'(NO INFORMADO)',414),
(415001,'TAJAMAR',415),
(415002,'ALEGRE',415),
(415003,'LAGUNA',415),
(415004,'JUVENTUD',415),
(415005,'COSMOS',415),
(415100,'POTRERO BENEGAS',415),
(415110,'TEBICUARY COSTA',415),
(415120,'PUESTO CAAGUY',415),
(415130,'CAPILLA CUE',415),
(415150,'CAPILLITA',415),
(415160,'VALLE PYTA',415),
(415170,'SANTA RITA',415),
(415180,'LOMA BARRETO',415),
(415190,'13 DE JUNIO',415),
(415200,'CAAGUY CUPE',415),
(415999,'(NO INFORMADO)',415),
(416001,'CENTRO',416),
(416100,'ÐUMI',416),
(416110,'DR. BOTTRELL',416),
(416120,'DE MATEI CUE',416),
(416130,'TACUAPITY',416),
(416140,'ITACURUBI',416),
(416150,'CALLE 40',416),
(416999,'(NO INFORMADO)',416),
(417001,'8 DE DICIEMBRE',417),
(417002,'CENTRO',417),
(417003,'SAN COSME',417),
(417100,'SAN ISIDRO',417),
(417110,'PANCHADA',417),
(417120,'ARROYO MOROTI',417),
(417130,'COLONIA NASSEN',417),
(417140,'ASENTAMIENTO SAN JOSE',417),
(417150,'3 DE NOVIEMBRE',417),
(417160,'COLONIA BERGTHAL',417),
(417170,'SAN FRANCISCO',417),
(417180,'CIERVO CUA',417),
(417190,'TAGUATO',417),
(417200,'SAN MARCOS',417),
(417210,'PALMETA',417),
(417220,'ALBORADA',417),
(417230,'PIKYRY',417),
(417240,'MANGRULLO',417),
(417250,'NUEVA GUAIRA 1 LINEA',417),
(417260,'NUEVA GUAIRA 2 LINEA',417),
(417270,'NUEVA GUAIRA 3 LINEA',417),
(417280,'ZANJA PYTA',417),
(417290,'SANTA MARIA',417),
(417310,'SAN ANTONIO',417),
(417320,'TAGUYI',417),
(417330,'TORRES CUE',417),
(417340,'3 MOJON',417),
(417350,'COLONIAS UNIDAS',417),
(417360,'CORONEL CUBAS',417),
(417370,'COLONIA SUDETIA',417),
(417380,'YCUA PORA',417),
(417390,'RINCON ALEGRE',417),
(417999,'(NO INFORMADO)',417),
(501001,'CERRITO RUGUA',501),
(501002,'1RO. DE MARZO',501),
(501003,'SAN MIGUEL',501),
(501004,'12 DE JUNIO',501),
(501005,'CENTRO',501),
(501006,'CAPITAN ROA',501),
(501007,'COSTA ALEGRE',501),
(501008,'AZUCENA',501),
(501009,'GRAL. BERNARDINO CABALLERO',501),
(501010,'BOQUERON',501),
(501011,'JOSE ALFONSO GODOY',501),
(501012,'SAN ISIDRO',501),
(501100,'YUQUYTY',501),
(501110,'CHASSE CUE',501),
(501120,'CHIRCATY',501),
(501130,'COLONIA BERNARD ROMERO',501),
(501140,'CALLE YCUA PORA',501),
(501150,'PIQUETE CUE',501),
(501160,'CALLE TACURUTY',501),
(501170,'CALLE BORDENABE',501),
(501180,'VOLCAN CUE',501),
(501190,'POSTA VARELA',501),
(501200,'CARANDAYTY',501),
(501210,'LEIVA - I',501),
(501220,'CALLE ARENA',501),
(501230,'CALLE FLORIDA',501),
(501240,'ÐU RUGUA',501),
(501250,'PLACIDO',501),
(501260,'CALLE GUAZU',501),
(501270,'CALLE CANGAI',501),
(501280,'CALLE ITACURUBI',501),
(501290,'OLEGARIO',501),
(501300,'CALLE ARROZ',501),
(501310,'SANTA LIBRADA',501),
(501320,'POTRERITO',501),
(501330,'AGUAPEY',501),
(501340,'POTRERO SAN ROQUE',501),
(501350,'CALLE GRAL. DIAZ',501),
(501360,'CALLE SANTO DOMINGO',501),
(501370,'COLONIA DOMINGO MONTANARO',501),
(501380,'CALLE SAN ISIDRO',501),
(501390,'SAN ANTONIO',501),
(501400,'CALLE SAN ROQUE',501),
(501410,'PINDOTY',501),
(501420,'MARTIRES DE ACOSTA ÐU',501),
(501440,'CAITA',501),
(501450,'SAN LUIS',501),
(501460,'CALLE MOREIRA',501),
(501470,'CALLE SAN FRANCISCO',501),
(501480,'CALLE DON BOSCO',501),
(501490,'CALLE MARISTA',501),
(501500,'VILLA DEL MAESTRO',501),
(501510,'CALLE JHOVY',501),
(501520,'SANTA MARIA',501),
(501530,'POTRERO CUE',501),
(501540,'BOQUERON (PASITO)',501),
(501550,'ESPINILLO',501),
(501560,'COSTA SAN ANTONIO',501),
(501570,'COLONIA PFANNL',501),
(501580,'CALLE SAN PEDRO',501),
(501590,'JHUGUA GUAZU',501),
(501600,'TUYU PUCU PUNTA',501),
(501610,'CAAGUY CUPE',501),
(501620,'TUYU PUCU',501),
(501630,'CARAGUATAY MI',501),
(501640,'BLAS GARAY CALLE PRIMERA',501),
(501650,'ZARO CARO',501),
(501660,'BLAS GARAY CALLE TERCERA',501),
(501670,'SILVA RUGUA',501),
(501680,'BLAS GARAY CALLE SEGUNDA',501),
(501690,'AGUAPE TY',501),
(501700,'ISLA PAU',501),
(501710,'POTRERO OCULTO',501),
(501999,'(NO INFORMADO)',501),
(502001,'IPVU',502),
(502002,'SANTA ISABEL',502),
(502003,'VILLA MARGARITA',502),
(502004,'TACURU',502),
(502005,'TORO BLANCO',502),
(502006,'CENTENARIO',502),
(502007,'CENTRO',502),
(502008,'SAN LORENZO',502),
(502009,'EMPALADO',502),
(502010,'INMACULADA CONCEPCION',502),
(502011,'SAN ROQUE',502),
(502012,'FLORIDA',502),
(502013,'GRAL. BERNARDINO CABALLERO',502),
(502014,'SAN RAFAEL',502),
(502015,'SANCHEZ CUE',502),
(502016,'SANTO DOMINGO',502),
(502100,'YUKYRY CENTRAL',502),
(502110,'GUAYAKI KUA',502),
(502120,'YPYTA',502),
(502130,'BAEZ ÐU',502),
(502140,'YACARE-I',502),
(502150,'GUYRAUNGUA-I',502),
(502160,'CALLE 25 TAYAO',502),
(502170,'6TA. LINEA DE AGUA',502),
(502180,'5TA. LINEA DE AGUA',502),
(502190,'3RA. LINEA DE AGUA',502),
(502200,'MBOCAYA-I',502),
(502210,'4TA. LINEA DE AGUA',502),
(502220,'YHOBY',502),
(502230,'7MA. LINEA GUAIRA',502),
(502240,'VYAPA GUAZU',502),
(502260,'VILLA SAN JUAN',502),
(502270,'INFANTIL',502),
(502280,'2DA. LINEA GUAVIRA',502),
(502290,'FINANGRAY',502),
(502300,'1RA. LINEA GUAVIRA',502),
(502310,'SANTA LIBRADA 1',502),
(502320,'YTU',502),
(502330,'1RO. DE MAYO',502),
(502340,'SAN MIGUEL',502),
(502350,'ARROYO TERERE',502),
(502360,'CAPITAN CUE',502),
(502370,'ARROYO MOROTI',502),
(502380,'CALLE PALMA',502),
(502390,'4TA. LINEA GUAYAKI',502),
(502410,'3RA. Y 2DA. LINEA GUAYAKI',502),
(502420,'WALTER INSFRAN',502),
(502430,'POTRERO GUAYAKI',502),
(502440,'YURUMI',502),
(502450,'EMPALADO-MI',502),
(502460,'ARROYO GUAZU',502),
(502470,'PARAJE GUAZU',502),
(502480,'VILLA CONSTITUCION',502),
(502490,'LA FABRIL',502),
(502500,'CALLE 6 POTRERO GUAYAKI',502),
(502510,'VILLA TRIUNFO',502),
(502520,'8 DE DICIEMBRE',502),
(502530,'CANTERA BOCA',502),
(502540,'2DA. LINEA BALANZA',502),
(502550,'CALLE SAN MIGUEL',502),
(502560,'BLAS GARAY',502),
(502570,'POTRERO BOCA',502),
(502580,'3RA. LINEA BALANZA',502),
(502590,'JAGUA KAI',502),
(502600,'COSTA ROSADO',502),
(502610,'1RA. LINEA BALANZA',502),
(502620,'CURUZU ARAUJO',502),
(502630,'5TA. LINEA BALANZA',502),
(502640,'SANTA LIBRADA 2',502),
(502650,'4TA. LINEA BALANZA',502),
(502660,'SAN FRANCISCO',502),
(502670,'8VA. LINEA WALTER INSFRAN',502),
(502680,'BRASILERO CUE',502),
(502690,'ITA PLANCHON',502),
(502700,'TEBICUARYMI',502),
(502710,'OVENA',502),
(502730,'12 LINEA TEBICUARYMI',502),
(502740,'13 LINEA WALTER INSFRAN',502),
(502750,'ÐANE MAITEI',502),
(502760,'MBOI CAE GUAZU',502),
(502999,'(NO INFORMADO)',502),
(503001,'CENTRO',503),
(503002,'SAN FRANCISCO',503),
(503003,'SAN JUAN DE LAS MERCEDES',503),
(503100,'CLETO ROMERO',503),
(503110,'PEGUAJHO',503),
(503120,'COMISARIA CUE',503),
(503130,'CAMPO REDONDO',503),
(503140,'ARROYO HONDO',503),
(503150,'SANTA CATALINA',503),
(503160,'PARANA CUE',503),
(503170,'ARROYO GUAZU',503),
(503180,'PARA\'I',503),
(503190,'CALLE 24 MIL',503),
(503200,'PARAGUAZU',503),
(503210,'CALLE 12 MIL',503),
(503220,'CERRO SAIGO',503),
(503230,'VIRGEN DE FATIMA',503),
(503240,'CRISTO REY',503),
(503250,'SAN GASPAR',503),
(503260,'ISLA GUAZU',503),
(503270,'CERRO CORA - MARIA AUXILIADORA',503),
(503280,'TTE. MORALES - ALEMAN CUE',503),
(503290,'ASENTAMIENTO 3 DE MAYO',503),
(503300,'TIQUINO',503),
(503999,'(NO INFORMADO)',503),
(504001,'MARIA AUXILIADORA',504),
(504002,'SAN JOSE',504),
(504003,'SAN MIGUEL',504),
(504004,'SAN LUIS',504),
(504005,'CAACUPE',504),
(504006,'FATIMA',504),
(504007,'CORAZON DE JESUS',504),
(504100,'ASENTAMIENTO SAN AGUSTIN',504),
(504110,'ASENTAMIENTO CANDIDO BENITEZ',504),
(504120,'ASENTAMIENTO SAN BLAS',504),
(504130,'ASENTAMIENTO SAN ANTONIO',504),
(504140,'JHUGUA POI',504),
(504150,'VIRGEN DEL ROSARIO',504),
(504160,'EMPALADO',504),
(504170,'TORORO',504),
(504180,'PIRAY',504),
(504190,'PASO ITA',504),
(504210,'SAN ANTONIO',504),
(504220,'CAATY MI',504),
(504230,'PRIMERO DE MAYO',504),
(504240,'CAÐADA',504),
(504250,'POTRERO',504),
(504999,'(NO INFORMADO)',504),
(505001,'URBANO',505),
(505100,'MBUTUY',505),
(505110,'CRUCE MBUTUY',505),
(505120,'NATIURY',505),
(505130,'MONDORI',505),
(505140,'INVERNADA',505),
(505150,'GUARDIA CUE',505),
(505160,'COSTA ALEGRE',505),
(505170,'SAN ISIDRO',505),
(505180,'SIETE CABRILLAS',505),
(505190,'CALLE 40',505),
(505200,'NATIURY MI',505),
(505210,'MBUTUY I',505),
(505220,'UMBU CUA',505),
(505230,'SAN MIGUEL',505),
(505240,'SANTO DOMINGO',505),
(505999,'(NO INFORMADO)',505),
(506001,'URBANO',506),
(506100,'YUKYRY SAN JUAN',506),
(506110,'MARIA AUXILIADORA',506),
(506120,'TEMBETARY',506),
(506130,'INDIGENA PUNTA PORA',506),
(506140,'LOPEZ - I',506),
(506150,'SAN MIGUEL',506),
(506160,'SAN JORGE',506),
(506170,'CAIBO',506),
(506180,'SAN JOSE YACAREI',506),
(506190,'COLONIA SANTO DOMINGO',506),
(506200,'YTU 2DA. LINEA',506),
(506210,'YTU 1RA. LINEA',506),
(506220,'YKUA PORA',506),
(506230,'SAN ISIDRO 2DA. LINEA',506),
(506240,'SAN ISIDRO 1RA. LINEA',506),
(506250,'PUENTE SECO',506),
(506260,'GUAVIYU',506),
(506270,'SAN FRANCISCO',506),
(506280,'YTU 3RA. LINEA',506),
(506290,'8 DE DICIEMBRE',506),
(506300,'PUENTECITO',506),
(506310,'YBU',506),
(506320,'YVYRA POKA',506),
(506330,'CALLE 3 ZANJA JHU',506),
(506340,'NUEVA ITALIA',506),
(506350,'CALLE 4 SAN AGUSTIN',506),
(506360,'PATIÐO',506),
(506370,'CALLE 5 MARIA AUXILIADORA',506),
(506380,'SANTA MARIA',506),
(506400,'CALLE 6 ZANJA PE',506),
(506410,'ISLA VERA',506),
(506420,'CALLE 9 ZANJA PE',506),
(506430,'SANTA CLARA',506),
(506440,'CAMPO 11 HALBSTAD',506),
(506450,'CALLE 7',506),
(506460,'CRUCE PASTOREO',506),
(506470,'SANTA ROSA',506),
(506480,'CAMPO 10 BLUMENTHAL',506),
(506490,'SAN ANTONIO GUAZU',506),
(506500,'CAMPO 4',506),
(506510,'CAMPO 5 REILAND',506),
(506520,'GUYRAUNGUA',506),
(506530,'CHACO - I',506),
(506540,'CAMPO 2 SOMMERFELD',506),
(506550,'CAMPO 1',506),
(506560,'SAN ANTONIO - MI',506),
(506570,'CAMPO 3',506),
(506580,'CAMPO 7',506),
(506999,'(NO INFORMADO)',506),
(507001,'SAN FRANCISCO',507),
(507002,'CENTRO',507),
(507003,'SAN BLAS',507),
(507100,'YPECA',507),
(507110,'1RA. LINEA CHACORE',507),
(507120,'2DA. LINEA CHACORE',507),
(507130,'3RA. LINEA NORTE',507),
(507140,'INDIGENA PINDO-I CULANTRILLO',507),
(507150,'SANTORY',507),
(507160,'CAÐADA',507),
(507180,'SAN ANTONIO',507),
(507190,'1RA. LINEA EUGENIO A. GARAY',507),
(507200,'CALLE PIRIBEBUY',507),
(507210,'4TA. LINEA CHACORE',507),
(507220,'1RA. LINEA IRRAZABAL',507),
(507230,'2DA. LINEA NORTE',507),
(507240,'2DA. LINEA EUGENIO A. GARAY',507),
(507250,'CABALLERO ALVAREZ',507),
(507260,'6TA. LINEA CHACORE',507),
(507270,'3RA. LINEA SANTA ROSA',507),
(507280,'EUGENIO A. GARAY',507),
(507290,'2DA. LINEA TACURU PYTA',507),
(507300,'2DA. LINEA SUR',507),
(507310,'4TA. LINEA EUGENIO A. GARAY',507),
(507320,'3RA. LINEA CAAMINDY',507),
(507330,'2DA. LINEA SAN MIGUEL',507),
(507340,'1RA. LINEA BALANZA',507),
(507350,'LOTE E CHACORE (3 DE NOVIEMBRE',507),
(507360,'3RA. LINEA KANGARA',507),
(507370,'BARRIENTOS CUE',507),
(507380,'6TA. LINEA',507),
(507390,'4TA. LINEA CABALLERO ALVAREZ',507),
(507400,'MANDUARA',507),
(507410,'1RA. Y 2DA. LINEA GRAL. DELGAD',507),
(507420,'5TA. LINEA GRAL. DELGADO',507),
(507430,'LOTE JHU',507),
(507440,'AGUILA NEGRA',507),
(507450,'INDIGENA SEÐORITA YPAU',507),
(507460,'INDIGENA ÐU JHOVY',507),
(507470,'EL TRIUNFO',507),
(507480,'INDIGENA KAATYMI',507),
(507490,'AGUILA REAL',507),
(507500,'INDIGENA 3 DE FEBRERO',507),
(507510,'3 DE NOVIEMBRE',507),
(507520,'3RA. LINEA GRAL. DELGADO',507),
(507530,'5TA. LINEA',507),
(507540,'TEJU',507),
(507999,'(NO INFORMADO)',507),
(508001,'URBANO',508),
(508100,'KARACHI',508),
(508110,'GUAVIRA',508),
(508120,'LEON CUE',508),
(508130,'LAVO-I',508),
(508140,'POTRERO TUYA',508),
(508150,'PUNTA ITACURUBI',508),
(508160,'TUYU RUGUA',508),
(508170,'LA NOVIA',508),
(508180,'JHUGUA YERE',508),
(508190,'ITAU',508),
(508200,'RAMAL NUEVA LONDRES',508),
(508210,'NUEVA ESTRELLA (CAPILLITA)',508),
(508220,'MBOREVI RUGUA',508),
(508230,'BOQUERON',508),
(508240,'LOMA RUGUA',508),
(508999,'(NO INFORMADO)',508),
(509001,'URBANO',509),
(509100,'YUQUYRY',509),
(509110,'SAN ROQUE',509),
(509120,'CELANO',509),
(509130,'JUAN SINFORIANO BOGARIN',509),
(509140,'CARPA CUE',509),
(509150,'TARUMA',509),
(509160,'SANTO DOMINGO',509),
(509170,'TEJAS CUE',509),
(509180,'PIRI POTY',509),
(509190,'R I 6 BOQUERON',509),
(509200,'VIRGEN DEL CARMEN',509),
(509210,'NOGUEIRA',509),
(509220,'ÐUAI',509),
(509230,'CERRO MOROTY',509),
(509240,'YBY TEE',509),
(509250,'QUINTA I',509),
(509260,'MARTILLO',509),
(509270,'MALVINAS',509),
(509280,'NACIENTE (YBU)',509),
(509290,'TACUAPI I',509),
(509300,'ESPORTIVO',509),
(509310,'SAN MIGUEL',509),
(509320,'SEGUNDA TAYI',509),
(509330,'LAGUNA PYTA',509),
(509340,'JAHAPE',509),
(509350,'CALLE MARIA AUXILIADORA',509),
(509360,'GUAJHO',509),
(509370,'TACUAPI GUAZU',509),
(509380,'POTRERO APUA',509),
(509390,'TORO ACA',509),
(509400,'PEYUPA',509),
(509410,'GUAA CUA',509),
(509420,'OLLA RUGUA',509),
(509999,'(NO INFORMADO)',509),
(510001,'VIRGEN DEL CARMEN',510),
(510002,'SANTA RITA',510),
(510003,'SAN JUAN',510),
(510004,'SAN BLAS',510),
(510100,'SAN BLAS (COSTA MI)',510),
(510110,'YCUA RUGUA',510),
(510120,'COSTA PUCU',510),
(510130,'SAN IGNACIO DE LOYOLA',510),
(510140,'YACU BARRERO',510),
(510150,'SAN LUIS (MBOITY)',510),
(510160,'PDTE. FRANCO',510),
(510170,'ISLA CARAGUATA',510),
(510180,'SAN JUAN BAUTISTA',510),
(510190,'ISLA CARAPA',510),
(510200,'MANDIJHO',510),
(510210,'POTRERO IRALA',510),
(510220,'ISLA ROJAS',510),
(510230,'SAN PATRICIO',510),
(510240,'SERAFINI',510),
(510250,'CHACHINDY',510),
(510260,'ARAZAPE',510),
(510270,'MONTE ALTO',510),
(510280,'LAGUNA VERDE',510),
(510290,'JHUGUA GUAZU',510),
(510300,'DACAK',510),
(510310,'SANTA TERESA',510),
(510320,'CASTAÐO',510),
(510330,'YHACA',510),
(510340,'CAÐADA',510),
(510999,'(NO INFORMADO)',510),
(511001,'URBANO',511),
(511100,'SIDEPAR TRES MIL',511),
(511110,'BELLA VISTA',511),
(511120,'VIRGEN DEL ROSARIO',511),
(511130,'SIDEPAR MALVINA',511),
(511140,'SIDEPAR COLONIA BELLEZA',511),
(511150,'SIDEPAR CUARTA LINEA',511),
(511160,'SIDEPAR QUINTA LINEA',511),
(511170,'CABO CUE',511),
(511180,'CHACHI SEGUNDA LINEA',511),
(511190,'SIDEPAR TERCERA LINEA',511),
(511200,'CHACHI PRIMERA LINEA',511),
(511210,'SIDEPAR SEGUNDA LINEA',511),
(511220,'PIQUETE I',511),
(511230,'SAN ROQUE',511),
(511240,'SIDEPAR PRIMERA LINEA',511),
(511250,'MCAL LOPEZ TERCERA LINEA',511),
(511260,'PATRIMONIO',511),
(511270,'MCAL LOPEZ CUARTA LINEA',511),
(511280,'MCAL LOPEZ QUINTA LINEA',511),
(511290,'SAN JORGE SEXTA LINEA',511),
(511300,'MCAL LOPEZ PRIMERA LINEA',511),
(511310,'CURUZU JHU',511),
(511320,'MCAL LOPEZ SEGUNDA LINEA',511),
(511330,'ANGUA RETA',511),
(511340,'YBY PYTA',511),
(511350,'ISLA  YACU',511),
(511360,'DEPOSITO CUE SEGUNDA LINEA',511),
(511370,'SAN ALBERTO',511),
(511380,'COLONIA MCAL LOPEZ',511),
(511390,'CAMBILO CUE',511),
(511400,'YATAI',511),
(511410,'GUAYAIBI',511),
(511420,'ADRI CUE PRIMERA LINEA',511),
(511430,'ARROYO GUAZU (INDIGENA MBYA)',511),
(511440,'DEPOSITO CUE PRIMERA LINEA',511),
(511450,'ADRI CUE SEGUNDA LINEA',511),
(511460,'SAN MIGUEL QUINTA',511),
(511470,'MALVINAS',511),
(511480,'KAIJHO',511),
(511490,'CURUPIKAY',511),
(511500,'MARIA AUXILIADORA',511),
(511510,'SAN RAFAEL',511),
(511520,'POTRERO ALVAREZ',511),
(511530,'SAN ANTONIO',511),
(511540,'PIQUETE CUE',511),
(511550,'SANTA ROSA',511),
(511560,'BARRIO FATIMA',511),
(511580,'YBYRA CATU',511),
(511590,'YATAITY',511),
(511600,'15 DE AGOSTO',511),
(511610,'BARRIO SANTA LIBRADA',511),
(511620,'SANTA LUCIA',511),
(511630,'SANTA RITA',511),
(511640,'ZAPATINI CUE',511),
(511660,'CALLE LIMA',511),
(511670,'AGUADA',511),
(511680,'SAN RAMON',511),
(511700,'ARAPAY',511),
(511710,'SAN FRANCISCO',511),
(511720,'CALLE MBYQUY',511),
(511730,'CALLE ZABALA',511),
(511740,'CORRENTINA',511),
(511750,'SANTA CATALINA',511),
(511760,'TORO CANGUE PRIMERA LINEA',511),
(511770,'TORO CANGUE SEGUNDA LINEA',511),
(511780,'CAÐADITA',511),
(511790,'TARUMA',511),
(511800,'JUAN SINFORIANO BOGARIN',511),
(511810,'PUENTECITA',511),
(511820,'CANDIA CUE',511),
(511999,'(NO INFORMADO)',511),
(512001,'MARIA AUXILIADORA',512),
(512002,'SAN BLAS',512),
(512003,'SAN JORGE',512),
(512004,'VIRGEN SERRANA',512),
(512005,'LA FORTUNA',512),
(512006,'SANTA LIBRADA',512),
(512007,'SANTA CATALINA',512),
(512008,'SAN FRANCISCO',512),
(512100,'TORIN',512),
(512110,'ASENTAMIENTO CRISTOBAL ESPINOL',512),
(512120,'ZAPALLO',512),
(512130,'CALLE TRES',512),
(512140,'YAGUARY',512),
(512150,'INDIGENA 225',512),
(512160,'INDIGENA MBARIGUI',512),
(512170,'FLORIDO',512),
(512180,'MARACANA',512),
(512190,'PRIMERA LINEA',512),
(512200,'LUZ Y ESPERANZA',512),
(512210,'SOMMERFELD',512),
(512220,'INDIGENA SAN JUAN',512),
(512230,'COLONIA BERGTHAL',512),
(512240,'MBOCAYA IGUAZU',512),
(512250,'INDIGENA NUEVA ESPERANZA',512),
(512260,'INDIGENA SANCERIA CUE',512),
(512999,'(NO INFORMADO)',512),
(513001,'URBANO',513),
(513100,'YPYTA',513),
(513110,'CALLE 25 TAYAO',513),
(513120,'CALLE 22 TAYAO',513),
(513130,'CALLE 20 TAYAO',513),
(513140,'CALLE 18 TAYAO',513),
(513150,'CALLE 17 TAYAO',513),
(513160,'CALLE 16 TAYAO',513),
(513170,'CALLE 13 TAYAO',513),
(513180,'CALLE 10 TACUA CORA',513),
(513190,'CALLE 14 TAYAO',513),
(513200,'CALLE 8 TACUA CORA',513),
(513210,'CALLE 6 TACUA CORA',513),
(513220,'CAPILLITA',513),
(513230,'CALLE 4 TACUA CORA',513),
(513240,'CALLE 12 TAYAO',513),
(513250,'CALLE 24 TAYAO',513),
(513999,'(NO INFORMADO)',513),
(514001,'URBANO',514),
(514100,'TOLEDO',514),
(514110,'CAGUA-PARIRI',514),
(514120,'SAN JUAN',514),
(514130,'CEDROTY',514),
(514140,'INDIGENA YBU',514),
(514150,'11 DE SETIEMBRE',514),
(514160,'PANAMBI',514),
(514170,'TRES PALMAS',514),
(514180,'INDIGENA PANAMBI',514),
(514190,'INDIGENA TAJY POTY',514),
(514200,'INDIGENA YBY YBATE',514),
(514210,'INDIGENA SANTA TERESA',514),
(514220,'CASILLA 2',514),
(514230,'LUCERO',514),
(514240,'GUAJHORY',514),
(514250,'SAN ISIDRO',514),
(514260,'SYRYKA',514),
(514270,'1RO. DE MAYO',514),
(514280,'CAMPANARIO',514),
(514290,'COLONIA UNIDA',514),
(514300,'LINEA 510',514),
(514310,'BANDERITA 4 BOCAS',514),
(514320,'SANCHEZ CUE',514),
(514330,'BANDERITA 8 DE DICIEMBRE',514),
(514340,'YHOVY',514),
(514350,'ARGENTINA-I',514),
(514360,'RANCHO FLORES',514),
(514370,'YKUA PORA',514),
(514380,'SATI \"B\"',514),
(514390,'SATI \"A\"',514),
(514400,'MARIA AUXILIADORA',514),
(514410,'1RA. LINEA SANTA LIBRADA',514),
(514420,'ARA PORA SAN RAMON',514),
(514430,'3 CORRALES',514),
(514440,'2DA. LINEA SANTA LIBRADA',514),
(514450,'BUENA VISTA',514),
(514460,'ARA PORA SAN PEDRO',514),
(514470,'PUENTE BABA',514),
(514480,'CABALLERIA',514),
(514490,'PINDO',514),
(514500,'CARRERIA-I',514),
(514510,'3RA. LINEA SANTA LIBRADA',514),
(514520,'LA PALOMA TEMBIAPORA',514),
(514530,'1RA. LINEA CAPIATI',514),
(514540,'2DA. Y 3RA. LINEAS CAPIATI',514),
(514550,'1RA. Y 2DA. LINEA SAN JORGE',514),
(514560,'MONCHO CUE TEMBIAPORA',514),
(514570,'YHAI',514),
(514580,'3RA. LINEA TEMBIAPORA',514),
(514590,'2DA. LINEA YKUA PYTA',514),
(514600,'2DA. LINEA TEMBIAPORA',514),
(514610,'500 YKUA PYTA',514),
(514620,'1RA. LINEA YKUA PYTA',514),
(514630,'1RA. LINEA TEMBIAPORA',514),
(514640,'ÐEMBIARA',514),
(514999,'(NO INFORMADO)',514),
(515001,'URBANO',515),
(515100,'MARIA AUXILIADORA',515),
(515110,'CALABRIA',515),
(515120,'SAN AGUSTIN',515),
(515130,'SAN ROQUE GONZALEZ DE SANTA CR',515),
(515140,'SAN ISIDRO NORTE',515),
(515150,'ASENTAMIENTO ARSENIO BAEZ',515),
(515160,'SAN ROQUE',515),
(515170,'VIRGEN DEL CARMEN',515),
(515180,'SAN FRANCISCO',515),
(515190,'SAN BLAS',515),
(515200,'CALLE ALEGRE',515),
(515210,'3 DE MAYO',515),
(515220,'LA VIRGINIA',515),
(515230,'NORTE AMERICA',515),
(515999,'(NO INFORMADO)',515),
(516001,'URBANO',516),
(516100,'MARGARITA',516),
(516110,'RESERVA PARAGUAYA',516),
(516120,'CAACUPEMI',516),
(516130,'ISLA CAMINERA',516),
(516140,'SAN MARCOS',516),
(516150,'SAN CARLOS',516),
(516160,'SAN LORENZO',516),
(516170,'SANTA TERESA',516),
(516180,'PALMITAL',516),
(516190,'SAN RAFAEL',516),
(516200,'YACARE CAI',516),
(516210,'SANTA ANA',516),
(516220,'CAMPO FLORIDO',516),
(516230,'SAN ROQUE',516),
(516240,'SAN ANTONIO',516),
(516250,'INDIGENA YBY MOROTI',516),
(516260,'PALOMARES',516),
(516999,'(NO INFORMADO)',516),
(517001,'URBANO',517),
(517100,'SAN JOSE OBRERO',517),
(517110,'SANTA LUCIA',517),
(517120,'SAN MIGUEL',517),
(517130,'SAN FRANCISCO',517),
(517140,'SAN JUAN',517),
(517150,'ZANJA CORA',517),
(517160,'SANTA ROSA',517),
(517170,'SANTO DOMINGO',517),
(517180,'SANTA ELENA',517),
(517190,'SAN ANTONIO',517),
(517200,'SANTA LIBRADA',517),
(517210,'MARIA AUXILIADORA',517),
(517220,'SAN LUIS',517),
(517230,'SAN ISIDRO',517),
(517240,'SAN RAFAEL',517),
(517250,'CALLE PYAJHU',517),
(517260,'LEIVA I',517),
(517270,'SAN BLAS',517),
(517999,'(NO INFORMADO)',517),
(518001,'URBANO',518),
(518100,'CANDIA CUE',518),
(518110,'SAN CARLOS',518),
(518120,'REMANSO',518),
(518130,'ZAPALLO',518),
(518140,'PILAR',518),
(518150,'YUQUERI',518),
(518160,'SANTA INES',518),
(518170,'SAN LUIS',518),
(518180,'CORRENTINA',518),
(518190,'SAN RAFAEL',518),
(518200,'SAN JOSE',518),
(518210,'SAN PABLO',518),
(518220,'YUQUYRY',518),
(518230,'SANTA ROSA',518),
(518240,'GIMENEZ CUE',518),
(518250,'SANTA LIBRADA',518),
(518260,'SAN MIGUEL',518),
(518270,'SAN PEDRO',518),
(518280,'SAN LORENZO',518),
(518290,'KOE RORY',518),
(518300,'PASO ITA',518),
(518999,'(NO INFORMADO)',518),
(519001,'URBANO',519),
(519100,'APLAYAR',519),
(519110,'COSTA VILLALBA',519),
(519120,'NUPY',519),
(519130,'SAN DAMIAN',519),
(519140,'SANTA ANA',519),
(519150,'POTRERO ACEVAL',519),
(519160,'SAN LUIS',519),
(519170,'ARROYO PORA',519),
(519999,'(NO INFORMADO)',519),
(520001,'URBANO',520),
(520100,'NARANJITO',520),
(520110,'ASENTAMIENTO 16 DE JULIO',520),
(520120,'YERUTI',520),
(520130,'PIRA VERA',520),
(520140,'PALOMARES',520),
(520150,'YBY PYTA',520),
(520160,'ARROYO GUAZU',520),
(520170,'TEKO JOJA',520),
(520180,'POROMBO',520),
(520190,'SANTO DOMINGO',520),
(520200,'MARACANA',520),
(520210,'TEKO JOJA SEGUNDA LINEA',520),
(520220,'TEKO JOJA PRIMERA LINEA',520),
(520230,'CURUZU I',520),
(520240,'SEGUNDA LINEA CANDELARIA',520),
(520250,'SANTA ELENA',520),
(520260,'VIRGEN DE FATIMA',520),
(520270,'SAN JOSE',520),
(520280,'SAN BLAS',520),
(520290,'NUEVA BRASILIA',520),
(520300,'CAPIIBEBE',520),
(520310,'MBOCAYA I',520),
(520999,'(NO INFORMADO)',520),
(601001,'SAN ANTONIO',601),
(601002,'SANTA TERESITA',601),
(601003,'SAN BLAS',601),
(601004,'SAN ROQUE',601),
(601005,'BUENA VISTA',601),
(601006,'AVA,I',601),
(601100,'PASO PINDO',601),
(601120,'SAN PEDRO MI',601),
(601130,'ARASATY',601),
(601140,'ROSARIO GUAVIRA',601),
(601150,'SAN JOSE MI',601),
(601160,'JAULA CUE INMACULADA CONCEPCIO',601),
(601170,'ROSARIO SARANDY',601),
(601180,'ROSARIO KATIRY',601),
(601190,'ROSARIO ISLA KUPE',601),
(601200,'ROJAS SILVA',601),
(601210,'SAN MIGUEL',601),
(601220,'KABAJU RETA',601),
(601230,'GALEANO CUE',601),
(601240,'JAHAPETY',601),
(601250,'LOMA CLAVEL',601),
(601260,'TAJY',601),
(601270,'CAAZAPA',601),
(601280,'VISCAINO',601),
(601290,'COLONIA SAN COSME',601),
(601300,'POTRERO GUAZU',601),
(601310,'SANTA CATALINA',601),
(601320,'ISLA PAU',601),
(601330,'MANDUCUA',601),
(601340,'ISLA GUAZU',601),
(601350,'NAUMBY',601),
(601360,'ÑU PYAHU',601),
(601370,'JHUGUA GUAZU',601),
(601380,'ARROYO PORA',601),
(601400,'ALBADON',601),
(601410,'KERA -Y JHUGUA-I',601),
(601420,'POTRERO SAN MARCOS',601),
(601430,'POTRERO YBATE',601),
(601440,'FATIMA',601),
(601450,'ÐU PYAHU MI',601),
(601460,'BOQUERON',601),
(601470,'SAN IGNACIO',601),
(601480,'SAN SALVADOR',601),
(601490,'20 DE JULIO',601),
(601999,'(NO INFORMADO)',601),
(602001,'SAN VALENTIN',602),
(602002,'SANTA ROSA',602),
(602003,'CENTRO',602),
(602004,'CORAZON DE JESUS',602),
(602100,'GOLONDRINA',602),
(602110,'SANTA TERESA',602),
(602120,'SAN ISIDRO MBYA',602),
(602130,'KUATI',602),
(602140,'SAN CARLOS',602),
(602150,'MBOKAJA',602),
(602160,'TUNA',602),
(602170,'SAN AGUSTIN',602),
(602180,'PLANTACION',602),
(602190,'KOKUE POTY',602),
(602200,'VILLA PASTOREO',602),
(602210,'ROSARIO PASTOREO',602),
(602220,'YAKU',602),
(602230,'TARUMA',602),
(602240,'8 DE DICIEMBRE',602),
(602250,'KUÐATAI',602),
(602260,'ORO CUI',602),
(602270,'CAMPO AZUL',602),
(602280,'MARACANA',602),
(602290,'TUPARENDA',602),
(602300,'LINEA SAN PABLO',602),
(602310,'LINEA 12',602),
(602320,'PAULISTA',602),
(602330,'ENTRE RIOS',602),
(602340,'EMILIANO RE',602),
(602350,'SAN JOSE CRISTAL',602),
(602360,'ARATIKU',602),
(602370,'CANTINA CUE',602),
(602380,'PIRAY',602),
(602390,'SANTA ELENA',602),
(602400,'SGDA LINEA CRISTAL',602),
(602410,'PARQUE NUEVO YGUAZU',602),
(602420,'ESPIRITU SANTO',602),
(602430,'NUEVA ESPERANZA',602),
(602440,'SAN ROQUE',602),
(602450,'AMAMBAY',602),
(602460,'SAN FRANCISCO',602),
(602470,'SAN JORGE',602),
(602480,'SANTA MARGARITA',602),
(602490,'TACUARY',602),
(602500,'GASPAR CUE',602),
(602510,'SANTA CATALINA',602),
(602520,'KAPIITYNDY',602),
(602530,'KILOMETRO 10',602),
(602540,'SAN LORENZO',602),
(602550,'TARUMA PRIMERA LINEA',602),
(602560,'SAN MARCOS',602),
(602570,'KM 18 MARIA AUXILIADORA',602),
(602999,'(NO INFORMADO)',602),
(603001,'SAN ANTONIO',603),
(603002,'SAN LUIS',603),
(603003,'CRISTO REY',603),
(603004,'CORAZON DE JESUS',603),
(603005,'SAN ISIDRO',603),
(603100,'SANTA ROSA',603),
(603110,'SAN RAMON',603),
(603130,'SAN AGUSTIN',603),
(603140,'TORRES CUE',603),
(603150,'JEROVIA',603),
(603160,'COCUERE',603),
(603170,'MIRANDA CUE',603),
(603190,'GUAJHO',603),
(603200,'COSTEADA',603),
(603210,'JAPEPO ISLA',603),
(603999,'(NO INFORMADO)',603),
(604001,'URBANO',604),
(604100,'CORRALITO SAN MIGUEL',604),
(604110,'CORRALITO SAN RAMON',604),
(604120,'MOISES BERTONI',604),
(604130,'ROGELIO BENITEZ',604),
(604140,'SANTA CECILIA',604),
(604150,'SAN CARLOS',604),
(604160,'SANTA TERESA',604),
(604170,'SAN ROQUE',604),
(604180,'LOMA I',604),
(604999,'(NO INFORMADO)',604),
(605001,'SAN ANTONIO',605),
(605002,'SAN JOSE',605),
(605003,'SAN MARCOS',605),
(605110,'YBA PYTA',605),
(605120,'MBARAKAJA KUA',605),
(605130,'GUYRA KEHA',605),
(605140,'SANTA MARIA JHUGUA',605),
(605150,'COSTA ESPERANZA',605),
(605160,'ISLA FLORIDA',605),
(605170,'SANTA MARIA',605),
(605180,'PINDOYU',605),
(605190,'SAN ESTANISLAO',605),
(605200,'SAN RAMON',605),
(605210,'DURAZNO',605),
(605220,'SANTA MARIA KM 50',605),
(605230,'PATIÐO',605),
(605999,'(NO INFORMADO)',605),
(606001,'URBANO',606),
(606100,'VALOIS RIVAROLA',606),
(606110,'ZANJA PYTA',606),
(606120,'CARA CARAI',606),
(606130,'SAN FRANCISCO MI',606),
(606140,'SAN MIGUEL',606),
(606150,'29 DE SETIEMBRE',606),
(606160,'SOLALINDE',606),
(606170,'MACIEL',606),
(606180,'COSTA DULCE',606),
(606999,'(NO INFORMADO)',606),
(607001,'SAN LUIS',607),
(607002,'SAN VICENTE',607),
(607003,'CENTRAL',607),
(607004,'SAN JOSE',607),
(607005,'SAGRADO CORAZON DE JESUS',607),
(607006,'SAN AGUSTIN',607),
(607100,'SAN FRANCISCO',607),
(607110,'SAN PEDRO',607),
(607120,'NOGUERAS CUE',607),
(607130,'VIRGEN DE FATIMA',607),
(607140,'FRANCO I',607),
(607150,'ZANJA PYTA',607),
(607160,'ÐU PYAJHU',607),
(607170,'SAN BENITO',607),
(607180,'CABAYU ACANGUE',607),
(607190,'FRANCO CUE',607),
(607200,'SAN CRISTOBAL',607),
(607210,'7 POTRERO SAN ALFONSO',607),
(607220,'JHUGUA PUCU',607),
(607230,'YURUNDIA Y',607),
(607240,'ISLA YOBAI',607),
(607250,'CARIDAD',607),
(607260,'SAN ROQUE MBURICA I',607),
(607270,'PINDO I',607),
(607280,'POTRERO YBATE',607),
(607290,'NARANJO',607),
(607300,'CIERVO KUA',607),
(607310,'ÐUMI',607),
(607320,'POTRERO OCULTO',607),
(607330,'KAUNDYGUE',607),
(607340,'POTRERO SAN MIGUEL',607),
(607350,'SANTA LIBRADA',607),
(607360,'BIJU',607),
(607370,'LORITO',607),
(607380,'MANDUARA',607),
(607390,'YPANE',607),
(607400,'SAN RAFAEL',607),
(607410,'AKANGUY',607),
(607420,'TEBIKUARY MI',607),
(607430,'SAN ISIDRO',607),
(607440,'SAN BLAS',607),
(607450,'SAN CARLOS',607),
(607460,'RESERVA TAPYTA',607),
(607470,'EMPALADO',607),
(607490,'NAHU',607),
(607500,'POTRERO SANTIAGO',607),
(607999,'(NO INFORMADO)',607),
(608001,'URBANO',608),
(608100,'MARIA AUXILIADORA',608),
(608110,'VOGONIA',608),
(608120,'APEPU',608),
(608130,'SANTA ANA',608),
(608140,'SAN FRANCISCO',608),
(608150,'SAN AGUSTIN',608),
(608160,'PINDO TAVAI',608),
(608170,'RAMADITA',608),
(608180,'ATONGUE',608),
(608190,'TORO BLANCO I',608),
(608200,'MARIA AUXILIADORA VALLE\'I',608),
(608210,'VIRGEN DEL CARMEN',608),
(608220,'SAN GABRIEL',608),
(608230,'RIVAS CUE',608),
(608240,'YBYBO',608),
(608250,'YBYARI',608),
(608260,'ÐU KAÐY',608),
(608270,'ITA ANGUA',608),
(608280,'KASTOR CUE',608),
(608290,'TAVA PORA',608),
(608300,'VIJU',608),
(608310,'KAAZAPA MI',608),
(608320,'YBYTU KORA',608),
(608330,'SAN ROQUE',608),
(608340,'ORO VERDE',608),
(608350,'TORANZO 2',608),
(608360,'ÐU PYAHU',608),
(608370,'MARIA DE LA ESPERANZA',608),
(608380,'VILLA UNIDAD',608),
(608390,'MBOIRY',608),
(608400,'NUEVA ESPERANZA',608),
(608410,'TEMBIAPORENDA',608),
(608420,'CERRO CORA',608),
(608430,'TORANZO 1',608),
(608440,'TORO BLANCO GUAZU',608),
(608450,'TITI FIRPO',608),
(608999,'(NO INFORMADO)',608),
(609001,'SAN SINFORIANO',609),
(609002,'SAN LUIS',609),
(609003,'CAACUPE',609),
(609004,'FATIMA',609),
(609100,'CASTA LIMA',609),
(609110,'SAN RAFAEL',609),
(609120,'PUNTA GUAZU',609),
(609130,'PINDOYU',609),
(609140,'GUYRAKATU',609),
(609150,'ISLA TERCERA',609),
(609160,'MBARIGUI',609),
(609170,'ISLA SAKA',609),
(609180,'ESTANCIA SAN LUIS S.A.',609),
(609190,'ESTANCIA CAMBAY S.A.',609),
(609200,'PUESTO NARANJO',609),
(609999,'(NO INFORMADO)',609),
(610001,'MARIA GORETTI',610),
(610002,'SANTO DOMINGO',610),
(610003,'SAN LUIS',610),
(610004,'SANTA INES',610),
(610100,'VERA CUE',610),
(610110,'YATAITY',610),
(610120,'SANTA URSULA',610),
(610130,'CERRITO',610),
(610140,'KUARAHY RESE',610),
(610150,'AVAY',610),
(610160,'KURUPI',610),
(610170,'TAKUAREMBOY',610),
(610180,'SAN GERONIMO',610),
(610190,'LIMA',610),
(610200,'DOLORES',610),
(610210,'CAPIINDY POTRERO',610),
(610220,'COLONIAS UNIDAS',610),
(610230,'BUENA VISTA',610),
(610240,'TUPILANDIA',610),
(610250,'CERRO YVU',610),
(610260,'POTRERO ANTEOJO',610),
(610270,'GASORY',610),
(610280,'KAA KARAPA',610),
(610290,'SAUCE',610),
(610300,'SARGENTO POTRERO',610),
(610310,'KAPIITINDY',610),
(610320,'PINDOTY',610),
(610330,'LOMITA',610),
(610340,'LOMA GUAZU',610),
(610350,'3 DE MAYO',610),
(610360,'YTORORO',610),
(610370,'ARGAÐA CUE',610),
(610380,'POTRERO YVATE',610),
(610390,'TATUKUA',610),
(610400,'CAÐADA SAN JOSE',610),
(610420,'JAKURA A',610),
(610430,'AZAME CUE',610),
(610440,'ARARUPE',610),
(610450,'AGUARAY GUAZU',610),
(610460,'JAGUARETE KORA',610),
(610470,'SAN MIGUEL',610),
(610480,'YARATI I',610),
(610490,'SAN ANTONIO',610),
(610500,'GUAZU KAI',610),
(610510,'LOMA URUGUAY',610),
(610520,'TIRIRI SAN ANTONIO',610),
(610530,'ITA ANGUA',610),
(610540,'SAN JUAN',610),
(610550,'SANTA BARBARA',610),
(610560,'SANTA ROSA DE LIMA',610),
(610570,'ESTACION SAN LORENZO',610),
(610580,'ESTACION YUTY',610),
(610590,'SAN ISIDRO',610),
(610600,'AYALA CUE',610),
(610610,'SAN JUAN LOMA',610),
(610620,'KAGUARE',610),
(610999,'(NO INFORMADO)',610),
(701001,'BOQUERON',701),
(701002,'INMACULADA CONCEPCION',701),
(701003,'JUAN LEON MALLORQUIN',701),
(701004,'LA VICTORIA',701),
(701005,'OBRERO',701),
(701006,'SAN ROQUE GONZALEZ',701),
(701007,'PACU CUA',701),
(701008,'CARLOS ANTONIO LOPEZ',701),
(701009,'CATEDRAL',701),
(701010,'SAN BLAS',701),
(701011,'SAN JOSE',701),
(701012,'BARRIL PASO',701),
(701013,'SANTA ROSA',701),
(701014,'PADRE BOLIK',701),
(701015,'GENERAL CABALLERO',701),
(701016,'LA PAZ',701),
(701017,'IPVU',701),
(701018,'VILLA CANDIDA',701),
(701019,'POLI-Y',701),
(701020,'BUENA VISTA',701),
(701021,'MBOY CAE',701),
(701022,'KENNEDY',701),
(701023,'MARIA AUXILIADORA',701),
(701024,'CAAGUY RORY',701),
(701025,'QUITERIA',701),
(701026,'SAN PEDRO',701),
(701027,'SANTA MARIA',701),
(701028,'NUEVA ESPERANZA',701),
(701029,'SAN ISIDRO',701),
(701100,'PRADERA ALTA',701),
(701110,'ITACUA',701),
(701120,'CHAIPE',701),
(701130,'SANTA MARIA SANTILLAN',701),
(701140,'ITANGUA',701),
(701150,'CURUZU TOMAS',701),
(701160,'CERRITO',701),
(701170,'ITA PASO',701),
(701180,'SANTO DOMINGO',701),
(701190,'SAN LUIS',701),
(701200,'URU SAPUCAI',701),
(701210,'SAN ANTONIO YPECURU',701),
(701220,'CUATRO POTRERO',701),
(701999,'(NO INFORMADO)',701),
(702001,'8 DE DICIEMBRE',702),
(702002,'NIÐO JESUS',702),
(702003,'CENTRO',702),
(702004,'OBRERO',702),
(702005,'TISCHLER',702),
(702006,'CONAVI',702),
(702100,'FISCO',702),
(702110,'VACAY',702),
(702120,'SANTA CLARA',702),
(702130,'ACA CARAYA',702),
(702140,'FORDI',702),
(702150,'SELECTA',702),
(702160,'SAN PEDRO',702),
(702170,'PUERTO BELLA VISTA',702),
(702999,'(NO INFORMADO)',702),
(703001,'URBANO',703),
(703100,'SAN FRANCISCO',703),
(703110,'VALDEZ',703),
(703120,'JARDIN',703),
(703130,'LA AMISTAD',703),
(703140,'LAS CARMELITAS',703),
(703150,'SAN MIGUEL',703),
(703160,'SAN BLAS',703),
(703170,'ESPIRITU SANTO',703),
(703180,'KURIY',703),
(703190,'LOS MAESTROS - LAS MERCEDES 2',703),
(703200,'SAN JUAN',703),
(703220,'SANTA LIBRADA',703),
(703230,'MBURICA',703),
(703240,'SAN BLAS INDEPENDENCIA',703),
(703250,'ARROYO PORA',703),
(703260,'BARRERO GUAZU',703),
(703270,'CAMPICHUELO',703),
(703280,'COL. PARANA',703),
(703290,'COL. CAMBYRETA',703),
(703295,'COL. CAMBYRETA 1',703),
(703300,'ARROYO VERDE',703),
(703999,'(NO INFORMADO)',703),
(704001,'URBANO',704),
(704100,'EDELIRA I',704),
(704110,'CAPITAN MEZA. 4 BOCAS',704),
(704120,'CAPITAN MEZA.KM.16',704),
(704130,'CAPITAN MEZA.KM.24',704),
(704140,'CAPITAN MEZA.KM.32',704),
(704150,'CAPITAN MEZA.KM.28',704),
(704999,'(NO INFORMADO)',704),
(705001,'URBANO',705),
(705100,'FEDERICO CHAVEZ',705),
(705110,'SANTA LIBRADA',705),
(705120,'CALLE B NORTE',705),
(705130,'CALLE A NORTE',705),
(705140,'PICADA BOCA',705),
(705150,'CALLE D NORTE',705),
(705160,'CALLE C NORTE',705),
(705170,'CALLE D SUR',705),
(705180,'CALLE C SUR',705),
(705190,'ITA VERA',705),
(705200,'CALLE B SUR',705),
(705210,'INMACULADA CONCEPCION',705),
(705220,'CALLE A SUR',705),
(705230,'YTORORO',705),
(705240,'ALBORADA 2',705),
(705999,'(NO INFORMADO)',705),
(706001,'URBANO',706),
(706100,'ALBORADA UNO',706),
(706110,'PUERTO ITA CAJON',706),
(706120,'PUERTO CANTERA',706),
(706130,'VILLA ALBORADA',706),
(706140,'PUERTO PARAISO',706),
(706150,'PUERTO SAMUHU',706),
(706160,'PUERTO TRINIDAD',706),
(706170,'PASO GUEMBE',706),
(706180,'ALBORADA CENTRAL SUR',706),
(706190,'ALBORADA CENTRAL NORTE',706),
(706200,'TRESPALMITO',706),
(706999,'(NO INFORMADO)',706),
(707001,'SAN MIGUEL',707),
(707002,'LOMA CLAVEL',707),
(707003,'SAN ISIDRO',707),
(707004,'SAN ROQUE',707),
(707005,'SAN BLAS',707),
(707006,'OBRERO',707),
(707100,'CALLE E SAN ISIDRO',707),
(707110,'KAATYMI',707),
(707120,'CERRITO',707),
(707130,'YACAREY',707),
(707140,'YBYRAITY',707),
(707150,'JHUGUA KARE',707),
(707160,'CARAGUATA',707),
(707170,'CALLE B SAN ISIDRO',707),
(707180,'CALLE D SAN ISIDRO',707),
(707190,'CALLE C SAN ISIDRO',707),
(707200,'SAN JORGE',707),
(707210,'SAN ANTONIO',707),
(707220,'CAMBAY',707),
(707230,'CALLE 7 CAMBAY',707),
(707250,'SAN MARTIN',707),
(707999,'(NO INFORMADO)',707),
(708001,'SANTA CLARA',708),
(708002,'SANTA ROSA',708),
(708003,'SAN BLAS',708),
(708004,'SANTA LIBRADA',708),
(708100,'CRISTO REY',708),
(708110,'SAN FRANCISCO',708),
(708120,'NACIONAL',708),
(708130,'CALLE 8',708),
(708150,'KURUÐAY',708),
(708160,'SAN ISIDRO',708),
(708170,'SAN RAFAEL',708),
(708180,'CAMBAY',708),
(708190,'ANTEQUERA',708),
(708200,'SAN ROQUE 2',708),
(708210,'SAN JUAN',708),
(708220,'CAUCASIA',708),
(708230,'YPYTA',708),
(708240,'DOMINGO BADO',708),
(708250,'SAN MIGUEL POTRERO',708),
(708260,'MBUTUY',708),
(708270,'RESQUIN CUE',708),
(708280,'TACUARY',708),
(708290,'AGUAPEY',708),
(708300,'SAN JUAN JHUGUA-I',708),
(708310,'AGUARARE',708),
(708320,'CERRITO',708),
(708330,'SAN ANTONIO',708),
(708340,'SAN ROQUE 1',708),
(708350,'TYMAKA',708),
(708360,'SIBERIA',708),
(708370,'FLORIDO',708),
(708380,'PUNTA PORA',708),
(708390,'TACUATY',708),
(708400,'SAN JORGE',708),
(708410,'TELLEZ CUE',708),
(708999,'(NO INFORMADO)',708),
(709001,'URBANO',709),
(709100,'PALMITAL',709),
(709110,'SANTO CRISTO',709),
(709120,'KRESBURGO',709),
(709130,'MAESTRO FERMIN',709),
(709140,'TIROL',709),
(709150,'SAN LORENZO',709),
(709160,'7 DE AGOSTO',709),
(709170,'VIRGEN DEL CARMEN',709),
(709180,'SAN ISIDRO',709),
(709190,'CAACUPEMI',709),
(709200,'MARIA AUXILIADORA',709),
(709999,'(NO INFORMADO)',709),
(710001,'URBANO',710),
(710100,'PUERTO TRIUNFO NIÐO JESUS',710),
(710110,'PUERTO TRIUNFO',710),
(710120,'PUERTO TRIUNFO SAN JOSE',710),
(710130,'NATALIO 6TA. LINEA',710),
(710140,'NATALIO 5TA. LINEA',710),
(710150,'NATALIO 3RA. LINEA',710),
(710160,'NATALIO 1RA. LINEA',710),
(710170,'PALOMA',710),
(710180,'NATALIO KM. 8',710),
(710190,'PASO CARRETA',710),
(710200,'SAN ISIDRO',710),
(710210,'NATALIO KM.12',710),
(710220,'NATALIO KM.23',710),
(710230,'CORAZON DE MARIA',710),
(710240,'NATALIO KM.17',710),
(710250,'SANTA LIBRADA',710),
(710260,'COL. NATALIO',710),
(710999,'(NO INFORMADO)',710),
(711001,'SAN ANTONIO',711),
(711002,'SAN FRANCISCO',711),
(711003,'SAN CAYETANO',711),
(711004,'SAN RAMON',711),
(711005,'ITAPE',711),
(711006,'SAN CRISTOBAL',711),
(711007,'OBRERO',711),
(711008,'8 DE DICIEMBRE',711),
(711100,'CALLE E-F',711),
(711110,'CALLE F-G',711),
(711120,'CALLE H-I',711),
(711130,'CALLE I-J',711),
(711140,'CALLE J-K',711),
(711150,'CALLE L-M',711),
(711160,'CALLE K-L',711),
(711170,'CALLE G-H',711),
(711999,'(NO INFORMADO)',711),
(712001,'URBANO 1',712),
(712002,'URNANO 2',712),
(712003,'URBANO 3',712),
(712004,'URBANO 4',712),
(712100,'AREKITA',712),
(712110,'DESGRACIA CUE',712),
(712120,'BOBI KARAPE',712),
(712130,'SAN PEDRO ÐU',712),
(712140,'POTRERO ÐEMBOTY',712),
(712150,'BOBI PUCU',712),
(712160,'HURTADO CUE',712),
(712170,'JHUGUA POI 2',712),
(712180,'SAN BLAS',712),
(712190,'YATAY',712),
(712200,'JHUGUA POI 1',712),
(712210,'ÐU GUAZU',712),
(712220,'POTRERITO',712),
(712230,'COLONIA INDEPENDENCIA',712),
(712240,'LOMA CLAVEL',712),
(712250,'TAROPE',712),
(712260,'YPA YERE',712),
(712270,'YUKYRAY',712),
(712280,'PICADA PYTA',712),
(712290,'ISLA ALTA',712),
(712300,'BUENA VISTA',712),
(712310,'SAN MIGUEL',712),
(712320,'SYRYRYKA',712),
(712330,'POTRERITO SAN ISIDRO',712),
(712340,'ÐU PYHAJHU',712),
(712350,'COLONIA CURUPAYTY',712),
(712360,'COLONIA URUGUAYA',712),
(712370,'SAN MIGUEL POTRERO',712),
(712380,'CAMBAY',712),
(712999,'(NO INFORMADO)',712),
(713001,'SAN ROQUE GONZALEZ',713),
(713002,'VIRGEN DE CAACUPE',713),
(713003,'NORTE',713),
(713100,'YBYRATY',713),
(713110,'COSTA CUE',713),
(713120,'SAN PEDRITO',713),
(713130,'SAN ISIDRO 2',713),
(713140,'SAN ESTANISLAO',713),
(713150,'VIRGEN DEL ROSARIO',713),
(713160,'SAN ISIDRO 1',713),
(713170,'KAATY',713),
(713180,'PUNTA PORA',713),
(713190,'SAN DIONICIO',713),
(713200,'SANTA LIBRADA',713),
(713210,'SAN JOSE',713),
(713220,'JHUGUA GUAZU',713),
(713230,'SAN BLAS',713),
(713240,'SANTA ROSA',713),
(713250,'PASO LAUREL',713),
(713260,'TAVAI',713),
(713999,'(NO INFORMADO)',713),
(714001,'URBANO',714),
(714100,'HOHENAU 5',714),
(714110,'HOHENAU 4 - KAGUARE NE',714),
(714120,'CAMPO ANGEL',714),
(714130,'HOHENAU 3',714),
(714140,'SANTA MARIA',714),
(714150,'HOHENAU 2',714),
(714160,'HOHENAU 1',714),
(714170,'SAN JOSE',714),
(714180,'CABAYU GUY',714),
(714190,'PUERTO SANTA ROSA',714),
(714999,'(NO INFORMADO)',714),
(715001,'URBANO',715),
(715100,'CAGUARENE',715),
(715110,'SAN ROQUE',715),
(715120,'CAAGUAZU',715),
(715130,'CARUMBEY',715),
(715140,'COLONIA GUARANI',715),
(715150,'SANTA TERESA',715),
(715160,'CAMBAY',715),
(715170,'INDIGENA GUARANI',715),
(715180,'MONDISABY',715),
(715999,'(NO INFORMADO)',715),
(716001,'URBANO',716),
(716100,'GAONA CUE',716),
(716110,'APEPU TY',716),
(716120,'LOMA JHOVY',716),
(716130,'SALISTRE CUE',716),
(716140,'CAÐADA TEBICUARY',716),
(716150,'SAN SOLANO MI',716),
(716160,'CAMPO FLORIDO',716),
(716170,'CAÑADA SAN RAMON',716),
(716180,'MBOCAPIRAY',716),
(716190,'POTRERO YAPEPO',716),
(716200,'ESTERO KAMBA',716),
(716999,'(NO INFORMADO)',716),
(717001,'URBANO',717),
(717100,'OBLIGADO KM 17',717),
(717110,'FISCO (OBLIGADO KM 42)',717),
(717120,'OBLIGADO KM 28',717),
(717130,'PASTOREO (ESCUELA SAN BENITO)',717),
(717140,'LAPACHAL',717),
(717150,'PALMITO',717),
(717160,'MORENA-I',717),
(717170,'ARRIBADA PYTA-I  (CANTERA)',717),
(717180,'OBLIGADO KM 10',717),
(717190,'VIRGEN DEL ROSARIO',717),
(717200,'OBLIGADO PUERTO (SAN MIGUEL)',717),
(717210,'VILLA ALEGRE',717),
(717999,'(NO INFORMADO)',717),
(718001,'REPUBLICANO',718),
(718002,'8 DE DICIEMBRE',718),
(718003,'DEFENSORES DEL CHACO',718),
(718004,'UNIVERSITARIO',718),
(718100,'1RA.LINEA',718),
(718110,'2DA. LINEA',718),
(718120,'3RA. LINEA',718),
(718130,'3RA. LINEA STO. DOMINGO',718),
(718140,'4TA. LINEA',718),
(718150,'SAN MIGUEL 1',718),
(718160,'DOMINGO ROBLEDO',718),
(718170,'PAREJHA 2',718),
(718180,'5TA. LINEA',718),
(718190,'JACUI MINI',718),
(718200,'JACUI GUAZU',718),
(718210,'REPATRIACION',718),
(718220,'KILOMETRO 24',718),
(718230,'SAN MIGUEL 2',718),
(718250,'SAN MIGUEL',718),
(718260,'SAN ROQUE',718),
(718270,'SANTA LIBRADA 4TA LINEA---',718),
(718290,'4TA LINEA BARRIO SAN JUAN',718),
(718300,'km24 palmital',718),
(718999,'(NO INFORMADO)',718),
(719001,'KAAGUY RORY',719),
(719002,'SAN MIGUEL',719),
(719003,'CENTRO',719),
(719004,'CAACUPE',719),
(719005,'VILLA PERMANENTE',719),
(719006,'NAINGUA',719),
(719007,'RIVERA',719),
(719100,'CRISTO REY',719),
(719110,'ISLA',719),
(719120,'CALLE 6',719),
(719130,'POTRERO CARDOZO',719),
(719140,'CAMBYRETA',719),
(719150,'INDIGENA PINDO',719),
(719160,'ÐUA U',719),
(719170,'SAN MAURICIO',719),
(719180,'ITAKY',719),
(719190,'ÐAIUNGUA',719),
(719200,'TAMBURA',719),
(719210,'PIRITY',719),
(719220,'LOMAS VALENTINAS',719),
(719230,'ATINGUY',719),
(719240,'TIBURCIO BOGADO',719),
(719250,'CALLE 1',719),
(719260,'CALLE 5',719),
(719270,'CALLE 2',719),
(719280,'CALLE 3',719),
(719290,'CALLE 4',719),
(719999,'(NO INFORMADO)',719),
(720001,'SAN FRANCISCO',720),
(720002,'SAN JOSE',720),
(720003,'SAN ANTONIO',720),
(720004,'SAN MIGUEL',720),
(720005,'SANTA ROSA',720),
(720006,'CENTRAL',720),
(720007,'SANTA CATALINA',720),
(720008,'FATIMA',720),
(720009,'VILLA ADELA',720),
(720010,'MANUEL ORTIZ GUERRERO',720),
(720100,'PIKY',720),
(720110,'NOVIRETA',720),
(720120,'POTRERITO',720),
(720130,'CAPITAN LEGUIZAMON',720),
(720140,'SAN ANTONIO MI',720),
(720150,'POTRERO KAA',720),
(720160,'COSTA RUIZ',720),
(720170,'SANJA HONDA',720),
(720180,'POTRERO DUARTE',720),
(720190,'BARRA CUE',720),
(720200,'SAN CAYETANO',720),
(720210,'TARUMA',720),
(720220,'SAN PEDRO ÐU',720),
(720230,'DESGRACIA CUE',720),
(720240,'SAN SOLANO',720),
(720250,'GUAZU CORA',720),
(720260,'MBOCAYA',720),
(720270,'SAN JUAN POI',720),
(720280,'SANTA BRIGIDA',720),
(720290,'SAN VICENTE',720),
(720300,'PUNTA RATY',720),
(720310,'CARAGUATAY',720),
(720320,'PASITO',720),
(720330,'COLONIAS UNIDAS',720),
(720340,'MBURUCUYA',720),
(720350,'MBOKAYA-I',720),
(720360,'YABEBYRY',720),
(720370,'SAN ANTONIO GUAZU',720),
(720380,'MBOPICUE',720),
(720390,'GUAZU ICUA',720),
(720400,'SAN JOSE PICADA',720),
(720410,'ÐU PYAJHU',720),
(720420,'MBARIGUI',720),
(720430,'SANTIAGO CUE',720),
(720440,'SAN ROQUE',720),
(720450,'SANTO DOMINGO',720),
(720460,'CARAGUATA',720),
(720470,'RINCON DE LUNA',720),
(720480,'SANTA CRUZ (CURUZU ESTEBAN)',720),
(720490,'CARIÐO',720),
(720500,'CURUPICAY',720),
(720510,'MISIONES',720),
(720520,'PINDOYU',720),
(720530,'TACUARA',720),
(720540,'TIMBO-I',720),
(720550,'SAN RAFAEL',720),
(720560,'MONTEGRANDE',720),
(720570,'SAN ISIDRO (COLONIA 44)',720),
(720580,'MANDIYU TYGUE - YSYPO YU',720),
(720590,'SAN LORENZO',720),
(720600,'PUENTE CUE',720),
(720610,'SAN AGUSTIN',720),
(720620,'PIRYTY',720),
(720630,'FLEITAS CUE',720),
(720640,'YAGUA CUA',720),
(720650,'MBYJA COE',720),
(720660,'SAN ROQUE POI',720),
(720670,'MBATOVI',720),
(720680,'POTRERO BENITEZ',720),
(720690,'POTRERO YBATE',720),
(720700,'SAN JOSE POTRERO',720),
(720710,'SAN JUAN GUAZU',720),
(720720,'PARIRI',720),
(720730,'MOROTINGUE',720),
(720740,'ARROYO FRAZADA',720),
(720750,'POTRERITO 2 (SAN JORGE)',720),
(720760,'CAAZAPAMI',720),
(720770,'CURUZU ESTEBAN',720),
(720780,'ASENTAMIENTO NVA ESPERANZA',720),
(720790,'CHILAVERT CUE',720),
(720800,'CAÑADITA',720),
(720810,'STA TERESA',720),
(720820,'ASENTAMIENTO 8 DE DICIEMBRE',720),
(720830,'VIRGEN DEL PILAR',720),
(720840,'KURUPIKAY',720),
(720850,'POCUA SAN LORENZO',720),
(720860,'HERMITA',720),
(720870,'HUGUA POI',720),
(720880,'POTRERO',720),
(720890,'COSTA PERO',720),
(720900,'SANTA LIBRADA',720),
(720910,'COLONIA EL PROGRESO',720),
(720920,'LAS MERCEDES',720),
(720930,'ASENTAMIENTO 15 DE MAYO',720),
(720940,'JAGUA KUA I',720),
(720950,'JAGUA KUAGUASU',720),
(720960,'ASENTAMIENTO ÑEMITYRA',720),
(720970,'YATA\'I',720),
(720980,'SANTA LUCIA',720),
(720981,'BOGADO CUE',720),
(720982,'IBARRA CUE',720),
(720983,'SAN NICOLAS',720),
(720984,'PAZ Y PROGRESO',720),
(720985,'TEBICUARY',720),
(720986,'12 DE JULIO CAMPAMENTO',720),
(720987,'KARACHÀ',720),
(720990,'ASC KUARAHY RESE',720),
(720991,'ÑU PYAHUMI',720),
(720992,'POTRERO ÑEMBOTY',720),
(720993,'POTRERO LOMA',720),
(720994,'AS, SAN RAMON',720),
(720995,'ZANJA KORA',720),
(720996,'SAN IGNACIO',720),
(720997,'COMP KY`YI',720),
(720999,'(NO INFORMADO)',720),
(721001,'URBANO',721),
(721100,'APEAIME',721),
(721110,'ALBORADA',721),
(721120,'YACUTINGA',721),
(721130,'YANQUI KUE',721),
(721140,'SAN RAFAEL PORVENIR 2DA. LINEA',721),
(721150,'SAN RAFAEL PORVENIR 1RA. LINEA',721),
(721160,'8 DE DICIEMBRE',721),
(721170,'COLONIA SAN RAFAEL',721),
(721180,'COLONIA TEMBEY',721),
(721190,'SAN FRANCISCO',721),
(721200,'NARANJITO',721),
(721210,'LOS CEDROS',721),
(721220,'NUEVA AURORA',721),
(721230,'ROSAURA',721),
(721999,'(NO INFORMADO)',721),
(722001,'URBANO',722),
(722002,'TABLADA',722),
(722100,'VILLA SANTA MARIA',722),
(722110,'NARANJAL',722),
(722120,'ITA VERA',722),
(722130,'PASO GUEMBE',722),
(722140,'SAN PEDRO',722),
(722150,'SAN JOAQUIN',722),
(722160,'PICADA BOCA',722),
(722170,'SAN ANTONIO',722),
(722180,'CAMBAY',722),
(722999,'(NO INFORMADO)',722),
(723001,'URBANO',723),
(723100,'PIRAPEY',723),
(723110,'PASO CARRETA',723),
(723120,'EDELIRA KM.28',723),
(723130,'ARA POTY',723),
(723140,'EDELIRA KM.54 A',723),
(723150,'EDELIRA KM.41',723),
(723160,'EDELIRA KM.45',723),
(723170,'EDELIRA KM.70',723),
(723180,'EDELIRA KM.49',723),
(723190,'EDELIRA KM.65',723),
(723200,'EDELIRA KM.54 B',723),
(723210,'EDELIRA KM.21',723),
(723999,'(NO INFORMADO)',723),
(724001,'URBANO',724),
(724100,'LAS MERCEDES',724),
(724110,'ITAPIRANGA',724),
(724120,'PERPETUO SOCORRO',724),
(724130,'TRIUNFO KM 60',724),
(724140,'NATALIO 70',724),
(724150,'TRINFO KM 50',724),
(724160,'ÐEMITY RENDA',724),
(724170,'SAN CAYETANO',724),
(724180,'TRIUNFO 43 (SAN ROQUE - SAN BL',724),
(724190,'6TA LINEA (PIRAPEY)',724),
(724200,'SAN BALTAZAR',724),
(724210,'SAN ANTONIO - SANTA LUCIA',724),
(724220,'VALLE PORA',724),
(724230,'BARRIO UNIDO',724),
(724240,'TRIUNFO 40 (SAN IGNACIO - SANT',724),
(724250,'BARRIO OBRERO - SAN PEDRO',724),
(724999,'(NO INFORMADO)',724),
(725001,'URBANO',725),
(725100,'LIBERTAD DEL SUR',725),
(725110,'ASENTAMIENTO TAGUATO',725),
(725120,'COMPAÐIA.PERLITA',725),
(725130,'LA AMISTAD',725),
(725140,'CERRO GUY',725),
(725150,'CÐIA.. MARGARITA',725),
(725160,'CÐIA. YNAMBU',725),
(725170,'CARAGUATA',725),
(725180,'CÐIA. PONCHO',725),
(725190,'STA. LIBRADA',725),
(725200,'SAN ROQUE',725),
(725210,'CERRO PERO',725),
(725220,'PARADEMA',725),
(725230,'VIALIDAD',725),
(725240,'TARUMA',725),
(725250,'COL. ALTO VERA',725),
(725260,'CARONA Y',725),
(725270,'PINDOJU',725),
(725280,'MBATOVI',725),
(725300,'POTRERO KAA',725),
(725310,'CERRO CORA',725),
(725320,'OGA ITA',725),
(725330,'SAN SOLANO',725),
(725350,'POZO AZUL',725),
(725360,'AS BONANZA',725),
(725370,'AS VY`A RENDA',725),
(725380,'SANTA ROSA',725),
(725390,'8 DE DICIEMBRE',725),
(725999,'(NO INFORMADO)',725),
(726001,'URBANO',726),
(726100,'SANTA ROSA',726),
(726110,'SUELO CUE',726),
(726120,'MBERY',726),
(726130,'SAN CARLOS',726),
(726140,'ITAPESYI',726),
(726150,'LA PAZ',726),
(726160,'CALLE CUATRO S',726),
(726170,'RECADO',726),
(726180,'CALLE R CUATRO',726),
(726190,'CALLE CERO',726),
(726200,'CALLE Q',726),
(726210,'CALLE M CINCO',726),
(726220,'CALLE P',726),
(726230,'FUJI',726),
(726999,'(NO INFORMADO)',726),
(727001,'URBANO',727),
(727100,'FATIMA',727),
(727110,'YATYTAY KM.16',727),
(727120,'VIRGEN DE FATIMA',727),
(727130,'YATYTAY KM.24',727),
(727140,'SAN FRANCISCO',727),
(727150,'ASENTAMIENTO SAN GERONIMO',727),
(727160,'BONANZA 1RA. LINEA',727),
(727170,'BONANZA 2DA. LINEA',727),
(727180,'BONANZA 3RA. LINEA',727),
(727190,'BONANZA 4TA. LINEA',727),
(727200,'YATYTAY KM.8',727),
(727210,'YATYTAY KM.13',727),
(727220,'GUAZUY KM.22',727),
(727230,'YATYTAY KM.18',727),
(727240,'BONANZA STA. RITA',727),
(727250,'BONANZA SAN ANTONIO',727),
(727260,'BONANZA 3 DE MAYO',727),
(727999,'(NO INFORMADO)',727),
(728001,'URBANO',728),
(728100,'VIRGEN DE FATIMA',728),
(728110,'SAN JUAN DEL PARANA 1',728),
(728120,'SAN NICOLAS',728),
(728130,'SANTA ROSA DE GUABIYU',728),
(728140,'SAN LUIS DEL PARANA',728),
(728150,'SAN JUAN DEL PARANA 2',728),
(728999,'(NO INFORMADO)',728),
(729001,'SAN BLAS',729),
(729002,'SAN FRANCISCO',729),
(729003,'CENTRO',729),
(729004,'OBRERO',729),
(729005,'SAN MIGUEL',729),
(729100,'YAGUARAZAPA',729),
(729110,'PUERTO PIRAPO',729),
(729120,'ACA CARAYA',729),
(729130,'MANDUBIYU',729),
(729140,'KAARENDY',729),
(729150,'CALLE 2',729),
(729160,'PIRAPO KM.23',729),
(729170,'PIRAPO KM.25',729),
(729180,'CAMPO GUARANI',729),
(729190,'COLONIA PIRAPO',729),
(729999,'(NO INFORMADO)',729),
(730001,'URBANO',730),
(730100,'EDELIRA 60',730),
(730110,'PIROY',730),
(730120,'ITAPUA POTY KM. 40',730),
(730130,'PIRAPOI 3RA. LINEA',730),
(730140,'PIRAPOI 1RA. LINEA',730),
(730150,'PIRAPOI 2DA. LINEA',730),
(730160,'ASENTAMIENTO TAGUATO',730),
(730170,'CLARO DEL SUR',730),
(730180,'TACUAPI',730),
(730190,'KATUPYRY 70',730),
(730200,'SAN BUENAVENTURA',730),
(730210,'COL. ITAPUA POTY',730),
(730220,'COL. KATUPYRY',730),
(730230,'ITAPUA POTY BARANA',730),
(730999,'(NO INFORMADO)',730),
(801001,'SAN FRANCISCO',801),
(801002,'SANTA ROSA DE LIMA',801),
(801003,'SAN MIGUEL',801),
(801004,'OBRERO',801),
(801005,'GENERAL CABALLERO',801),
(801006,'UNIVERSITARIO',801),
(801007,'CONCEPCION',801),
(801008,'BOQUERON',801),
(801009,'NUESTRA SENORA DE LA ASUNCION',801),
(801010,'GENERAL DIAZ',801),
(801011,'CENTRO',801),
(801012,'SANTA MARIA DE LOURDES',801),
(801013,'SAN ANTONIO',801),
(801014,'GUAPO,Y',801),
(801100,'AREA DE ESTANCIAS',801),
(801110,'ITA YURU',801),
(801120,'CERRO PERO',801),
(801130,'SAN CRISTOBAL',801),
(801140,'ISLA TOBATI',801),
(801150,'YATAI',801),
(801160,'TAPE GUAZU',801),
(801170,'YNAMBUVY',801),
(801190,'LOMA',801),
(801200,'VIRGEN DE LOURDES',801),
(801210,'TRISTAN SALAZAR',801),
(801220,'SAN JUAN',801),
(801230,'PASO NARANJA',801),
(801240,'MBURICA',801),
(801250,'COCUERE',801),
(801260,'COLONIA IBAÐEZ ROJAS',801),
(801999,'(NO INFORMADO)',801),
(802001,'NUCLEO 02',802),
(802002,'NUCLEO 01',802),
(802003,'VILLA PERMANENTE 2',802),
(802004,'VILLA PERMANENTE',802),
(802005,'SAN JOSE OBRERO',802),
(802006,'MARIA GRACIELA',802),
(802007,'SAN ANTONIO',802),
(802008,'SAN JOSE MI',802),
(802009,'SANTA ROSA DE LIMA',802),
(802100,'CAÐA DE CASTILLA',802),
(802110,'COSTA YABEBYRY',802),
(802120,'ESTERO BELLACO',802),
(802130,'JHUGUA-I',802),
(802140,'SANTA LIBRADA',802),
(802150,'BARRETO-CUE',802),
(802160,'ISLA YASYRETA',802),
(802170,'YATAITY',802),
(802180,'KOEYU',802),
(802190,'BOQUERON',802),
(802200,'MBOCAYATY',802),
(802210,'SIRENA',802),
(802220,'PUESTO 6',802),
(802230,'LAS MERCEDES',802),
(802240,'ALEJO GARCIA',802),
(802250,'CORATEI',802),
(802999,'(NO INFORMADO)',802),
(803001,'LOMA CLAVEL',803),
(803002,'LOURDES',803),
(803003,'SAN FRANCISCO',803),
(803004,'SAN JOSE',803),
(803005,'SAN SALVADOR',803),
(803006,'SAN ROQUE',803),
(803007,'MARIA AUXILIADORA',803),
(803008,'SAN VICENTE',803),
(803009,'SANTO ANGEL',803),
(803010,'RESISTENCIA',803),
(803100,'ASENTAMIENTO 1RO. DE NOVIEMBRE',803),
(803110,'COLONIA REINSFELD',803),
(803120,'COLONIA URUGUAYA',803),
(803130,'SAN ANTONIO',803),
(803140,'ARROYO VERDE',803),
(803150,'TAHYI-TY',803),
(803160,'KAA YBATE',803),
(803170,'SAN MIGUEL',803),
(803180,'HECTOR CUE',803),
(803190,'SAN BLAS SUR',803),
(803210,'TAÐARANDY',803),
(803220,'CAPIATI',803),
(803230,'SAN BLAS NORTE',803),
(803240,'SAN JAVIER',803),
(803250,'SAN JUAN POTRERO',803),
(803260,'SANTA MARIA MI',803),
(803270,'COSTA PIRU',803),
(803280,'LOMA PYTA',803),
(803290,'SAN PABLO',803),
(803300,'ÐEMI',803),
(803310,'SANTA RITA',803),
(803320,'ASENTAMIENTO MARTIN ROLON',803),
(803330,'SANTA TERESITA',803),
(803340,'JAGUA-RY',803),
(803350,'COSTA PUCU',803),
(803360,'KAAGUY JHOVY SAN BENITO',803),
(803370,'GUASU RAPE',803),
(803380,'SAN ISIDRO',803),
(803390,'SANTO DOMINGO',803),
(803400,'ROSADO TUJA SAN JOSE',803),
(803410,'ROSADO TUJA SANTA LIBRADA',803),
(803420,'ÐANGAPE',803),
(803430,'ABA-Y',803),
(803440,'CAJES CUE',803),
(803450,'MEZA CUE',803),
(803999,'(NO INFORMADO)',803),
(804001,'BARRIO 1',804),
(804002,'BARRIO 2',804),
(804003,'BARRIO 3',804),
(804004,'BARRIO 4',804),
(804100,'AREA DE ESTANCIAS',804),
(804110,'MARIA AUXILIADORA',804),
(804120,'ARASAPE',804),
(804130,'COSTA JHU',804),
(804140,'ITA YURU',804),
(804150,'CIUDAD NUEVA',804),
(804160,'ISLA TACUARA',804),
(804170,'SAN MAURICIO',804),
(804180,'YSYPO',804),
(804190,'SANTA LIBRADA',804),
(804200,'SAN PEDRO',804),
(804210,'YSYPO POTRERO',804),
(804999,'(NO INFORMADO)',804),
(805001,'URBANO',805),
(805100,'SANTO ANGEL',805),
(805110,'POTRERITO YBATE',805),
(805120,'CONCEPCION',805),
(805999,'(NO INFORMADO)',805),
(806001,'URBANO',806),
(806100,'ZONA DE ESTANCIAS',806),
(806110,'PARACAU',806),
(806120,'SAN ANTONIO',806),
(806130,'ITACURUBI',806),
(806140,'ZANJA CORA',806),
(806150,'SAN FERNANDO',806),
(806160,'TRINIDAD CUE',806),
(806170,'CERRO COSTA',806),
(806180,'LAS MERCEDES',806),
(806190,'SAN GERONIMO',806),
(806200,'CAACUPE',806),
(806210,'LOURDES',806),
(806220,'SAN JUAN BERCHMANS',806),
(806230,'FATIMA',806),
(806240,'TAVA I',806),
(806250,'CURUPAYTY',806),
(806260,'ARROYO KARE',806),
(806999,'(NO INFORMADO)',806),
(807001,'URBANO',807),
(807100,'AREA DE ESTANCIAS',807),
(807110,'SAN FRANCISCO CUE',807),
(807120,'SAN GABRIEL',807),
(807130,'COLONIA ACEVEDO',807),
(807140,'SAN JOSE 19',807),
(807150,'SAN JOSE MOROTI',807),
(807160,'ITA JHUGUA',807),
(807170,'ARROYO GONZALEZ',807),
(807180,'SAN ANTONIO',807),
(807190,'CERRO COSTA',807),
(807200,'GABINO ROJAS',807),
(807210,'VIRGEN DEL PILAR',807),
(807220,'SAN JOAQUIN',807),
(807230,'SAN FRANCISCO',807),
(807240,'SAN RAFAEL',807),
(807250,'SAN SOLANO',807),
(807260,'YPUCU',807),
(807270,'YACARE-Y',807),
(807280,'POTRERO GUAZU',807),
(807290,'SANTA ELENA',807),
(807300,'3 DE MAYO',807),
(807310,'YKUA SATI',807),
(807320,'ALCARAZ CUE',807),
(807330,'POTRERO ALTO',807),
(807340,'ZAPATERO CUE',807),
(807350,'FATIMA',807),
(807360,'SANTA TERESA',807),
(807999,'(NO INFORMADO)',807),
(808001,'URBANO',808),
(808100,'SAN RAMON',808),
(808110,'KAAGUY GUASU',808),
(808120,'TAMBORY',808),
(808130,'SAN ROQUE',808),
(808140,'ESTERO BELLACO',808),
(808150,'SAN ANTONIO',808),
(808160,'SANTA RITA',808),
(808170,'SAN BLAS',808),
(808180,'SAN FRANCISCO',808),
(808190,'YACUTY',808),
(808200,'SAN FELIPE',808),
(808210,'CAAGUAZU-MI',808),
(808220,'AREA DE ESTANCIAS',808),
(808230,'SAN JUAN',808),
(808240,'SAN MIGUEL',808),
(808250,'KAAGUY POI',808),
(808260,'FATIMA',808),
(808270,'MBOKAJATY',808),
(808999,'(NO INFORMADO)',808),
(809001,'MANGA YVYRA',809),
(809002,'SAN MIGUEL',809),
(809003,'SAN ISIDRO',809),
(809004,'MANGA ITA',809),
(809005,'CENTRAL',809),
(809100,'ZONA DE ESTANCIAS',809),
(809999,'(NO INFORMADO)',809),
(810001,'URBANO',810),
(810100,'TAVAI',810),
(810110,'BAULES',810),
(810120,'PANCHITO LOPEZ',810),
(810130,'LAGUNA PORA',810),
(810140,'PIRA GUASU',810),
(810150,'GALEANO CUE',810),
(810160,'PESOA CUE',810),
(810170,'MARISCAL',810),
(810180,'PEGUAJO',810),
(810190,'MBURUCUYA',810),
(810200,'BARRIO OBRERO',810),
(810999,'(NO INFORMADO)',810),
(901001,'BARRIO 1',901),
(901002,'BARRIO 2',901),
(901003,'BARRIO 3',901),
(901004,'PA,I GOMEZ',901),
(901005,'ÑUATI',901),
(901100,'ITA MOROTI',901),
(901110,'MBATOVI',901),
(901120,'CAPILLA CUE',901),
(901130,'CERRO LEON',901),
(901140,'CHOLOLO',901),
(901150,'JHUGUA SA\'YJU (MBATOVI)',901),
(901160,'CHOLOLO GUAZU',901),
(901170,'COSTA SEGUNDA',901),
(901180,'SANTO TOMAS (MBATOVI)',901),
(901190,'SOTO',901),
(901200,'COSTA PRIMERA',901),
(901210,'COMANDO ARTILLERIA',901),
(901220,'KILOMETRO 60',901),
(901230,'VIRGEN DEL CARMEN',901),
(901240,'SAN MIGUEL',901),
(901250,'JHUGUA POI (ÐUATI)',901),
(901270,'ESTANCIA ALFONSO XIII',901),
(901280,'ESTANCIA CHE PORA',901),
(901290,'AGROMONTE',901),
(901300,'NARANJO',901),
(901999,'(NO INFORMADO)',901),
(902001,'MONSEÐOR BOGARIN',902),
(902002,'MONSEÐOR CARDENS',902),
(902003,'CENTRAL',902),
(902004,'15 DE AGOSTO',902),
(902005,'SAN ALFONSO',902),
(902006,'SAN BLAS',902),
(902100,'YEGUARIZO',902),
(902110,'VALOIS RIVAROLA',902),
(902120,'TAPYTANGUA',902),
(902130,'COSTA PEÐA',902),
(902140,'POTRERO ARCE',902),
(902150,'COL. VIRGEN DE FATIMA',902),
(902160,'CERRO ICE',902),
(902170,'ISLA BAEZ',902),
(902180,'PINTOS',902),
(902190,'YBYRAITY',902),
(902200,'CERRO GUY',902),
(902210,'ÐU AHI',902),
(902220,'ISLERIA',902),
(902230,'RECOLETA',902),
(902240,'ARROYO VERDE',902),
(902250,'RINCON I',902),
(902260,'COSTA BAEZ YUQUYTY',902),
(902270,'CARAGUATAY',902),
(902280,'CARAGUATAY MI',902),
(902290,'LAGUNA PYTA',902),
(902300,'COSTA BAEZ CAAGUY',902),
(902310,'ZANJITA',902),
(902999,'(NO INFORMADO)',902),
(903001,'SAN SALVADOR',903),
(903002,'SAN ROQUE',903),
(903003,'SANTA LIBRADA',903),
(903004,'SAGRADO CORAZON DE JESUS',903),
(903005,'CENTRAL',903),
(903006,'ESPIRITU SANTO',903),
(903100,'MBOI CUATIA',903),
(903110,'ITAPE',903),
(903120,'TAPE GUAZU',903),
(903130,'YPUCU',903),
(903140,'CAPILLITA',903),
(903150,'CHARARA',903),
(903160,'CAPILLA TUYA',903),
(903170,'YAGUARETE CUA',903),
(903180,'MONTIEL POTRERO',903),
(903190,'COL. CNEL. JOSE V. MONGELOS',903),
(903200,'YERE',903),
(903999,'(NO INFORMADO)',903),
(904001,'MARIA AUXILIADORA',904),
(904002,'SANTA ROSA',904),
(904003,'VIRGEN DE FATIMA',904),
(904004,'SAN LUIS',904),
(904005,'8 DE DICIEMBRE',904),
(904006,'SAN JOSE',904),
(904100,'LINDERO',904),
(904110,'GUAVIRA',904),
(904120,'HORQUETA',904),
(904130,'ZORRILLA CUE',904),
(904140,'COSTA PUCU',904),
(904150,'TTE. MARTINEZ',904),
(904160,'PIRAYUVY',904),
(904170,'KIRITO',904),
(904180,'CATALAN',904),
(904190,'POTRERO PUCU',904),
(904200,'ISLA SEGURA 1RA.',904),
(904210,'POTRERO NARANJATY',904),
(904220,'ISLA SEGURA 2DA.',904),
(904230,'CERRO ÐU',904),
(904240,'FRANCO ÐU',904),
(904250,'LOMA PYTA',904),
(904260,'POTRERO YBATE',904),
(904270,'FRANCO I',904),
(904280,'IRIARTE PRIMERA',904),
(904290,'SAN CRISTOBAL',904),
(904300,'CHAURIA',904),
(904310,'IRIARTE SEGUNDA',904),
(904320,'IRIARTE TERCERA',904),
(904999,'(NO INFORMADO)',904),
(905001,'SANTO DOMINGO',905),
(905002,'SAN MIGUEL',905),
(905003,'SAN FRANCISCO',905),
(905004,'VIRGEN DEL CARMEN',905),
(905005,'SAN JOSE',905),
(905006,'SAN BLAS',905),
(905007,'CENTRAL',905),
(905008,'MARIA AUXILIADORA',905),
(905009,'SAN ROQUE',905),
(905100,'ISLA YBATE',905),
(905110,'CERRITO',905),
(905120,'ESPARTILLAR',905),
(905130,'PACHECO',905),
(905140,'POTRERO',905),
(905150,'NDAVARU',905),
(905160,'TAJY LOMA',905),
(905170,'CALIXTRO',905),
(905180,'AGUAIY',905),
(905190,'BENI LOMA',905),
(905200,'KAA YBATE',905),
(905210,'FRANCO ISLA',905),
(905220,'CAAZAPA',905),
(905230,'CAÐETE CUE',905),
(905999,'(NO INFORMADO)',905),
(906001,'URBANO',906),
(906100,'ÐU GUAZU',906),
(906110,'ITA MOROTI 1',906),
(906120,'YHAGUY GUAZU',906),
(906130,'ITA MOROTI GUAZU',906),
(906140,'CHOLOLO',906),
(906150,'ITA MOROTI 2',906),
(906160,'YPAHU',906),
(906170,'CERRO CORA II',906),
(906180,'GRAL. AQUINO',906),
(906190,'YBYRAITY',906),
(906200,'MBOCAYATY',906),
(906210,'MBOPICUA',906),
(906220,'CERRO CORA I',906),
(906230,'ARROYO PORA',906),
(906240,'EST. TONANEZ',906),
(906250,'EST. ABELENDA',906),
(906260,'POTRERO JARA',906),
(906270,'CHIRCAL',906),
(906280,'GUAZU CUA',906),
(906290,'OYOPOI',906),
(906999,'(NO INFORMADO)',906),
(907001,'SANTA CATALINA',907),
(907002,'VIRGEN DEL CARMEN',907),
(907003,'VIRGEN DE FATIMA',907),
(907004,'SAN JOSE',907),
(907005,'SAN FRANCISCO',907),
(907100,'PINDOTY',907),
(907110,'CERRITO',907),
(907120,'RORY',907),
(907130,'BARRIO SAN RAMON',907),
(907140,'YBAROTY',907),
(907150,'YAHAPETY',907),
(907160,'YBYRA PEPE',907),
(907170,'CAATYMI',907),
(907180,'FATIMA',907),
(907190,'MBOCAYATY',907),
(907200,'BARRERO AZUL',907),
(907210,'POTRERO ALTO',907),
(907999,'(NO INFORMADO)',907),
(908001,'ITATI 2',908),
(908002,'VIRGEN DE LOS DOLORES',908),
(908003,'PERPETUO SOCORRO',908),
(908004,'VIRGEN DE LOURDES',908),
(908005,'SANTA TERESITA',908),
(908006,'VIRGEN DEL ROSARIO',908),
(908007,'VIRGEN DE FATIMA',908),
(908008,'MARIA AUXILIADORA',908),
(908009,'VIRGEN DEL CARMEN',908),
(908010,'INMACULADA CONCEPCION',908),
(908011,'VIRGEN DE ITATI',908),
(908100,'ÐU AHI',908),
(908110,'RECTA',908),
(908120,'CULANDRITO',908),
(908130,'ISLA NARANJA',908),
(908140,'ÐU APUA MI',908),
(908150,'ÐU APUA',908),
(908160,'QUEBRADA',908),
(908170,'LA ROSA 2',908),
(908180,'LA ROSA 1',908),
(908190,'BOQUERON',908),
(908200,'COSTA PUCU',908),
(908210,'LOMA GUAZU',908),
(908220,'CERRITO',908),
(908230,'ELIGIO AYALA',908),
(908240,'LABARU',908),
(908250,'COSTA CAPILLA CUE',908),
(908260,'ISLA ALTA',908),
(908270,'ÐANDU RUGUA',908),
(908280,'ROA RUGUA',908),
(908290,'LOMITA',908),
(908300,'COLONIA MARIA ANTONIA',908),
(908999,'(NO INFORMADO)',908),
(909001,'BARRIO1',909),
(909002,'BARRIO2',909),
(909003,'BARRIO3',909),
(909004,'BARRIO4',909),
(909100,'AZCURRA',909),
(909110,'COSTA JHU',909),
(909120,'TUYUCUA',909),
(909130,'TABA-I',909),
(909140,'CERRO VERA',909),
(909150,'PASO ESPERANZA',909),
(909160,'POTRERO AVENDANO',909),
(909170,'TUYUCUA COCUE',909),
(909180,'YKUA KAU',909),
(909190,'COCUE POTI',909),
(909200,'CERRO LEON',909),
(909210,'YAGUARON YURU',909),
(909220,'ARROYO SERVIN',909),
(909999,'(NO INFORMADO)',909),
(910001,'SAGRADA FAMILIA',910),
(910002,'GRAL. BENARDINO CABALLERO',910),
(910003,'SANTA MARIA',910),
(910004,'SAN LORENZO',910),
(910005,'SAGRADO CORAZON DE JESUS',910),
(910006,'VDA. DE LA MERCED',910),
(910100,'NIÐO JESUS',910),
(910110,'SIMBRON',910),
(910120,'ISLA ALTA',910),
(910130,'COMANDANTE PERALTA',910),
(910140,'ACHOTEI',910),
(910150,'3 DE MAYO (SIMBRON)',910),
(910160,'ITA CAJON',910),
(910170,'TOBATINGUA',910),
(910180,'TACUARI',910),
(910190,'CAÐADA',910),
(910200,'COSTA GAONA 1RA.',910),
(910210,'COSTA GAONA 2DA.',910),
(910220,'MENDIETA CUE (TACUARI)',910),
(910230,'LOMA PYTA',910),
(910240,'COSTA IRALA',910),
(910250,'BARRIO AMISTAD',910),
(910260,'CAPILLA TUYA',910),
(910270,'QUIINDY PUNTA',910),
(910280,'BARRIO SAN ANTONIO',910),
(910290,'ISLA CUPE',910),
(910300,'COSTA JHU-U',910),
(910310,'CURUCAO',910),
(910320,'VALLE APUA',910),
(910330,'LAURELTY',910),
(910340,'CALLEJON',910),
(910999,'(NO INFORMADO)',910),
(911001,'SAN MIGUEL',911),
(911002,'SAN PEDRO Y SAN PABLO',911),
(911003,'CENTRAL',911),
(911100,'SAN JOSE IBAÐEZ',911),
(911110,'COL. FULGENCIO YEGROS',911),
(911120,'ISLA VALLE',911),
(911130,'CURUZU LACU',911),
(911140,'COSTA SAN LUIS',911),
(911150,'GUAZU CORA',911),
(911160,'COSTA OLAZAR',911),
(911170,'CERRO GUY 2DA. SAN JUAN',911),
(911180,'CERRO FRENTE',911),
(911190,'CERRO GUY 1RA. SAN JOSE',911),
(911200,'YAGUARY MBOIPYRI',911),
(911210,'MBOI CAE',911),
(911220,'ESPINILLAR',911),
(911999,'(NO INFORMADO)',911),
(912001,'INMACULADA CONCEPCION',912),
(912002,'SAGRADO CORAZON DE JESUS',912),
(912003,'SAN VICENTE',912),
(912004,'VIRGEN DEL ROSARIO',912),
(912100,'MATACHI',912),
(912110,'RINCON',912),
(912120,'ARAZATY',912),
(912130,'CERRITO',912),
(912140,'MOQUETE',912),
(912150,'MBOCAYATY',912),
(912160,'CAÐADA',912),
(912170,'POTRERO',912),
(912180,'SIMBRON',912),
(912999,'(NO INFORMADO)',912),
(913001,'PLANTA URBANA',913),
(913002,'TIERRA NEGRA',913),
(913003,'MBOCAYA',913),
(913100,'YTORORO',913),
(913110,'LOMA GUAZU',913),
(913120,'COSTA IRALA',913),
(913130,'CERRO  ROKE',913),
(913140,'YBYRAITY',913),
(913150,'ARROYO PORA',913),
(913160,'ADRIANO IRALA',913),
(913180,'CERRO VERDE',913),
(913190,'POTRERO YBATE',913),
(913200,'POTRERO VILLALBA',913),
(913210,'CHIRCAL',913),
(913220,'MBOPICUA',913),
(913230,'BOLAS CUA',913),
(913240,'COLONIA  SANTA ISABEL',913),
(913250,'PASO PE',913),
(913260,'YARIGUA A MI',913),
(913999,'(NO INFORMADO)',913),
(914001,'URBANO',914),
(914100,'CAHOBETI',914),
(914110,'POTRERITO',914),
(914120,'PAREDES COSTA',914),
(914130,'RECOLETA',914),
(914140,'CERRITO',914),
(914150,'JHUGUA',914),
(914160,'PUNTA GUAZU',914),
(914170,'COLONIA CESPEDES',914),
(914180,'SAN BLAS',914),
(914190,'ALONSO CUE',914),
(914200,'ÐUA HU',914),
(914999,'(NO INFORMADO)',914),
(915001,'SAN FRANCISCO',915),
(915002,'SAN ROQUE',915),
(915003,'SANTA LIBRADA',915),
(915004,'SAN MIGUEL',915),
(915005,'SAN JOSE',915),
(915100,'ITA POTRERO',915),
(915110,'KAAGUY POTI',915),
(915120,'ZAGUAZU',915),
(915130,'SAN BONINI',915),
(915140,'PIRAYU CALLE',915),
(915150,'GUAYAIBITY',915),
(915160,'ZAYAS',915),
(915170,'PORORO',915),
(915180,'MBARITU',915),
(915190,'NANDUA',915),
(915200,'GUARAPI',915),
(915210,'TACUARINDY',915),
(915220,'CARUNGUA',915),
(915230,'TACUMBU',915),
(915240,'PEGUAJHO',915),
(915250,'CURUPAYTY',915),
(915260,'CERRO GUY',915),
(915270,'CALLE POI',915),
(915280,'ÐUATI CALLE',915),
(915290,'POTRERITO',915),
(915300,'ÐUATI GUAZU',915),
(915999,'(NO INFORMADO)',915),
(916001,'VIRGEN DE FATIMA',916),
(916002,'SAN FRANCISCO',916),
(916003,'SAN JOSE',916),
(916004,'SANTA ROSA',916),
(916005,'SANTA TERESA',916),
(916100,'CERRO ACHON',916),
(916110,'CORDILLERITA (APYRAGUA)',916),
(916120,'ISLA ALTA',916),
(916130,'CERRO CARAPE',916),
(916140,'CABALLERO PUNTA',916),
(916150,'CESAR BARRIENTOS',916),
(916160,'VARGAS LOMA',916),
(916170,'ISLA PAU',916),
(916180,'BOLICHO CUE',916),
(916190,'TACUAPITY',916),
(916200,'PASO PARED',916),
(916210,'BOQUERON',916),
(916220,'CORDILLERA',916),
(916230,'ARASATY',916),
(916240,'MBOPICUA',916),
(916250,'KARAIMI',916),
(916260,'ISLA  KAA',916),
(916270,'CERRO CORA',916),
(916280,'PASO PINDO',916),
(916290,'ISLA YBATE',916),
(916300,'CARAGUATA',916),
(916310,'RINCON I',916),
(916320,'YBYCUI PUNTA',916),
(916330,'YATAITY',916),
(916340,'CAPILLA LOMA',916),
(916350,'CERRO SAUCE',916),
(916360,'MBOCAYA PUCU',916),
(916370,'ENTRE RIOS',916),
(916380,'RINCON GUAZU',916),
(916390,'PALACIO CUE',916),
(916400,'CARBON CUE',916),
(916410,'TACUARY',916),
(916420,'MINAS CUE',916),
(916430,'CAAGUY CUPE',916),
(916440,'PUEBLO JHU',916),
(916450,'SANTA ANGELA',916),
(916460,'PEREIRA CUE',916),
(916470,'SANTA TERESITA',916),
(916480,'AGUSTIN GOIBURU',916),
(916999,'(NO INFORMADO)',916),
(917001,'SAGRADO CORAZON DE JESUS',917),
(917002,'SAN ROQUE',917),
(917003,'VIRGEN DEL ROSARIO',917),
(917004,'FATIMA',917),
(917100,'PINDOTY',917),
(917110,'PUESTO MEZA',917),
(917120,'ISLA',917),
(917130,'AÐAZCO',917),
(917140,'PUESTO OVIEDO',917),
(917150,'ESTACION',917),
(917160,'ESTANCIA BASEDAN',917),
(917170,'RINCON',917),
(917180,'CERRO GUY',917),
(917190,'COL. HECTOR L. VERA',917),
(917200,'BARRIO POTRERITO',917),
(917210,'CERRO SAN ANTONIO',917),
(917220,'CAÐADA',917),
(917230,'COL. RAMON DELMAS',917),
(917240,'CHINI',917),
(917250,'VARGAS CUE',917),
(917260,'POTRERO GARAY',917),
(917270,'JHUGUA GUAZU',917),
(917280,'MARTINEZ CUE',917),
(917290,'TUCUMAN',917),
(917300,'SOLANO ESCOBAR',917),
(917310,'RIVAROLA CUE',917),
(917999,'(NO INFORMADO)',917),
(1001001,'10 A 13 ACARAY',1001),
(1001002,'9 A 10 ACARAY',1001),
(1001003,'7,5 A 9 ACARAY',1001),
(1001004,'DON BOSCO',1001),
(1001005,'6 A 7,5 ACARAY',1001),
(1001006,'5 A 6 ACARAY',1001),
(1001007,'4 A 5 ACARAY',1001),
(1001008,'PABLO ROJAS',1001),
(1001009,'SAN BLAS',1001),
(1001010,'MICRO CENTRO',1001),
(1001011,'JUAN E\'OLEARY',1001),
(1001012,'BOQUERON',1001),
(1001013,'AREA 1',1001),
(1001014,'SAN JOSE',1001),
(1001015,'23 DE OCTUBRE',1001),
(1001016,'AMAMBAY',1001),
(1001017,'AREA 8',1001),
(1001018,'OBRERO',1001),
(1001019,'SAN MIGUEL',1001),
(1001020,'REMANSITO',1001),
(1001021,'SAN ROQUE',1001),
(1001022,'FATIMA',1001),
(1001023,'SANTA ANA',1001),
(1001024,'CIUDAD NUEVA',1001),
(1001025,'7 A 10 MONDAY',1001),
(1001026,'10 A 13 MONDAY',1001),
(1001999,'(NO INFORMADO)',1001),
(1002001,'SAN ANTONIO',1002),
(1002002,'SAN PABLO-SAN JUAN',1002),
(1002003,'FATIMA',1002),
(1002004,'LAS MERCEDES',1002),
(1002005,'SAN RAFAEL',1002),
(1002006,'AREA 5',1002),
(1002007,'SAN SEBASTIAN',1002),
(1002008,'SANTO TOMAS',1002),
(1002009,'SAN LORENZO',1002),
(1002010,'SAN MIGUEL',1002),
(1002011,'MARIA AUXILIADORA',1002),
(1002012,'SAN MIGUEL-VILLA BAJA',1002),
(1002013,'SAN ROQUE',1002),
(1002014,'SAN FRANCISCO',1002),
(1002015,'SANTA ROSA',1002),
(1002016,'SAN JOSE OBRERO',1002),
(1002017,'FRAY LUIS BOLAÐOS',1002),
(1002100,'SANTA CLARA',1002),
(1002110,'KM. 10 MONDAY',1002),
(1002120,'SANTO DOMINGO',1002),
(1002130,'SAGRADO CORAZON DE JESUS',1002),
(1002140,'SAN JORGE',1002),
(1002150,'SAN ISIDRO',1002),
(1002160,'PUERTO FLORES',1002),
(1002170,'ALFREDO PLA',1002),
(1002180,'PENINSULA',1002),
(1002190,'INDIGENA PUERTO GIMENEZ',1002),
(1002200,'PUERTO BERTONI',1002),
(1002999,'(NO INFORMADO)',1002),
(1003001,'URBANO',1003),
(1003100,'ITALIANO CUE',1003),
(1003110,'ITUTI',1003),
(1003120,'SAN ISIDRO 5TA. Y 6TA. LINEAS',1003),
(1003130,'COLONIA YEPOPYHY',1003),
(1003140,'SAN ISIDRO 1RA. LINEA',1003),
(1003150,'COLONIA TABUCAY',1003),
(1003160,'PUERTO TABUCAY',1003),
(1003170,'COLONIA PIRA PYTA',1003),
(1003180,'360 HECTAREAS',1003),
(1003190,'SARITA',1003),
(1003200,'HACIENDA IVP',1003),
(1003210,'COLONIA PIRA PYTA MI',1003),
(1003220,'CAPILLA',1003),
(1003230,'BOQUERON',1003),
(1003240,'ITA VERA',1003),
(1003999,'(NO INFORMADO)',1003),
(1004001,'SAN ANTONIO',1004),
(1004002,'SAN FRANCISCO',1004),
(1004003,'SANTA ROSA',1004),
(1004004,'INMACULADA',1004),
(1004100,'VILLA SAN JUAN',1004),
(1004110,'LA VICTORIA NORTE',1004),
(1004120,'PAZ DEL CHACO NORTE',1004),
(1004130,'POTRERO JARDIN NORTE',1004),
(1004140,'YUQUERI NORTE',1004),
(1004150,'LA VICTORIA',1004),
(1004160,'PAZ DEL CHACO',1004),
(1004170,'POTRERO JARDIN',1004),
(1004180,'CAARENDY GUAZU',1004),
(1004190,'YUQUERI',1004),
(1004200,'LOMA PIROY',1004),
(1004210,'SANTO DOMINGO-I',1004),
(1004220,'VENECIA-I',1004),
(1004230,'LOMA CLAVEL',1004),
(1004240,'YJHOVY',1004),
(1004250,'ROJAS SILVA',1004),
(1004260,'LOMA TAYI',1004),
(1004270,'VENECIA GUAZU',1004),
(1004280,'SANTA CATALINA',1004),
(1004290,'SAN ISIDRO',1004),
(1004999,'(NO INFORMADO)',1004),
(1005001,'SAN ANTONIO',1005),
(1005002,'SAN FRANCISCO',1005),
(1005003,'MCAL. LOPEZ',1005),
(1005004,'SAN RAMON',1005),
(1005005,'SAN JOSE',1005),
(1005006,'SAN CARLOS',1005),
(1005007,'NTRA. SRA. DE LA ASUNCION',1005),
(1005008,'AREA 6',1005),
(1005009,'SAN LORENZO',1005),
(1005010,'SAN PABLO',1005),
(1005011,'SANTO DOMINGO',1005),
(1005012,'FATIMA',1005),
(1005013,'BELLA VISTA',1005),
(1005014,'AURORA',1005),
(1005015,'CAACUPE-MI',1005),
(1005016,'SAN MIGUEL',1005),
(1005017,'NUEVA ESPERANZA',1005),
(1005018,'MARIA MAGDALENA',1005),
(1005100,'GLEVA 12 GRAL. DIAZ',1005),
(1005110,'GLEVA 7',1005),
(1005120,'GLEVA 5 PIKYRY',1005),
(1005130,'COLONIA NUEVA ESPERANZA',1005),
(1005140,'PIKYRY',1005),
(1005150,'COLONIA FORTUNA NUEVA',1005),
(1005160,'COLONIA ITAIPU-I',1005),
(1005170,'VILLA FORTUNA',1005),
(1005180,'GLEVA 1 MBARACAYU',1005),
(1005190,'3RA. LINEA FORTUNA',1005),
(1005200,'SANTA FE',1005),
(1005210,'PETRONA CUE',1005),
(1005220,'CAMPO ALEGRE',1005),
(1005230,'MARACAMOA',1005),
(1005240,'GLEVA 23 COLONIA ITAIPU',1005),
(1005250,'2DA. LINEA FORTUNA',1005),
(1005260,'1RA. LINEA FORTUNA',1005),
(1005270,'ACARAY-MI',1005),
(1005280,'COLONIA LAURA',1005),
(1005290,'ROMERO-CUE',1005),
(1005300,'INDIGENA ACARAY-MI',1005),
(1005310,'MBOI-KUA',1005),
(1005320,'COLONIA TORYVETE',1005),
(1005330,'PASO ITA',1005),
(1005340,'ORLANDO CUE',1005),
(1005350,'TACURU PUKU',1005),
(1005360,'TATI YUPI',1005),
(1005370,'SAN ROQUE',1005),
(1005380,'COLONIA ACARAY',1005),
(1005400,'ITAIPU',1005),
(1005410,'PILARENSE',1005),
(1005420,'FELIX DE AZARA',1005),
(1005430,'ASENTAMIENTO NIÐO JESUS',1005),
(1005440,'PARANA COUNTRY CLUB',1005),
(1005999,'(NO INFORMADO)',1005),
(1006001,'SAN JOSE',1006),
(1006002,'SANTA LIBRADA',1006),
(1006003,'URBANO',1006),
(1006100,'ACARAY COSTA',1006),
(1006110,'CRISTO REY',1006),
(1006120,'BARRO NEGRO',1006),
(1006130,'CRUCE ITAKYRY',1006),
(1006140,'ITAIPYTE',1006),
(1006150,'CAPIIBARY',1006),
(1006160,'3 DE FEBRERO',1006),
(1006170,'YBYTIMBO',1006),
(1006180,'TACUAREE',1006),
(1006190,'EX COMBATIENTES 47',1006),
(1006200,'SAN MIGUEL',1006),
(1006210,'PUERTO JUANITA',1006),
(1006220,'LAGUNA',1006),
(1006230,'CALLE 15 DE AGOSTO',1006),
(1006240,'TACUARA',1006),
(1006250,'TIMBO',1006),
(1006260,'CAMPO REDONDO',1006),
(1006270,'YTORORO',1006),
(1006280,'SAN ANTONIO',1006),
(1006290,'CAREMA GUAZU',1006),
(1006300,'COLONIA KAATI MIRI',1006),
(1006310,'CAAGUY ROQUY (KAA POTY)',1006),
(1006320,'COLORADO I',1006),
(1006330,'CAPII',1006),
(1006340,'LEVA 8',1006),
(1006350,'TABARORY',1006),
(1006360,'CHINO CUE',1006),
(1006370,'CHINO I',1006),
(1006380,'SANTA MARIA',1006),
(1006390,'ARROYO GUAZU',1006),
(1006400,'SANTA LUCIA',1006),
(1006410,'VACA RETA (SANTA LUCIA)',1006),
(1006420,'YUQUYRY',1006),
(1006430,'PROMETIDA',1006),
(1006440,'NUEVA CONQUISTA',1006),
(1006450,'COLONIA ALEGRE',1006),
(1006460,'NARANJITO',1006),
(1006470,'ASENTAMIENTO YCUA PORA',1006),
(1006480,'VILLA CELESTE',1006),
(1006490,'PARAGUAY PYAJHU',1006),
(1006500,'SAN JUAN',1006),
(1006510,'SANTO DOMINGO',1006),
(1006520,'SANTA TERESA',1006),
(1006530,'YTU',1006),
(1006540,'CARRERIA I',1006),
(1006550,'YRUKU POTY',1006),
(1006560,'TREINTA Y CINCO',1006),
(1006570,'CAAGUY POTY (ASENT. INDI )',1006),
(1006580,'YAJHAPE',1006),
(1006590,'VILLA CUE',1006),
(1006600,'AGUAPE',1006),
(1006610,'ACARAY POTY',1006),
(1006620,'PASO CADENA',1006),
(1006630,'ZANJA MOROTI',1006),
(1006640,'YCUA PORA',1006),
(1006650,'ANGELITO',1006),
(1006999,'(NO INFORMADO)',1006),
(1007001,'URBANO',1007),
(1007100,'VILLA DEL ROSARIO',1007),
(1007110,'LA VICTORIA YGUAZU',1007),
(1007120,'3 DE MAYO',1007),
(1007130,'8 DE DICIEMBRE',1007),
(1007140,'CALLE R.I. 14 CERRO CORA',1007),
(1007150,'TACUARO',1007),
(1007160,'LAS MERCEDES',1007),
(1007170,'LA VICTORIA MONDAY',1007),
(1007180,'MARIA AUXILIADORA',1007),
(1007190,'VIRGEN I. CONCEPCION',1007),
(1007200,'SAN PABLO',1007),
(1007210,'SAN AGUSTIN',1007),
(1007220,'SAN ISIDRO',1007),
(1007230,'SAN FRANCISCO',1007),
(1007240,'TAROBY',1007),
(1007250,'MBARACAU',1007),
(1007999,'(NO INFORMADO)',1007),
(1008001,'URBANO',1008),
(1008100,'PARANAMBU',1008),
(1008110,'COL. 8 DE DICIEMBRE',1008),
(1008120,'SANTA CAROLINA',1008),
(1008130,'SAN ROQUE GONZALEZ DE SANTACRU',1008),
(1008140,'COLONIA MBARETE',1008),
(1008150,'SANTA ROSA',1008),
(1008160,'ITAIPYTE',1008),
(1008170,'AGROTORO',1008),
(1008180,'SANTO DOMINGO',1008),
(1008190,'PORTAL TIGRE',1008),
(1008200,'TOROCUA I',1008),
(1008210,'CRUCE GUARANI',1008),
(1008220,'SANTO TOMAS',1008),
(1008230,'LOMAS VALENTINAS',1008),
(1008240,'CHACOREI TERCERA LINEA',1008),
(1008250,'CHACOREI SEGUNDA LINEA',1008),
(1008260,'CHACOREI PRIMERA LINEA',1008),
(1008999,'(NO INFORMADO)',1008),
(1009001,'URBANO',1009),
(1009100,'KM 43',1009),
(1009110,'KM 45',1009),
(1009120,'KM 44',1009),
(1009130,'KM 46',1009),
(1009140,'KM 42',1009),
(1009150,'NUEVA ALIANZA',1009),
(1009160,'SAN LUIS',1009),
(1009170,'SANTO DOMINGO',1009),
(1009180,'KILOMETRO 55',1009),
(1009190,'KM 53',1009),
(1009200,'TATARE',1009),
(1009210,'NUEVA ESPERANZA',1009),
(1009220,'PUERTO JUANITA',1009),
(1009230,'REMANSO TORO (INDIGENA)',1009),
(1009240,'KM 49',1009),
(1009250,'KM 48',1009),
(1009260,'KM 34 - 35',1009),
(1009270,'KM 37',1009),
(1009280,'KM 38',1009),
(1009290,'KM 41',1009),
(1009999,'(NO INFORMADO)',1009),
(1010001,'BARRIO LOS LAURELES',1010),
(1010002,'BARRIO B',1010),
(1010003,'FRACCION  LA ESPERANZA',1010),
(1010004,'FRACCION A',1010),
(1010005,'FRACCION AURORA',1010),
(1010100,'GUAYAKI',1010),
(1010110,'LOS CEDRALES',1010),
(1010120,'PENGO',1010),
(1010130,'22 DE MAYO',1010),
(1010140,'AGUA LIBERAL',1010),
(1010150,'PARANA POTY',1010),
(1010160,'GLEVA 4',1010),
(1010170,'SANTA CRUZ',1010),
(1010180,'SAN JOSE ARA POTI',1010),
(1010190,'SAN ISIDRO 1RA. LINEA \"B\"',1010),
(1010200,'ITA KOTY',1010),
(1010210,'SAN ISIDRO 1RA. LINEA \"C\"',1010),
(1010220,'SOCIEGO',1010),
(1010230,'SAN ISIDRO 2DA. LINEA',1010),
(1010240,'SAN MIGUEL',1010),
(1010250,'CAACUPE DEL PARANA',1010),
(1010260,'SAN ISIDRO 1RA. LINEA \"A\"',1010),
(1010270,'MARIA AUXILIADORA',1010),
(1010280,'SAN ISIDRO 5TA. Y 6TA. LINEAS',1010),
(1010290,'ITUTI',1010),
(1010300,'SAN ISIDRO 4TA. LINEA',1010),
(1010310,'SAN JUAN',1010),
(1010999,'(NO INFORMADO)',1010),
(1011001,'SCHNEIDER',1011),
(1011002,'CENTRO',1011),
(1011003,'VILLA NELIDA I',1011),
(1011004,'VILLA NELIDA II',1011),
(1011005,'DORITA',1011),
(1011006,'LOS ALAMOS',1011),
(1011007,'FRACCION SANTA MONICA',1011),
(1011008,'FRACCION NORMA LUISA',1011),
(1011009,'FRACCION YHAGUY',1011),
(1011100,'CALLE 32 ACARAY',1011),
(1011110,'CALLE 33 TRIUNFO',1011),
(1011120,'CALLE 30 ACARAY',1011),
(1011130,'CALLE 28 ACARAY',1011),
(1011140,'CALLE 26 ACARAY',1011),
(1011150,'CALLE 22 ACARAY',1011),
(1011160,'CALLE 20 ACARAY',1011),
(1011170,'CALLE 16 ACARAY',1011),
(1011180,'CALLE 12 ACARAY',1011),
(1011190,'CALLE 14 ACARAY',1011),
(1011200,'CALLE 14 MONDAY',1011),
(1011210,'CALLE 16 MONDAY',1011),
(1011220,'CALLE 18 MONDAY',1011),
(1011230,'CALLE 20 MONDAY',1011),
(1011240,'CALLE 22 MONDAY',1011),
(1011250,'CALLE 24 MONDAY',1011),
(1011260,'CALLE 26 MONDAY',1011),
(1011270,'CALLE 28 MONDAY',1011),
(1011280,'ARROYO GUAYAKI',1011),
(1011290,'CALLE 30 MONDAY',1011),
(1011999,'(NO INFORMADO)',1011),
(1012001,'URBANO',1012),
(1012100,'MARIA AUXILIADORA',1012),
(1012110,'FITINA',1012),
(1012120,'VISTA ALEGRE',1012),
(1012130,'SAN JOSE OBRERO',1012),
(1012140,'PACUCUA 1',1012),
(1012150,'LINEA BUSANELLO',1012),
(1012160,'SAN ANTONIO',1012),
(1012170,'SAPIRE',1012),
(1012180,'FLORES-I',1012),
(1012190,'YBAROTY',1012),
(1012200,'SANTO DOMINGO',1012),
(1012210,'YACUTINGA',1012),
(1012220,'3 NACIENTE',1012),
(1012230,'CAMPO ALEGRE',1012),
(1012240,'SANTA LUCIA',1012),
(1012250,'SAN JORGE',1012),
(1012260,'RELOJ CUE',1012),
(1012270,'8 DE DICIEMBRE',1012),
(1012280,'3 DE MAYO',1012),
(1012290,'ARROYO QUEMADO',1012),
(1012310,'SAN CRISTOBAL',1012),
(1012320,'11 DE SETIEMBRE',1012),
(1012330,'SAN MIGUEL',1012),
(1012340,'KAA JOVAI  (INDIGENA)',1012),
(1012999,'(NO INFORMADO)',1012),
(1013001,'IMPERIAL',1013),
(1013002,'NUEVA PLATA',1013),
(1013003,'EL COLONO',1013),
(1013004,'SAN RAMON',1013),
(1013005,'CARDOZO',1013),
(1013006,'BIRNFER',1013),
(1013007,'SHULTZ',1013),
(1013008,'NUEVA ESPERANZA',1013),
(1013009,'NUEVA SANTA RITA',1013),
(1013100,'FULGENCIO R. MORENO',1013),
(1013110,'SANTO DOMINGO',1013),
(1013120,'VILLA NUEVA',1013),
(1013130,'SAN MIGUEL 1',1013),
(1013140,'GRAL P. COLMAN',1013),
(1013150,'SANTA LUCIA',1013),
(1013160,'SAN VICENTE',1013),
(1013170,'CAACUPEMI',1013),
(1013180,'ESQUINA GAUCHA',1013),
(1013190,'SAN MIGUEL 2',1013),
(1013200,'LINEA YACARE',1013),
(1013210,'PACUCUA 2',1013),
(1013220,'PANAMBI',1013),
(1013230,'BUEN JESUS',1013),
(1013240,'NUEVA ASUNCION - 14 DE MAYO',1013),
(1013250,'LAS TORRES',1013),
(1013260,'CARAYA',1013),
(1013270,'ALTO ALEGRE',1013),
(1013999,'(NO INFORMADO)',1013),
(1014001,'URBANO',1014),
(1014100,'LINEA ÐACUNDAY',1014),
(1014110,'LINEA BUSANELLO',1014),
(1014120,'AURORA',1014),
(1014130,'3 DE MAYO',1014),
(1014140,'LINEA FRANCA',1014),
(1014150,'1RO. DE MAYO',1014),
(1014160,'SAN PEDRO',1014),
(1014170,'PALMITAL',1014),
(1014180,'10 DE MAYO',1014),
(1014190,'PRIMAVERA',1014),
(1014200,'VILLA MONACO',1014),
(1014210,'SAN ALFREDO',1014),
(1014220,'INDIGENA PUERTO BARRA (ACHE)',1014),
(1014230,'AGROPECO',1014),
(1014240,'RAUL PEÐA - MCAL ESTIGARRIBIA',1014),
(1014250,'NVA JERUSALEN 2',1014),
(1014260,'JERUSALEN 3',1014),
(1014999,'(NO INFORMADO)',1014),
(1015001,'URBANO',1015),
(1015100,'MONDAY',1015),
(1015110,'DOLORES TAVAPY',1015),
(1015120,'SAN CRISTOBAL',1015),
(1015130,'COLONIA YGUAZU',1015),
(1015140,'FATIMA TAVAPY',1015),
(1015150,'SAN BLAS',1015),
(1015160,'GUABITI',1015),
(1015170,'TAVAPY 1',1015),
(1015180,'COLONIA 22 DE MAYO',1015),
(1015190,'8 DE DICIEMBRE',1015),
(1015200,'TAVAPY 2',1015),
(1015210,'SANTA LUCIA',1015),
(1015220,'BELLA VISTA',1015),
(1015230,'SANTA MARIA',1015),
(1015240,'LINEA BOTAFOGO',1015),
(1015250,'SAN ANTONIO',1015),
(1015260,'FRANCES-CUE',1015),
(1015270,'SANTA ROSA DEL MONDAY NORTE',1015),
(1015280,'CURUPAYTY LINEA PROGRESO',1015),
(1015290,'SANTA ROSA DEL MONDAY SUR',1015),
(1015300,'YACUTINGA',1015),
(1015310,'SAN LUIS',1015),
(1015320,'SAN CARLOS',1015),
(1015330,'GLEVA NOVA TRES PINHEIROS',1015),
(1015999,'(NO INFORMADO)',1015),
(1016001,'SANTA CECILIA',1016),
(1016002,'CENTRO',1016),
(1016100,'ARROYO GUAZU',1016),
(1016110,'SAN LORENZO',1016),
(1016120,'COLONIA GUARANI',1016),
(1016130,'LOTE 7',1016),
(1016140,'ENTRE RIOS',1016),
(1016150,'GRAL. DIAZ ( LOTE 5 )',1016),
(1016160,'COOPASAN',1016),
(1016170,'TRONCAL TRES ( VILLA NUEVA )',1016),
(1016180,'13 DE MAYO',1016),
(1016190,'LIMOY',1016),
(1016200,'LIMOY 2',1016),
(1016210,'SEXTA LINEA',1016),
(1016220,'8 DE DICIEMBRE',1016),
(1016230,'LOTE 8',1016),
(1016240,'SAN JORGE',1016),
(1016250,'QUINTA LINEA',1016),
(1016260,'CUARTA LINEA',1016),
(1016270,'DIVISA MINGA PORA',1016),
(1016280,'SAN BLAS',1016),
(1016290,'TERCERA LINEA',1016),
(1016999,'(NO INFORMADO)',1016),
(1017001,'URBANO',1017),
(1017100,'BARRO NEGRO',1017),
(1017110,'COLONIA 8 DE DICIEMBRE',1017),
(1017120,'COLONIA MBARACAYU',1017),
(1017130,'GLEVA 2 MBARACAYU',1017),
(1017140,'COLONIA SAN JOSE BANANERO',1017),
(1017150,'KM. 42 GRAL. DIAZ',1017),
(1017160,'COLONIA LIMO-Y',1017),
(1017170,'COLONIA BELLA VISTA',1017),
(1017180,'KM. 28 GRAL. DIAZ',1017),
(1017190,'CRUCE MBARACAYU',1017),
(1017200,'GLEVA 11 MBARACAYU',1017),
(1017210,'INDIGENA KIRITO GLEVA 10',1017),
(1017220,'GLEVA 3 MBARACAYU',1017),
(1017230,'3RA. LINEA TAPE PORA',1017),
(1017240,'COLONIA FORTUNA',1017),
(1017260,'GLEVA 5 MBARACAYU',1017),
(1017270,'GLEVA 4 MBARACAYU',1017),
(1017280,'KM. 19 MBARACAYU',1017),
(1017290,'NUEVA ESPERANZA',1017),
(1017300,'COLONIA PALOMA BLANCA',1017),
(1017310,'COLONIA PROCOPIO',1017),
(1017320,'COLONIA GUARANI',1017),
(1017330,'PUERTO INDIO',1017),
(1017999,'(NO INFORMADO)',1017),
(1018001,'URBANO',1018),
(1018100,'LIMOY',1018),
(1018110,'8 DE DICIEMBRE',1018),
(1018120,'GUARAPUABA',1018),
(1018130,'ITAIPU PORA',1018),
(1018140,'SANTA TERESA',1018),
(1018150,'COLONIA NAVEGANTE',1018),
(1018160,'SAN FRANCISCO ( LEVA 8 )',1018),
(1018170,'SAN RAMON',1018),
(1018180,'SAN ANTONIO 2',1018),
(1018190,'SAN ISIDRO',1018),
(1018200,'CRUCE SAN ALBERTO',1018),
(1018210,'SAN PATRICIO',1018),
(1018220,'SAN GABRIEL ( LOTE 9 )',1018),
(1018230,'SAN ANTONIO',1018),
(1018240,'TAPE PORA ( SAN ALBERTO )',1018),
(1018250,'MBARACAYU LEVA 4 ( LOTE 9 )',1018),
(1018260,'MARIA AUXILIADORA',1018),
(1018270,'SANTA ROSA',1018),
(1018280,'TAPE YERE',1018),
(1018290,'CAMPO LIMPIO',1018),
(1018999,'(NO INFORMADO)',1018),
(1019001,'URBANO',1019),
(1019100,'PASO TIGRE',1019),
(1019110,'SAN MIGUEL',1019),
(1019120,'NUEVA JERUSALEN UNO ( SAN JOSE',1019),
(1019130,'NUEVA JERUSALEN DOS ( SAN JUAN',1019),
(1019140,'SAN PEDRO',1019),
(1019150,'CONSUELO',1019),
(1019160,'BOQUERON',1019),
(1019170,'SANTA TERESITA',1019),
(1019180,'JUAN PABLO SEGUNDO',1019),
(1019190,'DOS HERMANOS',1019),
(1019200,'SAN MARCOS',1019),
(1019210,'SAN ROQUE',1019),
(1019220,'SAN CARLOS',1019),
(1019999,'(NO INFORMADO)',1019),
(1101001,'SAN MIGUEL',1101),
(1101002,'SANTO DOMINGO',1101),
(1101003,'SAN ROQUE',1101),
(1101004,'LAS MERCEDES',1101),
(1101005,'NUEVA ASUNCION',1101),
(1101006,'VILLA AMPARO',1101),
(1101100,'PINDOLO',1101),
(1101110,'COCUE GUAZU',1101),
(1101120,'SAN ANTONIO',1101),
(1101130,'ESTANZUELA',1101),
(1101140,'COSTA FLEITAS',1101),
(1101150,'YUQUYTY',1101),
(1101160,'CONAVI (TAJY POTY)',1101),
(1101170,'VALLE PUCU',1101),
(1101180,'CAACUPEMI',1101),
(1101200,'ISLA VALLE',1101),
(1101999,'(NO INFORMADO)',1101),
(1102001,'BARRIO A',1102),
(1102002,'BARRIO B',1102),
(1102003,'ZONA MILITAR',1102),
(1102004,'VILLA MILITAR',1102),
(1102005,'BARRIO C',1102),
(1102006,'LAURELTY',1102),
(1102007,'CARUMBE-CUA',1102),
(1102008,'CANDELARIA',1102),
(1102009,'ROBERTO L. PETIT',1102),
(1102010,'BARRIO E',1102),
(1102011,'BARRIO D',1102),
(1102012,'PUERTA DEL SOL',1102),
(1102013,'ARATIRI',1102),
(1102014,'BARRIO F',1102),
(1102015,'TORREMOLINOS',1102),
(1102016,'SAN MIGUEL',1102),
(1102017,'SAN LORENZO',1102),
(1102018,'CAPSA',1102),
(1102019,'ARRUA',1102),
(1102020,'BARRIO M',1102),
(1102021,'BARRIO N',1102),
(1102022,'BARRIO L',1102),
(1102023,'BARRIO K',1102),
(1102024,'BARRIO G',1102),
(1102025,'SAN JORGE',1102),
(1102026,'VIRGEN DEL PILAR',1102),
(1102027,'RETIRO',1102),
(1102028,'POSTA YBYCUA',1102),
(1102029,'BARRIO I',1102),
(1102030,'BARRIO J',1102),
(1102031,'CERRITO',1102),
(1102032,'SANTISIMA CRUZ',1102),
(1102033,'SANTA RITA',1102),
(1102034,'CASCO URBANO',1102),
(1102035,'SAN ROQUE',1102),
(1102036,'SANTO DOMINGO',1102),
(1102037,'BARRIO H',1102),
(1102038,'LOMA CLAVEL',1102),
(1102039,'AS',1102),
(1102040,'CONAVI',1102),
(1102041,'EL RETIRO',1102),
(1102042,'PIRO,Y',1102),
(1102043,'SAN WENCESLAO',1102),
(1102044,'ROSARIO',1102),
(1102045,'SAN SALVADOR',1102),
(1102046,'STA LIBRADA',1102),
(1102047,'VIRGEN DE FATIMA',1102),
(1102048,'CÑIA. QUINTA',1102),
(1102049,'SAN SEBASTIAN',1102),
(1102050,'LA ENCARNACION',1102),
(1102052,'SAN RAMON',1102),
(1102053,'SAN JUAN',1102),
(1102054,'LAS MERCEDES',1102),
(1102055,'VILLA CONSTITUCION',1102),
(1102056,'CAACUPEMI',1102),
(1102057,'KENNEDY',1102),
(1102058,'SAN BLAS',1102),
(1102059,'SAN CAYETANO',1102),
(1102060,'SAN LUIS',1102),
(1102061,'VIRGEN DEL ROSARIO',1102),
(1102062,'12 DE JUNIO',1102),
(1102063,'LOS MANIANTALES',1102),
(1102999,'(NO INFORMADO)',1102),
(1103001,'ORILLA DEL CAMPO GRANDE',1103),
(1103002,'VILLA OFELIA',1103),
(1103003,'LAGUNA GRANDE',1103),
(1103004,'PROYECTO 16 LILIO',1103),
(1103005,'ESTANZUELA',1103),
(1103006,'LAS RESIDENTAS',1103),
(1103007,'LAGUNA SATI',1103),
(1103008,'DOMINGO SAVIO',1103),
(1103009,'CIUDAD',1103),
(1103010,'BERNARDINO CABALLERO',1103),
(1103011,'COCUE GUAZU',1103),
(1103012,'PITIANTUTA',1103),
(1103013,'ITA KAAGUY',1103),
(1103014,'TRES BOCAS',1103),
(1103015,'SAN JUAN',1103),
(1103016,'8 DE DICIEMBRE ZONA NORTE',1103),
(1103017,'ZONA SUR',1103),
(1103018,'SANTA MARIA',1103),
(1103019,'CAACUPEMI',1103),
(1103020,'CORAZON DE JESUS',1103),
(1103021,'SANTA ANA',1103),
(1103022,'ZONA NORTE',1103),
(1103999,'(NO INFORMADO)',1103),
(1104001,'FELSINA',1104),
(1104002,'SAN MIGUEL',1104),
(1104003,'COLON',1104),
(1104004,'ALEGRE',1104),
(1104005,'KURUZU LEGUA',1104),
(1104100,'YBY ZUNU',1104),
(1104110,'NUEVA ESPERANZA',1104),
(1104120,'RINCON',1104),
(1104130,'CAUGUA',1104),
(1104140,'RINCON LOMA-I',1104),
(1104150,'TYPYCHATY',1104),
(1104999,'(NO INFORMADO)',1104),
(1105001,'SAN BLAS',1105),
(1105002,'SPORTIVO',1105),
(1105003,'CERRO CORA',1105),
(1105004,'SAN ANTONIO',1105),
(1105100,'VALLE YOA',1105),
(1105110,'TAPE TUYA',1105),
(1105120,'AVEIRO',1105),
(1105130,'OCULTO',1105),
(1105140,'ARRUA-I',1105),
(1105150,'ITA POTRERO',1105),
(1105160,'CURUPICAYTY',1105),
(1105170,'CALLE YBATE',1105),
(1105180,'JHUGUA ÐARO',1105),
(1105190,'POTRERO POI',1105),
(1105200,'CALLE POI',1105),
(1105210,'YHOVY',1105),
(1105220,'CARAGUATAITY',1105),
(1105230,'PEGUAJHO',1105),
(1105240,'CAAGUAZU',1105),
(1105250,'LAS PIEDRAS',1105),
(1105260,'POSTA GAONA',1105),
(1105999,'(NO INFORMADO)',1105),
(1106001,'BARRIO 1',1106),
(1106002,'BARRIO 2',1106),
(1106003,'BARRIO 3',1106),
(1106004,'BARRIO 4',1106),
(1106005,'BARRIO 5',1106),
(1106006,'BARRIO 6',1106),
(1106007,'BARRIO 7',1106),
(1106008,'VALLE CARE',1106),
(1106009,'GUAZUVIRA',1106),
(1106010,'GUAYAIBI-TY',1106),
(1106011,'MBOCAYATY DEL NORTE',1106),
(1106012,'MBOCAYATY DEL SUR',1106),
(1106013,'MBOI-Y',1106),
(1106014,'ALDAMA CAÐADA',1106),
(1106015,'JHUGUA POTI',1106),
(1106016,'POTRERITO',1106),
(1106017,'GUADALUPE',1106),
(1106018,'VILLA KONAVI',1106),
(1106019,'ARSENIO ERICO',1106),
(1106100,'ESTANZUELA',1106),
(1106110,'PATIÐO',1106),
(1106130,'YBYRATY',1106),
(1106150,'CAÐADITA',1106),
(1106160,'ITAUGUA GUAZU',1106),
(1106210,'SAN ANTONIO',1106),
(1106220,'POTRERO GUAZU',1106),
(1106230,'ÐU POI',1106),
(1106999,'(NO INFORMADO)',1106),
(1107001,'PALOMAR',1107),
(1107002,'SAN RAFAEL',1107),
(1107003,'SANTO DOMINGO',1107),
(1107004,'PANAMBI RETA',1107),
(1107005,'PILAR',1107),
(1107006,'FELICIDAD',1107),
(1107007,'SANTA ROSA  II',1107),
(1107008,'MCAL. LOPEZ',1107),
(1107009,'VALLE YBATE',1107),
(1107010,'SANTA LUISA',1107),
(1107011,'SANTA LUCIA',1107),
(1107012,'LA VICTORIA',1107),
(1107013,'KENNEDY',1107),
(1107014,'CENTRO URBANO',1107),
(1107015,'VILLA VIRGINIA',1107),
(1107016,'VILLA CERRO CORA',1107),
(1107017,'VALLE APUA',1107),
(1107018,'CUATRO MOJONES',1107),
(1107019,'SAN ANTONIO',1107),
(1107020,'SAN ROQUE GONZALEZ',1107),
(1107021,'CAÑADA SAN MIGUEL',1107),
(1107022,'MBACHIO',1107),
(1107023,'PUERTO PABLA',1107),
(1107024,'SAN ISIDRO',1107),
(1107025,'SANTA ROSA  I',1107),
(1107026,'CANAL 13',1107),
(1107027,'VILLA MIRTHA',1107),
(1107028,'YSATY',1107),
(1107029,'8 DE DICIEMBRE',1107),
(1107030,'CERRO CORA',1107),
(1107031,'SAN JOSE',1107),
(1107999,'(NO INFORMADO)',1107),
(1108001,'PIQUETE CUE',1108),
(1108002,'LIMPIO RUGUA',1108),
(1108003,'RINCON DEL PEÐON',1108),
(1108004,'SALADO-I',1108),
(1108005,'SALADO',1108),
(1108006,'CICOMAR',1108),
(1108007,'SAN SALVADOR',1108),
(1108008,'SAN PEDRO',1108),
(1108009,'SAN JOSE',1108),
(1108010,'SAN ANTONIO',1108),
(1108011,'SANTA LUCIA',1108),
(1108012,'MONTAÐA ALTA',1108),
(1108013,'SAN FRANCISCO B',1108),
(1108014,'MBAYUE',1108),
(1108015,'SAN RAMON II',1108),
(1108016,'SAN FRANCISCO A',1108),
(1108017,'SANTA LIBRADA',1108),
(1108018,'8 DE DICIEMBRE',1108),
(1108019,'AGUAPEY',1108),
(1108020,'ISLA ARANDA',1108),
(1108021,'SAN JUAN',1108),
(1108022,'ISLA AVEIRO',1108),
(1108023,'COLONIA JUAN DE SALAZAR',1108),
(1108024,'VILLA JARDIN',1108),
(1108025,'SAN RAFAEL',1108),
(1108026,'VILLA MADRID',1108),
(1108027,'SAN BLAS',1108),
(1108999,'(NO INFORMADO)',1108),
(1109001,'AEROPUERTO',1109),
(1109002,'ZARATE ISLA',1109),
(1109003,'YCUA CARANDAY',1109),
(1109004,'MORA CUE',1109),
(1109005,'CAÐADA GARAY',1109),
(1109006,'YCA A',1109),
(1109007,'LOMA MERLO',1109),
(1109008,'PRIMER BARRIO',1109),
(1109009,'SEGUNDO BARRIO',1109),
(1109010,'CENTRO',1109),
(1109011,'CUARTO BARRIO',1109),
(1109012,'CAMPO GRANDE',1109),
(1109013,'JHUGUA DE SEDA',1109),
(1109014,'TERCER BARRIO',1109),
(1109015,'MARAMBURE',1109),
(1109016,'YAGUARETE CORA',1109),
(1109017,'COSTA SOSA',1109),
(1109018,'YCUA DURE',1109),
(1109019,'MACA-I',1109),
(1109020,'CAÐADA SAN RAFAEL',1109),
(1109021,'ISLA BOGADO',1109),
(1109022,'LAURELTY',1109),
(1109023,'LAS RESIDENTAS',1109),
(1109024,'SAN BENIGNO',1109),
(1109025,'SAN VICENTE',1109),
(1109026,'6TA COMPAÑIA MARAMBURE',1109),
(1109027,'JULIO CORREA',1109),
(1109028,'BELLA VISTA',1109),
(1109029,'INMACULADA',1109),
(1109030,'PALMA LOMA',1109),
(1109031,'SANTA CRUZ',1109),
(1109033,'SAN CARLOS',1109),
(1109034,'MARIA BLANCA',1109),
(1109035,'SAGRADO CORAZON DE JESUS',1109),
(1109036,'LA PACHAL I',1109),
(1109038,'LAS PALMERAS',1109),
(1109039,'BARRIO MOLINO',1109),
(1109100,'TARUMANDY',1109),
(1109110,'ITAPUAMI',1109),
(1109120,'NUEVA ASUNCION',1109),
(1109130,'MARIN CAAGUY',1109),
(1109140,'ITA ANGUA',1109),
(1109150,'YUKYRY',1109),
(1109180,'SAN RAFAEL',1109),
(1109190,'ISLA BOGADO',1109),
(1109999,'(NO INFORMADO)',1109),
(1110001,'CORUMBA-CUE',1110),
(1110002,'SURUBI-Y',1110),
(1110003,'ARECAYA',1110),
(1110004,'CAAGUY-CUPE',1110),
(1110005,'SAN LUIS',1110),
(1110006,'CONCORDIA',1110),
(1110007,'CENTRAL',1110),
(1110008,'MARIA AUXILIADORA',1110),
(1110009,'REMANSO',1110),
(1110010,'BAÐADO',1110),
(1110011,'VILLA MARGARITA',1110),
(1110012,'ROSA MISTICA',1110),
(1110013,'DEFENSORES DEL CHACO',1110),
(1110014,'LA ASUNCION',1110),
(1110015,'SAN BLAS',1110),
(1110016,'SAN JORGE',1110),
(1110017,'SAN RAMON',1110),
(1110018,'UNIVERSO',1110),
(1110019,'SAN CARLOS II',1110),
(1110020,'SAN RAFAEL',1110),
(1110021,'SANTA LIBRADA',1110),
(1110022,'MONSEÑOR BOGARIN',1110),
(1110023,'CAACUPEMI',1110),
(1110024,'LA COLINA',1110),
(1110025,'EL MIRADOR',1110),
(1110026,'LOMBARDO',1110),
(1110999,'(NO INFORMADO)',1110),
(1111001,'SANTA ROSA',1111),
(1111002,'SAN PEDRO',1111),
(1111003,'SAN BLAS',1111),
(1111004,'SAN FRANCISCO',1111),
(1111100,'ITA YBATE I',1111),
(1111120,'YUQUYTY',1111),
(1111130,'ISLA GUAVIRA',1111),
(1111140,'TACUARA',1111),
(1111150,'PINDOTY',1111),
(1111160,'CHACO I',1111),
(1111999,'(NO INFORMADO)',1111),
(1112004,'VISTA ALEGRE',1112),
(1112006,'PIROY',1112),
(1112007,'SALINAS',1112),
(1112008,'VILLA DEL CARMEN',1112),
(1112009,'FRACCION SAN CELESTINO',1112),
(1112011,'CAPILLA DEL MONTE',1112),
(1112012,'RINCON',1112),
(1112014,'SANTA LIBRADA',1112),
(1112015,'CAÐADITA',1112),
(1112999,'(NO INFORMADO)',1112),
(1113001,'SAN FRANCISCO CENTRO',1113),
(1113002,'PUEBLO',1113),
(1113003,'SAN BLAS',1113),
(1113004,'MARIA AUXILIADORA',1113),
(1113005,'SAN FRANCISCO SUR',1113),
(1113006,'LAS GARZAS',1113),
(1113007,'LAS MERCEDES',1113),
(1113008,'SAN ROQUE',1113),
(1113009,'NARANJATY',1113),
(1113010,'ANTIGUA IMAGEN 1',1113),
(1113011,'ANTIGUA IMAGEN 2',1113),
(1113012,'ACOSTA ÐU',1113),
(1113013,'SAN JORGE',1113),
(1113014,'ACHUCARRO NORTE',1113),
(1113015,'ACHUCARRO SUR',1113),
(1113016,'CERRITO',1113),
(1113017,'YTORORO',1113),
(1113018,'MBOKAJTY',1113),
(1113019,'LA AMISTAD',1113),
(1113999,'(NO INFORMADO)',1113),
(1114001,'LAURELTY',1114),
(1114002,'VILLA AMELIA',1114),
(1114003,'SAN MIGUEL',1114),
(1114004,'SANTO REY',1114),
(1114005,'VIRGEN DE LOS REMEDIOS',1114),
(1114007,'SAGRADA FAMILIA',1114),
(1114008,'SAN JUAN - CALLE-I',1114),
(1114009,'SAN ISIDRO',1114),
(1114010,'SAN FRANCISCO',1114),
(1114011,'SANTA MARIA',1114),
(1114012,'SAN PEDRO - ÐU PORA',1114),
(1114013,'SAN RAMON',1114),
(1114014,'LAS MERCEDES',1114),
(1114015,'SAN JOSE',1114),
(1114016,'SANTA LUCIA',1114),
(1114017,'SAN RAFAEL',1114),
(1114018,'SAN ROQUE',1114),
(1114019,'INMACULADA',1114),
(1114021,'SAN BLAS',1114),
(1114022,'CORAZON DE JESUS',1114),
(1114024,'SAN FELIPE',1114),
(1114025,'MARIA AUXILIADORA',1114),
(1114026,'VIRGEN DE FATIMA',1114),
(1114027,'SAN LUIS',1114),
(1114028,'FLORIDA',1114),
(1114029,'LA ENCARNACION',1114),
(1114030,'LUCERITO',1114),
(1114031,'SANTA ANA',1114),
(1114032,'SANTA CRUZ',1114),
(1114033,'SANTA LIBRADA',1114),
(1114034,'BARCEQUILLO',1114),
(1114035,'VILLA UNIVERSITARIA',1114),
(1114036,'ESPIRITU SANTO',1114),
(1114037,'VILLA DEL AGRONOMO',1114),
(1114038,'SANTO TOMAS',1114),
(1114039,'NUESTRA SENORA DE LA ASUNCION',1114),
(1114041,'TAYAZUAPE',1114),
(1114042,'LOS NOGALES',1114),
(1114043,'MIRAFLORES',1114),
(1114044,'VILLA INDUSTRIAL',1114),
(1114045,'MITA-I',1114),
(1114046,'VIRGEN DEL ROSARIO',1114),
(1114047,'CAPILLA DEL MONTE',1114),
(1114048,'RINCON',1114),
(1114049,'LERIDA',1114),
(1114050,'REDUCTO',1114),
(1114051,'ANAHI',1114),
(1114052,'LA VICTORIA',1114),
(1114053,'FATIMA',1114),
(1114054,'SINALCO',1114),
(1114055,'LOTE GUAZU',1114),
(1114056,'KOKUERE',1114),
(1114057,'MIRA FLORES',1114),
(1114999,'(NO INFORMADO)',1114),
(1115001,'29 DE SETIEMBRE',1115),
(1115002,'TRES BOCAS',1115),
(1115003,'YPATI',1115),
(1115004,'ROSEDAL',1115),
(1115005,'GLORIA MARIA',1115),
(1115006,'8 DE DICIEMBRE',1115),
(1115007,'ARROYO SECO',1115),
(1115008,'SAN JOSE',1115),
(1115009,'CENTRO',1115),
(1115010,'SOL DE AMERICA',1115),
(1115011,'MBOCAYATY',1115),
(1115012,'REMANSO',1115),
(1115013,'PICADA',1115),
(1115014,'VILLA BONITA',1115),
(1115015,'VILLA HERMOSA',1115),
(1115016,'SAN JUAN',1115),
(1115017,'CONAVI 1',1115),
(1115019,'REMANSITO',1115),
(1115999,'(NO INFORMADO)',1115),
(1116001,'INMACULADA',1116),
(1116002,'SAGRADO CORAZON DE JESUS',1116),
(1116003,'SAN JORGE',1116),
(1116004,'SAN JUAN',1116),
(1116005,'SAN ISIDRO',1116),
(1116006,'SAN MARTIN DE PORRES',1116),
(1116007,'LAS LEÑAS',1116),
(1116100,'SENDA',1116),
(1116110,'VALLE POI',1116),
(1116120,'TACUATY RUGUA',1116),
(1116130,'ZANJA PYTA',1116),
(1116140,'TUCURUTY',1116),
(1116150,'CUMBARYTI',1116),
(1116160,'ITA YBATE',1116),
(1116170,'PUERTO GUYRATI',1116),
(1116180,'SURUBI-Y',1116),
(1116190,'PUERTO SANTA ROSA',1116),
(1116200,'BUEY RODEO',1116),
(1116210,'YPECAE',1116),
(1116220,'ABAY',1116),
(1116230,'NARANJAISY',1116),
(1116240,'LOMA PERO',1116),
(1116250,'GUAZU CORA',1116),
(1116999,'(NO INFORMADO)',1116),
(1117001,'SANTA ROSA',1117),
(1117002,'LA VICTORIA',1117),
(1117003,'PALMA',1117),
(1117004,'SAN BLAS',1117),
(1117100,'PEDROZO',1117),
(1117110,'JHUGUA JHU',1117),
(1117120,'ITAPYTANGUA',1117),
(1117130,'MBOCAYATY',1117),
(1117140,'CERRITO',1117),
(1117150,'ARROYO ESTRELLA',1117),
(1117160,'PASO PUENTE',1117),
(1117170,'CERRO GUY',1117),
(1117999,'(NO INFORMADO)',1117),
(1118001,'SAN FRANCISCO',1118),
(1118002,'SAN PEDRO',1118),
(1118003,'CHACO-I',1118),
(1118004,'SAN ANTONIO',1118),
(1118006,'SAN JOSE',1118),
(1118007,'SAN ISIDRO',1118),
(1118008,'VIRGEN DEL PILAR',1118),
(1118100,'COLONIA THOMPSON',1118),
(1118110,'VILLA CONAVI',1118),
(1118120,'COMPAÐIA SIETE',1118),
(1118140,'PASO DE ORO',1118),
(1118150,'SAN NICOLAS',1118),
(1118160,'YTORORO',1118),
(1118170,'ROSADO GUAZU',1118),
(1118180,'YPANE ÐU',1118),
(1118190,'COSTA ALEGRE',1118),
(1118200,'ALTOS DE YPANE',1118),
(1118210,'POTRERITO',1118),
(1118220,'ABAY (COSTA JHU)',1118),
(1118999,'(NO INFORMADO)',1118),
(1119001,'MARISCAL FRANCISCO SOLANO LOPE',1119),
(1119002,'SAN MIGUEL',1119),
(1119003,'LAS MENSAS',1119),
(1119004,'SAN LAZARO',1119),
(1119005,'10 DE AGOSTO',1119),
(1119100,'14 ALDANA CAÐADA',1119),
(1119110,'8 ROJAS CAÐADA',1119),
(1119120,'12 TOLEDO CAÐADA',1119),
(1119130,'7 YBYRARO',1119),
(1119140,'MBOCAYATY',1119),
(1119150,'TRES BOCAS',1119),
(1119160,'NIÐO JESUS',1119),
(1119999,'(NO INFORMADO)',1119),
(1120001,'14 DE MAYO',1118),
(1120004,'VIRGEN DEL CARMEN',1118),
(1201001,'VILLA PASO',1201),
(1201002,'GUARANI',1201),
(1201003,'SAN JOSE',1201),
(1201004,'GRAL. E. DIAZ',1201),
(1201005,'12 DE OCTUBRE',1201),
(1201006,'OBRERO',1201),
(1201007,'CRUCECITA',1201),
(1201008,'LOMA CLAVEL',1201),
(1201009,'SAN ANTONIO',1201),
(1201010,'SAN FRANCISCO',1201),
(1201011,'SAN MIGUEL',1201),
(1201012,'8 DE DICIEMBRE',1201),
(1201013,'SAN LORENZO',1201),
(1201014,'YTORORO',1201),
(1201120,'YATAITY',1201),
(1201130,'MEDINA',1201),
(1201140,'VALLE APUA',1201),
(1201150,'CAMBA KUA',1201),
(1201160,'YEGROS PASO',1201),
(1201180,'PUERTO NUEVO',1201),
(1201999,'(NO INFORMADO)',1201),
(1202001,'URBANO',1202),
(1202100,'TARUMA VUELTA',1202),
(1202110,'ISLA LEON',1202),
(1202120,'LOMAS PUNTA',1202),
(1202130,'ESTERO CORA',1202),
(1202140,'ACEVEDO',1202),
(1202150,'LOMAS',1202),
(1202160,'CHACO I',1202),
(1202170,'MOÐAI CUARE',1202),
(1202999,'(NO INFORMADO)',1202),
(1203001,'URBANO',1203),
(1203100,'ISLA ROY',1203),
(1203110,'BLANCO ÐU',1203),
(1203120,'KURUSU AVA',1203),
(1203130,'SAN SALVADOR',1203),
(1203140,'YRYBUCUA',1203),
(1203150,'PASO TAJU',1203),
(1203160,'POTRERITO',1203),
(1203170,'TACURUTY',1203),
(1203180,'POTRERO VILLALBA',1203),
(1203190,'CERRO ÐU',1203),
(1203200,'ZANJA RUGUA',1203),
(1203210,'COSTAS-I',1203),
(1203999,'(NO INFORMADO)',1203),
(1204001,'URBANO',1204),
(1204100,'SANTA CATALINA',1204),
(1204110,'SAN ROQUE 2',1204),
(1204120,'SAN ROQUE 1',1204),
(1204130,'ISLA LIMA',1204),
(1204140,'SAN ANTONIO NORTE',1204),
(1204150,'SANTA MARIA',1204),
(1204160,'SAN ANTONIO SUR',1204),
(1204170,'CAPILLITA',1204),
(1204180,'COSTA PO\'+C5073I',1204),
(1204190,'POTRERO SAN JUAN',1204),
(1204200,'POTRERO ZARZA',1204),
(1204999,'(NO INFORMADO)',1204),
(1205001,'8 DE DICIEMBRE',1205),
(1205002,'SANTA LIBRADA',1205),
(1205003,'CENTRO',1205),
(1205004,'SANTA LUCIA',1205),
(1205110,'VELAZQUEZ CUE',1205),
(1205120,'LOMA RINCON',1205),
(1205130,'PUESTO TORRES',1205),
(1205140,'CAMPAMENTO CUE',1205),
(1205150,'YBYCUI',1205),
(1205160,'ESTERO BELLACO',1205),
(1205170,'LOMA-I',1205),
(1205180,'LOMA',1205),
(1205999,'(NO INFORMADO)',1205),
(1206001,'URBANO',1206),
(1206100,'3RA. COMPAÐIA KARANDAYTY',1206),
(1206110,'2DA. COMPAÐIA PASO TYPY',1206),
(1206120,'1RA. COMPAÐIA GUAZU CUA NORTE',1206),
(1206130,'MONTUOSO COSTA',1206),
(1206140,'1RA. COMPAÐIA GUAZU CUA SUR',1206),
(1206150,'POTRERO PIRU',1206),
(1206160,'DUARTE CUE',1206),
(1206170,'POTRERO GUEMBE',1206),
(1206180,'RINCON DE LUNA',1206),
(1206190,'YVAVIJU',1206),
(1206999,'(NO INFORMADO)',1206),
(1207001,'ACOSTA ÐU',1207),
(1207002,'CHACO\'I',1207),
(1207003,'SAN FRANCISCO',1207),
(1207004,'ARROYO JABON',1207),
(1207100,'PASO PUKU',1207),
(1207110,'TUYU KUE',1207),
(1207120,'PARED KUE',1207),
(1207130,'PASO CORNELIO',1207),
(1207140,'ARROYO HONDO',1207),
(1207999,'(NO INFORMADO)',1207),
(1208001,'URBANO',1208),
(1208100,'BOQUERON',1208),
(1208110,'CAMBA CUA',1208),
(1208120,'LOMA CLAVEL',1208),
(1208130,'VALLE POI',1208),
(1208140,'COSTA PUKU',1208),
(1208150,'ISLERIA',1208),
(1208160,'TACURU PYTA',1208),
(1208999,'(NO INFORMADO)',1208),
(1209001,'URBANO',1209),
(1209100,'PASO PINDO',1209),
(1209110,'APIPE',1209),
(1209120,'POTRERO ESTECHE',1209),
(1209130,'POTRERO SAN JUAN',1209),
(1209140,'CASTILLO CUE',1209),
(1209150,'POTRERO POI',1209),
(1209160,'ISLA YRYVU',1209),
(1209170,'ISLA CABRERA',1209),
(1209180,'ESPINILLO',1209),
(1209190,'KAA ROGUE',1209),
(1209200,'LOMAS',1209),
(1209210,'COSTA PUCU',1209),
(1209220,'PINDURA',1209),
(1209230,'ÐEEMBUCUMI',1209),
(1209240,'ISLERIA',1209),
(1209250,'ISLA SOLA',1209),
(1209260,'SAN ANTONIO',1209),
(1209270,'YATAITY',1209),
(1209999,'(NO INFORMADO)',1209),
(1210001,'URBANO',1210),
(1210100,'FUERTE CUE',1210),
(1210110,'SAN ROQUE',1210),
(1210120,'CABRERA CUE',1210),
(1210130,'ISLA YSYPO',1210),
(1210140,'YATAITY',1210),
(1210150,'KAAGUY KUPE',1210),
(1210160,'TRES CORONAS',1210),
(1210170,'POTRERO BORDON',1210),
(1210180,'KURUZU KUATIA',1210),
(1210190,'KUATIA\'I',1210),
(1210200,'PUERTO ITA CORA',1210),
(1210210,'MANDARINA',1210),
(1210220,'ALARCON',1210),
(1210230,'ESTERO PUNTA',1210),
(1210240,'LOMA-I',1210),
(1210999,'(NO INFORMADO)',1210),
(1211001,'URBANO',1211),
(1211100,'SAUCE BOQUERON',1211),
(1211110,'PASO CANOA',1211),
(1211120,'COSTA PARANA',1211),
(1211130,'PASO DE PATRIA NORTE',1211),
(1211140,'PASO DE PATRIA SUR',1211),
(1211999,'(NO INFORMADO)',1211),
(1212001,'URBANO',1212),
(1212100,'CIERVO BLANCO',1212),
(1212110,'OTAZU',1212),
(1212120,'LAGUNA ITA',1212),
(1212130,'COSTA PINDO',1212),
(1212140,'LOMA CAMBA KUA',1212),
(1212150,'COSTA ROSADO',1212),
(1212160,'SAN JUAN ÐEEMBUCU NORTE',1212),
(1212170,'POTRERO CABALLERO',1212),
(1212180,'8 DE DICIEMBRE',1212),
(1212190,'SAN JUAN ÐEEMBUCU SUR',1212),
(1212200,'PIRITY',1212),
(1212210,'POTRERO TAJY',1212),
(1212220,'ESPINILLO',1212),
(1212230,'MALVINA',1212),
(1212240,'POTRERO PO-I',1212),
(1212250,'SAN LORENZO ESTERO CAMBA',1212),
(1212260,'KARANDA\'Y TY',1212),
(1212999,'(NO INFORMADO)',1212),
(1213001,'URBANO',1213),
(1213100,'SAN BLAS',1213),
(1213110,'PUNTA DIAMANTE',1213),
(1213120,'TACUARA-I',1213),
(1213130,'POTRERO GONZALEZ',1213),
(1213140,'MBURICA',1213),
(1213150,'CAMPO BELEN',1213),
(1213160,'YAGUARON',1213),
(1213170,'YATAITY',1213),
(1213180,'CANO CUE',1213),
(1213190,'TACUARAS NORTE',1213),
(1213200,'TACUARAS SUR',1213),
(1213999,'(NO INFORMADO)',1213),
(1214001,'URBANO',1214),
(1214100,'SEBASTIAN GABOTO',1214),
(1214110,'ISLA GUAZU',1214),
(1214120,'CARANITY',1214),
(1214130,'BANCO PIRAY',1214),
(1214140,'BANCO PARAGUAY',1214),
(1214999,'(NO INFORMADO)',1214),
(1215001,'URBANO',1215),
(1215100,'ZANJITA',1215),
(1215110,'YVY ATA',1215),
(1215120,'BARRIO ALEGRE',1215),
(1215130,'VALLE PUCU',1215),
(1215140,'KARANDA\'Y TY',1215),
(1215150,'CUATRO VIENTOS',1215),
(1215160,'ESTANZUELA',1215),
(1215170,'ISLA REAL',1215),
(1215180,'SAN JUAN',1215),
(1215190,'VILLA OLIVA',1215),
(1215200,'PARAY',1215),
(1215210,'RINCON-PARAISO',1215),
(1215999,'(NO INFORMADO)',1215),
(1216001,'URBANO',1216),
(1216100,'SAN FRANCISCO',1216),
(1216110,'MANANTIALES',1216),
(1216120,'SAN SEBASTIAN',1216),
(1216130,'SAN MIGUEL',1216),
(1216140,'PASO ITA',1216),
(1216150,'ISLA RO\'Y',1216),
(1216160,'ISLA REAL',1216),
(1216170,'TENIENTE SANCHEZ',1216),
(1216180,'ÐU PA\'U',1216),
(1216999,'(NO INFORMADO)',1216),
(1301001,'MARIA VICTORIA',1301),
(1301002,'MARISCAL ESTIGARRIBIA',1301),
(1301003,'PERPETUO SOCORRO',1301),
(1301004,'GENERAL DIAZ',1301),
(1301005,'SAN ANTONIO',1301),
(1301006,'BERNARDINO CABALLERO',1301),
(1301007,'GUARANI',1301),
(1301008,'VIRGEN DE CAACUPE',1301),
(1301009,'SAN GERARDO',1301),
(1301010,'GENERAL IGNACIO GENES',1301),
(1301011,'SAN JUAN NEUMANN',1301),
(1301012,'OBRERO',1301),
(1301013,'JARDIN AURORA',1301),
(1301014,'DEFENSORES DEL CHACO',1301),
(1301015,'CENTRO',1301),
(1301100,'VALLE DEL SOL',1301),
(1301105,'ESTRELLA',1301),
(1301110,'SAN LUIS',1301),
(1301115,'TIMBURY',1301),
(1301120,'GRACIA DE DIOS',1301),
(1301125,'CABECERA  AQUIDABAN',1301),
(1301130,'PORTERA ORTIZ',1301),
(1301135,'SANTA CATALINA',1301),
(1301140,'TRES PALOS',1301),
(1301145,'TACUARA INDIGENA  (TAKUAGUY OG',1301),
(1301150,'KACHIMBO',1301),
(1301155,'AMARO CUE',1301),
(1301160,'POTRERO SANTIAGO',1301),
(1301165,'CERRO CORA-I',1301),
(1301170,'SPENCE',1301),
(1301175,'MARIA AUXILIADORA',1301),
(1301180,'SANTA CLARA',1301),
(1301185,'1ro. DE MAYO',1301),
(1301190,'JAKAIRA POTRERITO',1301),
(1301195,'SERENO',1301),
(1301200,'VICTORIA-I',1301),
(1301205,'GENERAL GENEZ',1301),
(1301210,'VISTA ALEGRE',1301),
(1301215,'ISLA MADAMA',1301),
(1301220,'VICTORIA GUAZU',1301),
(1301225,'ZONA INDUSTRIAL',1301),
(1301230,'JAKAIRA',1301),
(1301235,'BATALLON DE FRONTERA',1301),
(1301240,'MAFFUCCI',1301),
(1301245,'YBYPE',1301),
(1301250,'POTRERO REPUBLICA',1301),
(1301255,'PIKY CUA (INDIGENA)',1301),
(1301260,'CUMBRE',1301),
(1301265,'15 DE AGOSTO',1301),
(1301270,'JAGUATI (INDIGENA)',1301),
(1301275,'PANAMBY (INDIGENA)',1301),
(1301280,'POTRERO SUR',1301),
(1301285,'PIRITY INDIGENA',1301),
(1301290,'YHAMBUE',1301),
(1301295,'PARQUE NACIONAL CERRO CORA',1301),
(1301300,'NARANJA JAI',1301),
(1301305,'ZANJA PYTA',1301),
(1301310,'CHIRIGUELO',1301),
(1301320,'CALLEJON SANTA MARIA',1301),
(1301325,'ITA POPO',1301),
(1301330,'FORTUNA',1301),
(1301335,'SAN VICENTE',1301),
(1301340,'PIKY',1301),
(1301345,'ACEITE-I',1301),
(1301350,'PICADA LORITO',1301),
(1301355,'ITAGUASU (INDIGENA)',1301),
(1301360,'CALLEJON CANO',1301),
(1301365,'CALLEJON BRASIL',1301),
(1301370,'SAN MIGUEL 1',1301),
(1301375,'TAVA MBOAE (INDIGENA)',1301),
(1301380,'YBY JU',1301),
(1301385,'RINCON DE JULIO',1301),
(1301390,'ÐANDEJARA PUENTE',1301),
(1301395,'POTRERO JARDIN',1301),
(1301400,'CERRO YERE',1301),
(1301405,'TAJY (INDIGENA)',1301),
(1301410,'CERRO PERO',1301),
(1301415,'ITA PAVUSU (INDIGENA)',1301),
(1301420,'CABECERITA',1301),
(1301425,'YPYTA',1301),
(1301430,'CERRO BOBO',1301),
(1301435,'MBARACAYA-I',1301),
(1301440,'DUKE',1301),
(1301445,'CERRO 21',1301),
(1301450,'CAMPO FLOR (INDIGENA)',1301),
(1301455,'CERRO JHU',1301),
(1301460,'NUEVA VIRGINIA',1301),
(1301465,'ÐUNDIARY (INDIGENA)',1301),
(1301470,'JURUKA (INDIGENA)',1301),
(1301475,'PIRARY (INDIGENA)',1301),
(1301480,'ITA HU\'U',1301),
(1301485,'KUTIJUI (INDIGENA)',1301),
(1301490,'MBOKAJA-I (INDIGENA)',1301),
(1301495,'LOMA-I (INDIGENA)',1301),
(1301500,'EST. PAPA NOEL',1301),
(1301505,'ATYVA (INDIGENA)',1301),
(1301510,'JAGUARY',1301),
(1301515,'EST. YPACARAI',1301),
(1301520,'JETE MIRI (INDIGENA)',1301),
(1301525,'YJHEVY (INDIGENA)',1301),
(1301530,'EST. SANTA GENOVEVA',1301),
(1301535,'TATU KAITA (INDIGENA)',1301),
(1301540,'CERRO GUAZU',1301),
(1301545,'YRYVU-I (INDIGENA)',1301),
(1301550,'ÐUAPY (INDIGENA)',1301),
(1301555,'GRAN CHAPARRAL (EST. CHAPARRO)',1301),
(1301560,'MBAE MARANGATU (INDIGENA)',1301),
(1301565,'ARAROKE (INDIGENA)',1301),
(1301570,'EST. ARA ROKE',1301),
(1301575,'EST. KAI MEMBY',1301),
(1301580,'PAI KUARA',1301),
(1301585,'ARROYO BLANCO',1301),
(1301590,'ANGUJA-I (INDIGENA)',1301),
(1301595,'SAN MIGUEL 2',1301),
(1301600,'INDIGENA MBAE NEMI',1301),
(1301605,'GUAVIRA',1301),
(1301610,'JATEBU\'I',1301),
(1301999,'(NO INFORMADO)',1301),
(1302001,'PERPETUO SOCORRO',1302),
(1302002,'OBRERO',1302),
(1302003,'MARIA AUXILIADORA',1302),
(1302004,'APA',1302),
(1302005,'INMACULADA CONCEPCIËN',1302),
(1302006,'SAN ANTONIO',1302),
(1302100,'APA MI',1302),
(1302110,'SGTO. DURE',1302),
(1302120,'MANDYJU POTY',1302),
(1302130,'RINCONADA',1302),
(1302140,'CURUZU EVA',1302),
(1302150,'SAN ISIDRO',1302),
(1302160,'PASTORIL',1302),
(1302170,'COL. SANTA ANA',1302),
(1302180,'EST. DON GUALBERTO',1302),
(1302190,'ASENTAMIENTO BRAZOS UNIDOS',1302),
(1302200,'LA LOMITA',1302),
(1302210,'LAGUNA PLATILLO',1302),
(1302220,'EST. TIMBORI',1302),
(1302230,'EST. LA CASCADA',1302),
(1302240,'SAN ROQUE',1302),
(1302250,'LAS MERCEDES',1302),
(1302260,'CASUALIDAD',1302),
(1302270,'EST. SANTA TERESA',1302),
(1302280,'ALEGRE',1302),
(1302290,'CERRO ACANGUE',1302),
(1302999,'(NO INFORMADO)',1302),
(1303001,'PRIMAVERA',1303),
(1303002,'SAN ROQUE',1303),
(1303003,'SAN JOSE',1303),
(1303004,'OBRERO',1303),
(1303005,'SAN MIGUEL',1303),
(1303100,'NUEVA YAU',1303),
(1303110,'CERRO KUATIA',1303),
(1303120,'CERRO GUY',1303),
(1303130,'MANTA POTRERO',1303),
(1303140,'SAN FERNANDO',1303),
(1303150,'CURUPAYTY',1303),
(1303160,'CRISTINO POTRERO',1303),
(1303170,'KA\'AGUY POTY',1303),
(1303180,'INDIGENA TAVYTERA',1303),
(1303190,'UMBU',1303),
(1303200,'CHACO-I',1303),
(1303210,'MENTA',1303),
(1303220,'MARISCAL LOPEZ',1303),
(1303230,'INDIGENA MBARACAY',1303),
(1303240,'AGUARA',1303),
(1303250,'TACUARA  (TACUARATY)',1303),
(1303260,'POTRERITO',1303),
(1303270,'ARROYITO',1303),
(1303280,'RINCON PARAGUAYO',1303),
(1303290,'GUYRA KEJHA',1303),
(1303300,'YBYPE',1303),
(1303310,'TOTORA',1303),
(1303320,'POTRERO NOVILLO',1303),
(1303330,'JUKYRY GUASU   (PAKOLA)',1303),
(1303340,'PASO ITA',1303),
(1303350,'COL. PIRAY',1303),
(1303360,'YSOSO',1303),
(1303370,'CAAZAPA-MI',1303),
(1303380,'SAN JUAN',1303),
(1303390,'INDIGENA PIRAY',1303),
(1303400,'PUENTE KURE',1303),
(1303410,'CADETE BOQUERON',1303),
(1303420,'JAGUARUNDI',1303),
(1303430,'KARAPÃ\'I',1303),
(1303440,'INDIGENA ITAJU',1303),
(1303450,'AGUARA VEVE',1303),
(1303460,'CERRO TORIN',1303),
(1303470,'ZANJA JHU',1303),
(1303480,'COLO-O',1303),
(1303490,'COL. INDIGENA ITA POTY',1303),
(1303500,'PUERTO PANADERO',1303),
(1303510,'PASO HISTORICO',1303),
(1303520,'CERRO VERDE',1303),
(1303530,'ESTANCIA PANAMBI',1303),
(1303540,'ESTANCIA SAN JUAN',1303),
(1303550,'SAN CAMILO',1303),
(1303560,'JUKYRY MI   (CUPI\'I)',1303),
(1303570,'CORRALITO',1303),
(1303580,'EST. LAGUNITA',1303),
(1303999,'(NO INFORMADO)',1303),
(1401001,'SAN PEDRO',1401),
(1401002,'INDUSTRIAL',1401),
(1401003,'VILLA NUEVA',1401),
(1401004,'VILLA FLORIDA',1401),
(1401005,'ITAIPU',1401),
(1401006,'SANTA TERESA',1401),
(1401007,'PRIMAVERA',1401),
(1401008,'SAN MIGUEL',1401),
(1401009,'SANTA ROSA',1401),
(1401010,'DONDE NACE EL SOL',1401),
(1401011,'SAN FRANCISCO',1401),
(1401100,'COL. CARAPA.',1401),
(1401110,'PUERTO ADELA',1401),
(1401120,'SALTO DEL GUAIRA KM.32',1401),
(1401130,'SALTO DEL GUAIRA KM.20',1401),
(1401140,'SALTO DEL GUAIRA KM. 18',1401),
(1401150,'COL. GASORY',1401),
(1401160,'COL. CANINDEYU',1401),
(1401170,'ALBORADA',1401),
(1401180,'GUAVIRA',1401),
(1401190,'YBY PORA',1401),
(1401200,'COL. GUADALUPE CAMINO TRES',1401),
(1401210,'PUERTO TIGRE',1401),
(1401999,'(NO INFORMADO)',1401),
(1402001,'URBANO',1402),
(1402100,'ARROZ TYGUE ( COLONIA MARILUZ',1402),
(1402110,'COLONIA AMERICANA',1402),
(1402120,'CERRO PORTEÐO',1402),
(1402130,'PACOVA',1402),
(1402140,'FELICIDAD',1402),
(1402150,'LIMA',1402),
(1402160,'SOLIS CUE',1402),
(1402170,'CONTROL',1402),
(1402180,'CAYE CUE',1402),
(1402190,'YNAMBU YCUA',1402),
(1402200,'MARECO CUE',1402),
(1402210,'BARRIO SAN FRANCISCO',1402),
(1402220,'MARISCAL ( CREPO )',1402),
(1402230,'BARUDA',1402),
(1402240,'CORPUS VIEJO',1402),
(1402250,'PENOSA',1402),
(1402260,'COLONIA GUARANI ( KM 5 )',1402),
(1402270,'FORTUNA ( CRISTO REY )',1402),
(1402280,'CERRO PYTA',1402),
(1402290,'AGUA BLANCA',1402),
(1402300,'COPARO',1402),
(1402310,'COLONIA ANAHI',1402),
(1402320,'YBYRAROBANA',1402),
(1402330,'ARROYO MOKOI',1402),
(1402340,'CRUCE CAROLINA',1402),
(1402350,'SANTA ANA',1402),
(1402360,'CRUCE GUARANI',1402),
(1402370,'Y JHOVY',1402),
(1402380,'SAN ANTONIO',1402),
(1402390,'SELETA',1402),
(1402400,'VILLA ALTA',1402),
(1402410,'LAMBARE',1402),
(1402420,'GRAL BERNARDINO CABALLERO',1402),
(1402430,'PASO ITA',1402),
(1402440,'JEJUI SUR',1402),
(1402450,'SANTA LUCIA',1402),
(1402460,'PINDOTY PORA',1402),
(1402999,'(NO INFORMADO)',1402),
(1403001,'SANTA MARIA',1403),
(1403002,'CIUDAD INDUSTRIAL',1403),
(1403003,'MARIA AUXILIADORA',1403),
(1403004,'CENTRO',1403),
(1403005,'FATIMA',1403),
(1403006,'SAN JOSE OBRERO',1403),
(1403007,'CERRO CORA',1403),
(1403100,'MARACANA',1403),
(1403110,'TREINTA',1403),
(1403120,'6 ENCUADRE',1403),
(1403130,'HUDER DURE',1403),
(1403140,'LUZ BELLA',1403),
(1403150,'CANGUERY',1403),
(1403160,'4 ENCUADRE',1403),
(1403170,'COLONIA NUEVA DURANGO',1403),
(1403180,'7 MONTE',1403),
(1403190,'PASO REAL',1403),
(1403200,'SAGRADA FAMILIA',1403),
(1403210,'1RO DE MARZO',1403),
(1403220,'ARROYO PIROY',1403),
(1403230,'CARRO CUE',1403),
(1403240,'COLONIA PYNANDI',1403),
(1403250,'SANTA LIBRADA',1403),
(1403260,'SAN BLAS',1403),
(1403270,'COLONIA CANELA ( TITO ROJAS )',1403),
(1403280,'MANDUARA',1403),
(1403290,'YASY KAÐY',1403),
(1403300,'SAN MIGUEL',1403),
(1403310,'8 DE DICIEMBRE',1403),
(1403320,'RIO CORRIENTES',1403),
(1403330,'SANTO DOMINGO',1403),
(1403340,'NACIENTE',1403),
(1403350,'LAGUNITA',1403),
(1403360,'MBURUCUYA',1403),
(1403370,'LAGUNA PACOVA',1403),
(1403380,'CERRITO',1403),
(1403390,'NUEVA ALIANZA',1403),
(1403400,'TAPIA',1403),
(1403410,'ALEMAN CUE',1403),
(1403420,'ACEPAR CUE',1403),
(1403430,'SEXTA LINEA ACEPAR',1403),
(1403440,'QUINTA LINEA ACEPAR',1403),
(1403450,'CUARTA LINEA ACEPAR',1403),
(1403460,'TERCERA LINEA ACEPAR',1403),
(1403470,'SEGUNDA LINEA ACEPAR',1403),
(1403480,'PRIMERA LINEA ACEPAR ( PLANTA',1403),
(1403490,'CALLE TACUAPI',1403),
(1403500,'BARRERO VILLAR',1403),
(1403510,'GUAYAYBI',1403),
(1403520,'YBY PYAJHU',1403),
(1403530,'SAN ISIDRO',1403),
(1403540,'PUERTO LATA',1403),
(1403550,'TACUARI  ( KM. 15 )',1403),
(1403560,'ÐU APUA ( KM. 9 )',1403),
(1403570,'ARAUJO CUE',1403),
(1403580,'SANTA ROSA MI',1403),
(1403590,'PRIMERA LINEA SANTA ROSA MI',1403),
(1403600,'SEGUNDA LINEA SANTA ROSA MI',1403),
(1403610,'ITANDEY',1403),
(1403620,'CALLE SAN JORGE',1403),
(1403630,'SANTA ROSA',1403),
(1403640,'SANTA CATALINA',1403),
(1403650,'COLONIA YEPOPYJHY I',1403),
(1403660,'TACUARA TY ( KM. 7 )',1403),
(1403670,'CALLE CURUGUATY I ( LAGUNITA )',1403),
(1403680,'NARANJATY',1403),
(1403700,'BARRIO CIUDAD NUEVA',1403),
(1403720,'ASENT. MARZO PARAGUAYO',1403),
(1403730,'GRAL BERNARDINO CABALLERO',1403),
(1403740,'GRAL ARTIGAS',1403),
(1403750,'SAN FRANCISCO',1403),
(1403760,'PUESTO JHU',1403),
(1403770,'YERUTI',1403),
(1403780,'AGUA E',1403),
(1403790,'COLONIA YBYPYTA',1403),
(1403800,'KM.35 YBYPYTA',1403),
(1403810,'ARROYO GUAZU',1403),
(1403820,'NARANJITO',1403),
(1403830,'JUANA DE LARA',1403),
(1403840,'COLONIA SANTO DOMINGO',1403),
(1403860,'LOMAS VALENTINAS',1403),
(1403870,'SAN ISIDRO 2',1403),
(1403880,'NUEVA ESPERANZA',1403),
(1403890,'COLONIA FORTUNA',1403),
(1403999,'(NO INFORMADO)',1403),
(1404001,'URBANO',1404),
(1404100,'KOE PORA',1404),
(1404110,'MARQUETI CUE',1404),
(1404120,'ITANARAMI',1404),
(1404130,'LOMA CLAVEL ( YGATIMI )',1404),
(1404140,'JEJUI MI',1404),
(1404150,'JEJUI GUAZU',1404),
(1404160,'COLONIA 1o DE MAYO',1404),
(1404170,'POTRERO GUAZU',1404),
(1404180,'LA MORENA',1404),
(1404190,'ALIANZA',1404),
(1404200,'KARUPERA',1404),
(1404210,'YVY PYTA',1404),
(1404220,'BRITEZ CUE',1404),
(1404230,'GUYRA KEJHA',1404),
(1404240,'MBOI JAGUA',1404),
(1404250,'ITACURUBI',1404),
(1404260,'ITA POTY',1404),
(1404270,'TENDAL ( RESERVA DEL MBARACAYU',1404),
(1404280,'SAN BLAS',1404),
(1404290,'SAN MARCOS',1404),
(1404300,'RESIDENTAS',1404),
(1404310,'SAN ANTONIO',1404),
(1404320,'ARROYO GUAZU',1404),
(1404330,'11 DE SETIEMBRE',1404),
(1404340,'ÐANDU ROCAI',1404),
(1404350,'ÐUHAI ( CABAYU ACUA',1404),
(1404999,'(NO INFORMADO)',1404),
(1405001,'URBANO',1405),
(1405100,'ESTANCIA KARY',1405),
(1405110,'COLONIA PARIRI',1405),
(1405120,'ESTANCIA YPACARAI',1405),
(1405130,'CERRO MBARACAYU ( ITANARA )',1405),
(1405140,'ITANARA I',1405),
(1405150,'YPAU',1405),
(1405160,'ITANARA MI',1405),
(1405999,'(NO INFORMADO)',1405),
(1406001,'SAN ISIDRO LABRADOR',1406),
(1406002,'SAN ISIDRO',1406),
(1406003,'FATIMA',1406),
(1406004,'VIRGEN DEL ROSARIO',1406),
(1406100,'ASENTAMIENTO PRIMAVERA',1406),
(1406110,'8 DE DICIEMBRE',1406),
(1406120,'ASENTAMIENTO ARA VERA 2',1406),
(1406130,'ASENTAMIENTO ARA VERA 1',1406),
(1406140,'ASENTAMIENTO CRESCENCIO GONZAL',1406),
(1406150,'KOE PORA',1406),
(1406160,'CAAGUY POTY ( CAÐADITA )',1406),
(1406170,'BARRANCA YAPY ( TORRES CUE )',1406),
(1406180,'ESTANCIA KARY ( CAAGUY PORA )',1406),
(1406190,'PYPYKY ( MENCHAKA CUE )',1406),
(1406200,'AMERICANA CUE ( ROQUE GONZALEZ',1406),
(1406210,'PARIRI',1406),
(1406220,'CERRO GUY',1406),
(1406230,'CARAPA',1406),
(1406240,'YBU',1406),
(1406250,'SAN ISIDRO 1',1406),
(1406260,'SAN ISIDRO 2',1406),
(1406999,'(NO INFORMADO)',1406),
(1407001,'URBANO',1407),
(1407100,'COLONIA ALBORADA',1407),
(1407110,'SAN JUAN',1407),
(1407120,'ARENA BLANCA',1407),
(1407130,'POTEZUELO',1407),
(1407140,'PUERTO ADELA',1407),
(1407150,'IBEL',1407),
(1407160,'PUENTE KYJHA LINEA PROGRESO',1407),
(1407170,'PUENTE KYJHA 1RO. DE MARZO',1407),
(1407180,'PUENTE KYJHA SAN IGNACIO',1407),
(1407190,'PUENTE KYJHA SAN LUIS',1407),
(1407200,'PUENTE KYJHA SAN PEDRO',1407),
(1407999,'(NO INFORMADO)',1407),
(1408001,'URBANO',1408),
(1408100,'11 DE SETIEMBRE',1408),
(1408110,'PASO ITA',1408),
(1408120,'KUMANDA KAI',1408),
(1408130,'FAZENDA LA BOLSA',1408),
(1408140,'FAZENDA',1408),
(1408150,'AGRICOLA PARAGUAY',1408),
(1408160,'FAZENDA ESPAÐA',1408),
(1408999,'(NO INFORMADO)',1408),
(1409001,'URBANO',1409),
(1409100,'CAMINO 3',1409),
(1409110,'COLONIA GUADALUPE',1409),
(1409120,'SANTA CLARA',1409),
(1409130,'MBARACAYU',1409),
(1409140,'COLONIA JAMAICA',1409),
(1409150,'LOTE 5',1409),
(1409160,'6 DE ENERO',1409),
(1409170,'YBU PORA',1409),
(1409999,'(NO INFORMADO)',1409),
(1410001,'URBANO',1410),
(1410100,'14 MIL',1410),
(1410110,'LAUREL',1410),
(1410120,'COLONIA GENERAL',1410),
(1410130,'TRACTOR CUE',1410),
(1410140,'COLONIA MARANGATU',1410),
(1410150,'NUEVA ASUNCION',1410),
(1410160,'COLONIA ITAMBEY',1410),
(1410170,'TRONCAL 4 NORTE',1410),
(1410180,'TRONCAL 4 SUR',1410),
(1410999,'(NO INFORMADO)',1410),
(1501640,'ZONA URBANA POZO COLORADO',1501),
(1502001,'URBANO BENJAMIN ACEVAL',1502),
(1502002,'SANTA TERESITA',1502),
(1502100,'ZONA PECHUGON',1502),
(1502110,'ZONA GARELLI',1502),
(1502120,'ZONA ESTANCIA SANTA TERESA',1502),
(1502130,'ZONA LA PIEDAD',1502),
(1502140,'ZONA CERRITO',1502),
(1502160,'COSTA GUAZU',1502),
(1502180,'ZONA  ZANJITA',1502),
(1502999,'(NO INFORMADO)',1502),
(1503001,'ZONA URBANA',1503),
(1503100,'ZONA PINASCO',1503),
(1503110,'CEIBO NORTE',1503),
(1503120,'CEIBO SUR',1503),
(1503999,'(NO INFORMADO)',1503),
(1504001,'CIUDAD NUEVA',1504),
(1504002,'PAÐETE',1504),
(1504003,'ALONSO',1504),
(1504004,'GOLONDRINA',1504),
(1504005,'SAN JUAN',1504),
(1504006,'CERRITO',1504),
(1504100,'ZONA GRAL DIAZ',1504),
(1504110,'ZONA AVALOS SANCHEZ',1504),
(1504120,'ZONA CERRITO MAQUEDA',1504),
(1504130,'ZONA RIO NEGRO MONTELINDO',1504),
(1504140,'ZONA POZO AZUL',1504),
(1504150,'SUBURBANO MONTELINDO SUR',1504),
(1504160,'ZONA ESTANCIA PFANNEL',1504),
(1504170,'ZONA ESTANCIA LA CONCEPCION',1504),
(1504180,'ZONA MOISES GALEANO',1504),
(1504190,'ZONA DE TREBOL',1504),
(1504200,'ZONA ESTEBAN MARTINEZ',1504),
(1504210,'SUBURBANO CADETE PANDO',1504),
(1504220,'ZONA DE CADETE PANDO',1504),
(1504230,'ZONA GRAL BRUGUEZ',1504),
(1504240,'SUBURBANO GRAL BRUGUEZ',1504),
(1504250,'ZONA ESTANCIA BOCA I',1504),
(1504260,'ZONA ESTANCIA SAN LUIS',1504),
(1504270,'SALADILLO',1504),
(1504280,'SUBURBANO COSTA VILLA HAYES',1504),
(1504290,'ZONA RIO VERDE VILLA HAYES',1504),
(1504300,'ZONA LA PAZ',1504),
(1504310,'SUBURBANO BETERETE CUE',1504),
(1504320,'SUBURBANO CHACO I',1504),
(1504330,'SUBURBANO REMANCITO',1504),
(1504340,'ZONA CHACO I',1504),
(1504350,'ZONA REMANCITO',1504),
(1504360,'ZONA CAMPO AROMA',1504),
(1504370,'SUB URBANO CRUCE DE LOS PIONER',1504),
(1504380,'ZONA 25 LEGUAS OESTE',1504),
(1504390,'SUB URBANO IRALA FERNANDEZ',1504),
(1504400,'ZONA 25 LEGUAS ESTE',1504),
(1504410,'ZONA ZALAZAR',1504),
(1504420,'CAMPO ACEVAL NORTE',1504),
(1504430,'SUB URBANO CAMPO ACEVAL',1504),
(1504440,'CAMPO ACEVAL SUR',1504),
(1504450,'ZONA MONTELINDO OESTE',1504),
(1504460,'ZONA NUEVA MESTRE',1504),
(1504470,'ZONA POZO COLORADO - PUERTO MI',1504),
(1504480,'ZONA MONTELINDO ESTE',1504),
(1504490,'ZONA MONTELINDO POZO',1504),
(1504500,'SUB URBANO NUEVA MESTRE',1504),
(1504510,'LOCALIDAD 01',1504),
(1504520,'LOCALIDAD 02',1504),
(1504530,'LOCALIDAD 03',1504),
(1504540,'LOCALIDAD 04 (SUB URBANO LOLIT',1504),
(1504550,'LOCALIDAD 05',1504),
(1504560,'LOCALIDAD 06',1504),
(1504570,'LOCALIDAD 07',1504),
(1504580,'LOCALIDAD 08 (SUB URBANO PARA',1504),
(1504590,'LOCALIDAD 09',1504),
(1504600,'LOCALIDAD 10',1504),
(1504610,'LOCALIDAD 11',1504),
(1504620,'LOCALIDAD 01 - FERNHEIN',1504),
(1504630,'LOCALIDAD 01 - NEULAND',1504),
(1504999,'(NO INFORMADO)',1504),
(1505001,'SAN MIGUEL',1505),
(1505002,'QUINTA',1505),
(1505003,'VIRGEN DEL ROSARIO',1505),
(1505004,'SAN ANTONIO',1505),
(1505005,'CENTRAL',1505),
(1505006,'INDEPENDIENTE',1505),
(1505007,'ORIENTAL',1505),
(1505008,'8 DE DICIEMBRE',1505),
(1505999,'(NO INFORMADO)',1505),
(1506001,'SANTA ROSA - ZONA URBANA',1506),
(1506100,'ZONA DE NINFA',1506),
(1506110,'SUBURBANO NINFA',1506),
(1506120,'ZONA DE ESPARTILLITO',1506),
(1506130,'ZONA DE GANADERA ESPINILLO',1506),
(1506140,'ZONA PARIRI',1506),
(1506150,'ZONA LAS MERCEDES',1506),
(1506160,'ZONA RIO NEGRO',1506),
(1506170,'SUBURBANO PTO FALCON',1506),
(1506999,'(NO INFORMADO)',1506),
(1602001,'URBANO',1602),
(1602002,'SAN ANTONIO',1602),
(1602100,'ZONA ESTANCIA MBUTURETA',1602),
(1602110,'ZONA ESTANCIA REMONIA',1602),
(1602130,'UNIDAD MILITAR',1602),
(1602140,'ZONA PRATTS GILL',1602),
(1602150,'ZONA PEDRO P PENA',1602),
(1602160,'ZONA ESTANCIA AGROFIL',1602),
(1602170,'ZONA MARGARINO',1602),
(1602180,'ZONA PIRIZAL',1602),
(1602190,'ZONA ESTANCIA SANTA MARTA',1602),
(1602200,'ZONA GRAL GARAY',1602),
(1602210,'ZONA EST AMAPOLA',1602),
(1602220,'ZONA EST MORINIGO',1602),
(1602230,'LOCALIDAD 1',1602),
(1602240,'LOCALIDAD 2',1602),
(1602250,'LOCALIDAD 3',1602),
(1602260,'LOCALIDAD 4',1602),
(1602270,'CRUCE BOQUERON',1602),
(1602315,'LOCALIDAD 5',1602),
(1602320,'SUBURBANO CHOFERES DEL CHACO',1602),
(1602360,'URBANO LOMA PLATA',1602),
(1602370,'URBANO LOMA PLATA - INDIGENA',1602),
(1602380,'URBANO FILADELFIA',1602),
(1602390,'URBANO FILADELFIA - INDIGENA',1602),
(1602400,'URBANO NEULAND',1602),
(1602410,'URBANO NEULAND - INDIGENA',1602),
(1602999,'(NO INFORMADO)',1602),
(1701001,'URBANO OLIMPO',1701),
(1701100,'ZONA YACYRETA',1701),
(1701110,'ZONA LEDA',1701),
(1701120,'SUB URBANO BAHIA NEGRA',1701),
(1701130,'ZONA CORRALITO',1701),
(1701140,'ZONA YAGUARETE PORA',1701),
(1701150,'ZONA RIVERA DE OLIMPO',1701),
(1701160,'ZONA TORO PAMPA ESTE',1701),
(1701170,'SUB URBANO SAN CARLOS',1701),
(1701180,'SUB URBANO TORO PAMPA',1701),
(1701190,'ZONA FLORIDA',1701),
(1701200,'ZONA TORO PAMPA OESTE',1701),
(1701210,'ZONA PARQUE NACIONAL DEFENSORE',1701),
(1701220,'ZONA AGUA DULCE',1701),
(1701999,'(NO INFORMADO)',1701),
(1702001,'URBANO LA VICTORIA - (EX PUERT',1702),
(1702100,'SUB URBANO CARMELO PERALTA',1702),
(1702105,'ISLA MARGARITA',1702),
(1702110,'SUB URBANO LA ESPERANZA (SASTR',1702),
(1702120,'SUB URBANO PTO GUARANI',1702),
(1702140,'ZONA CAÐADITA',1702),
(1702150,'ZONA SANTA VIRGINIA',1702),
(1702160,'ZONA MENNONITA ALTO PARAGUAY',1702),
(1702170,'ZONA MONTANIA',1702),
(1725340,'ZONA RIBERA CARMELO PERALTA',1702),
(1725341,'CATEDRAL',1),
(1725342,'SANTA TERESA',1103),
(1725343,'ROBERTO L. PETIT - OBRERO',1),
(1725344,'RICARDO BRUGADA - PELOPINCHO',1),
(1725345,'NO REGISTRADO',1800),
(1725346,'SAN CARLOS 1',1110),
(1725347,'FRACCION AURORA',1108),
(1725348,'CIUDAD NUEVA',1),
(1725349,'LAS AMERICAS',1005),
(1725350,'SAN JUAN',1005),
(1725351,'SAN ISIDRO',1005),
(1725352,'CHE JAZMIN',1005),
(1725353,'PUERTA DEL SOL',1005),
(1725354,'LAS MERCEDES',1005),
(1725355,'VILLA DEPORTIVA',1005);

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
  `foto` text,
  PRIMARY KEY (`idcliente`),
  UNIQUE KEY `idx_cliente_ci` (`ci`),
  KEY `fk_cliente_zona_idx` (`idzona`),
  KEY `fk_cliente_barrio1_idx` (`idbarrio`),
  KEY `fk_cliente_profesion1_idx` (`idprofesion`),
  KEY `idx_cliente_nombre_apellido` (`nombre`,`apellido`),
  CONSTRAINT `fk_cliente_barrio1` FOREIGN KEY (`idbarrio`) REFERENCES `barrio` (`idbarrio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_profesion1` FOREIGN KEY (`idprofesion`) REFERENCES `profesion` (`idprofesion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_cliente_zona` FOREIGN KEY (`idzona`) REFERENCES `zona` (`idzona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=928 DEFAULT CHARSET=utf8;

/*Data for the table `cliente` */

insert  into `cliente`(`idcliente`,`idzona`,`idbarrio`,`idprofesion`,`nombre`,`apellido`,`ruc`,`ci`,`celular`,`telefono`,`referencia`,`trabajo_lugar`,`trabajo_telefono`,`ref1`,`ref2`,`ref3`,`reftel1`,`reftel2`,`reftel3`,`foto`) values 
(1,216,216260,1,'NANCY','BERONICA FRETES GIMENEZ','','4811710','0981987736','','','','','','','','','','',''),
(2,216,216460,1,'VERONICA','RAMONA CANDIA CABALLERO','','5487498','0983817445','','CALLE SAN MIGUEL MANO IZQUERDA PASANDO LA IGLESIA UNOS 200MTS','','','','','','','','',''),
(3,214,214210,1,'MARIA','DOLORES SANABRIA','','4275625','0982903075','','2 CASA DEL TABLERO STA LUCIA MANO DERECHA','','','','','','','','',''),
(4,216,216400,1,'REINALDO','SANCHEZ','','3467055','0971252980','','CENTRO BSP  FRENTE MISMO DEL COLEGIO JUAN H PETENGILL','','','','','','','','',''),
(5,216,216350,1,'MIGUEL','ROSALINO VAZQUEZ CAÑETE','','7468645','0983955758','','','','','','','','','','',''),
(6,216,216260,1,'MARIELA','GONZALEZ ZORILLA','','5855331','0975421241','','B NAVIDAD COMERCIAL BODEGA SAN CAYETANO','','','','','','','','',''),
(7,216,216260,1,'FREDY','ARIEL ROLON FERREIRA','','5514869','0985119763','','B NAVIDAD ES HIJO DEL ELECTRICICTA ESTELVINO ROLON','','','','','','','','',''),
(8,216,216350,1,'SILVINO','JACQUET CARDOZO','','7531611','0973644317','','TORO PIRU SITIO TIENE SU CASA A LADO  DE LA IGLESIA DIOS ES AMOR','','','','','','','','',''),
(9,218,218001,1,'LAURA','CHAPARRO TORRES','','5074649','0985159683','','ES AMIGA DE FANY Y LUCIA  VIVE EN STA ROSA  Y CRNEL OVIEDO','','','','','','','','',''),
(10,216,216260,1,'SONIA','ELENA  GAUTO ROMAN','','2983178','0984983754','','ES HERMANA DE RAMON ,TIENE SU CASA LADO MISMO','','','','','','','','',''),
(11,216,216350,1,'MARIANO','GAMARRA ACOSTA','','4338450','0984707255','','TORO PIRU 2 6KM MANO DERECHA CASA MADERA COLOR VERDE','','','','','','','','',''),
(12,216,216350,1,'ALEXIS','AYALA ARANDA','','7117211','0976849414','','MORUMBI 2 PASANDO COMERCIAL EL SOL MANO DERECHA','','','','','','','','',''),
(13,216,216260,1,'SANTIAGO','PAREDES','S/N','3347595','0984105664','S/N','FRENTE MISMO DE LA CASA DE LA SRA FATIMA MEDINA','S/N','S/N','S/N','S/N','S/N','S/N','S/N','S/N',NULL),
(14,216,216400,1,'SAN ISIDRO','PERFORACIONES','S/N','940158','0985526884','S/N','SU DUEÑO ES EL SR ARNALDO MARTINEZ','S/N','S/N','S/N','S/N','S/N','S/N','S/N','S/N',NULL),
(15,216,216001,1,'BLAS','ANTONIO TORREZ GONZALEZ','','3804880','0971438485','','GUAJAYVI CENTRO ENTRAR FRENTE MISMO DE PETROPAR','','','','','','','','',''),
(16,216,216340,1,'HN','HIDRAULICOS','','6289029','0984580148','','CALLE SAN JOSE SU DUEÑO ES EL SR EVANDRO DE MOURA','','','','','','','','',''),
(17,216,216350,1,'ELIEZER','ROA VILLALBA','','5780855','0975363442','','ESQUINA MOROMBI 1, ES EL HIJO DE VICENTE ROA','','','','','','','','',''),
(18,216,216260,1,'NARCISO','BENITEZ','','7617600','0984978854','','TRABAJA EN FERPAR Y SAN ISIDRO ELECTRODOMESTICOS','','','','','','','','',''),
(19,216,216260,1,'FELICIA','SAMANIEGO','','4413209','0975321436','','ES ESPOSA DE DIONICIO LOPEZ','','','','','','','','',''),
(20,203,203240,1,'IGNACIA','DAMIANA BENITEZ DE GONZALEZ','S/N','7391773','0985391157','S/N','LIBERACION SANTA HELENA.','S/N','S/N','S/N','S/N','S/N','S/N','S/N','S/N',NULL),
(21,216,216260,1,'MONICA','GERDING CANDIA','','6044087','0972834135','','VECINA DE LILIAN ZARACHO','','','','','','','','',''),
(22,216,216260,1,'LIZ','CAROLINA TORRES SANGUINA','','6955774','0976909051','','TIENE SU CASILLA EN LA ESQUINA DE NAVIDAD','','','','','','','','',''),
(23,216,216260,1,'PABLINA','BEATRIZ RODRIGUEZ GUILLEN','','7191697','0971431521','','FRENTE MISMO DE NAVIDAD CELL','','','','','','','','',''),
(24,216,216350,1,'SINDULFO','RAMON GONZALEZ AREVALOS','','4053938','0983190503','','SU CASA QUEDA EN EL FONDO DE ARIFAN','','','','','','','','',''),
(25,216,216170,1,'CECILIA','ALVAREZ','','3543222','+5491125894298','','ES LA MAMA DE GABRIEL','','','','','','','','',''),
(26,216,216400,1,'LEILA','EDITH RAMIREZ GARCIA','','5354902','0985647155','','CALLE SAN JOSE MANO IZQUERDA 2 CASA ANTES DE ARIEL ZABALA','','','','','','','','',''),
(27,107,107001,1,'MYRIAN','ADELA ARANDA MALDONADO','','5766211','','','','','','','','','','','',''),
(28,216,216350,1,'ELENA','ESCOBAR','','4886764','0971464336','','ES DOCTORA VIVE EN EL FONDO DE ARIFAN','','','','','','','','',''),
(29,1115,1115002,1,'EDGAR','RIVAROLA','','3410648','0981459276','','','','','','','','','','',''),
(30,216,216350,1,'GERBACIO','RAMON GONZALEZ','','7385084','0982326883','','MORUMBI 2 ENTRANDO UNOS 700MTS DEL ASFALTADO','','','','','','','','',''),
(31,216,216260,1,'ESTEBAN','ZARACHO MEDINA','','4399604','0986283998','','','','','','','','','','',''),
(32,216,216260,1,'CAROLINA','BOGADO','','3585499','0986856482','','ES LA ESPOSA DE KUKA','','','','','','','','',''),
(33,216,216400,1,'LAURA','ELIZABETH ROJAS','','4545132','0973809416','','ES LA ESPOSA DE SERGIO GIMENEZ','','','','','','','','',''),
(34,216,216540,1,'BLANCA','MARTINEZ CARISIMO','','6363968','0972774381','','ES LA ESPOSA DE DE LEON HECTOR RAMON','','','','','','','','',''),
(35,216,216260,1,'ELOIDA','ENRIQUEZ GARCIA','','4387302','0981823057','','ES LA HERMANA DE REBECA','','','','','','','','',''),
(36,216,216350,1,'RONALDO','MARTINEZ LOPEZ','','6296794','0982138058','','FRENTE INPASA ES EL HIJO DE BLANCA LOPEZ','','','','','','','','',''),
(37,216,216260,1,'TEODOLINA','ACUÑA SOSA','','4277361','0974302873','','ES LA CUÑADA DE REBECA','','','','','','','','',''),
(38,216,216170,1,'EUGENIA','CENTURION','','2293219','0993339448','','ES LA MAMA DE AURELIANA','','','','','','','','',''),
(39,216,216350,1,'LIDIA','MARIANA TORRES CACERES','','3957409','0983948432','','A 10KM DEL ASFALTADO MANO IZQUERDA','','','','','','','','',''),
(40,216,216350,1,'MARIO','BENITEZ','','2447092','0984267002','','A 300MTS DEL ASFALTADO','','','','','','','','',''),
(41,216,216400,1,'MARIA','LUISA VERA CACERES','','6121800','0982399804','','ES LAHERMANA DE JORGE VERA','','','','','','','','',''),
(42,216,216350,1,'FELIX','LOPEZ DIAZ','','4649718','0985146585','','A 3KM DEL ASFALTADO','','','','','','','','',''),
(43,216,216340,1,'NATIVIDAD','DE JESUS ALVAREZ','','2687532','0982809429','','ES LA ABUELA DE GABRIEL','','','','','','','','',''),
(44,216,216450,1,'VILMA','MARTINEZ BLANCO','','3006106','0982408650','','ES LA HIJA DE CRISTINA BLANCO','','','','','','','','',''),
(45,216,216400,1,'CAYO','HUGO CORONEL','','5104997','0975844866','','CALLE SAN MIGUEL ENTRANDO UNOS 1500MTS','','','','','','','','',''),
(46,216,216350,1,'RODRIGO','LOPEZ','','7033956','0986292583','','PRIMERA LINEA MORUMBI','','','','','','','','',''),
(47,216,216350,1,'VIRGINIA','AMARILLA','','1683261','0983648880','','A 3 CASA DE ARIFAN','','','','','','','','',''),
(48,216,216460,1,'LUCIA','CANTERO VDA DE ENCISO','','3460619','0985692411','','SAN MIGUEL FRENTE DE LA IGLESIA','','','','','','','','',''),
(49,1301,1301012,1,'ELVA','AMADA CRISTALDO','','2170950','0992225166','','VENDEDORA DE ROMANCE','','','','','','','','',''),
(50,216,216360,1,'VIRGINIA','MOLAS DE MARTENS','','1849853','0981961719','','ES LA MAMA DE JUAN MARTENS 2 CASA ANTES DE GASUR','','','','','','','','',''),
(51,216,216340,1,'LUIS','MARECOS SANABRIA','','6121674','0983298975','','TIENE LAVADERO EN LA CURVA MISMO DE SAN JOSE','','','','','','','','',''),
(53,216,216400,1,'PEDRO','ZELAYA CHAVEZ','','1465926','0985265157','','ES CAMIONERO VIVE CERCA DE POHA RAITY','','','','','','','','',''),
(54,216,216340,1,'MARIA','FATIMA AGUILAR AGUILERA','','6233783','0982596974','','ES LA CUÑADA DE NATY GONZALEZ','','','','','','','','',''),
(55,216,216260,1,'LUIS','ALBERTO CAÑETE ANTUNEZ','','5205172','0975726647','','ES  EL MARIDO DE ELDA BENITEZ','','','','','','','','',''),
(56,216,216350,1,'FREDY','AGUIRRE LOPEZ','','7007972','0982305944','','VIVE EN LIBERACION','','','','','','','','',''),
(57,216,216350,1,'LUIS','MIGUEL VERA FERNANDEZ','','7047202','0986110423','','MORUMBI 2 CALLE A LA SUBESTATICA','','','','','','','','',''),
(58,216,216260,1,'ANTONIA','BENITEZ GIMENEZ','','3684249','+34665139514','','ES LA HIJA DE KAI SILVINO BENITEZ','','','','','','','','',''),
(59,216,216400,1,'VICTOR','RAMON GARCIA DELVALLE','','6021459','0984446270','','TIENE SU TALLER QUE SE LLAMA EL TRONCO','','','','','','','','',''),
(60,217,217400,1,'FREDDI','RAUL DUARTE GIMENEZ','','2678488','','','TIENE SU VENTA DE ELECTRO ES EL AMIGO DE JAIME SALINAS','','','','','','','','',''),
(61,216,216260,1,'NELIDA','ACOSTA CUBILLA','','3365185','0972522767','','VIVE EN FRENTE DE LA CASADE KAI LOPE','','','','','','','','',''),
(62,216,216999,1,'NINFA','DIANA RODAS BOBADILLA','','6766920','0984735499','','PASANDO LA LOMADA','','','','','','','','',''),
(63,216,216400,1,'EVER','RODRIGUEZ GOMEZ','','5086234','0984251961','','CERCA DE LA ESCUELA BSP TIENE VENTA DE MOTO REPUESTO','','','','','','','','',''),
(64,216,216350,1,'ARSENIO','CHAPARRO','','3901999','0975342477','','TRABAJA EN INPASA ALQUILA LA CASA DE ACHITO','','','','','','','','',''),
(65,216,216260,1,'TERESA','FALCON DE MONTIEL','','2610698','0985528048','','HIJA DE JOSEFA CACERES DE FALCON','','','','','','','','',''),
(66,216,216350,1,'ALFREDO','RAMIREZ','','5432750','0982373532','','','','','','','','','','',''),
(67,216,216340,1,'EDUARDO','CACERES ZABALA','','5286893','0981335615','','VIVE  CERCA DE PERFORACIONES SAN ISIDRO','','','','','','','','',''),
(68,203,203380,1,'ANTELL','TIGO S.A','','80021940','','','CHORE','','','','','','','','',''),
(69,1,1001,1,'MIGUEL','ORTEGA','','1843031','0981410771','','VENDEDOR INVERFIN','','','','','','','','',''),
(70,203,203380,1,'CARLOS','VEGA BENITEZ','','4405461','','','VIVE EN CHORE','','','','','','','','',''),
(71,216,216260,1,'ROSANA','ZARACHO','','3640382','0984189533','','A LADO MISMO DE PETROCHACO','','','','','','','','',''),
(72,216,216260,1,'ERICO','MANUEL JARA MERCADO','','5912902','0981790609','','TRES CASAS DESPUES DE LILIAN ZARACHO','','','','','','','','',''),
(73,216,216350,1,'ROSA','ISABEL ARANDA BRITEZ','','4105731','0985998970','','ES LA CUÑADA DE LAURA PATIÑO','','','','','','','','',''),
(74,216,216350,1,'BERTA','ALMADA BENITEZ','','6348534','0983603119','','FRENTE DE LA ESTANCIA SANTA CECILIA','','','','','','','','',''),
(75,216,216350,1,'LIZA','OTAZU ALMADA','','7017814','0983603119','','ES LA HIJA DE BERTA ALMADA','','','','','','','','',''),
(76,216,216350,1,'LEONARDO','BERNAL PERALTA','','5432759','0986628081','','CUARTA LINEA','','','','','','','','',''),
(77,216,216350,1,'EDUARDO','NUÑEZ PEREZ','','5880908','0981827531','','ES EL HERMANO DE LA CUÑADA DE JESSICA DUARTE','','','','','','','','',''),
(78,1101,1101001,1,'ALFREDO','TABOADA','','5101277','0985188793','','ES CAMIONERO','','','','','','','','',''),
(79,216,216260,1,'DEISY','FABIOLA VARGAS MEDINA','','5921820','','','ES LA ESPOSA DE OSDEN','','','','','','','','',''),
(80,216,216260,1,'RODE','ENRIQUEZ GARCIA','','5773368','0986785180','','ES LA HERMANA DE REBECA','','','','','','','','',''),
(81,216,216400,1,'CEFERINO','ESPINOLA','','3495993','0981204264','','','','','','','','','','',''),
(82,216,216400,1,'DANIEL','MARTINEZ NOGUERA','','3529827','0981329074','','ES EL ESPOSO DE TOMASA MEZA','','','','','','','','',''),
(83,216,216350,1,'ALBERTO','BERNAL PERALTA','','6893974','0983732644','','MORUMBI 4TA LINEA','','','','','','','','',''),
(84,216,216260,1,'MIRTHA','ZUNILDA BENITEZ MEDINA','','2309180','0984801148','','ES LA HIJA DE TIA BARSI','','','','','','','','',''),
(85,216,216350,1,'ADOLFO','GONZALEZ','','5896651','0983873332','','TORO PIRU 1 A 1KM DEL ASFALTADO','','','','','','','','',''),
(86,216,216350,1,'JOSE','RAMON ECHEVERRIA PINHO','','5095471','0983893781','','TORO PIRU SITIO AL FONDO DE NECO','','','','','','','','',''),
(87,216,216350,1,'CATALINA','CACERES GARCIA','','4579340','0984156265','','MORUMBI 2DA LINEA','','','','','','','','',''),
(88,216,216350,1,'MILCIADES','GARCETE ROMAN','','6078479','0972464870','','TORO PIRU 1 A 1200MTS DEL ASFALTADO','','','','','','','','',''),
(89,216,216400,1,'LIZ','AMALIA PEREIRA PERALTA','','6121748','0975973613','','BARRIO SAN PERDRO NIÑO JESUS','','','','','','','','',''),
(90,216,216350,1,'YISSEL','DAVALOS','','5866156','0984637798','','FRENTE MISMO DE MORUMBI 1RA LINEA','','','','','','','','',''),
(91,216,216260,1,'JORGE','LUIS PEZOA MARTINEZ','','5346209','0983723655','','EN SU LOCAL ESTA ESTEBEN BARBERSHOP','','','','','','','','',''),
(92,216,216350,1,'RAFAELA',' PEREIRA DE VILLALBA','','1902773','0984651660','','MORUMBI 2 A 10KM DEL ASFALTADO ES LA SUEGRA DE IDALINA INSFRAN','','','','','','','','',''),
(93,216,216260,1,'ADA','MARLENE BRITOS LOPEZ','','6287308','0986144177','','B NAVIDAD EN EL FONDO DE FERRETERIA NIÑO JESUS','','','','','','','','',''),
(94,216,216260,1,'MARIO','LUIS BENITEZ NUÑEZ','','5424197','0981590162','','ES EL ESPOSO DE LORENZA PAREDES','','','','','','','','',''),
(95,216,216260,1,'ALDER','JOANI INSFRAN GONZALEZ','','7018001','+34603226589','','EN FRENTE MISMO DE LA USF DE NAVIDAD','','','','','','','','',''),
(96,216,216350,1,'JULIO','CANDIA','','1268643','0985181730','','ES EL HERMANO DE FELIPE CANDIA','','','','','','','','',''),
(97,216,216350,1,'ABISMAEL','AYALA ARANDA','','7040177','0975978342','','','','','','','','','','',''),
(98,216,216350,1,'ESTEBEN','CANDIA FALCON','','7017692','0972976075','','ES EL HIJO DE FELIPE CANDIA','','','','','','','','',''),
(99,216,216350,1,'FERNANDO','ARIEL GAUTO ROMAN','','6362224','0986890216','','ES EL HIJO DE RAMON GAUTO','','','','','','','','',''),
(100,216,216260,1,'VILMA','ROJAS ROMERO','','3217533','0975869045','','A LADO MISMO DE TALLER DE MOTO LA ESTRELLA','','','','','','','','',''),
(101,216,216350,1,'JOEL','GERDING ROLON','','5346204','0983593226','','A 8KM MANO IZQUERDA CASI FRENTE IDALINA INSFRAN','','','','','','','','',''),
(102,216,216400,1,'ARNALDO','FRANCO LEIVA','','5831492','0975929350','','ES EL AMIGO DE JUAN DE LA CRUZ  TRABAJA EN PROEL','','','','','','','','',''),
(103,216,216350,1,'DELFINA','ORTIZ GOMEZ','','2475767','0985394484','','ES LA MAMA DE FLORENTIN CELL','','','','','','','','',''),
(104,216,216350,1,'LIDER','MARTINEZ GONZALEZ','','7011981','0984145218','','MORUMBI A 6KM','','','','','','','','',''),
(105,216,216350,1,'SONIA','ZORRILLA BAREIRO','','3444853','0982482868','','ES LA TIA DE VIVIANA GONZALEZ ZORRILLA','','','','','','','','',''),
(106,216,216130,1,'EDILBERTO','ZARATE VAZQUEZ','','5319378','0971701137','','VIVE EN SAN RAMON }','','','','','','','','',''),
(107,216,216260,1,'BERNARDINA','AGUILERA DIAZ','','5864871','0984513097','','MOROMBI 2 EN FRENTE DE PERLA GIMENEZ','','','','','','','','',''),
(108,216,216350,1,'GLADYS','TORRES GONZALEZ','','5976931','0984611110','','MOROMBI 2','','','','','','','','',''),
(109,216,216260,1,'MARY','ROCIO OLMEDO CACERES','','6567400','0985324186','','HIJA DE LALO OLMEDO','','','','','','','','',''),
(110,216,216350,1,'FABIO','VICENTE FERREIRA VERA','','6227881','0971311018','','','','','','','','','','',''),
(111,216,216260,1,'CARLOS','ZARACHO MEDINA','','4903353','0982643302','','','','','','','','','','',''),
(112,216,216350,1,'MARIA','ISABEL VELAZQUEZ RODRIGUEZ','','6693849','0975482381','','ES LA SOBRINA DE LUCIA GARCIA','','','','','','','','',''),
(113,216,216400,1,'NIDIA','AGULERA','','2350336','0981311780','','ES LA ESPOSA DE BARTOLO ZABALA','','','','','','','','',''),
(114,216,216300,1,'JOSE','ADRIANO DOMINGO','','8004195','0976545914','','TRABAJA EN LA ESTANCIA 2 TAUROS','','','','','','','','',''),
(115,216,216260,1,'ABEL','GERDING','','4749782','0982283855','','','','','','','','','','',''),
(116,216,216350,1,'CRISTINO','OTAZU','','4349808','0983173315','','','','','','','','','','',''),
(117,216,216260,1,'GLORIA','ZARACHO DE GAUTO','','4383498','0982958070','','','','','','','','','','',''),
(118,216,216350,1,'FIDELINA','ARRUA SANABRIA','','7543849','0971840045','','TRABAJA EN ÑA VIKY','','','','','','','','',''),
(119,216,216350,1,'NILSA','BENITEZ CABALLERO','','5123167','0983994701','','ES LA HERMANA DE ELVIO BENITEZ CABALLERO','','','','','','','','',''),
(120,216,216350,1,'CELSA','CUEVAS LOPEZ','','5887318','0975255115','','ES LA PRIMA DE ANGEL JAVIER BAEZ (MORENO)','','','','','','','','',''),
(121,216,216400,1,'ALFREDO','BASILICO MARECOS','','7014119','0982518285','','ES EL HIJO DE TACHUE','','','','','','','','',''),
(122,216,216400,1,'LIZ','FABIOLA CACERES VILLALBA','','7017806','0993334440','','ES LA HIJA DE EVER CACERES VIVE FRENTE DE NATY GONZALEZ','','','','','','','','',''),
(123,214,214210,1,'FABIOLA','TORRES SANABRIA','','6992398','0971515963','','SANGUINA KUE ES LA CUÑADA DE NELSON (AMIGO KALO)','','','','','','','','',''),
(124,1403,1403170,1,'JORGE','ENCISO','','4012796','0984406930','','ES EL MARIDO DE REBECA ENRIQUEZ','','','','','','','','',''),
(125,216,216350,1,'PASCUALA','PEREIRA DE CANDIA','','1772143','0976587789','','VIVE DETRAS DE ARIFAN COBRA TERCERA EDAD','','','','','','','','',''),
(126,203,203390,1,'SEBASTIANA','SANCHEZ','','3712436','0973896052','','VIVE EN FRENTE MISMO DE LA CASA DE KAI LOPE','','','','','','','','',''),
(127,216,216260,1,'JACINTA','GIMENEZ DE BERNAL','','1781414','','','ES LA MAMA DE ERCILIA BERNAL','','','','','','','','',''),
(128,203,203310,1,'CYNTHIA','MABEL PAEZ OLMEDO','','4755715','0976549915','','TRABAJA EN ACENOR','','','','','','','','',''),
(129,216,216350,1,'NEDER','ALCIDES BAEZ ESQUIVEL','','4392968','0975514679','','','','','','','','','','',''),
(130,216,216310,1,'MILDER','ALCIDES CARDOZO','','7318877','0984569725','','TRABAJA EN CAÑETE','','','','','','','','',''),
(131,216,216300,1,'PABLINA','DUARTE','','2430213','0985223430','','ES LA SUEGRA DEL BOLIVIANO','','','','','','','','',''),
(132,216,216400,1,'JUAN','CARLOS GIMENEZ','','7017975','0982683729','','B SAN PEDRO CALLE SAN JOSE','','','','','','','','',''),
(133,216,216260,1,'KUÑA','PYAPY MBARETE','','123456','','','ES LA ESPOSA DE TI,I','','','','','','','','',''),
(134,216,216350,1,'DAMIAN','CHAPARRO IRALA','','5176455','0981322196','','TRABAJA EN INPASA','','','','','','','','',''),
(135,216,216260,1,'ROLANDO','PEREIRA','','3605405','0984461963','','ES EL HIJO DE KAI YAMBAI','','','','','','','','',''),
(136,216,216350,1,'NATALIA','GIMENEZ','','6061615','0983880685','','ES LA ESPOSA DE OLMEDO','','','','','','','','',''),
(137,216,216260,1,'HERMINIA','VAZQUEZ DE PAREDES','','2687568','0981590162','','ES LA MAMA DE LORENZA','','','','','','','','',''),
(138,216,216260,1,'CARMEN','FRANCO ARECO','','1458120','0976573559','','ES LA SUEGRA DE SEBASTIAN PAREDES','','','','','','','','',''),
(139,216,216350,1,'PAOLA','GAMARRA GONZALEZ','','7201323','','','ES LA HIJASTRA DE GUSTAVO MEDINA','','','','','','','','',''),
(140,216,216260,1,'APOLONIO','GIMENEZ','','1580511','0984207854','','ESEL HERMANO DE INO GIMENEZ','','','','','','','','',''),
(141,203,203120,1,'PABLA','LEOVIGILDA GIMENEZ','','4811711','0975887878','','','','','','','','','','',''),
(142,216,216400,1,'SILVIO','PANIAGUA','','1523370','0981369274','','A LADO ,ISMO','','','','','','','','',''),
(143,216,216400,1,'PABLINA','MENDEZ','','1940945','0976966814','','B SAN PEDRO NIÑO JESUS PASANDO LA ULTIMA LOMADA','','','','','','','','',''),
(144,216,216350,1,'LIDIO','ARMADO QUISAMA FELTES','','5326441','','','TRABAJA EN INPASA','','','','','','','','',''),
(145,216,216350,1,'LEONIDA','FONSECA GONZALEZ','','5747753','0985783063','','ES LA AMIGA DE FANY','','','','','','','','',''),
(146,216,216350,1,'MABEL','CAÑETE','','5316531','0985282380','','ES LA ESPOSA DE TANI','','','','','','','','',''),
(147,216,216350,1,'JUAN','ANTONIO ANTUNEZ','','6755915','0976161600','','ES EL YERNO DE OVIDIO BERNAL','','','','','','','','',''),
(148,216,216350,1,'ALDO','AZUAGA PAREDES','','5432749','0976261806','','ES  ELHIJO DE AMALIO AZUAGA','','','','','','','','',''),
(149,216,216350,1,'VALDOMERO','OJEDA','','1841182','','','TORO PIRU A 8KM','','','','','','','','',''),
(150,216,216150,1,'CELESTINA','CANTERO RECALDE','','797735','0972743725','','A LADO MISMO DEL COMITE DE PRODUCTORES','','','','','','','','',''),
(151,216,216350,1,'NELSON','FALCON','','5346133','0986538527','','TORO PIRU SITIO','','','','','','','','',''),
(152,216,216350,1,'EDELIO','BARETO','','4340398','','','TRABAJA EN INPASA MOTO AZUL','','','','','','','','',''),
(153,216,216350,1,'ELVIO','DIAZ','','5307517','0971921261','','ES EL HERMANO DE EULALIO DIAZ','','','','','','','','',''),
(154,216,216260,1,'NOE','ARIEL ZABALA BLANCO','','4646497','0984123508','','','','','','','','','','',''),
(155,216,216350,1,'LUIS','MIGUEL FARIÑA RUIZ','','7187201','0982556655','','TRABAJA EN CFS','','','','','','','','',''),
(156,216,216540,1,'CAYO','LILIO ORTIZ','','2231377','0971892207','','TRABAJA EN ECOMIPA','','','','','','','','',''),
(157,216,216350,1,'ESTEBAN','MIRANDA CACERES','','6705676','','','','','','','','','','','',''),
(158,216,216250,1,'AGUSTIN','ORTELLADO SALINAS','','6636660','0975940922','','TRABAJA EN MARIELA GONZALEZ Y RUBEN NOGUERA','','','','','','','','',''),
(159,216,216350,1,'MARCIANA','ROMERO FRUTOS','','4046232','0975258381','','MORUMBI 2 FRENTE DEL COLEGIO SAN MARTIN','','','','','','','','',''),
(160,203,203220,1,'MELCHISEDEC','MAS SILGUERO','','1','0976157897','','','','','','','','','','',''),
(161,216,216350,1,'CELIA','NOEMI FRUTOS VELAZQUEZ','','7245250','0981648681','','TIENE SULOCAL ES LA ESPOSADE TIO PULE','','','','','','','','',''),
(162,216,216100,1,'DAVID','JARA LOPEZ','','654321','0973411037','','ES EL AMIGO DE PAUL ZABALA','','','','','','','','',''),
(163,216,216350,1,'SILVIA','CABRAL','','4609571','0975822687','','VIVE FRENTEIMPASA','','','','','','','','',''),
(164,216,216350,1,'FATIMA','RAMIREZ','','5162450','0983963503','','TIENE SU FERRETERIA ES LA ESPOSA DE QUIÑONEZ','','','','','','','','',''),
(165,216,216350,1,'RICARDO','FALCON CACERES','','4393195','0976467862','','ES EL HIJO DE JOSEFA FALCON','','','','','','','','',''),
(166,216,216260,1,'NOELIA','RIVEROS','','4749784','','','','','','','','','','','',''),
(167,216,216340,1,'JUAN','DE LA CRUZ RAMIREZ LOPEZ','','10101010','0985366534','','','','','','','','','','',''),
(168,216,216350,1,'CHRISTIAN','DAVID CHAPARRO','','5948182','0984892264','','ES EL SOBRINODE ARSENIO CHAPARRO','','','','','','','','',''),
(169,216,216260,1,'LIDER','DELVALLE','','2101028','0986205465','','ES CAMIONERO TRABAJA EN UN TRANSGANADO','','','','','','','','',''),
(170,216,216350,1,'JORGE','ANASTACIO DUARTE BENITEZ','','5671849','0972928703','','ES EL HERMANO DE JESSICA DUARTE','','','','','','','','',''),
(171,216,216350,1,'ISABEL','CANDIA DE ACOSTA','','2687627','0986849612','','ES LA TIA DE FANY','','','','','','','','',''),
(172,216,216130,1,'DERLIS','CIRILO CUBILLA BURGOS','','4382380','0982257636','','ES POLICE','','','','','','','','',''),
(173,216,216300,1,'ALCIDES','CACERES FERNANDEZ','','4511871','0986691765','','ERA EL CLIENTE DE CHAVEZ','','','','','','','','',''),
(174,216,216350,1,'MARILINA','GONZALEZ ORTIZ','','5346190','0975348366','','ES LA MAMA DE AILEN','','','','','','','','',''),
(175,216,216260,1,'ESTANILAO','PEÑA VILLALBA','','1365731','0981720792','','ES DE NAVIDAD CELL','','','','','','','','',''),
(176,216,216350,1,'ALEXIS','FALCON SANABRIA','','7035752','0972902987','','ESEL SOBRINO DE TERESA FALCON','','','','','','','','',''),
(177,216,216350,1,'LUDY','CANDIA CABALLERO','','7073821','0994591009','','ES LA HERMANA DE FABIANA CANDIA','','','','','','','','',''),
(178,216,216290,1,'HERIBERTO','PORTILLO FARIÑA','','6308912','0986482033','','ES EL HERMANO DE CARLOS PORTILLO FARIÑA','','','','','','','','',''),
(179,216,216350,1,'JORGE','DAVID MARTINEZ','','4690563','0981719614','','TIENE UNA TOYOTA VITZ GRIS','','','','','','','','',''),
(180,216,216340,1,'MERCEDES','ALVAREZ','','5569212','0971375231','','ES LA HERMANA DE GABRIEL ALVAREZ','','','','','','','','',''),
(181,216,216350,1,'TANIA','ELIZABETH ALMONTE LOPEZ','','5559874','0976957380','','TRABAJA E INPASA','','','','','','','','',''),
(182,216,216350,1,'CLAUDEMIRA','RAMONA BORGES SEGOVIA','','3961107','0981640071','','TRABAJA SU MARIDO EN TAVARES GROUP','','','','','','','','',''),
(183,216,216350,1,'CERAFIN','AYALA GNZALEZ','','1907250','0975263332','','MORUMBI 5TA LINEA','','','','','','','','',''),
(184,216,216350,1,'GLADYS','DUARTE ENCISO','','5200935','0986672368','','ES LA HERMANA DE CARLOS DUARTE','','','','','','','','',''),
(185,216,216350,1,'DAHIANA','ACOSTA','','5552528','0982842703','','ES LA PRIMA DE REBECA','','','','','','','','',''),
(186,216,216400,1,'GENARA','BENITEZ SORIA','','6651499','0986647426','','A LADO MISMO DE CENTRO DE SALUD','','','','','','','','',''),
(187,216,216350,1,'JORGE','DARIO INSFRAN','','5776112','0984161308','','','','','','','','','','',''),
(188,216,216350,1,'AGUSTINA','GALEANO CAMACHO','','4851402','0976491540','','VIVE DE TRAS DE CENTRO DE SALUD 5TA LINEA','','','','','','','','',''),
(189,216,216350,1,'LUCIA','GARCIA VELAZQUEZ','','5255850','0976998510','','A LADO MISMO DE ARIFAN','','','','','','','','',''),
(190,216,216350,1,'EULOGIO','GONZALEZ SAMANIEGO','','1996197','0975798153','','VENDEDOR DE TELE BINGO','','','','','','','','',''),
(191,216,216350,1,'REINALDO','RAMIREZ VERA','','5470599','0984421803','','TRABAJAEN TAVARES GROUP','','','','','','','','',''),
(192,216,216260,1,'ANA','DE JESUS PAREDESDE MENCIA','','2139259','0971427753','','ES LA ESPOSA DE CHAPI','','','','','','','','',''),
(193,216,216350,1,'ENRIQUE','BENITEZ BENITEZ','','4043690','0984403916','','EX DE ROSA MEZA','','','','','','','','',''),
(194,216,216350,1,'SILVIA','GOMEZ','','6197848','0971975672','','TRABAJA EN RAPIDITO INPASA','','','','','','','','',''),
(195,216,216350,1,'CESAR','AZUAGA GAMARRA','','7830623','0983210958','','ES EL HIJO DE SEBASTIAN AZUAGA','','','','','','','','',''),
(196,216,216350,1,'MARENISE','BERWANGER DE PILTZ','','6085732','0982827738','','VIUDA DE DONECO','','','','','','','','',''),
(197,216,216350,1,'GLORIA','EMILCE CRISTALDO','','2377164','','','ESPOSA DE MATEO VERA','','','','','','','','',''),
(198,216,216290,1,'EMILIA','ALVARENGA CAMACHO','','7714679','0976464497','','ES LA NOVIA DEL HIJO DE PELAGIA','','','','','','','','',''),
(199,216,216350,1,'JOSEFINA','ALMADA','','5316513','0986332727','','ES LA HNA DE BERTAALMADA','','','','','','','','',''),
(200,216,216350,1,'ALEJO','BERNAL AYALA','','3270549','0984656475','','MORUMBI 4TA LINEA','','','','','','','','',''),
(201,216,216350,1,'ESTEFANIA','LOPEZ BERNAL','','6750473','0971721764','','MORUMBI 2 1RA LINEA','','','','','','','','',''),
(202,216,216350,1,'CRISTINO','FARIÑA NOGUERA','','7086152','0976405899','','ES EL SOBRINO DE RUBEN NOGUERA','','','','','','','','',''),
(203,216,216400,1,'CRISTINA','FRETES FONSECA','','6341649','0983782721','','SU MARIDO TRABAJA EN INPASA','','','','','','','','',''),
(204,216,216350,1,'ANGEL','JAVIER BAEZ ESQUIVEL','','5352449','0975280233','','LOMBI','','','','','','','','',''),
(205,216,216350,1,'MARIA','LUISA VIANA LOPEZ','','5051564','','','TRABAJA EN INPASA','','','','','','','','',''),
(206,216,216350,1,'LIMPIA','CONCEPCION CHENA','','3616146','0984319567','','ES LA ESPOSA DEL CHAPISTA DE TAVARES','','','','','','','','',''),
(207,203,203380,1,'ADA','GUILLERMINA DAVALOS','','5017985','0982931446','','VIVE EN EL PORTAL','','','','','','','','',''),
(208,216,216260,1,'JUAN','ANTONIO ESPINOZA','','4117911','0975935752','','TRABAJA EN PETROCHACO','','','','','','','','',''),
(209,216,216350,1,'EMIGDIO','VELAZQUEZ','','3449408','0985915980','','ES EL HERMANO DE LUCIA VECI','','','','','','','','',''),
(210,216,216350,1,'RAMONA','LETICIA AZCONA AZCONA','','5810240','0983831667','','MORUMBI 2 A 2500MTS','','','','','','','','',''),
(211,216,216350,1,'LIZ','MARINA BOGADO BOGADO','','7163948','','','ES LA YERNA DE MATEO VERA','','','','','','','','',''),
(212,216,216260,1,'PELAGIA','MARTINEZ','','1020306','0971149236','','TINE CASILLA','','','','','','','','',''),
(213,216,216350,1,'AGUSTIN','LOPEZ SEGOVIA','','3942874','0983424121','','TRABAJA EN FRENTE DE INPASA','','','','','','','','',''),
(214,216,216400,1,'ISMAEL','BENITEZ TROCHE','','4928467','0973632848','','','','','','','','','','',''),
(215,216,216350,1,'CARMEN','RECALDE','','2944841','0985457132','','ES LA ESPOSA DE PELE,I','','','','','','','','',''),
(216,216,216350,1,'BERNARDO','NOGUERA','','1893648','0971336721','','TIENE LA FERRETERIA MORUMBI','','','','','','','','',''),
(217,216,216350,1,'ESMANUEL','NUÑEZ PEREZ','','5749711','0975939438','','ES EL HNO DE EDUARDO NUÑEZ','','','','','','','','',''),
(218,216,216100,1,'ELIZABETH','ARROYO MOROTI','','7261873','09726683305','','VIVE EN ARROYO MOROTI EX CLIENTE LICENCIADA NOEMI','','','','','','','','',''),
(219,216,216350,1,'LILIAN','MIRELLA CESPEDES ALFONSO','','4650831','0985241648','','AHORA ESTA EN EL CHACO','','','','','','','','',''),
(220,216,216001,1,'LUIS','JAVIER GIMENEZ BOBADILLA','','934462','0992516046','','','','','','','','','','',''),
(221,203,203380,1,'CARLOS','ALBERTO VALDEZ','','4230806','0971256307','','TRABAJA EN LA ESTANCIA SANTA CECILIA','','','','','','','','',''),
(222,216,216350,1,'RUPERTO','BENITEZ','','1652824','0983218723','','','','','','','','','','',''),
(223,216,216350,1,'FREDY','JAVIER LOPEZ JARA','','6311425','0982680097   0986339','','','','','','','','','','',''),
(224,216,216350,1,'JOSEFA','CACERES FALCON','','1522107','0981934043','','ES LA MAMA DE TERESA','','','','','','','','',''),
(225,216,216350,1,'MIRTA','ZORRILLA BAREIRO','','2261105','09985351686','','ES LA  MAMA DE MARIELA GONZALEZ','','','','','','','','',''),
(226,216,216350,1,'ROMUALDO','ROTELA','','4002828','','','ES EL MARIDO  DE BLANCA OLMEDO','','','','','','','','',''),
(227,216,216350,1,'ROSANA','AZUAGA GAMARRA','','6673984','0984500642','','','','','','','','','','',''),
(228,216,216350,1,'ARIEL','TORRES','','4367487','','','','','','','','','','','',''),
(229,216,216350,1,'ISIDRO','ACOSTA ALMIRON','','5303418','0982875916','','ES EL CUÑAO DE MARIO MARTINEZ','','','','','','','','',''),
(230,216,216350,1,'ALBERTO','ROMERO FRUTOS','','4844965','0983965260','','ES EL HERMANO DE MARCIANA ROMERO FRUTOS','','','','','','','','',''),
(231,216,216350,1,'ANASTACIA','MARECO CABRAL','','4511030','0984920419','','ESTA EN LA CALLE DE VIVIANA','','','','','','','','',''),
(232,216,216350,1,'TERESA','RAMONA MERCADO DE JARA','','1314796','09833801847','','ES LA MAMA DE ERICO JARA MERCADO','','','','','','','','',''),
(233,216,216280,1,'SILVIO','AYALA FERNANDEZ','','3965381','0973992982','','','','','','','','','','',''),
(234,216,216350,1,'FELIPE','CANDIA','','789456','0975334905','','','','','','','','','','',''),
(235,216,216350,1,'MARIA','GUADALUPE TROCHE VERA','','5178105','0975979539','','ES LA HNA DE JINA VICTORIA','','','','','','','','',''),
(236,216,216260,1,'IRENE','VERA VERA','','4725342','0975836974','','ES LA HNA DE TI,I','','','','','','','','',''),
(237,216,216340,1,'JUAN','ALBERTO MARTENS MOLAS','','2487455','0971523057','','','','','','','','','','',''),
(238,216,216350,1,'LEOVIGILDO','MIRANDA','','1907239','0982455505','','ES EL PAPA DE GORDO','','','','','','','','',''),
(239,216,216350,1,'EDGAR','FARIÑA OJEDA','','3823945','0986573103','','','','','','','','','','',''),
(240,216,216350,1,'VIDAL','ALFONSO','','3486371','0985891951','','','','','','','','','','',''),
(241,216,216130,1,'EDIT','HERMELINDA CAÑETE ALMADA','','6232886','0971565102','','ES LA ESPOSA DE ROLI PEREIRA YAMBAI','','','','','','','','',''),
(242,216,216260,1,'ELADIO','ESTECHE NEGRETE','','1585542','','','','','','','','','','','',''),
(243,216,216350,1,'NILSA','SARA INSFAN GONZALEZ','','4781588','0981641045','','ES LA MAMA DE ALEJANDRO','','','','','','','','',''),
(244,216,216001,1,'PATRICIA','ANTONIA FERREIRA VERA','','852741','','','','','','','','','','','',''),
(245,216,216540,1,'HECTOR','RAMON DE LEON','','852147','','','TRABAJA EN LA ESTANCIA SANTA ASUNCION','','','','','','','','',''),
(246,216,216350,1,'MARIA','ELISA SANBRIA LOPEZ','','4349747','09825178995','','VIVE FRNTE MISMO DEL COLEGIO AGROPECUARIO','','','','','','','','',''),
(247,216,216350,1,'PEDRO','AZUAGA GAMARRA','','7825864','0975975406','','','','','','','','','','',''),
(248,203,203120,1,'FEDERICO','CASTILLO ESQUIVEL','','4741020','0975393615','','TRABAJA EN INPASA','','','','','','','','',''),
(249,216,216350,1,'CESAR','LOPEZ DIAZ','','5575434','0983939237','','ES EL HERMANO DE FELIX LOPEZ','','','','','','','','',''),
(250,216,216350,1,'CAROLINA','CANDIA FALCON','','7018135','','','','','','','','','','','',''),
(251,216,216350,1,'TEODORA','MARTINEZ BRITOS','','3440247','0976422368','','','','','','','','','','',''),
(252,216,216001,1,'PELE,I','PELE,I','','525252','12333','','','','','','','','','','',''),
(253,216,216350,1,'EVARISTO','RAMON ORTIGOZA','','2885896','0986461410','','','','','','','','','','',''),
(254,216,216350,1,'BENICIO','BENITEZ FLEITAS','','4781462','','','','','','','','','','','',''),
(255,216,216350,1,'MERCEDES','PANIAGUA OTAZU','','3958476','0982755899','','','','','','','','','','',''),
(256,216,216350,1,'JOEL','OTAZU BENITEZ','','6202633','0984636808','','','','','','','','','','',''),
(257,216,216350,1,'EUSTACIA','ESTELA RIVAS MEDINA','','3292402','0982702708','','','','','','','','','','',''),
(258,216,216350,1,'ANIBAL','AYALA AZUAGA','','2687679','0973599924','','','','','','','','','','',''),
(259,216,216260,1,'EULALIO','FERNANDEZ GENEZ','','7562937','0981732817','','','','','','','','','','',''),
(260,216,216260,1,'GLADYS','PEREIRA','','1742541','0975953889','','','','','','','','','','',''),
(261,216,216400,1,'MERCEDES','BELEN GALEANO','','4868408','0973502188','','','','','','','','','','',''),
(262,216,216350,1,'SERAFIN','MARTINEZ SERVIN','','3602504','0983842918','','','','','','','','','','',''),
(263,216,216350,1,'JOSE','RAMON LOPEZ','','3881432','0985234999','','','','','','','','','','',''),
(264,216,216350,1,'ALCIDES','FALCON CACERES','','3038445','0975345566','','','','','','','','','','',''),
(265,216,216350,1,'FERNANDO','ANDRES FRANCO ACOSTA','','4969313','0974503907','','ES AMIGO DE FRDY AGUIRRE','','','','','','','','',''),
(266,216,216260,1,'OVIDIO','CARDOZO LOPEZ','','3407127','0984348570','','','','','','','','','','',''),
(267,216,216350,1,'MARIA','DEL ROSARIO LOPEZ AREVALOS','','2944749','0986288966','','','','','','','','','','',''),
(268,216,216350,1,'BLANCA','VIVIANA JARA SANTACRUZ','','6381861','0974573352','','','','','','','','','','',''),
(269,216,216350,1,'MARTIN','VILLALBA MENDOZA','','3232920','0982988009','','','','','','','','','','',''),
(270,216,216350,1,'FELICITA','MARTINEZ','','3768052','','','','','','','','','','','',''),
(271,216,216350,1,'FEDERICO','ALMADA BENITEZ','','2696487','0981530028','','','','','','','','','','',''),
(272,216,216340,1,'CESAR','FRANCO SEGOVIA','','6800173','0973853310','','','','','','','','','','',''),
(273,216,216350,1,'NERY','GARCIA MACIEL','','2813996','0985389919','','','','','','','','','','',''),
(274,216,216350,1,'LUCINA','NUÑEZ LUGO','','5731802','0986174486','','','','','','','','','','',''),
(275,216,216130,1,'EZEQUIEL','CHAPARRO FRANCO','','5492147','0973642184','','','','','','','','','','',''),
(276,203,203160,1,'LIZ','MABEL CAMPUZANO GODOY','','6046630','0971476456','','','','','','','','','','',''),
(277,216,216350,1,'MIRNA','MARTINEZ GONZALEZ','','6785922','0984540628','','','','','','','','','','',''),
(278,216,216350,1,'MIGUEL','ANGEL DUARTE MORINIGO','','5996052','0975329161','','','','','','','','','','',''),
(279,216,216350,1,'CARLOS','ALARCON RODAS','','1327423','0984468707','','','','','','','','','','',''),
(280,216,216350,1,'CARINA','NOGUERA','','44596410','0976912907','','','','','','','','','','',''),
(281,216,216350,1,'CENEN','VILLASANTI MEZA','','2093171','0985831384','','','','','','','','','','',''),
(282,216,216350,1,'JEREMIA','FLORENTIN ORTIZ','','4941520','0971590137','','','','','','','','','','',''),
(283,216,216350,1,'AMALIA','LOPEZ ALARCON','','4764500','0981974582','','','','','','','','','','',''),
(284,216,216400,1,'REINILDA','CORONEL','','4252612','0984135225','','','','','','','','','','',''),
(285,216,216260,1,'ADALBERTO','CABELLO','','876507','0983929684','','TRABAJA EN CREDITO AGRICOLA','','','','','','','','',''),
(286,216,216260,1,'WILSON','DANIEL CABELLO PESOA','','7505344','0972885760','','ES EL HNO DE FABIO.I','','','','','','','','',''),
(287,216,216350,1,'FRANCISCO','CANDIA BOGADO','','5231877','0972738180','','ES EL CUÑADO DE MILAGROS','','','','','','','','',''),
(288,216,216350,1,'MARY','LIZ AYALA ARANDA','','7040250','0983257084','','','','','','','','','','',''),
(289,216,216350,1,'ESTELVINO','ROLON','','2823229','0981770869','','','','','','','','','','',''),
(290,216,216350,1,'JUAN','DE LA CRUZ RAMIREZ','','1188789','0981573922','','','','','','','','','','',''),
(291,214,214310,1,'IGNACIO','TORRES SANABRIA','','5161430','0982603863','','','','','','','','','','',''),
(292,216,216350,1,'MARLENE','ALVARENGA','','6082473','0985390196','','','','','','','','','','',''),
(293,216,216350,1,'GABRIELA','VERA ALMIRON','','3023501','0983376637','','','','','','','','','','',''),
(294,216,216350,1,'JUAN','JOSE ROTELA','','3854677','0982687916','','','','','','','','','','',''),
(295,216,216350,1,'MIGUEL','AYALA FERNANDEZ','','7831545','0984670115-097591906','','','','','','','','','','',''),
(296,216,216350,1,'WILFRIDO','BENITEZ CABALLERO','','4651244','0976594138','','','','','','','','','','',''),
(297,216,216350,1,'ANGELINA','ALVARENGA','','3960306','0983865421','','','','','','','','','','',''),
(298,216,216260,1,'FATIMA','PESOA','','4903372','0984978123','','','','','','','','','','',''),
(299,216,216400,1,'RUTILIA','MARECOS FLEITAS','','3319399','0985403237','','','','','','','','','','',''),
(300,216,216350,1,'LIZ','MARLIS ORTEGA ROLON','','5260777','0971213306','','','','','','','','','','',''),
(301,216,216350,1,'JOSE','MARIA CABRERA SOSA','','2821883','09832331190','','','','','','','','','','',''),
(302,216,216350,1,'GERONIMO','ACOSTA CUBILLA','','1544393','0983998110','','','','','','','','','','',''),
(303,216,216350,1,'SONIA','SANTACRUZ ROJAS','','6364113','0976921092','','','','','','','','','','',''),
(304,216,216260,1,'MARIA',' MAGDALENA VERA DE CABELLO','','1866137','0976489504','','','','','','','','','','',''),
(305,216,216350,1,'JUAN','PABLO ACOSTA CANDIA','','7435650','0972528346','','','','','','','','','','',''),
(306,216,216350,1,'REMIGIO','GONZALEZ CABALLERO','','4137183','0975348501','','','','','','','','','','',''),
(307,216,216350,1,'WILFRIDO','ACUÑA ROJAS','','5995684','0985966651','','','','','','','','','','',''),
(308,216,216350,1,'MARIA','LETICIA ISASI','','4338411','0971607308','','','','','','','','','','',''),
(309,216,216350,1,'CINTHIA','NOEMI GODOY ZORRILLA','','7290548','0986544739','','','','','','','','','','',''),
(310,216,216260,1,'DERLIS','GABRIEL BENITEZ CHAVEZ','','7043391','0976521464','','','','','','','','','','',''),
(311,216,216260,1,'GABRIELINA','FRUTOS AGUERO','','3918682','0982933721','','','','','','','','','','',''),
(312,216,216350,1,'LIZ','MARILINA VILLALBA GUERRERO','','5584455','0985334047','','','','','','','','','','',''),
(313,216,216350,1,'DAYLEN','ARACELI AYALA BENITEZ','','6376807','0985572099','','','','','','','','','','',''),
(314,216,216350,1,'HERIBERTO','FERREIRA MEDINA','','1760262','0981342702','','','','','','','','','','',''),
(315,216,216350,1,'VALENTINA','FRETES','','4589332','0975328331','','','','','','','','','','',''),
(316,216,216350,1,'LOS','SANTOS CABALLERO GARCIA','','8585858','0976416066','','','','','','','','','','',''),
(317,216,216350,1,'DALILO','OLMEDO AGUILAR','','7860398','0984921533','','','','','','','','','','',''),
(318,216,216350,1,'FAUSTINA','FLEITAS BOGADO','','8122325','','','','','','','','','','','',''),
(319,216,216340,1,'FABIO','RENE RAMIREZ GARCIA','','858585','0984277234','','','','','','','','','','',''),
(320,216,216350,1,'FIDENCIO','MARTINEZ OJEDA','','3186315','0982325684','','ES EL HERMANO DE MARIO MARTINEZ','','','','','','','','',''),
(321,216,216130,1,'MARIA','VERONICA MIRANDA ORTIZ','','7014019','0972862380','','SAN RAMON','','','','','','','','',''),
(322,216,216350,1,'MARIA','EVA GONZALEZ','','3716753','0982197628','','SU HIJA ESTA ESPAÑA','','','','','','','','',''),
(323,216,216260,1,'JULIA','BENITEZ','','2695580','0985942430','','','','','','','','','','',''),
(324,216,216260,1,'JORGE','JAVIER INSFRAN CASCO','','5429761','0981329323','','','','','','','','','','',''),
(325,216,216100,1,'JUSTINO','ALEGRE BENITEZ','','3900440','0971421002','','','','','','','','','','',''),
(326,216,216001,1,'LORENZA','VAZQUEZ CABRAL','','7035452','0975497834','','','','','','','','','','',''),
(327,216,216001,1,'ONOFRE','ESTIGARRIBIA','','0','0983733923.','','','','','','','','','','',''),
(328,216,216400,1,'JUAN','RAMON BLANCO BENITEZ','','3621544','0985191360','','','','','','','','','','',''),
(329,216,216001,1,'RICARDO','ALVARENGA','','7007679','0983176892','','','','','','','','','','',''),
(330,216,216130,1,'GESSENIA','CAROLINA GONZALEZ RODRIGUEZ','','5866525','0981467592','','','','','','','','','','',''),
(331,216,216350,1,'SANTIAGO','GARCIA CANTERO','','2687643','0984372442','','','','','','','','','','',''),
(332,216,216350,1,'ELVIO','BENITEZ CABALLERO','','7131115','0985896253','','','','','','','','','','',''),
(333,216,216350,1,'NOELIA','ARANDA LEDESMA','','6724300','0981653780','','','','','','','','','','',''),
(334,216,216350,1,'DEISY','FIORELA MEDINA RIOS','','7251116','0976262114','','','','','','','','','','',''),
(335,216,216350,1,'','MARIA CAROLINA ROMERO FRUTOS','','4008436','0971464599','','','','','','','','','','',''),
(336,201,201010,1,'ALFREDO','BERNAL SEGOVIA','','6986124','0975267699','','','','','','','','','','',''),
(337,216,216260,1,'NIDIA','ESTER INSFRAN MENDEZ','','4383472','0986514950','','','','','','','','','','',''),
(338,216,216350,1,'MARCO','ANTONIO LEON LUGO','','5997370','0972124874','','','','','','','','','','',''),
(339,216,216350,1,'LILIANA','RAMIREZ','','6002134','0991580672','','ESPOSA DE BLAS','','','','','','','','',''),
(340,216,216350,1,'BRAHIAN','FERNANDO MARECO CABRAL','','6227678','0975312809','','','','','','','','','','',''),
(341,216,216260,1,'FANI',' ROMERO DIAZ','','6364110','+34602656496','','A 100 M DE LA ESC MARIA AUXILIADORA','','','','','','','','',''),
(342,216,216350,1,'ISABEL','GONZALEZ VDA DE INSFRAN','','2399124','0983265127','','','','','','','','','','',''),
(343,216,216350,1,'EMILCE','FARIÑA OJEDA','','6902848','0982734372','','','','','','','','','','',''),
(344,216,216350,1,'FELIPA','BAEZ SALDIVAR','','4497619','0982401061','','','','','','','','','','',''),
(345,216,216350,1,'FLORENTINA','ROA VILLALBA','','4413264','','','ES LA HNA DE ELIEZER','','','','','','','','',''),
(346,216,216350,1,'SERGIO','SEGOVIA BAEZ','','4878383','0972591283','','','','','','','','','','',''),
(347,216,216130,1,'GUIDO','CHAPARRO BRITEZ','','7005963','0975815152','','','','','','','','','','',''),
(348,216,216260,1,'ALFONSO','ACOSTA CUBILLA','','2687669','0975304308','','','','','','','','','','',''),
(349,216,216350,1,'JULIANA','PAIVA','','4312680','0975494856','','','','','','','','','','',''),
(350,216,216350,1,'SILVESTRE','ACOSTA','','2687503','','','','','','','','','','','',''),
(351,216,216350,1,'BLANCA','INES CHENA ROJAS','','6513872','0976111410','','PASANDO ESC MARIA AUXILIADORA','','','','','','','','',''),
(352,216,216350,1,'MIRNA','LETICIA VAZQUEZ CABALLERO','','6363971','0984518432','','','','','','','','','','',''),
(353,216,216350,1,'HUGO','HERNAN ROJAS','','4528167','0973433512','','','','','','','','','','',''),
(354,216,216350,1,'LEIDY','NOEMI AYALA ROA','','6552801','0982341291','','','','','','','','','','',''),
(355,216,216350,1,'FERNANDA','CRISTINA SIMOES ARRAIS','','8835478','','','','','','','','','','','',''),
(356,216,216350,1,'NERY','OMAR CABRERA TORRES','','4774383','0986915484','','','','','','','','','','',''),
(357,216,216350,1,'ALBERTO','CAMACHO VELAZQUEZ','','6242083','0982751501','','','','','','','','','','',''),
(358,216,216350,1,'MILCA','CANDIA CABALLERO','','7017807','0971478146- 09714162','','','','','','','','','','',''),
(359,216,216350,1,'BLAS','ANTONIO MARTINEZ BERGARA','','3716777','0984876146','','','','','','','','','','',''),
(360,216,216260,1,'FRANCISCO','ORTIZ MARTINEZ','','6826867','0976467762','','YERNO DE ROGELIA','','','','','','','','',''),
(361,216,216260,1,'MARIANA','GARCIA FIGUEREDO','','3881876','0975859450','','','','','','','','','','',''),
(362,216,216350,1,'MARI','ESTELA ROLON MENDOZA','','4313857','0975499234-098114742','','','','','','','','','','',''),
(363,216,216350,1,'MENELEO','LOPEZ DIAZ','','4053975','0976475305','','','','','','','','','','',''),
(364,216,216350,1,'RAMON','VILLALBA ORTIZ','','1902792','0986156937','','','','','','','','','','',''),
(365,216,216350,1,'ERMELINDA','VILLALBA','','4702365','0981768870','','ES PROF','','','','','','','','',''),
(366,216,216350,1,'JULIO','CABRERA SOSA','','1746294','0984963025','','','','','','','','','','',''),
(367,216,216260,1,'DOMINGO','VERA VERA','','2089786','0975969166','','','','','','','','','','',''),
(368,216,216350,1,'PAULA','PATRICIA GOMEZ LEGUIZAMON','','5727487','0986364742','','','','','','','','','','',''),
(369,216,216350,1,'SONIA','BOGADO','','5656489','0975916022','','','','','','','','','','',''),
(370,216,216350,1,'ALEXI','RAMON ORTIZ RAMOS','','8148087','0976417895','','','','','','','','','','',''),
(371,216,216350,1,'SALOMON','BENITEZ','','3564100','0971458897','','','','','','','','','','',''),
(372,216,216350,1,'MARIA','LETICIA RUIZ OLIVERA','','6653048','0972532006','','','','','','','','','','',''),
(373,216,216350,1,'RICARDO','VERGARA LOPEZ','','5425278','0982255501','','','','','','','','','','',''),
(374,216,216350,1,'EULALIO','DIAZ CANDIA','','5563837','0986198319','','','','','','','','','','',''),
(375,216,216350,1,'MIGUEL','COLMAN','','2067126','0971145205','','','','','','','','','','',''),
(376,216,216350,1,'VALERIO','FRETE VILLALBA','','3348442','0986761661','','','','','','','','','','',''),
(377,216,216350,1,'NANCY','MARIA FERREIRA VERA','','7222319','','','','','','','','','','','',''),
(378,216,216260,1,'TERESA','VILLALBA SAUCEDO','','3716730','0985236694','','','','','','','','','','',''),
(379,216,216310,1,'RUT','KAREN LUGO PORTILLO','','4440127','0975365422','','','','','','','','','','',''),
(380,216,216350,1,'GLADYS','MARTINEZ','','6301944','0971419537','','','','','','','','','','',''),
(381,216,216350,1,'BLANCA','GRISELDA GONZALEZ  CAÑETE','','5346144','0982634745','','','','','','','','','','',''),
(382,216,216350,1,'LORETO','RECALDE','','1639960','0984785216','','','','','','','','','','',''),
(383,216,216350,1,'LUCIANO','VELAZQUEZ BENITEZ','','5666238','0982494547','','','','','','','','','','',''),
(384,216,216350,1,'MANUEL','FERREIRA GODOY','','1982861','0986632086','','','','','','','','','','',''),
(385,216,216350,1,'LIBORIO','JARA GARCETE','','5346166','0984841717','','','','','','','','','','',''),
(386,216,216350,1,'DAVID','DANIEL SANABRIA','','6081393','0972984931','','','','','','','','','','',''),
(387,216,216350,1,'ISAAC','ESTEBAN MERCADO ARZAMENDIA','','4209624','0975902551','','','','','','','','','','',''),
(388,216,216350,1,'BLAS','MARCELO ROMERO DIAZ','','6364092','0985114012','','','','','','','','','','',''),
(389,216,216350,1,'ELISA','CAÑETE RAMIREZ','','5282550','0982677467','','','','','','','','','','',''),
(390,216,216350,1,'VICTOR','RAMON BOBADILLA MACHUCA','','7599881','0984309348-098569383','','','','','','','','','','',''),
(391,216,216350,1,'CHINTIA','MARLENE VAZQUEZ CABALLERO','','6690416','0981490952','','','','','','','','','','',''),
(392,216,216260,1,'LILIAN','ZARACHO MEDINA','','3720709','0983234550','','','','','','','','','','',''),
(393,216,216340,1,'OBDULIO','GONZALEZ FULLAONDO','','6170865','0981797624','','','','','','','','','','',''),
(394,216,216290,1,'EUSEBIO','MARTINEZ SERVIN','','3958471','0985730980','','','','','','','','','','',''),
(395,216,216290,1,'OVIDIO','GIMENEZ CACERES','','5895428','0982876626','','','','','','','','','','',''),
(396,216,216350,1,'CECILIA','GARCIA CANTERO','','5432675','0971481902','','','','','','','','','','',''),
(397,216,216260,1,'JULIO','CESAR ZARACHO MEDINA','','6363999','0986984710','','','','','','','','','','',''),
(398,214,214210,1,'MARIBEL','TORRES GARAY','','5839974','0975307256','','','','','','','','','','',''),
(399,216,216350,1,'AGUSTIN','GIMENEZ','','6927818','0983854007','','TRABAJA EN INPSA','','','','','','','','',''),
(400,216,216350,1,'FREDDY','LEDESMA FLEITAS','','2098178','0984344838','','','','','','','','','','',''),
(401,216,216350,1,'ADRIAN','QUIÑONEZ FORCADO','','7041132','0975481304','','','','','','','','','','',''),
(402,216,216350,1,'PASTORA','ISOLINA VERA DE DUARTER','','4146983','0976144502','','','','','','','','','','',''),
(403,216,216400,1,'BENITO','ESPINOLA RIVEROS','','3567362','0983357611','','','','','','','','','','',''),
(404,216,216350,1,'VICTOR','RAMON GARCETE ROMAN','','5825895','0984210513','','','','','','','','','','',''),
(405,216,216350,1,'JUAN','MANUEL GALEANO CAMACHO','','5432734','0975485332','','','','','','','','','','',''),
(406,216,216350,1,'FRANCISCO','ALFONZO PEREIRA','','3401546','0983342142','','ES EL VECINO DE HERIBERTO FERREIRA MEDINA','','','','','','','','',''),
(407,216,216350,1,'OSCAR','DUARTE ENCISO','','3460616','0983174525','','','','','','','','','','',''),
(408,1107,1107018,1,'ADOLFO','AUGUSTO AYALA GONZALEZ','','4544670','0971413688','','','','','','','','','','',''),
(409,216,216350,1,'ISRRAEL','VERGARA LOPEZ','','5425277','0982536099','','','','','','','','','','',''),
(410,216,216350,1,'RUBEN','OLMEDO MARTINEZ','','6372618','0971742547','','','','','','','','','','',''),
(411,216,216350,1,'VIDALIA','BRITEZ','','7111846','0985379724','','','','','','','','','','',''),
(412,216,216350,1,'HERMINIO','DUARTE GONZALEZ','','2938509','0971607186','','','','','','','','','','',''),
(413,216,216350,1,'EUGENIA','DAVALOS','','6856652','0975950517','','','','','','','','','','',''),
(414,216,216350,1,'CARMELO','ANTONIO OLMEDO GAVILAN','','4225313','0972897371','','','','','','','','','','',''),
(415,216,216350,1,'JOSE','LUIS JARA COLMAN','','6381882','0972336438','','','','','','','','','','',''),
(416,216,216350,1,'MARCIAL','RECALDE AZUAGA','','7725801','0976491232','','','','','','','','','','',''),
(417,216,216400,1,'DE','LOS SANTOS BRITEZ GAVILAN','','3750599','0983906705','','','','','','','','','','',''),
(418,216,216350,1,'SUNILDA','VILLALBA CHAPARRO','','5492136','0984467978','','','','','','','','','','',''),
(419,216,216350,1,'ARACELI','BEATRIZ LOPEZ ESCOBAR','','7996003','0973615275','','','','','','','','','','',''),
(420,216,216350,1,'NICOLAS','VERA VERGARA','','691848','0975361009','','','','','','','','','','',''),
(421,216,216350,1,'JORGE','VERA VENIALGO','','4642056','0981807334','','','','','','','','','','',''),
(422,216,216540,1,'GILBERTO','SILVA MIERES','','6662108','0976400487','','','','','','','','','','',''),
(423,216,216350,1,'LETICIA','FERREIRA VERA','','6696893','0985279884','','','','','','','','','','',''),
(424,216,216350,1,'ADOLFO','ALIENDRE','','1786165','0976195608','','','','','','','','','','',''),
(425,216,216350,1,'ARNALDO','AZUAGA PAREDES','','6560814','0975915154','','','','','','','','','','',''),
(426,216,216350,1,'ANTONIO','ADRIAN QUIÑONEZ FORCADO','','7018046','0975481304','','','','','','','','','','',''),
(427,216,216350,1,'HUGO','RICHARD PAREDES LESME','','5839723','0984099189','','','','','','','','','','',''),
(428,216,216350,1,'SEBASTIAN','QUIÑONEZ FORCADO','','1118136','0976455297','','','','','','','','','','',''),
(429,216,216100,1,'DEMETRIO','ZABALA ORREGO','','2446457','0983178748','','','','','','','','','','',''),
(430,216,216350,1,'AGAPITO','ROJAS DAVALOS','','2068188','0972742471','','','','','','','','','','',''),
(431,216,216350,1,'RUMILDA','BENITEZ GONZALEZ','','2068364','0972712639','','','','','','','','','','',''),
(432,216,216350,1,'MARIA','LUCI BLANCO BOMFIN','','5832940','0976814260','','','','','','','','','','',''),
(433,216,216350,1,'MARIZA','GAMARRA RIVAROLA','','5841534','0986552139','','','','','','','','','','',''),
(434,216,216290,1,'OSCAR','DAMIAN CANDIA DIAZ','','2975196','0982455129','','','','','','','','','','',''),
(435,216,216260,1,'AGUSTIN','MARECO','','5997609','','','','','','','','','','','',''),
(436,216,216350,1,'VIVIANA','GONZALEZ ZORRILLA','','6719202','0984593293','','','','','','','','','','',''),
(437,216,216350,1,'MIGUELA','GAMARRA RIVAROLA','','5196166','5196166','','','','','','','','','','',''),
(438,216,216350,1,'JUAN','ADALBERTO CABRERA FERREIRA','','4817219','0973199635','','','','','','','','','','',''),
(439,216,216350,1,'CEVERIANA','ALONZO DE CESPEDES','','1940957','0985241648','','','','','','','','','','',''),
(440,216,216350,1,'VERONICA','AZUAGA GAMARRA','','5855323','0984399584','','','','','','','','','','',''),
(441,216,216350,1,'ANASTACIA','ZARZA AYALA','','2033878','','','','','','','','','','','',''),
(442,216,216350,1,'MIRTA','ROCIO DIAZ CABALLERO','','8065189','0983706345','','','','','','','','','','',''),
(443,216,216350,1,'OSMAR','MARTINEZ LOPEZ','','6296792','','','','','','','','','','','',''),
(444,216,216260,1,'ELIGIO','OSVALDO NUÑEZ VILLAGRA','','5044032','0986631221','','','','','','','','','','',''),
(445,216,216290,1,'NELSON','DEVARIS ROJAS JIMENEZ','','6082418','0983347947','','','','','','','','','','',''),
(446,216,216350,1,'JOEL','ORTIZ','','7450528','0985430865','','','','','','','','','','',''),
(447,216,216350,1,'CELINA','AYALA BENITEZ','','2988947','0976422281','','','','','','','','','','',''),
(448,216,216350,1,'BLAS','ANTONIO ACOSTA CANDIA','','5255379','0973708802','','','','','','','','','','',''),
(449,216,216350,1,'FATIMA','CANDIA CABALLERO','','8329704','0976466402','','','','','','','','','','',''),
(450,216,216350,1,'LORENZA','BARRIENTOS CABALLERO','','2988783','0981756254','','','','','','','','','','',''),
(451,216,216350,1,'JOSE','MIGUEL CAÑIZA','','2696482','0985302839','','','','','','','','','','',''),
(452,216,216350,1,'JOSE','LUIS VERON DUARTE','','5410224','0975269478','','','','','','','','','','',''),
(453,216,216350,1,'FABIANA','PESOA ACEVEDO','','6612625','0972803063','','','','','','','','','','',''),
(454,216,216350,1,'WILSON','INSFRAN RIVEROS','','5831502','0975910856','','','','','','','','','','',''),
(455,216,216350,1,'DERLIS','MIRANDA MIRANDA','','6136896','0975420341-','','','','','','','','','','',''),
(456,216,216350,1,'JONATAN','JULIO GONZALEZ OLMEDO','','5831551','0971114087','','','','','','','','','','',''),
(457,216,216350,1,'RUMILDA','ESTELA ALVARENGA PRIETO','','6072492','0985115756','','','','','','','','','','',''),
(458,216,216350,1,'FREDDY','ALEJANDRO PESOA','','5760043','','','','','','','','','','','',''),
(459,216,216350,1,'HERNAN','FERREIRA VERA','','6363998','0985554365','','HIJO DE ERIC','','','','','','','','',''),
(460,216,216350,1,'MARCOS','GAMARRA','','1882050','0984998736','','','','','','','','','','',''),
(461,216,216350,1,'JUAN','ANDRES LOPEZ RUIZ','','2419395','0986939838','','','','','','','','','','',''),
(462,216,216350,1,'CRISTIAN','DAVID ARANDA LOPEZ','','6962061','0975358443- 09753688','','','','','','','','','','',''),
(463,216,216350,1,'JAIME','ARTURO LOPEZ FARIÑA','','7527870','0976409917','','','','','','','','','','',''),
(464,216,216100,1,'REINALDO','AGUILAR BARRIENTOS','','5945035','0985340835','','','','','','','','','','',''),
(465,216,216350,1,'RODRIGO','DANIEL CANO','','3862312','','','','','','','','','','','',''),
(466,216,216350,1,'MIRNA','GOMEZ FIGUEREDO','','6727524','0982466263','','','','','','','','','','',''),
(467,216,216350,1,'ADELIO','CABALLERO TORALES','','5361230','0973175693','','','','','','','','','','',''),
(468,216,216130,1,'ANER','CHAPARRO BRITEZ','','5316515','0975269313','','','','','','','','','','',''),
(469,216,216001,1,'CLAUDIA','ELIZABETH MOREL PEÑA','','6995237','0984321828','','','','','','','','','','',''),
(470,216,216350,1,'JENY','ENRIQUEZ GARCIA','','2','','','','','','','','','','','',''),
(471,101,101001,1,'RUBEN','LOVERA','','2961965','0983415909','','','','','','','','','','',''),
(472,216,216350,1,'BIANCA','DUARTE','','4264277','0982786674','','','','','','','','','','',''),
(473,216,216350,1,'GILBERTO','RECALDE AZUAGA','','7428099','0982206565','','','','','','','','','','',''),
(474,216,216400,1,'ALCIDES','CABRERA OCAMPOS','','4249730','0982584846','','','','','','','','','','',''),
(475,216,216350,1,'MARIA','NORMA GONZALEZ RODRIGUEZ','','2696466','0985605377','','','','','','','','','','',''),
(476,216,216350,1,'DIANA','AGUILERA BENITEZ','','7002242','','','','','','','','','','','',''),
(477,1403,1403100,1,'JORGE','ALFONZO ESTIGARRIBIA','','6136344','0971147393','','','','','','','','','','',''),
(478,216,216350,1,'DIANA','LUCIA CABALLERO GONZALEZ','','4209628','0976410925','','','','','','','','','','',''),
(479,802,802999,1,'ANGELICA','BEATRIZ FLORENTIN RAMIREZ','','7276775','0984917549','','','','','','','','','','',''),
(480,216,216350,1,'MARIZA','DUARTE GIMENEZ','','6726168','0985305437','','','','','','','','','','',''),
(481,216,216350,1,'LEA','CRISTALDO GARCIA','','5776053','0985664735','','','','','','','','','','',''),
(482,216,216350,1,'ARNALDO','DUARTE ENCISO','','3460621','0985307185','','','','','','','','','','',''),
(483,216,216100,1,'PANFILO','VALDOVINO','','1779378','0984725102','','','','','','','','','','',''),
(484,216,216350,1,'FIDENCIA','DUARTE VDA DE LOPEZ','','1304599','','','','','','','','','','','',''),
(485,216,216130,1,'ROSANA','ROCIO VALENZUELA RAMIREZ','','7021453','0975347040-098410934','','','','','','','','','','',''),
(486,216,216260,1,'DORA','BENITEZ BENITEZ','','4291893','0982308790','','','','','','','','','','',''),
(487,216,216350,1,'DERLIS','JOEL GALEANO ROA','','4625551','0976304514','','','','','','','','','','',''),
(488,216,216350,1,'GLORIA','MABEL GONZALEZ AGUERO','','4413217','','','','','','','','','','','',''),
(489,216,216350,1,'LIZ','PAOLA CORONEL ENCISO','','6865432','','','','','','','','','','','',''),
(490,216,216350,1,'PABLINA','ENCISO DE DUARTE','','2495381','0983852695','','','','','','','','','','',''),
(491,216,216350,1,'FREDY','GONZALO GONZALEZ OLMEDO','','5418874','0981610727','','','','','','','','','','',''),
(492,216,216350,1,'VICTOR','SAMANIEGO JARA','','6595608','0986436720','','','','','','','','','','',''),
(493,216,216350,1,'SERGIO','CANDIA PEREIRA','','5777328','0976118440','','','','','','','','','','',''),
(494,216,216350,1,'LUCIRIA','DIAZ CABALLERO','','6934520','0984648023 ','','','','','','','','','','',''),
(495,216,216260,1,'FIDENCIO','ANIBAL VERA PANIAGUA','','5469141','0986574018','','','','','','','','','','',''),
(496,216,216350,1,'MIGUEL','ANGEL VEGA GAUTO','','2818744','0982836192','','','','','','','','','','',''),
(497,216,216350,1,'DEISY','CAROLINA CHAVEZ GAMARRA','','7039488','0975368629','','','','','','','','','','',''),
(498,216,216350,1,'PABLO','ORTIZ ORTIZ','','2687623','','','','','','','','','','','',''),
(499,216,216350,1,'MARIO','RAMON ACOSTA CANDIA','','7262883','0991388297','','','','','','','','','','',''),
(500,1013,1013001,1,'JUAN','RAMON GUERRERO GAVILAN','','5264765','0975851630','','','','','','','','','','',''),
(501,1013,1013004,1,'VICTOR','DANIEL MOREL SANTACRUZ','','5879146','0983220256','','','','','','','','','','',''),
(502,216,216350,1,'MARIA','FANILDA MERELES','','7051142','0982352453','','','','','','','','','','',''),
(503,216,216350,1,'FRANCISCO','ANTONIO MOLINA ORTIZ','','3715976','','','','','','','','','','','',''),
(504,216,216350,1,'GERMAN','DAVID ALFONZO MENDOZA','','5980740','0982517562','','','','','','','','','','',''),
(505,216,216350,1,'MENELIO','LEDESMA FLEITAS','','6777939','0976454982','','','','','','','','','','',''),
(506,214,214001,1,'WINER','VALDOVINO GONZALEZ','','5358850','','','','','','','','','','','',''),
(507,216,216350,1,'MATHIAS','EZEQUIEL ESCOBAR','','7027297','0972942907','','','','','','','','','','',''),
(508,216,216350,1,'MARLENE','ISASI SANABRIA','','6296650','0976451245','','','','','','','','','','',''),
(509,216,216350,1,'MARIA','DEL CARMEN CABRAL FIGUEREDO','','5346149','0971666344','','','','','','','','','','',''),
(510,216,216350,1,'LUIS','ALBERTO GONZALEZ AYALA','','3815465','0971483331','','','','','','','','','','',''),
(511,216,216260,1,'MIRIAN','HERMOSILLA RIVAS','','5320238','0975253151','','','','','','','','','','',''),
(512,216,216350,1,'ROLANDO','ROA VILLALBA','','5772571','0975913554','','','','','','','','','','',''),
(513,216,216260,1,'JORGE','DAVID FRANCO STOCKL','','4613861','0976466757','','ES DE LA PANADERIA TORRES HERMANOS','','','','','','','','',''),
(514,216,216350,1,'MARIA','MAGDALENA VALLEJOS CABALLERO','','5432637','0991280974','','','','','','','','','','',''),
(515,216,216350,1,'MILCIADES','ACOSTA CANDIA','','4969640','','','','','','','','','','','',''),
(516,204,204001,1,'HECTOR','DANIEL RODRIGUEZ ORTIZ','','7018034','','','','','','','','','','','',''),
(517,216,216350,1,'REINALDO','FRANCISCO CARBALLO GONZALEZ','','5971999','0976503124','','','','','','','','','','',''),
(518,216,216350,1,'MARIO','RAMON VERA','','2252026','0976426987','','','','','','','','','','',''),
(519,216,216350,1,'PATRICIO','CABRAL GIMENEZ','','2259625','0981207127','','','','','','','','','','',''),
(520,216,216350,1,'FATIMA','LILIANA VALLEJOS PAREDES','','4586781','0971416676','','','','','','','','','','',''),
(521,216,216310,1,'CESAR','ALMADA BENITEZ','','4272744','','','','','','','','','','','',''),
(522,216,216350,1,'GERALDO','RIVAS','','4285222','0972942627','','','','','','','','','','',''),
(523,216,216350,1,'SANDRA','ELIZABETH ISASI SANABRIA','','5654730','0983769925','','','','','','','','','','',''),
(524,216,216350,1,'EVER','ARMANDO AGUERO RIOS','','4320248','0986311609','','','','','','','','','','',''),
(525,216,216350,1,'SERGIO','SALINAS RUIZ DIAZ','','5371201','0984829339','','','','','','','','','','',''),
(526,216,216350,1,'EVER','IGNACIO BRITEZ MARTINEZ','','5959643','0971868945','','','','','','','','','','',''),
(527,216,216350,1,'GABRIEL','CABRERA IRALA','','7009204','0976360686','','','','','','','','','','',''),
(528,216,216280,1,'IVAN','ACHEZA GUILLEN','','7191716','0976434764','','','','','','','','','','',''),
(529,216,216350,1,'SUSANA','GAMARRA ACOSTA','','3361592','0982046735','','','','','','','','','','',''),
(530,216,216260,1,'BLANCA','ESTELA SERVIANO FRANCO','','4871624','0975999747','','','','','','','','','','',''),
(531,216,216100,1,'ADRIANA','AGUILAR BARRIENTOS','','7191737','0984471214','','','','','','','','','','',''),
(532,216,216350,1,'MELANIO','BENITEZ SILVA','','1952872','0971453965','','','','','','','','','','',''),
(533,216,216350,1,'ALFREDO','FRANCO PAREDES','','3038444','','','','','','','','','','','',''),
(534,216,216350,1,'ALEJANDRA','LUGO DE FRANCO','','3919426','','','','','','','','','','','',''),
(535,216,216350,1,'CINTHIA','MABEL OVELAR BARBOZA','','9012350','0975316110-097667204','','','','','','','','','','',''),
(536,216,216280,1,'MARCO','ANTONIO GUILLEN ESCALANTE','','6891349','0984529964','','','','','','','','','','',''),
(537,216,216350,1,'MATIAS','DAMIAN PAIVA','','6373694','0975313155','','','','','','','','','','',''),
(538,216,216350,1,'SEVERIANO','SOSA MALDONADO','','2438961','0982898827','','','','','','','','','','',''),
(539,216,216350,1,'RAMONA','TORALES FERNANDEZ','','6693868','0983873332','','','','','','','','','','',''),
(540,216,216350,1,'HILDA','GUAYUAN GAMARRA','','5389277','+549297458-8342','','','','','','','','','','',''),
(541,216,216350,1,'SONIA','CAÑIZA ORTIZ','','5065262','0981679332','','','','','','','','','','',''),
(542,216,216460,1,'NORMA','ENCISO CANTERO','','5222756','0986604698','','','','','','','','','','',''),
(543,216,216350,1,'ENZO','DAVID CASCO ACOSTA','','8004215','0982692379','','','','','','','','','','',''),
(544,216,216350,1,'HERIBERTO','RUIZ DIAZ CANTERO','','7004803','','','','','','','','','','','',''),
(545,216,216350,1,'ALCIDES','DUARTE ENCISO','','4661537','0983740536','','','','','','','','','','',''),
(546,216,216350,1,'SELVA','SABINA GONZALEZ DE ZORRILLA','','1772148','0983792399','','','','','','','','','','',''),
(547,216,216350,1,'LIZ','MARISA DIAZ FRANCO','','6021493','0982102323','','TIA DE FANY ROMERO','','','','','','','','',''),
(548,216,216350,1,'BLANCA','RAMONA RAMIREZ DUARTE','','7022854','0973644317','','','','','','','','','','',''),
(550,216,216350,1,'ADOLFINO','CAÑETE REYES','','5817069','','','','','','','','','','','',''),
(551,216,216350,1,'SIXTA','GAVILAN DE JARA','','2687554','','','','','','','','','','','',''),
(552,216,216350,1,'MARCOS','ANTONIO CASCO FRANCO','','6897489','0975922529','','','','','','','','','','',''),
(553,216,216350,1,'JUAN','GABRIEL CABRAL MARTINEZ','','5579662','0975924556','','','','','','','','','','',''),
(554,216,216350,1,'RAMONA','DE JESUS ALCARAZ DE FALCON','','7135003','0974200297','','','','','','','','','','',''),
(555,216,216350,1,'CRISTIAN','DAVID CACERES RODRIGUEZ','','6986080','0975356187','','','','','','','','','','',''),
(556,216,216350,1,'ADA','NOEMI BOGADO VALDEZ','','5914851','0975968041','','','','','','','','','','',''),
(557,216,216290,1,'ARSENIO','ALVARENGA DAVALOS','','7042061','','','','','','','','','','','',''),
(558,216,216350,1,'MARIO','CORONEL','','4642915','0985479897','','','','','','','','','','',''),
(559,203,203200,1,'FELIPE','SIMPLICIO CASTILLO RECALDE','','5654692','','','','','','','','','','','',''),
(560,216,216350,1,'REINALDO','SALINAS RUIZ DIAZ','','6364108','0983437565','','','','','','','','','','',''),
(561,216,216340,1,'CATALINA','RAMONA RODRIGUEZ GARRIDO','','4300594','0982307402','','','','','','','','','','',''),
(562,216,216280,1,'PERLA','BEATRIZ ESCALANTE LOPEZ','','3900384','0986382522','','','','','','','','','','',''),
(563,216,216350,1,'JENNIFER','LETICIA GONZALEZ CANDIA','','6900108','','','','','','','','','','','',''),
(564,216,216350,1,'ARNALDO','RUBEN DUARTE MARTINEZ','','6363994','','','','','','','','','','','',''),
(565,216,216350,1,'VICTOR','LUIS CHAMORRO NAVARO','','1437457','','','','','','','','','','','',''),
(566,216,216350,1,'ABEL','LUCIO GAONA','','6776990','','','','','','','','','','','',''),
(567,216,216350,1,'GILBERTO','DIAZ COLINA','','1157100','0971311312','','','','','','','','','','',''),
(568,216,216350,1,'BASILIO','BERNAL CUEVAS','','1938307','','','','','','','','','','','',''),
(569,216,216350,1,'MARIA','ESTELA MARTINEZ FLORENTIN','','4767568','','','','','','','','','','','',''),
(570,216,216350,1,'ESMILDA','ELIZABETH ACOSTA','','4231499','0975366540','','','','','','','','','','',''),
(571,216,216350,1,'IGNACIO','DAVID RAMIREZ GARCIA','','7017952','0984822185','','','','','','','','','','',''),
(572,216,216350,1,'RAFAEL','BALBUENA CAMACHO','','7022926','0974553818','','','','','','','','','','',''),
(573,216,216350,1,'DAISY','DIAZ CABALLERO','','6755040','','','','','','','','','','','',''),
(574,216,216350,1,'JORGE','MANUEL CABALLERO BOGADO','','6608986','','','','','','','','','','','',''),
(575,216,216100,1,'BEATRIZ','ESTECHE CANDIA','','2282799','2282799','','','','','','','','','','',''),
(576,216,216350,1,'MERCEDES','IRALA GARCETE','','5730433','0983700531','','','','','','','','','','',''),
(577,216,216350,1,'IGNACIO','RAMON ENCISO','','5855217','0985322326','','','','','','','','','','',''),
(578,216,216350,1,'TIBURCIO','DOMINGUEZ LIMA','','3039484','0986869253','','','','','','','','','','',''),
(579,216,216350,1,'JOVITA','CABALLERO VDA DE VALLEJOS','','2479644','0976662575','','','','','','','','','','',''),
(580,216,216460,1,'JORGE','DANIEL URGATE','','5182367','0986604698','','','','','','','','','','',''),
(581,216,216350,1,'BLAS','ADAN DE LA CRUZ INSFRAN GONZALEZ','','5831505','0976492496','','','','','','','','','','',''),
(582,216,216350,1,'EVER','ADRIAN ORTELLADO ORTEGA','','5635046','','','','','','','','','','','',''),
(583,216,216350,1,'CYNTHIA','LORENA RECALDE AZUAGA','','6971053','','','','','','','','','','','',''),
(584,216,216260,1,'CESARINA','ROJAS ENCISO','','4614804','','','','','','','','','','','',''),
(585,216,216260,1,'SANDRA','AQUINO MARTINEZ','','6543759','0975307679','','','','','','','','','','',''),
(586,216,216350,1,'CELIA','GARCIA DE VILLALBA','','2668733','0975368629','','','','','','','','','','',''),
(587,216,216350,1,'FELIPA','ESPINOLA MEZA','','6925133','0986339331','','','','','','','','','','',''),
(588,216,216350,1,'SELVA','FERNANDEZMARTINEZ','','5015412','0983528131','','','','','','','','','','',''),
(589,216,216350,1,'MARIA','SAMUDIO ORTIZ','','4220427','0983064890','','','','','','','','','','',''),
(590,216,216260,1,'SEBASTIAN','PAREDES VAZQUEZ','','5196185','','','','','','','','','','','',''),
(591,216,216350,1,'VIDAL','MERCADO VERA','','675987','0984296376','','','','','','','','','','',''),
(592,216,216350,1,'GABRIEL','AZUAGA GAMARRA','','6674814','0971474046','','','','','','','','','','',''),
(593,216,216310,1,'CRISPIN','BOGADO AYALA','','1781612','0985336616','','','','','','','','','','',''),
(594,216,216350,1,'CELESTINO','MENDEZ BENITEZ','','3892530','0984024903','','','','','','','','','','',''),
(595,216,216350,1,'JUNIOR','CESAR BORGES SEGOVIA','','3961098','0983955606','','','','','','','','','','',''),
(596,216,216350,1,'ANA','MARINA ARZAMENDIA','','4239535','0983844037','','','','','','','','','','',''),
(597,216,216100,1,'MARIA','DOMINGA BARRIENTOS CABALLERO','','5838069','0983594167','','','','','','','','','','',''),
(598,216,216350,1,'FABIANA','CANDIA CABALLERO','','6679806','','','','','','','','','','','',''),
(599,216,216350,1,'OSMAR','VILLALBA CHAPARRO','','4400436','0985920108','','','','','','','','','','',''),
(600,216,216350,1,'JANDERSON','MASSARANDUBA','','50083314','0976650623','','.','','','','','','','','',''),
(601,216,216170,1,'MARIO','PESOA ARRIOLA','','7180032','0973815883','','','','','','','','','','',''),
(602,216,216350,1,'JOSE','LEDESMA VERA','','2687659','','','','','','','','','','','',''),
(603,216,216350,1,'OSCAR','RECALDE GIMENEZ','','6372325','0984778151','','','','','','','','','','',''),
(604,1403,1403100,1,'ATILANO','RUIZ GALEANO','','4809043','','','','','','','','','','','',''),
(605,216,216260,1,'AGUSTINA','VERA VERA','','4941574','','','','','','','','','','','',''),
(606,216,216350,1,'MATIAS','GABRIEL MILOSLAVICH ENCISO','','8212584','','','','','','','','','','','',''),
(607,216,216350,1,'SILVIO','VAZQUEZ CABRAL','','5346137','','','','','','','','','','','',''),
(608,216,216350,1,'NELSON','RODRIGO MILOSLAVICH ENCISO','','5380238','5380238','','','','','','','','','','',''),
(609,216,216260,1,'DANIELA','GENEZ SANCHEZ','','6751083','0972713746','','','','','','','','','','',''),
(610,216,216350,1,'VERONICA','GOMEZ FIGUEREDO','','5896588','','','','','','','','','','','',''),
(611,216,216350,1,'NOELIA','RAQUEL CARDENAS BOGADO','','7034379','','','','','','','','','','','',''),
(612,216,216350,1,'ROLANDO','DAVID GAMARRA GONZALEZ','','7201331','0975364124','','','','','','','','','','',''),
(613,216,216350,1,'CASIANO','SANABRIA FERNANDEZ','','2362871','','','','','','','','','','','',''),
(614,216,216350,1,'SAMUEL','BAZAN TORRES','','6348342','0975531282','','','','','','','','','','',''),
(615,216,216350,1,'DIEGO','ARMANDO LOPEZ MEDINA','','5183487','0981994925','','','','','','','','','','',''),
(616,216,216350,1,'OSCAR','RICARDO SILVA','','7452914','','','','','','','','','','','',''),
(617,216,216350,1,'DELIO','DIOSNEL ROLON ACOSTA','','6221028','0975331248','','','','','','','','','','',''),
(618,216,216350,1,'ESTELA','BERNAL BENITEZ','','6250947','0985673951','','SU MARIDO SE LLAMA JUAN BENITEZ','','','','','','','','',''),
(619,216,216350,1,'MIGUEL','MOISES ALFONZO MENDOZA','','5980737','0981374472','','','','','','','','','','',''),
(620,216,216350,1,'EMILIO','GABRIEL ESPINOLA','','3766606','0983632001','','','','','','','','','','',''),
(621,216,216350,1,'BALBINA','RIQUELME DE GONZALEZ','','2293173','0976459193','','','','','','','','','','',''),
(622,216,216350,1,'CARLOS','RAMON ORTIGOZA LOPEZ','','3423733','','','','','','','','','','','',''),
(623,216,216350,1,'MARCELO','FERREIRA VERA','','6717150','','','','','','','','','','','',''),
(624,216,216260,1,'JERSON','JOEL MIRANDAORTIZ','','7100839','0975841175','','','','','','','','','','',''),
(625,216,216350,1,'ANA','RAQUEL IRALA DE CABRERA','','5224575','','','','','','','','','','','',''),
(626,216,216350,1,'RAFAELA','GUAYUAN GAMARRA','','4332336','','','','','','','','','','','',''),
(627,216,216001,1,'VICTORINO','SOSA ROMERO','','5073193','0973119873','','','','','','','','','','',''),
(628,216,216350,1,'GUSTAVO','ADOLFO MEDINA FRANCO','','3929181','0985605377','','','','','','','','','','',''),
(629,216,216350,1,'RICARDO','VELAZQUEZ ESQUIVEL','','2535873','','','','','','','','','','','',''),
(630,216,216350,1,'VIVIANA','CHISEL GUAIRARE','','6372608','','','','','','','','','','','',''),
(631,216,216350,1,'ARIEL','CABRERA IRALA','','5432736','0984291517','','','','','','','','','','',''),
(632,216,216350,1,'JUAN','CARLOS DUARTE BENITEZ','','4947447','','','','','','','','','','','',''),
(633,216,216350,1,'ROSALINO','ALVARENGA CAMACHO','','7736174','0984742324','','','','','','','','','','',''),
(634,216,216350,1,'MENCHI','CAROLINA BRITEZ','','5796305','0975493160','','','','','','','','','','',''),
(635,216,216350,1,'ZULLY','EMILCE AGUILERA OVELAR','','1500827','0986224634','','','','','','','','','','',''),
(636,216,216350,1,'CARLOS','DAVID CENTURION AYALA','','6891470','0975135835','','','','','','','','','','',''),
(637,216,216350,1,'MARIO','DANIEL PATIÑO CACERES','','6573796','','','','','','','','','','','',''),
(638,214,214210,1,'CRISTIAN','TORRES SANABRIA','','5469170','','','','','','','','','','','',''),
(639,216,216130,1,'CAROLINA','ORTIZ VERA','','7518425','0983980944','','','','','','','','','','',''),
(640,216,216350,1,'CLAVELINO','GALEANO','','1897076','0986237164','','','','','','','','','','',''),
(641,216,216310,1,'LIDIA','BENITEZ DE MEZA','','5316524','','','','','','','','','','','',''),
(642,216,216350,1,'VANESSA','SOLEDAD AMARILLA OJEDA','','6372748','','','','','','','','','','','',''),
(643,216,216260,1,'DIANA','PEREIRA PEREIRA','','5938063','','','','','','','','','','','',''),
(644,216,216350,1,'EDGAR','ORTIZ BAREIRO','','6690583','','','','','','','','','','','',''),
(645,216,216350,1,'YOHANA','MARGARITA RIQUELME LOPEZ','','7017939','','','','','','','','','','','',''),
(646,216,216350,1,'TERENSIO','ALCADIO SANTACRUZ GOMEZ','','5843341','0976465383','','','','','','','','','','',''),
(647,216,216350,1,'ICO','GERONIMO CAÑETE ROLON','','2975208','0976457180','','','','','','','','','','',''),
(648,216,216350,1,'ROQUE','MIGUEL DUARTE','','4924143','0984032058','','','','','','','','','','',''),
(649,216,216120,1,'JOSE','ALCIDES GERDING RODRIGUEZ','','2196117','0985650851','','','','','','','','','','',''),
(650,216,216460,1,'ANTENOR','SANCHEZ MORENO','','5316073','0982590287','','','','','','','','','','',''),
(651,216,216350,1,'PATRICIA','ELIZABETH CABRAL FIGUEREDO','','4744993','0975945594','','','','','','','','','','',''),
(652,216,216350,1,'EZEQUIEL','VILLALBA GARCIA','','5996110','','','','','','','','','','','',''),
(653,216,216350,1,'REINALDO','AGUILERA DIAZ','','6639825','0971345688','','','','','','','','','','',''),
(654,216,216350,1,'ANACLETO','VILLALBA SANCHEZ','','1501788','0983204540','','','','','','','','','','',''),
(655,216,216350,1,'FRANCISCO','JAVIER JARA SANCHEZ','','4559119','0982377581','','','','','','','','','','',''),
(656,216,216270,1,'IDELINA','BENITEZ DE GARCETE','','4781464','','','','','','','','','','','',''),
(657,216,216350,1,'YANINA','MONSERRATH LOPEZ ESCOBAR','','7997997','0984349595','','','','','','','','','','',''),
(658,216,216130,1,'ANTONIO','MEDINA PAEZ','','929539','','','','','','','','','','','',''),
(659,216,216350,1,'JORGE','DANIEL VILLALBA GARCIA','','6817511','0982409317','','','','','','','','','','',''),
(660,216,216350,1,'JUAN','BENITO TILLERIA CANTERO','','2975194','0971606125','','','','','','','','','','',''),
(661,216,216350,1,'JAVIER',' CHAVEZ CUELLAR','','5883478','','','','','','','','','','','',''),
(662,216,216350,1,'CRISTIAN','ESTIGARRIBIA','','5855226','0976234538','','','','','','','','','','',''),
(663,216,216350,1,'ELIO','MANUEL VILLALBA AGUERO','','5303874','0972615307','','','','','','','','','','',''),
(664,1,1001,1,'FEDERICO','ORTELLADO OCAMPOS','','3892544','0971684292','','','','','','','','','','',''),
(665,216,216350,1,'ROLANDO','TEODORO ORTIZ RODRIGUEZ','','6139813','0982138903','','','','','','','','','','',''),
(666,216,216350,1,'CELSO','JOEL GENEZ FALCON','','6560429','0975359862','','','','','','','','','','',''),
(667,216,216350,1,'CLAUDIO','ESTEBAN GONZALEZ MARTINEZ','','3804089','0982696403','','','','','','','','','','',''),
(668,216,216350,1,'HUGO','MOTTE','','929885','0971434713','','','','','','','','','','',''),
(669,216,216260,1,'EDELMIRA','BRITEZ MARTINEZ','','6667681','','','','','','','','','','','',''),
(670,216,216350,1,'CELESTINA','CHAVEZ GAMARRA','','4791549','0986417859','','','','','','','','','','',''),
(671,216,216350,1,'LIZ','PAOLA BOBADILLA MACHUCA','','7592420','','','','','','','','','','','',''),
(672,216,216350,1,'JULIA','GALEANO ORTIZ','','5855223','0986387597','','','','','','','','','','',''),
(673,216,216400,1,'DERLIS','ENRIQUE CUEVAS BATTE','','3780583','0986116702','','','','','','','','','','',''),
(674,216,216350,1,'SANTIAGO','RAMON ORREGO LUNGKIS','','7341683','','','','','','','','','','','',''),
(675,216,216350,1,'FEDERICO','GONZALEZ REYES','','4762166','0982027936','','','','','','','','','','',''),
(676,216,216260,1,'LUZ','MARIBEL JARA MERCADO','','5922221','+5491124547997','','EN FRENTE DE LALO ENRRIQUEZ','','','','','','','','',''),
(677,216,216350,1,'GABRIELA','BEATRIZ LEIVA MARTINEZ','','6858795','','','','','','','','','','','',''),
(678,216,216350,1,'ANGEL','SALVADOR SANCHEZ VILLALBA','','5426489','0972820509','','','','','','','','','','',''),
(679,216,216350,1,'EDGAR','RODRIGO PAIVA ALONSO','','6837626','0982686520','','','','','','','','','','',''),
(680,216,216350,1,'ALEXIS','GONZALEZ CHENA','','7009235','0974593495','','','','','','','','','','',''),
(681,216,216350,1,'FREDY','ACUÑA FERNANDEZ','','6078482','0986888509','','','','','','','','','','',''),
(682,216,216400,1,'ELADIO','GAYOSO','','4057149','0984393236','','','','','','','','','','',''),
(683,216,216350,1,'ANTONIO','BURGOS','','3844899','0982470090','','','','','','','','','','',''),
(684,216,216350,1,'SONIA','ELIZABETH BOBADILLA MACHUCA','','7592788','','','','','','','','','','','',''),
(685,216,216350,1,'CARLOS','GALEANO LOPEZ','','6081350','','','','','','','','','','','',''),
(686,216,216350,1,'TORIBIO','PAREDES FRANCO','','3613670','','','','','','','','','','','',''),
(687,216,216350,1,'SARA','AGUERO PACHECO','','5908868','5908868','','','','','','','','','','',''),
(688,216,216350,1,'HUGO','RAMON ZARATE CUENCA','','2244364','0985407947','','','','','','','','','','',''),
(689,216,216350,1,'CARLOS','AZUAGA PAREDES','','6597677','','','','','','','','','','','',''),
(690,216,216350,1,'DORALICIA','MARTINEZ GONZALEZ','','6705811','','','','','','','','','','','',''),
(691,216,216350,1,'ALBERTO','CAÑIZA ORTIZ','','5362963','','','','','','','','','','','',''),
(692,216,216350,1,'HERI','ALBERTO OJEDA RUIZ DIAZ','','5212729','0981764328','','','','','','','','','','',''),
(693,216,216260,1,'SONIA','ZARACHO LOPEZ','','5','','','','','','','','','','','',''),
(694,216,216350,1,'EDELIO','JAVIER GUTIERREZ BENITEZ','','6834445','0976463470','','','','','','','','','','',''),
(695,216,216350,1,'ISACIO','DIAZ','','4059854','0971360081','','','','','','','','','','',''),
(696,216,216350,1,'JUAN','DAVID LOPEZ COLMAN','','6087194','0973664987','','','','','','','','','','',''),
(697,216,216350,1,'CECILIO','VILLAMAYOR ESPINOLA','','3379907','0985476848','','','','','','','','','','',''),
(698,1108,1108999,1,'OSCAR','BENITEZ BENITEZ','','4043587','0984129302','','','','','','','','','','',''),
(699,216,216350,1,'CESAR','DURE','','555','','','','','','','','','','','',''),
(700,216,216350,1,'MAICON','ANTUNES ABREU','','5080','0985468938','','','','','','','','','','',''),
(701,216,216350,1,'HERNAN','DUARTE RECALDE','','5503592','0985931960','','','','','','','','','','',''),
(703,1001,1001999,1,'TOMAS','ARBE VEGA','','3750088','0984832770','','','','','','','','','','',''),
(704,216,216350,1,'MIRNA','ROSANA ROJAS JIMENEZ','','6363882','0971420429','','','','','','','','','','',''),
(705,216,216350,1,'MARTA','MARINA SANCHEZ RAMIREZ','','2438847','','','','','','','','','','','',''),
(706,216,216350,1,'OSCAR','LEONEL MARTINEZ','','7776124','0983287064','','','','','','','','','','',''),
(707,216,216350,1,'AMADA','PESOA VAZQUEZ','','2068173','','','','','','','','','','','',''),
(708,216,216350,1,'NATALIA','BERNAL GIMENEZ','','5983789','','','','','','','','','','','',''),
(709,216,216350,1,'DENIS','DAMIAN BENITEZ CHAVEZ','','7017884','0975516170','','','','','','','','','','',''),
(710,216,216350,1,'RAFAEL','SOSA BRITOS','','2215282','0971609541','','','','','','','','','','',''),
(711,216,216450,1,'JAVIER','BAEZ GARAY','','3416354','0971526768','','','','','','','','','','',''),
(712,216,216350,1,'NORMA','ALICE AGUILERAOVELAR','','2479419','','','','','','','','','','','',''),
(713,216,216100,1,'CARLOS','GABRIEL JARA LOPEZ','','6920508','0985271437','','','','','','','','','','',''),
(714,216,216350,1,'LIDIA','PAREDES FRNACO','','4383381','','','','','','','','','','','',''),
(715,216,216260,1,'CELSO','ANTONIO NOGUERA PINTOS','','4654638','0982152212','','','','','','','','','','',''),
(716,216,216350,1,'FRANCISCO','ANTONIO MARECO RODRIGUEZ','','6593484','','','','','','','','','','','',''),
(717,216,216260,1,'LUIS','ALCIDES RIVAS CASTILLO','','6873727','0975137152','','','','','','','','','','',''),
(718,216,216350,1,'OSCAR','DANIEL SALINAS','','8263088','0985401743','','','','','','','','','','',''),
(719,216,216350,1,'CECILIO','BRITOS BRITES','','5912323','09745795572','','','','','','','','','','',''),
(720,216,216350,1,'DEL','CARMEN GARCIA PAREDES','','2254498','','','','','','','','','','','',''),
(721,216,216400,1,'ANTONIA','SOLEDAD AGUILERA OVELAR','','55','0981749203','','','','','','','','','','',''),
(722,216,216350,1,'FREDY','HERNAN PAREDES VILLAGRA','','7380675','0983670795','','','','','','','','','','',''),
(723,216,216350,1,'FATIMA','ARCE FERNANDEZ','','6851074','','','','','','','','','','','',''),
(724,216,216350,1,'ABELINA','SOSA ROMERO','','4023166','','','','','','','','','','','',''),
(725,216,216260,1,'CECILIA','ALVARENGA CAMACHO','','7007697','','','','','','','','','','','',''),
(726,216,216260,1,'FATIMA','ROMINA FERREIRA VERA','','4967458','','','','','','','','','','','',''),
(727,216,216350,1,'ROSALBA','VAZQUEZ PAREDES','','5977503','','','','','','','','','','','',''),
(728,216,216350,1,'ELDA','IGNACIA BENITEZ JIMENEZ','','5073203','','','','','','','','','','','',''),
(729,216,216350,1,'VICTORIA','DUARTE DE ARANDA','','6598331','0986634429','','','','','','','','','','',''),
(730,216,216350,1,'SABINO','ROMAN ROLON','','3307942','','','','','','','','','','','',''),
(731,216,216310,1,'NORMA','JULIANA CAÑETE ROLON','','3960305','','','','','','','','','','','',''),
(732,216,216350,1,'LIZ','PATRICIA CAMACHO GAMARRA','','7063943','','','','','','','','','','','',''),
(733,216,216260,1,'ANGELINA','PRIETO MARTINEZ','','5080651','0984422395','','','','','','','','','','',''),
(734,216,216300,1,'ANIBAL','RODRIGUEZ VILLAVERDE','','3901946','','','','','','','','','','','',''),
(735,216,216350,1,'GABRIEL','ROLON SAMUDIO','','5785709','','','','','','','','','','','',''),
(736,216,216350,1,'MARIA','ESTER AMARILLA ROJAS','','5346175','0973559001','','','','','','','','','','',''),
(737,216,216350,1,'CARLOS','ALBERTO LOPEZ DIAZ','','5575451','','','','','','','','','','','',''),
(738,216,216350,1,'JULIANO','VENANCIO DA SILVA','','7668279','0982515508','','','','','','','','','','',''),
(739,216,216350,1,'CEVERIANO','SOSA ROMERO','','6589726','0983507664','','','','','','','','','','',''),
(740,216,216350,1,'PABLINA','GAVILAN PEREIRA','','5758419','','','','','','','','','','','',''),
(741,216,216350,1,'EVER','RECALDE ALFONZO','','7441826','','','','','','','','','','','',''),
(742,216,216350,1,'HILDA','GONZALEZ CUENCA','','5492138','0973116844','','','','','','','','','','',''),
(743,216,216350,1,'ORLANDO','MACHUCA ROTELA','','3657277','','','','','','','','','','','',''),
(744,216,216350,1,'RAMONA','GARRIDO','','1111239','','','','','','','','','','','',''),
(745,216,216350,1,'IVAN','MOISES GONZALEZ CACERES','','6860856','0983566264','','','','','','','','','','',''),
(746,216,216350,1,'JOSE','ASUNCION DOMINGUEZ ESPINOLA','','2051182','0984728280','','','','','','','','','','',''),
(747,216,216350,1,'JACINTO','AREVALO','','2430262','0983991556','','','','','','','','','','',''),
(748,216,216350,1,'ANSELMO','SIMEON RODRIGUEZ','','2062015','0975368463','','','','','','','','','','',''),
(749,216,216350,1,'CLAUDIA','MERI CASTRO','','7294722','0975598772-097536034','','','','','','','','','','',''),
(750,216,216350,1,'RAQUELA','BERNAL FLEITAS','','7296917','0982710454','','','','','','','','','','',''),
(751,216,216350,1,'FERMIN','FIGUEREDO SERVIN','','2975211','0982889270','','','','','','','','','','',''),
(752,216,216350,1,'ABDO','RAMON CACERES LOPEZ','','6962177','','','','','','','','','','','',''),
(753,216,216350,1,'CRISNILDA','CANDIA PEREIRA','','6363294','','','','','','','','','','','',''),
(754,216,216350,1,'OMAR','RICARDO LOPEZ GOMEZ','','6796012','0971351886','','','','','','','','','','',''),
(755,216,216350,1,'NOELIA','JARA CARTAMAN','','7107062','','','','','','','','','','','',''),
(757,203,203650,1,'EFIGENIO','GERDING MEDOZA','','3730758','0983162878','','','','','','','','','','',''),
(758,216,216350,1,'CRISTIAN','JABIER LOPEZ BARRETO','','4232755','0987156175','','','','','','','','','','',''),
(759,1403,1403100,1,'SILVINO','ROMERO GUTIERRE','','2076971','0983869258','','MARACANA 6TO ENCUADRE','','','','','','','','',''),
(760,216,216350,1,'ELEUTERIO','AYALA GONZALEZ','','3929232','0973572773','','','','','','','','','','',''),
(761,216,216320,1,'HUGO','RAMON ROA VILLALBA','','4313876','0982457440','','','','','','','','','','',''),
(762,216,216350,1,'ALDO','AGUILAR CACERES','','7036721','0976462888','','','','','','','','','','',''),
(763,216,216350,1,'CARLOS','ALEXANDER FRANCO LUGO','','5479732','0986693836','','','','','','','','','','',''),
(764,216,216400,1,'JUAN','GABRIELCHAVEZ FRANCO','','6381851','0982803842','','','','','','','','','','',''),
(765,216,216350,1,'SILVERIO','SANCHEZ RAMIREZ','','3723074','0984176688','','','','','','','','','','',''),
(766,1403,1403170,1,'JOSE','CARDOZOCAÑIZA','','7488728','0982231479','','','','','','','','','','',''),
(767,216,216350,1,'LUDY','ESTELA JACQUET BORDON','','5115891','0983911253','','','','','','','','','','',''),
(768,208,208380,1,'BENITA','FERNANDEZ PEREIRA','','7259209','','','','','','','','','','','',''),
(769,216,216350,1,'GERONIMO','ACUÑA','','7261844','0987334590','','VIVE DETRAS DE LALO ENRIQUEZ','','','','','','','','',''),
(770,216,216260,1,'NADIA','LOPEZ BENITEZ','','1224180','0985315195','','','','','','','','','','',''),
(771,216,216470,1,'ARNALDO','ANDRES RANIREZ PRUDTTOME','','6163219','0985351318','','','','','','','','','','',''),
(772,216,216350,1,'JOISI','PILTZ BERWANGERR','','5881168','','','','','','','','','','','',''),
(773,216,216260,1,'FABIO','ADALBERTO CABELLO PESOA','','6475365','0972968334','','','','','','','','','','',''),
(774,216,216350,1,'MIRTA','CAROLINA MARTINEZ GERDING','','4941573','0976148192','','','','','','','','','','',''),
(775,216,216350,1,'EUSEBIO','MARTINEZ PAREDES','','2821861','0984580042','','','','','','','','','','',''),
(776,216,216350,1,'GRISELDA','CAÑETE ROLON','','5926578','','','','','','','','','','','',''),
(777,216,216260,1,'PEDRO','FABIAN GIMENEZ SILVA','','7689782','0971734278','','','','','','','','','','',''),
(778,216,216260,1,'BERNARDA','AZCONA MORENO','','6098147','','','','','','','','','','','',''),
(779,216,216350,1,'LILIAN','JARA CARTAMAN','','7043483','','','','','','','','','','','',''),
(780,216,216290,1,'RONALDO','CANDIA DIAZ','','5920218','','','','','','','','','','','',''),
(782,216,216290,1,'CELIA','GONZALEZ ZORRILLA','','5855332','','','','','','','','','','','',''),
(783,216,216260,1,'DANIEL','ELIEZER MIRANDA ORTIZ','','7017788','','','','','','','','','','','',''),
(784,216,216350,1,'MARIA','ROQUE ORTIZ GOMEZ','','3815489','','','','','','','','','','','',''),
(785,203,203490,1,'JUSTINA','MARLENE SAAVEDRA','','5163760','0985762140','','','','','','','','','','',''),
(786,216,216350,1,'LUIS','ALBERTO GONZALEZ AREVALOS','','4397981','984544365','','','','','','','','','','',''),
(787,216,216350,1,'BERNARDINO','RECALDE CACERES','','3752929','0983481603','','','','','','','','','','',''),
(788,216,216350,1,'WILIAN','DAVID LOPEZ SILVA','','7788000','0992641744','','','','','','','','','','',''),
(789,203,203120,1,'RODRIGO','MARCIAL AGUERO ESPINOLA','','8085192','0984391300','','','','','','','','','','',''),
(790,216,216350,1,'DELFINO','AMARILLA ALUISO','','4043793','0986784230','','','','','','','','','','',''),
(791,216,216350,1,'MAXIMO','VICENTE TROCHE TORALES','','5755591','0985962107','','','','','','','','','','',''),
(792,216,216350,1,'JAVIER','MIRANDA CACERES','','6745738','0982757041','','','','','','','','','','',''),
(793,216,216350,1,'ROCIO','DAIHANA LOPEZ BALBUENA','','8018525','0975310183','','','','','','','','','','',''),
(794,216,216350,1,'WILSON','MARCIANO VAZQUEZ CABALLERO','','4399636','0975497119-097532318','','','','','','','','','','',''),
(795,216,216350,1,'MARCOS','BASTIAN PEITER','','8734786','0981546326','','','','','','','','','','',''),
(796,203,203120,1,'JUAN','GOMEZ LUGO','','5015342','0982668983','','','','','','','','','','',''),
(797,216,216290,1,'ADRIAN','CAMACHO ACOSTA','','2222','','','','','','','','','','','',''),
(798,203,203999,1,'GRUPO','EMMANUEL','','33','0984260387','','','','','','','','','','',''),
(799,216,216350,1,'YANINA','ELIZABETH SAMANIEGO GAMARRA','','702364','+34633574506','','','','','','','','','','',''),
(800,216,216350,1,'LOURDES','RAQUEL LUGO AYALA','','6835928','0975828143','','','','','','','','','','',''),
(801,218,218001,1,'YASMIL','ESMILCAR FERREIRA','','7010473','0985233127','','','','','','','','','','',''),
(802,216,216350,1,'LOURDES','MARIA CARDOZO LOPEZ','','4844729','0984114514','','','','','','','','','','',''),
(803,216,216350,1,'ANGEL','GIMENEZ BENITEZ','','2680164','0984183610','','','','','','','','','','',''),
(804,216,216350,1,'CINTHIA','CAROLINA CAMACHO ESCOBAR','','5839972','','','','','','','','','','','',''),
(805,216,216260,1,'NELSON','JAVIER PAREDES VAZQUEZ','','6364099','0972862655','','','','','','','','','','',''),
(806,216,216350,1,'CAROLINA','ACOSTA CANDIA','','6923232','0984878196','','','','','','','','','','',''),
(807,216,216350,1,'DINA','NOEMI ZARATE ARBE','','6992778','0971314978','','','','','','','','','','',''),
(808,216,216350,1,'GUSTAVO','ADOLFO MARTINEZ PAREDES','','5810141','','','','','','','','','','','',''),
(809,208,208380,1,'JOAQUIN','AGUILERA ARGUELLO','','4530084','0975360312','','','','','','','','','','',''),
(810,216,216260,1,'LEIDI','DAHIANA VERA FERNANDEZ','','7137341','0972940846','','','','','','','','','','',''),
(811,216,216350,1,'JUAN','CAÑETE CARDOZO','','1260709','0971392811','','','','','','','','','','',''),
(812,216,216350,1,'MOISES','VARELA SERVIN','','6318155','0984940965','','','','','','','','','','',''),
(813,216,216350,1,'CRISTINO','RAMON AGUERO AREVALOS','','3280425','0982651732','','','','','','','','','','',''),
(814,216,216350,1,'GILDA','RAMONA JARA PORTILLO','','6361543','','','','','','','','','','','',''),
(815,216,216350,1,'DENIS','MELGAREJO FLORENTIN','','6107072','','','','','','','','','','','',''),
(816,216,216350,1,'ALEXANDER','ROA BENITEZ','','7172355','','','','','','','','','','','',''),
(817,216,216350,1,'JUAN','HERIBERTO ALMADA BENITEZ','','5316533','','','','','','','','','','','',''),
(818,216,216350,1,'GABRIEL','CANDIA PEREIRA','','4400421','','','','','','','','','','','',''),
(819,216,216350,1,'JULIA','ACOSTA','','4458616','0985183487','','','','','','','','','','',''),
(820,216,216350,1,'NEIDE','MARIBEL ROLON FERREIRA','','5640209','0971258235','','','','','','','','','','',''),
(821,216,216400,1,'ARNALDO','ANDRES MARTINEZ AGUILERA','','6121684','0985526884','','','','','','','','','','',''),
(822,216,216350,1,'ANTONIO','JOAQUIN GALEANO RAMIREZ','','1510309','0971962130','','','','','','','','','','',''),
(823,216,216350,1,'MARIANO','RAFAEL GARAY ROJAS','','6908191','0972611028','','','','','','','','','','',''),
(824,216,216350,1,'JUAN','CARLOS CENTURION GOMEZ','','1925779','0983576428','','','','','','','','','','',''),
(825,216,216350,1,'MONICA','LOPEZ','','5385236','','','','','','','','','','','',''),
(826,216,216260,1,'ROSA','MABEL MERELES ROJAS','','5617237','','','','','','','','','','','',''),
(827,216,216260,1,'LUIS','FERNANDO CABELLO RODRIGUEZ','','5640090','0975327072','','','','','','','','','','',''),
(828,216,216350,1,'MARIO','ARIEL GIMENEZ LARROZA','','6847428','0985663731','','','','','','','','','','',''),
(829,216,216310,1,'MARICEL','CAÑETE RAMIREZ','','4762153','0976458453','','','','','','','','','','',''),
(830,216,216350,1,'SEBASTIAN','EMANUEL GONZALEZ OLMEDO','','8434076','0975347641','','','','','','','','','','',''),
(831,216,216350,1,'DIEVER','ARZAMENDIA PESOA','','5920192','0971358337','','','','','','','','','','',''),
(832,216,216350,1,'DALILA','ENRIQUEZ GARCIA','','4308912','','','','','','','','','','','',''),
(833,216,216400,1,'AGRO','M Y M S.R.L','','80058191','0983116685','','','','','','','','','','',''),
(834,216,216350,1,'OSVALDO','LOPEZ RUIZ','','1561268','0981749462','','','','','','','','','','',''),
(835,216,216350,1,'CAYO','ANTONIO ZORILLA VILLALBA','','6312677','0994594943','','','','','','','','','','',''),
(836,1403,1403140,1,'FIDEL','RAMON MARTINEZ ZARZA','','5177159','0983201671','','','','','','','','','','',''),
(837,216,216130,1,'ALFREDO','PERALTA AREVALOS','','6688484','0982331091','','','','','','','','','','',''),
(838,216,216350,1,'DAVID','DANIEL TRINIDAD RUIZ','','7715561','','','','','','','','','','','',''),
(839,216,216350,1,'JAVIER','ORTIZ LOPEZ','','2593715','','','','','','','','','','','',''),
(840,216,216350,1,'EDGAR','GIMENEZ DUARTE','','6336463','0986979110','','','','','','','','','','',''),
(841,216,216310,1,'ANIBAL','RIVAS LOPEZ','','4400438','0973743057','','','','','','','','','','',''),
(842,216,216400,1,'ALDO','RENE SANTACRUZ MENDEZ','','2988779','0986825245','','','','','','','','','','',''),
(843,204,204170,1,'REINALDO','NOGUERA GIRETT','','6075962','0972306274','','','','','','','','','','',''),
(844,216,216350,1,'ROSANA','PEREIRA MENDOZA','','3548026','0971109545','','','','','','','','','','',''),
(845,216,216350,1,'LUCIA','RAMONA VAZQUEZ CUENCA','','7011995','0971129394','','','','','','','','','','',''),
(846,216,216260,1,'NATALIA','BELEN ROJAS BENITEZ','','6635846','0972985152','','','','','','','','','','',''),
(847,216,216350,1,'PEDRO','ARIEL PEREIRA CANDIA','','6603137','0983437430','','','','','','','','','','',''),
(848,216,216350,1,'DIEGO','LEZCANO ISASI','','6197917','','','','','','','','','','','',''),
(849,216,216350,1,'ELIGIO','BENITEZ ACOSTA','','3365205','','','','','','','','','','','',''),
(850,216,216290,1,'NELIDA','ROSA RIVAROLA ALMIRON','','7206397','+24885939','','','','','','','','','','',''),
(851,216,216350,1,'MARIO','GABRIEL SILVEIRA QUIÑONEZ','','5424062','0975904065','','','','','','','','','','',''),
(852,1110,1110013,1,'LORENZO','ARIEL OVELAR MONTIEL','','3781479','0982555278','','','','','','','','','','',''),
(853,216,216350,1,'ELIDA','ACHEZA ALFONSO','','6363289','+56974959221','','','','','','','','','','',''),
(854,216,216350,1,'OSCAR','DANIEL CARDOZO ACOSTA','','6674817','0975934857','','','','','','','','','','',''),
(855,216,216350,1,'ROSAURA','DOMINGUEZ PAREDES','','7320733','0986670488','','','','','','','','','','',''),
(856,216,216350,1,'RICHARD','ARIEL CUENCA MARTINEZ','','7310268','0971486785','','','','','','','','','','',''),
(857,208,208720,1,'LUIS','SERVIN','','5793856','0983198993','','','','','','','','','','',''),
(858,216,216350,1,'CARLOS','RUBEN GARCETE INSFRAN','','6205006','0976836117','','','','','','','','','','',''),
(859,216,216350,1,'FATIMA','FRUTOS BAEZ','','6001375','0983427314','','','','','','','','','','',''),
(860,216,216260,1,'PAOLO','SEBASTIAN OLMEDO ESTIGARRIBIA','','4567091','0984527201','','','','','','','','','','',''),
(861,216,216350,1,'LORENZA','AMAMBAY CARDENAS BOGADO','','6364004','0976119842','','','','','','','','','','',''),
(862,216,216350,1,'PABLINO','DIAZ ALVARENGA','','6191982','0982331172','','','','','','','','','','',''),
(863,216,216350,1,'CAMILO','FERNANDO CABELLO SANTACRUZ','','5870990','','','','','','','','','','','',''),
(864,216,216350,1,'TEODORA','GAMARRA VAZQUEZ','','6002640','0975302653','','','','','','','','','','',''),
(865,216,216260,1,'ANA','VERONICA ENRIQUEZ GARCIA','','5636794','0982343383','','HNA DE REBECA','','','','','','','','',''),
(866,216,216350,1,'ANGELICA','PAVON GARCIA','','5756278','','','','','','','','','','','',''),
(867,216,216350,1,'JAVIER','DECOUD VILLALBA','','4138182','','','','','','','','','','','',''),
(868,216,216260,1,'DELCY','COLMAN PELOZO','','7182001','0986310058','','','','','','','','','','',''),
(869,216,216260,1,'ANALIA','TORALEZ','','5464796','0982211842','','AMIGA DE REBECA','','','','','','','','',''),
(870,216,216350,1,'ROCIO','SOLEDAD ACUÑA RIOS','','5995683','0984018066','','','','','','','','','','',''),
(871,216,216260,1,'EDGAR','LUCIANO ROJAS VALDEZ','','2120383','','','','','','','','','','','',''),
(872,216,216350,1,'ANTONIO','RAMON LOPEZ GOMEZ','','5552519','0973664153','','','','','','','','','','',''),
(873,216,216350,1,'JUSTINIANA','RUIZ DE LOPEZ','','1460582','0984101608','','','','','','','','','','',''),
(874,203,203380,1,'MIGUEL','ANDRES OJEDA ZORRILLA','','4833213','0984260387','','','','','','','','','','',''),
(875,203,203004,1,'ANDRES','GUSMAN LOPEZ DIAZ','','7026927','0987139692','','','','','','','','','','',''),
(876,216,216350,1,'RICARDO','RAMON TORRES ENRIQUE','','6702475','','','','','','','','','','','',''),
(877,216,216260,1,'MARIO','MENCIA  VAZQUEZ','','2068193','0981684871','','VIVE EN CASA DE CESAR','','','','','','','','',''),
(879,216,216350,1,'GILDA','GAVILAN BURGOS','','6753616','0987103207','','TRABAJA EN ÑA BLANCA OLMEDO','','','','','','','','',''),
(880,216,216260,1,'LIDER','GABRIEL OLMEDO MELGAREJO','','8027155','','','VIVE EN EL FONDO','','','','','','','','',''),
(881,216,216260,1,'TORIBIO','ARGUELLO ORTEGA','','3608126','0982996517','','','','','','','','','','',''),
(882,216,216350,1,'ANTOLIANO','BENITEZ ACOSTA','','1893651','','','','','','','','','','','',''),
(883,216,216350,1,'HECTOR','JAVIER BENITEZ CABALELRO','','6690405','0982850718','','','','','','','','','','',''),
(884,216,216350,1,'ARISTIDES','DUARTE LARROZA','','2495418','','','','','','','','','','','',''),
(885,216,216350,1,'SONIA','LIZA BRITOS LOPEZ','','6858864','0975492191','','','','','','','','','','',''),
(886,216,216260,1,'GABRIELA','TRINIDAD ALVARENGA','','2687535','','','','','','','','','','','',''),
(887,216,216260,1,'EVELIN','RAQUEL ORTIZ','','7108214','','','','','','','','','','','',''),
(888,216,216260,1,'CELIA','CANDIA FERNANDEZ','','5320247','+34643084536','','','','','','','','','','',''),
(889,216,216260,1,'ALEXSANDRO','GUAYUAN GAMARRA','','6003044','0973878074','','','','','','','','','','',''),
(890,216,216260,1,'MAURO','WELLENGTEO BARRIOS','','5855212','5855212','','','','','','','','','','',''),
(891,216,216350,1,'JORGELINA','SOSA ROMERO','','3876118','0973572773','','','','','','','','','','',''),
(892,216,216260,1,'LIDUVINA','CASTILLO MEDINA','','3633518','+541134337203','','','','','','','','','','',''),
(893,1101,1101999,1,'LIZ','PAMELA MARTINEZ DRAZ','','5129027','0983167075','','','','','','','','','','',''),
(894,206,206130,1,'GUIDO','DANIEL AVALOS IBARROLA','','6690711','0971513593','','','','','','','','','','',''),
(895,216,216260,1,'AGUSTIN','DAVID LOPEZ BARRETO','','4384842','0981751030','','','','','','','','','','',''),
(896,216,216350,1,'OFELIA','FERNANDEZ MARTINEZ','','4941569','','','','','','','','','','','',''),
(897,216,216350,1,'MIRNA','MARTINEZ GONZALEZ','','7011987','+34611309271','','','','','','','','','','',''),
(898,216,216260,1,'NOELIA','MARTINEZ GONZALEZ','','6705202','0985480569','','','','','','','','','','',''),
(899,203,203120,1,'DAVID','SAMUEL FIGUEREDO LOPEZ','','6374061','0972822825','','','','','','','','','','',''),
(900,216,216350,1,'WILMA','MENDOZA AQUINO','','7865409','0986363102','','','','','','','','','','',''),
(901,216,216350,1,'ANALIA','MARTINEZ GODOY','','6695679','0994595760','','','','','','','','','','',''),
(902,216,216260,1,'RAFAEL','TRINIDAD ALVARENGA','','2986428','0984786219','','','','','','','','','','',''),
(903,216,216350,1,'RODY','ARMANDO ROJAS CARDOZO','','6990102','0976457138','','','','','','','','','','',''),
(904,216,216350,1,'ROBERTO','CARLOS FLORENTIN PAIVA','','6986165','0971871597','','','','','','','','','','',''),
(905,216,216350,1,'SARA','CARDOZO PERALTA','','4674269','0971470544','','','','','','','','','','',''),
(906,216,216350,1,'ALCIDES','VASQUEZ CABALLERO','','6363976','0973454704','','','','','','','','','','',''),
(907,216,216260,1,'ADALINA','BENITEZ ROMERO','','4358435','','','','','','','','','','','',''),
(908,216,216340,1,'JAVIER','GALEANO GIMENEZ','','3805416','0984271461','','FRENTE DE LA BODEGA ZOE','','','','','','','','',''),
(909,216,216350,1,'CARMEN','AGUERO ZARATE','','6100319','0984256778','','','','','','','','','','',''),
(910,216,216350,1,'ALICIA','GAMARRA VAZQUEZ','','4305531','+34657944187','','SAN FRANCISCO','','','','','','','','',''),
(911,216,216350,1,'CARLOS','JUSTINO MORAN ROJAS','','5106463','0971717957','','','','','','','','','','',''),
(912,203,203660,1,'SERGIO','JAVIER RAMIREZ','','8683008','0987421723','','','','','','','','','','',''),
(913,203,203310,1,'ROLANDO','GONZALEZ GONZALEZ','','3449323','0983884873','','','','','','','','','','',''),
(914,216,216260,1,'LISA','FERNANDEZ VAZQUEZ','','8648083','0971435429','','','','','','','','','','',''),
(915,216,216350,1,'MELANI','AILEN GONZALEZ ORTIZ','','7553124','0975242762','','','','','','','','','','',''),
(916,216,216350,1,'HERNAN','DANIEL AGUERO PACHECO','','6049198','0976439685','','','','','','','','','','',''),
(917,216,216300,1,'LIDYS','FABIOLA GONZALEZ','','6092507','','','','','','','','','','','',''),
(918,216,216400,1,'EDGAR','ELIGIO ALVISO','','3244724','0982649397','','','','','','','','','','',''),
(919,216,216350,1,'SEBASTIAN','FERREIRA VERA','','6363997','0983317376','','','','','','','','','','',''),
(920,216,216350,1,'RAMÓN','OTAZÚ LOPEZ','','3679914','0976434126','','','','','','','','','','',''),
(921,216,216260,1,'ELVIO','MENDOZA SANTANDER','','6731134','0986534771','','','','','','','','','','',''),
(922,216,216260,1,'ANDREA','ROSANA CABELLO PESOA','','4663032','0986744821','','','','','','','','','','',''),
(923,216,216260,1,'SANDRA','REBECA ENRIQUEZ GARCIA','','7014417','0986894111','','HIJA DE VICHY','','','','','','','','',''),
(924,216,216260,1,'DERLIS','ANTONIO BENITEZ GIMENEZ','','5346148','0984118418','','','','','','','','','','',''),
(925,216,216280,1,'GENNIFER','NOEMI CANDIA FERNANDEZ','','6363309','0975979666','','','','','','','','','','',''),
(926,216,216350,1,'JULIO','IVAN BENITEZ LÓPEZ','','7125214','0975262658','','','','','','','','','','',''),
(927,216,216350,1,'ESTER','RAMIREZ DUARTE','','7146104','0987137761','','','','','','','','','','','');

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

/*Data for the table `cobrador` */

insert  into `cobrador`(`idcobrador`,`idPersonal`,`idzona`) values 
(1,1,1);

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

/*Data for the table `compra` */

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

/*Data for the table `compra_detalle` */

/*Table structure for table `concepto_caja` */

DROP TABLE IF EXISTS `concepto_caja`;

CREATE TABLE `concepto_caja` (
  `idconcepto` int(11) NOT NULL AUTO_INCREMENT,
  `concepto` varchar(45) DEFAULT NULL,
  `tipo` enum('E','I') DEFAULT NULL COMMENT 'I Ingresos E Egreso',
  PRIMARY KEY (`idconcepto`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `concepto_caja` */

insert  into `concepto_caja`(`idconcepto`,`concepto`,`tipo`) values 
(1,'VENTAS','I'),
(2,'COMPRAS','E'),
(3,'PAGO DE CUOTAS','I'),
(4,'ANULACION RECIBO','E'),
(5,'ANULACION VENTA','E'),
(6,'ANULACION COMPRA','I');

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

/*Data for the table `conteo_inventario` */

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

/*Data for the table `conteo_inventario_detalle` */

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

/*Data for the table `control_numeracion_timbrado` */

insert  into `control_numeracion_timbrado`(`idcontrol`,`idEmpresa`,`idsucursal`,`establecimiento`,`nro_expedicion`,`timbrado`,`timb_desde`,`timb_hasta`,`contador`,`tipo_documento`,`fecha_ultima_actualizacion`,`activo`) values 
(1,1,1,'001','001','458778889','2025-11-01','2025-12-31',1,'FACTURA','2025-11-30 12:43:00',1),
(2,1,1,'001','001','458778889','2025-11-01','2025-12-31',1,'RECIBO','2025-11-30 13:17:43',1),
(5,1,1,'001','002','458778889','2025-11-01','2025-12-31',1,'RECIBO','2025-11-30 19:17:48',1),
(6,1,1,'001','002','458778889','2025-11-01','2025-12-31',1,'FACTURA','2025-11-30 21:35:12',1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cuotas` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `cuotas_detalle` */

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

/*Data for the table `deposito` */

insert  into `deposito`(`iddeposito`,`deposito`,`idsucursal`) values 
(1,'SALON DE VENTAS',1);

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `detalle_pagos_cuotas` */

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

/*Data for the table `detalle_traslado` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `detalle_venta` */

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

/*Data for the table `empresa` */

insert  into `empresa`(`idEmpresa`,`empresa`,`ruc`,`descrip`,`telefono`) values 
(1,'ARIFAN ELECTRODOMESTICOS                     ','4521464-61','TIENDA DE ELECTRODOMESTICOS','-              ');

/*Table structure for table `grupo` */

DROP TABLE IF EXISTS `grupo`;

CREATE TABLE `grupo` (
  `idgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `grupo` char(45) DEFAULT NULL,
  PRIMARY KEY (`idgrupo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `grupo` */

insert  into `grupo`(`idgrupo`,`grupo`) values 
(1,'S/D'),
(2,'ELECTRODOMESTICOS'),
(3,'MUEBLES'),
(4,'PELUQUERIAS'),
(5,'SONIDO'),
(6,'BAZAR'),
(7,'HERRAMIENTAS');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `kardex` */

/*Table structure for table `marca` */

DROP TABLE IF EXISTS `marca`;

CREATE TABLE `marca` (
  `idMarca` int(11) NOT NULL AUTO_INCREMENT,
  `Marca` char(45) DEFAULT NULL,
  PRIMARY KEY (`idMarca`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;

/*Data for the table `marca` */

insert  into `marca`(`idMarca`,`Marca`) values 
(1,'S/N'),
(2,'SONY'),
(3,'ARNO'),
(4,'SUENOLAR'),
(5,'ELECTROLUX'),
(6,'TEST'),
(7,'APPLE'),
(8,'FAMA'),
(9,'KOLKE'),
(10,'MIDAS'),
(11,'GOODWEATHER'),
(12,'NAPPO'),
(13,'MOVELMAX'),
(14,'ATALAS'),
(15,'ECOPOWER'),
(16,'BEKO'),
(17,'SPEED'),
(18,'CARRIER'),
(19,'TOKIO'),
(20,'CHIQ'),
(21,'MULTIUSER'),
(22,'MULTILASER'),
(23,'PHILIPS');

/*Table structure for table `motivo_ajuste` */

DROP TABLE IF EXISTS `motivo_ajuste`;

CREATE TABLE `motivo_ajuste` (
  `idmotivo` int(11) NOT NULL AUTO_INCREMENT,
  `motivo` varchar(45) DEFAULT NULL,
  `tipo` enum('E','S') DEFAULT NULL COMMENT 'E entradas S salidas',
  PRIMARY KEY (`idmotivo`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

/*Data for the table `motivo_ajuste` */

insert  into `motivo_ajuste`(`idmotivo`,`motivo`,`tipo`) values 
(1,'VENTA','E'),
(2,'COMPRA','E'),
(3,'INVENTARIO INCIAL','E'),
(4,'AJUSTE(+)','E'),
(5,'AJUSTE(-)','S'),
(6,'ANULACION VENTA','E'),
(7,'ANULACION COMPRA','S');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mov_operacion` */

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `pagos_cuotas` */

/*Table structure for table `parametros_sistema` */

DROP TABLE IF EXISTS `parametros_sistema`;

CREATE TABLE `parametros_sistema` (
  `idparametros_sistema` int(10) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(45) DEFAULT NULL,
  `tabla` varchar(45) DEFAULT NULL,
  `valor` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`idparametros_sistema`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `parametros_sistema` */

insert  into `parametros_sistema`(`idparametros_sistema`,`nombre`,`tabla`,`valor`) values 
(1,'CONCEPTO_PAGO_CUOTA','concepto_caja','3'),
(2,'CONCEPTO_VENTA','concepto_caja','1'),
(4,'KADEX_VENTA','motivo_ajuste','1'),
(5,'KADEX_COMPRA','motivo_ajuste','2'),
(6,'COMPRA_CONCEPTO','concepto_caja','2'),
(7,'INTERES_MORA','S/D','1.8'),
(8,'ANULACION_RECIBO','concepto_caja','4'),
(9,'ANULACION_VENTA','concepto_caja','5'),
(10,'KARDEX_ANULACION','motivo_ajuste','6'),
(11,'ANULACION_COMPRA','concepto_caja','6'),
(12,'KARDEX_ANULACION_COMPRA','motivo_ajuste','7');

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

/*Data for the table `personal` */

insert  into `personal`(`idPersonal`,`nombre`,`apellido`,`ci`,`telefono`,`Direccion`,`idsucursal`) values 
(1,'ADMINISTADORES                               ','LOCAL                                        ','-                        ','-                   ','-                                            ',1),
(2,'JUAN                                         ','PEREZ                                        ','-                        ','-                   ','-                                            ',1),
(4,'CESAR                                 ','GODOY CABALLERO                       ','4521478                  ','0987161464          ','CHORE - CASCO CENTRICO                ',1);

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

/*Data for the table `plan_cuota` */

insert  into `plan_cuota`(`idplan_cuota`,`nombre_plan`,`margen_contado`,`interes_mensual`,`limite_cuota`) values 
(1,'S/D',0.00,0.00,0);

/*Table structure for table `profesion` */

DROP TABLE IF EXISTS `profesion`;

CREATE TABLE `profesion` (
  `idprofesion` int(11) NOT NULL AUTO_INCREMENT,
  `profesion` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idprofesion`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `profesion` */

insert  into `profesion`(`idprofesion`,`profesion`) values 
(1,'SIN DEFINIR                                  '),
(3,'CARPINTERO'),
(4,'ING INFORMATICO                              '),
(5,'JUBILADO/A                           '),
(6,'DOCENTE                              '),
(7,'TIKTOKER                                     '),
(8,'COMERCIANTE                          '),
(9,'AGRICULTOR');

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

/*Data for the table `proveedor` */

insert  into `proveedor`(`idproveedor`,`proveedor`,`direccion`,`propietario`,`telefono`,`ruc`,`ci`,`observacion`) values 
(1,'S/D','S/N','-','S/N','S/N',0,''),
(2,'TEST0125','TES','TES','TES','TE',1,''),
(5,'TEST','TES','TEST','TES','TEST',0,'sddasda'),
(6,'GLOBAL IMPORT','ASUNCION','S/D','0432558745','700025598-8',0,'');

/*Table structure for table `secuencias` */

DROP TABLE IF EXISTS `secuencias`;

CREATE TABLE `secuencias` (
  `nombre` varchar(50) NOT NULL,
  `valor` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `secuencias` */

insert  into `secuencias`(`nombre`,`valor`) values 
('articulos',2);

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
) ENGINE=InnoDB AUTO_INCREMENT=345 DEFAULT CHARSET=utf8;

/*Data for the table `stockarticulo` */

insert  into `stockarticulo`(`idstock`,`stock`,`iddeposito`,`idarticulo`,`idsucursal`,`idEmpresa`) values 
(1,0,1,1,1,1),
(2,0,1,2,1,1),
(3,0,1,3,1,1),
(4,0,1,4,1,1),
(5,0,1,5,1,1),
(6,0,1,6,1,1),
(7,0,1,7,1,1),
(8,0,1,8,1,1),
(9,0,1,9,1,1),
(10,0,1,10,1,1),
(11,0,1,11,1,1),
(12,0,1,12,1,1),
(13,0,1,13,1,1),
(14,0,1,14,1,1),
(15,0,1,15,1,1),
(16,0,1,16,1,1),
(17,0,1,17,1,1),
(18,0,1,18,1,1),
(19,0,1,19,1,1),
(20,0,1,20,1,1),
(21,0,1,21,1,1),
(22,0,1,22,1,1),
(23,0,1,23,1,1),
(24,0,1,24,1,1),
(25,0,1,25,1,1),
(26,0,1,26,1,1),
(27,0,1,27,1,1),
(28,0,1,28,1,1),
(29,0,1,29,1,1),
(30,0,1,30,1,1),
(31,0,1,31,1,1),
(32,0,1,32,1,1),
(33,0,1,33,1,1),
(34,0,1,34,1,1),
(35,0,1,35,1,1),
(36,0,1,36,1,1),
(37,0,1,37,1,1),
(38,0,1,38,1,1),
(39,0,1,39,1,1),
(40,0,1,40,1,1),
(41,0,1,41,1,1),
(42,0,1,42,1,1),
(43,0,1,43,1,1),
(44,0,1,44,1,1),
(45,0,1,45,1,1),
(46,0,1,46,1,1),
(47,0,1,47,1,1),
(48,0,1,48,1,1),
(49,0,1,49,1,1),
(50,0,1,50,1,1),
(51,0,1,51,1,1),
(52,0,1,52,1,1),
(53,0,1,53,1,1),
(54,0,1,54,1,1),
(55,0,1,55,1,1),
(56,0,1,56,1,1),
(57,0,1,57,1,1),
(58,0,1,58,1,1),
(59,0,1,59,1,1),
(60,0,1,60,1,1),
(61,0,1,61,1,1),
(62,0,1,62,1,1),
(63,0,1,63,1,1),
(64,0,1,64,1,1),
(65,0,1,65,1,1),
(66,0,1,66,1,1),
(67,0,1,67,1,1),
(68,0,1,68,1,1),
(69,0,1,69,1,1),
(70,0,1,70,1,1),
(71,0,1,71,1,1),
(72,0,1,72,1,1),
(73,0,1,73,1,1),
(74,0,1,74,1,1),
(75,0,1,75,1,1),
(76,0,1,76,1,1),
(77,0,1,77,1,1),
(78,0,1,78,1,1),
(79,0,1,79,1,1),
(80,0,1,80,1,1),
(81,0,1,81,1,1),
(82,0,1,82,1,1),
(83,0,1,83,1,1),
(84,0,1,84,1,1),
(85,0,1,85,1,1),
(86,0,1,86,1,1),
(87,0,1,87,1,1),
(88,0,1,88,1,1),
(89,0,1,89,1,1),
(90,0,1,90,1,1),
(91,0,1,91,1,1),
(92,0,1,92,1,1),
(93,0,1,93,1,1),
(94,0,1,94,1,1),
(95,0,1,95,1,1),
(96,0,1,96,1,1),
(97,0,1,97,1,1),
(98,0,1,98,1,1),
(99,0,1,99,1,1),
(100,0,1,100,1,1),
(101,0,1,101,1,1),
(102,0,1,102,1,1),
(103,0,1,103,1,1),
(104,0,1,104,1,1),
(105,0,1,105,1,1),
(106,0,1,106,1,1),
(107,0,1,107,1,1),
(108,0,1,108,1,1),
(109,0,1,109,1,1),
(110,0,1,110,1,1),
(111,0,1,111,1,1),
(112,0,1,112,1,1),
(113,0,1,113,1,1),
(114,0,1,114,1,1),
(115,0,1,115,1,1),
(116,0,1,116,1,1),
(117,0,1,117,1,1),
(118,0,1,118,1,1),
(119,0,1,119,1,1),
(120,0,1,120,1,1),
(121,0,1,121,1,1),
(122,0,1,122,1,1),
(123,0,1,123,1,1),
(124,0,1,124,1,1),
(125,0,1,125,1,1),
(126,0,1,126,1,1),
(127,0,1,127,1,1),
(128,0,1,128,1,1),
(129,0,1,129,1,1),
(130,0,1,130,1,1),
(131,0,1,131,1,1),
(132,0,1,132,1,1),
(133,0,1,133,1,1),
(134,0,1,134,1,1),
(135,0,1,135,1,1),
(136,0,1,136,1,1),
(137,0,1,137,1,1),
(138,0,1,138,1,1),
(139,0,1,139,1,1),
(140,0,1,140,1,1),
(141,0,1,141,1,1),
(142,0,1,142,1,1),
(143,0,1,143,1,1),
(144,0,1,144,1,1),
(145,0,1,145,1,1),
(146,0,1,146,1,1),
(147,0,1,147,1,1),
(148,0,1,148,1,1),
(149,0,1,149,1,1),
(150,0,1,150,1,1),
(151,0,1,151,1,1),
(152,0,1,152,1,1),
(153,0,1,153,1,1),
(154,0,1,154,1,1),
(155,0,1,155,1,1),
(156,0,1,156,1,1),
(157,0,1,157,1,1),
(158,0,1,158,1,1),
(159,0,1,159,1,1),
(160,0,1,160,1,1),
(161,0,1,161,1,1),
(162,0,1,162,1,1),
(163,0,1,163,1,1),
(164,0,1,164,1,1),
(165,0,1,165,1,1),
(166,0,1,166,1,1),
(167,0,1,167,1,1),
(168,0,1,168,1,1),
(169,0,1,169,1,1),
(170,0,1,170,1,1),
(171,0,1,171,1,1),
(172,0,1,172,1,1),
(173,0,1,173,1,1),
(174,0,1,174,1,1),
(175,0,1,175,1,1),
(176,0,1,176,1,1),
(177,0,1,177,1,1),
(178,0,1,178,1,1),
(179,0,1,179,1,1),
(180,0,1,180,1,1),
(181,0,1,181,1,1),
(182,0,1,182,1,1),
(183,0,1,183,1,1),
(184,0,1,184,1,1),
(185,0,1,185,1,1),
(186,0,1,186,1,1),
(187,0,1,187,1,1),
(188,0,1,188,1,1),
(189,0,1,189,1,1),
(190,0,1,190,1,1),
(191,0,1,191,1,1),
(192,0,1,192,1,1),
(193,0,1,193,1,1),
(194,0,1,194,1,1),
(195,0,1,195,1,1),
(196,0,1,196,1,1),
(197,0,1,197,1,1),
(198,0,1,198,1,1),
(199,0,1,199,1,1),
(200,0,1,200,1,1),
(201,0,1,201,1,1),
(202,0,1,202,1,1),
(203,0,1,203,1,1),
(204,0,1,204,1,1),
(205,0,1,205,1,1),
(206,0,1,206,1,1),
(207,0,1,207,1,1),
(208,0,1,208,1,1),
(209,0,1,209,1,1),
(210,0,1,210,1,1),
(211,0,1,211,1,1),
(212,0,1,212,1,1),
(213,0,1,213,1,1),
(214,0,1,214,1,1),
(215,0,1,215,1,1),
(216,0,1,216,1,1),
(217,0,1,217,1,1),
(218,0,1,218,1,1),
(219,0,1,219,1,1),
(220,0,1,220,1,1),
(221,0,1,221,1,1),
(222,0,1,222,1,1),
(223,0,1,223,1,1),
(224,0,1,224,1,1),
(225,0,1,225,1,1),
(226,0,1,226,1,1),
(227,0,1,227,1,1),
(228,0,1,228,1,1),
(229,0,1,229,1,1),
(230,0,1,230,1,1),
(231,0,1,231,1,1),
(232,0,1,232,1,1),
(233,0,1,233,1,1),
(234,0,1,234,1,1),
(235,0,1,235,1,1),
(236,0,1,236,1,1),
(237,0,1,237,1,1),
(238,0,1,238,1,1),
(239,0,1,239,1,1),
(240,0,1,240,1,1),
(241,0,1,241,1,1),
(242,0,1,242,1,1),
(243,0,1,243,1,1),
(244,0,1,244,1,1),
(245,0,1,245,1,1),
(246,0,1,246,1,1),
(247,0,1,247,1,1),
(248,0,1,248,1,1),
(249,0,1,249,1,1),
(250,0,1,250,1,1),
(251,0,1,251,1,1),
(252,0,1,252,1,1),
(253,0,1,253,1,1),
(254,0,1,254,1,1),
(255,0,1,255,1,1),
(256,0,1,256,1,1),
(257,0,1,257,1,1),
(258,0,1,258,1,1),
(259,0,1,259,1,1),
(260,0,1,260,1,1),
(261,0,1,261,1,1),
(262,0,1,262,1,1),
(263,0,1,263,1,1),
(264,0,1,264,1,1),
(265,0,1,265,1,1),
(266,0,1,266,1,1),
(267,0,1,267,1,1),
(268,0,1,268,1,1),
(269,0,1,269,1,1),
(270,0,1,270,1,1),
(271,0,1,271,1,1),
(272,0,1,272,1,1),
(273,0,1,273,1,1),
(274,0,1,274,1,1),
(275,0,1,275,1,1),
(276,0,1,276,1,1),
(277,0,1,277,1,1),
(278,0,1,278,1,1),
(279,0,1,279,1,1),
(280,0,1,280,1,1),
(281,0,1,281,1,1),
(282,0,1,282,1,1),
(283,0,1,283,1,1),
(284,0,1,284,1,1),
(285,0,1,285,1,1),
(286,0,1,286,1,1),
(287,0,1,287,1,1),
(288,0,1,288,1,1),
(289,0,1,289,1,1),
(290,0,1,290,1,1),
(291,0,1,291,1,1),
(292,0,1,292,1,1),
(293,0,1,293,1,1),
(294,0,1,294,1,1),
(295,0,1,295,1,1),
(296,0,1,296,1,1),
(297,0,1,297,1,1),
(298,0,1,298,1,1),
(299,0,1,299,1,1),
(300,0,1,300,1,1),
(301,0,1,301,1,1),
(302,0,1,302,1,1),
(303,0,1,303,1,1),
(304,0,1,304,1,1),
(305,0,1,305,1,1),
(306,0,1,306,1,1),
(307,0,1,307,1,1),
(308,0,1,308,1,1),
(309,0,1,309,1,1),
(310,0,1,310,1,1),
(311,0,1,311,1,1),
(312,0,1,312,1,1),
(313,0,1,313,1,1),
(314,0,1,314,1,1),
(315,0,1,315,1,1),
(316,0,1,316,1,1),
(317,0,1,317,1,1),
(318,0,1,318,1,1),
(319,0,1,319,1,1),
(320,0,1,320,1,1),
(321,0,1,321,1,1),
(322,0,1,322,1,1),
(323,0,1,323,1,1),
(324,0,1,324,1,1),
(325,0,1,325,1,1),
(326,0,1,326,1,1),
(327,0,1,327,1,1),
(328,0,1,328,1,1),
(329,0,1,329,1,1),
(330,0,1,330,1,1),
(331,0,1,331,1,1),
(332,0,1,332,1,1),
(333,0,1,333,1,1),
(334,0,1,334,1,1),
(335,0,1,335,1,1),
(336,0,1,336,1,1),
(337,0,1,337,1,1),
(338,0,1,338,1,1),
(339,0,1,339,1,1),
(340,0,1,340,1,1),
(341,0,1,341,1,1),
(342,0,1,342,1,1),
(343,0,1,343,1,1),
(344,0,1,344,1,1);

/*Table structure for table `subgrupo` */

DROP TABLE IF EXISTS `subgrupo`;

CREATE TABLE `subgrupo` (
  `idsubgrupo` int(11) NOT NULL AUTO_INCREMENT,
  `subgrupo` varchar(45) DEFAULT NULL,
  `idgrupo` int(11) NOT NULL,
  PRIMARY KEY (`idsubgrupo`),
  KEY `fk_subgrupo_grupo1_idx` (`idgrupo`),
  CONSTRAINT `fk_subgrupo_grupo1` FOREIGN KEY (`idgrupo`) REFERENCES `grupo` (`idgrupo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `subgrupo` */

insert  into `subgrupo`(`idsubgrupo`,`subgrupo`,`idgrupo`) values 
(1,'S/D',1),
(2,'AIRES                                 ',2),
(3,'BALANZAS                              ',2),
(4,'BALCONES                              ',3),
(5,'BARBEADOR                             ',4),
(6,'AUDICULARES                           ',5),
(7,'ASPIRADORAS                           ',2),
(8,'ASADERAS                              ',6),
(9,'ANAFE                                 ',2),
(10,'AMOLADORAS                            ',7);

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

/*Data for the table `sucursal` */

insert  into `sucursal`(`idsucursal`,`idEmpresa`,`sucursal`,`ciudad`,`direccion`,`telefono`) values 
(1,1,'CASA CENTRAL','GUAJAYBI','TORO PIRU II','-');

/*Table structure for table `tipo_pago` */

DROP TABLE IF EXISTS `tipo_pago`;

CREATE TABLE `tipo_pago` (
  `idTipo_pago` int(11) NOT NULL AUTO_INCREMENT,
  `tipo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idTipo_pago`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `tipo_pago` */

insert  into `tipo_pago`(`idTipo_pago`,`tipo`) values 
(1,'EFECTIVO'),
(2,'TRANSFERENCIAS'),
(3,'CHEQUES'),
(6,'TESTER');

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

/*Data for the table `traslado` */

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

/*Data for the table `usuario` */

insert  into `usuario`(`idusuario`,`nick`,`clave`,`idPersonal`,`nventa`,`tipo`) values 
(1,'admin','21232f297a57a5a743894a0e4a801fc3',1,NULL,1);

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

/*Data for the table `vendedor` */

insert  into `vendedor`(`idVendedor`,`idPersonal`,`tipo_vendedor`) values 
(1,1,'INTERNO');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `venta` */

/*Table structure for table `zona` */

DROP TABLE IF EXISTS `zona`;

CREATE TABLE `zona` (
  `idzona` int(11) NOT NULL AUTO_INCREMENT,
  `zona` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idzona`)
) ENGINE=InnoDB AUTO_INCREMENT=1801 DEFAULT CHARSET=utf8;

/*Data for the table `zona` */

insert  into `zona`(`idzona`,`zona`) values 
(1,'ASUNCION'),
(101,'CONCEPCIÓN'),
(102,'BELÉN'),
(103,'HORQUETA'),
(104,'LORETO'),
(106,'SAN LÁZARO'),
(107,'YBY YAÚ'),
(199,'NO INFORMADO'),
(201,'SAN PEDRO'),
(202,'ANTEQUERA'),
(203,'CHORÉ'),
(204,'GRAL. ELIZARDO AQUINO'),
(205,'ITACURUBÝ DEL ROSARIO'),
(206,'LIMA'),
(207,'NUEVA GERMANIA'),
(208,'SAN ESTANISLAO'),
(209,'SAN PABLO'),
(210,'TACUATÍ'),
(211,'UNIÓN'),
(212,'25 DE DICIEMBRE'),
(213,'VILLA DEL ROSARIO'),
(214,'GRAL. ISIDRO RESQUÍN'),
(215,'YATAYTY DEL NORTE'),
(216,'GUAYAIBÝ'),
(217,'CAPIIBARY'),
(218,'SANTA ROSA DEL AGUARAY'),
(299,'NO INFORMADO'),
(301,'CAACUPÉ'),
(302,'ALTOS'),
(303,'ARROYOS Y ESTEROS'),
(304,'ATYRÁ'),
(305,'CARAGUATAY'),
(306,'EMBOSCADA'),
(307,'EUSEBIO AYALA'),
(308,'ISLA PUCÚ'),
(309,'ITACURUBÝ DE LA CORDILLERA'),
(310,'JUAN DE MENA'),
(311,'LOMA GRANDE'),
(312,'MBOCAYATY DEL YHAGUY'),
(313,'NUEVA COLOMBIA'),
(314,'PIRIBEBUY'),
(315,'1ERO. DE MARZO'),
(316,'SAN BERNARDINO'),
(317,'SANTA ELENA'),
(318,'TOBATÝ'),
(319,'VALENZUELA'),
(320,'SAN JOSÉ OBRERO'),
(399,'NO INFORMADO'),
(401,'VILLARRICA'),
(402,'BORJA'),
(403,'CAPITÁN MAURICIO JOSÉ TROCHE'),
(404,'CORONEL MARTÍNEZ'),
(405,'FÉLIX PÉREZ CARDOZO'),
(406,'GENERAL EUGENIO A. GARAY'),
(407,'COLONIA INDEPENDENCIA'),
(408,'ITAPÚ'),
(409,'ITURBE'),
(410,'JOSÉ FASSARDI'),
(411,'MBOCAYATY'),
(412,'NATALICIO TALAVERA'),
(413,'ÑUMY'),
(414,'SAN SALVADOR'),
(415,'YATAITY'),
(416,'DR. BOTTRELL'),
(417,'PASO YOBAI'),
(499,'NO INFORMADO'),
(501,'CORONEL OVIEDO'),
(502,'CAAGUAZU'),
(503,'CARAYAÓ'),
(504,'DR. CECILIO BSSEZ'),
(505,'SANTA ROSA DEL MBUTUY'),
(506,'DR. JUAN MANUEL FRUTOS'),
(507,'REPATRIACIÓN'),
(508,'NUEVA LONDRES'),
(509,'SAN JOAQUÍN'),
(510,'SAN JOSE DE LOS ARROYOS'),
(511,'YHÚ'),
(512,'DR. J. EULOGIO ESTIGARRIBIA'),
(513,'R.I. 3 CORRALES'),
(514,'RAÚL ARSENIO OVIEDO'),
(515,'JOSÉ DOMINGO OCAMPOS'),
(516,'MCAL. FRANCISCO SOLANO LÓPEZ'),
(517,'LA PASTORA'),
(518,'3 DE FEBRERO'),
(519,'SIMÓN BOLIVAR'),
(520,'VAQUERÍA (EX SAN BLAS)'),
(599,'NO INFORMADO'),
(601,'CAAZAPÁ'),
(602,'ABAI'),
(603,'BUENA VISTA'),
(604,'DR. MOISÚS BERTONI'),
(605,'GENERAL HIGINIO MORÍNIGO'),
(606,'MACIEL'),
(607,'SAN JUAN NEPOMUCENO'),
(608,'TAVAÍ'),
(609,'YEGROS'),
(610,'YUTY'),
(699,'NO INFORMADO'),
(701,'ENCARNACIÓN'),
(702,'BELLA VISTA'),
(703,'CAMBYRETÁ'),
(704,'CAPITÁN MEZA'),
(705,'CAPITÁN MIRANDA'),
(706,'NUEVA ALBORADA'),
(707,'CARMEN DEL PARANSSÁ'),
(708,'CORONEL BOGADO'),
(709,'CARLOS ANTONIO LÓPEZ'),
(710,'NATALIO'),
(711,'FRAM'),
(712,'GENERAL ARTIGAS'),
(713,'GENERAL DELGADO'),
(714,'HOHENAU'),
(715,'JESÚS'),
(716,'LEANDRO OVIEDO'),
(717,'OBLIGADO'),
(718,'MAYOR OTAÑO'),
(719,'SAN COSME Y DAMIÁN'),
(720,'SAN PEDRO DEL PARANÁ'),
(721,'SAN RAFAEL DEL PARANÁ'),
(722,'TRINIDAD'),
(723,'EDELIRA'),
(724,'TOMÁS ROMERO PEREIRA'),
(725,'ALTO VERÁ'),
(726,'LA PAZ'),
(727,'YATYTAY'),
(728,'SAN JUAN DEL PARANÁ'),
(729,'PIRAPO'),
(730,'ITAPÚA POTY'),
(731,'MARIA AUXILIADORA'),
(799,'NO INFORMADO'),
(801,'SAN JUAN BAUTISTA'),
(802,'AYOLAS'),
(803,'SAN IGNACIO'),
(804,'SAN MIGUEL'),
(805,'SAN PATRICIO'),
(806,'SANTA MARÍA'),
(807,'SANTA ROSA'),
(808,'SANTIAGO'),
(809,'VILLA FLORIDA'),
(810,'YABEBYRY'),
(899,'NO INFORMADO'),
(901,'PARAGUARÍ'),
(902,'ACAHAY'),
(903,'CAAPUCÚ'),
(904,'GENERAL BERNARDINO CABALLERO'),
(905,'CARAPEGUÁ'),
(906,'ESCOBAR'),
(907,'LA COLMENA'),
(908,'MBUYAPEY'),
(909,'PIRAYU'),
(910,'QUIINDY'),
(911,'QUYQUYHÓ'),
(912,'SAN ROQUE GONZALEZ DE SANTA CRUZ'),
(913,'SAPUCAI'),
(914,'TEBICUARYMÍ'),
(915,'YAGUARÓN'),
(916,'YBYCUÍ'),
(917,'YBYTIMÍ'),
(999,'NO INFORMADO'),
(1001,'CIUDAD DEL ESTE'),
(1002,'PRESIDENTE FRANCO'),
(1003,'DOMINGO MARTÍNEZ DE IRALA'),
(1004,'DR. JUAN LEÓN MALLORQUÍN'),
(1005,'HERNANDARIAS'),
(1006,'ITAKYRY'),
(1007,'JUAN E. OLEARY'),
(1008,'ÑACUNDAY'),
(1009,'YGUAZÚ'),
(1010,'LOS CEDRALES'),
(1011,'MINGA GUAZÚ'),
(1012,'SAN CRISTÓBAL'),
(1013,'SANTA RITA'),
(1014,'NARANJAL'),
(1015,'SANTA ROSA DEL MONDAY'),
(1016,'MINGA PORÁ'),
(1017,'MBARACAYÚ'),
(1018,'SAN ALBERTO'),
(1019,'IRUÑA'),
(1020,'CLETO ROMERO'),
(1099,'NO INFORMADO'),
(1101,'AREGUÁ'),
(1102,'CAPIATA'),
(1103,'FERNANDO DE LA MORA'),
(1104,'GUARAMBARÉ'),
(1105,'ITÁ'),
(1106,'ITAUGUÁ'),
(1107,'LAMBARE'),
(1108,'LIMPIO'),
(1109,'LUQUE'),
(1110,'MARIANO ROQUE ALONSO'),
(1111,'NUEVA ITALIA'),
(1112,'ÑEMBY'),
(1113,'SAN ANTONIO'),
(1114,'SAN LORENZO'),
(1115,'VILLA ELISA'),
(1116,'VILLETA'),
(1117,'YPACARAÍ'),
(1118,'YPANÉ'),
(1119,'J. AUGUSTO SALDÍVAR'),
(1199,'NO INFORMADO'),
(1201,'PILAR'),
(1202,'ALBERDI'),
(1203,'CERRITO'),
(1204,'DESMOCHADOS'),
(1205,'GENERAL JOSÉ EDUVIGIS DÍAZ'),
(1206,'GUAZÚ CUÁ'),
(1207,'HUMAITÁ'),
(1208,'ISLA UMBÚ'),
(1209,'LAURELES'),
(1210,'MAYOR JOSÉ D. MARTÍNEZ'),
(1211,'PASO DE PATRIA'),
(1212,'SAN JUAN BAUTISTA DE ÑEEMBUCÚ'),
(1213,'TACUARAS'),
(1214,'VILLA FRANCA'),
(1215,'VILLA OLIVA'),
(1216,'VILLALBÍN'),
(1299,'NO INFORMADO'),
(1301,'PEDRO JUAN CABALLERO'),
(1302,'BELLA VISTA'),
(1303,'CAPITÁN BADO'),
(1399,'NO INFORMADO'),
(1401,'SALTO DEL GUAIRÁ'),
(1402,'CORPUS CHRISTI'),
(1403,'CURUGUATY'),
(1404,'YGATIMÍ'),
(1405,'ITANARÁ'),
(1406,'YPEHÚ'),
(1407,'GENERAL FRANCISCO C. ALVAREZ'),
(1408,'KATUETE'),
(1409,'LA PALOMA'),
(1410,'NUEVA ESPERANZA'),
(1499,'NO INFORMADO'),
(1501,'POZO COLORADO'),
(1502,'BENJAMÍN ACEVAL'),
(1503,'PTO. PINASCO'),
(1504,'VILLA HAYES'),
(1505,'NANAWA'),
(1506,'JOSÉ FALCÓN'),
(1599,'NO INFORMADO'),
(1601,'CHACO'),
(1602,'MCAL. JOSE F. ESTIGARRIBIA'),
(1699,'NO INFORMADO'),
(1701,'FUERTE OLIMPO'),
(1702,'LA VICTORIA'),
(1799,'NO INFORMADO'),
(1800,'NO REGISTRADO');

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

/* Trigger structure for table `anulacion_compra` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_after_anulacion_compra_insert` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_after_anulacion_compra_insert` AFTER INSERT ON `anulacion_compra` FOR EACH ROW 
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_iddeposito INT;
    DECLARE v_total_compra DECIMAL(10,0);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    DECLARE v_idproveedor INT;
    DECLARE v_proveedor_nombre VARCHAR(45);
    DECLARE v_proveedor_ruc VARCHAR(20);
    DECLARE v_nro_factura VARCHAR(45);
    DECLARE v_fecha_compra DATE;
    DECLARE v_idconcepto INT;
    DECLARE v_idusuario_anulacion INT;
    DECLARE v_finished INTEGER DEFAULT 0;
    
    -- Variables para el cursor de detalles de compra
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precio_costo DECIMAL(10,0);
    DECLARE v_iddeposito_compra INT;
    
    -- Cursor para recorrer los detalles de la compra anulada
    DECLARE cur_detalles_compra CURSOR FOR 
        SELECT cd.idarticulo, cd.cantidad, cd.precio_costo, c.iddeposito
        FROM compra_detalle cd
        INNER JOIN compra c ON cd.idcompra = c.idcompra
        WHERE cd.idcompra = NEW.idcompra;
    
    -- Declarar handler para cuando no haya más filas en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
    -- 1. OBTENER DATOS DE LA COMPRA ANULADA
    SELECT 
        c.idEmpresa, 
        c.idsucursal, 
        c.iddeposito,
        c.total,
        c.tipo,
        c.idproveedor,
        p.proveedor,
        p.ruc,
        CONCAT(c.nro_est, '-', c.nro_exp, '-', c.nro_factura),
        c.fecha
    INTO 
        v_idempresa, 
        v_idsucursal, 
        v_iddeposito,
        v_total_compra,
        v_tipo_compra,
        v_idproveedor,
        v_proveedor_nombre,
        v_proveedor_ruc,
        v_nro_factura,
        v_fecha_compra
    FROM compra c
    INNER JOIN proveedor p ON c.idproveedor = p.idproveedor
    WHERE c.idcompra = NEW.idcompra;
    
    -- 2. OBTENER EL CONCEPTO PARA ANULACIÓN DE COMPRA
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
    FROM parametros_sistema
    WHERE nombre = 'ANULACION_COMPRA'
    AND tabla = 'concepto_caja'
    LIMIT 1;
    
    -- Si no existe el parámetro, usar uno por defecto
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- 3. RECORRER DETALLES DE COMPRA Y REVERTIR STOCK
    OPEN cur_detalles_compra;
    
    get_detalles_compra: LOOP
        FETCH cur_detalles_compra INTO v_idarticulo, v_cantidad, v_precio_costo, v_iddeposito_compra;
        
        IF v_finished = 1 THEN
            LEAVE get_detalles_compra;
        END IF;
        
        -- 3.1. REVERTIR STOCK (RESTA LA CANTIDAD COMPRADA)
        UPDATE stockarticulo 
        SET stock = stock - v_cantidad
        WHERE idarticulo = v_idarticulo 
        AND iddeposito = v_iddeposito_compra
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- 3.2. REGISTRAR EN KARDEX (SALIDA POR DEVOLUCIÓN DE COMPRA)
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
            NEW.fecha,
            CONCAT('ANU-C-', v_nro_factura),
            v_iddeposito_compra,
            (SELECT CAST(valor AS SIGNED) FROM parametros_sistema 
             WHERE nombre = 'KARDEX_ANULACION_COMPRA' AND tabla = 'motivo_ajuste' LIMIT 1),
            v_idarticulo,
            v_precio_costo,
            v_cantidad,
            'COMPRA',
            'SALIDA',  -- SALIDA porque se quita stock (reversión de compra)
            CONCAT('DEVOLUCIÓN POR ANULACIÓN COMPRA - ', v_nro_factura, 
                   ' - Proveedor: ', v_proveedor_nombre,
                   ' (RUC: ', v_proveedor_ruc, ')'),
            NEW.idusuario,
            v_idempresa,
            v_idsucursal
        );
        
    END LOOP get_detalles_compra;
    
    CLOSE cur_detalles_compra;
    
    -- 4. REGISTRAR EN MOV_OPERACION (INGRESO POR DEVOLUCIÓN DE DINERO)
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
        'ANULACION_COMPRA',
        CASE 
            WHEN v_tipo_compra = 'CONTADO' THEN 'CONTADO'
            WHEN v_tipo_compra = 'CREDITO' THEN 'CREDITO'
            ELSE v_tipo_compra
        END,
        'INGRESOS',  -- INGRESOS porque se recupera dinero (devolución)
        v_idconcepto,
        CONCAT('ANU-C-', v_nro_factura),
        v_total_compra,
        CONCAT('ANULACIÓN COMPRA #', v_nro_factura, 
               ' - Proveedor: ', v_proveedor_nombre,
               ' (RUC: ', v_proveedor_ruc, ')',
               ' - Motivo: ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idempresa
    );
    
    -- 5. ACTUALIZAR ÚLTIMA FECHA DE AJUSTE EN ARTÍCULOS AFECTADOS
    UPDATE articulo a
    INNER JOIN compra_detalle cd ON a.idarticulo = cd.idarticulo
    SET a.ultima_fecha_ajuste = NEW.fecha
    WHERE cd.idcompra = NEW.idcompra;
    
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

/* Trigger structure for table `anulacion_venta` */

DELIMITER $$

/*!50003 DROP TRIGGER*//*!50032 IF EXISTS */ /*!50003 `trg_after_anulacion_venta` */$$

/*!50003 CREATE */ /*!50003 TRIGGER `trg_after_anulacion_venta` AFTER INSERT ON `anulacion_venta` FOR EACH ROW 
BEGIN
    DECLARE v_idempresa INT;
    DECLARE v_idsucursal INT;
    DECLARE v_iddeposito INT;
    DECLARE v_total_venta DECIMAL(10,2);
    DECLARE v_tipo_venta ENUM('CON','CRE');
    DECLARE v_idcliente INT;
    DECLARE v_cliente_nombre VARCHAR(120);
    DECLARE v_nro_factura VARCHAR(45);
    DECLARE v_fecha_venta DATE;
    DECLARE v_idconcepto INT;
    DECLARE v_idusuario_anulacion INT;
    DECLARE v_idapecierre INT;
    DECLARE v_idpersonal_vendedor INT;
    DECLARE v_finished INTEGER DEFAULT 0;
    
    -- Variables para el cursor de detalles de venta
    DECLARE v_idarticulo INT;
    DECLARE v_cantidad INT;
    DECLARE v_precosto DECIMAL(10,2);
    DECLARE v_iddeposito_venta INT;
    
    -- Cursor para recorrer los detalles de la venta anulada
    DECLARE cur_detalles CURSOR FOR 
        SELECT dv.idarticulo, dv.cantidad, dv.precosto, dv.iddeposito
        FROM detalle_venta dv
        WHERE dv.idVenta = NEW.idVenta;
    
    -- Declarar handler para cuando no haya más filas en el cursor
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET v_finished = 1;
    
    -- 1. OBTENER DATOS DE LA VENTA ANULADA
    SELECT 
        v.idEmpresa, 
        v.idsucursal, 
        v.iddeposito,
        v.total,
        v.tipo,
        v.idcliente,
        CONCAT(v.nrosuc, '-', v.nroexp, '-', v.nrofactura),
        v.fecha,
        v.idusuario
    INTO 
        v_idempresa, 
        v_idsucursal, 
        v_iddeposito,
        v_total_venta,
        v_tipo_venta,
        v_idcliente,
        v_nro_factura,
        v_fecha_venta,
        v_idusuario_anulacion
    FROM venta v
    WHERE v.idVenta = NEW.idVenta;
    
    -- 2. OBTENER NOMBRE DEL CLIENTE
    SELECT CONCAT(nombre, ' ', apellido) INTO v_cliente_nombre
    FROM cliente 
    WHERE idcliente = v_idcliente;
    
    -- 3. OBTENER PERSONAL DEL VENDEDOR PARA APERTURA DE CAJA
    SELECT vd.idPersonal INTO v_idpersonal_vendedor 
    FROM vendedor vd 
    INNER JOIN venta v ON v.idVendedor = vd.idVendedor
    WHERE v.idVenta = NEW.idVenta;
    
    -- Obtener id apertura cierre caja (si existe)
    SET v_idapecierre = f_get_apertura_activa(v_idpersonal_vendedor);
    
    -- 4. OBTENER EL CONCEPTO PARA ANULACIÓN DE VENTA
    SELECT CAST(valor AS SIGNED) INTO v_idconcepto
    FROM parametros_sistema
    WHERE nombre = 'ANULACION_VENTA'
    AND tabla = 'concepto_caja'
    LIMIT 1;
    
    -- Si no existe el parámetro, usar uno por defecto
    IF v_idconcepto IS NULL THEN
        SET v_idconcepto = 1;
    END IF;
    
    -- 5. RECORRER DETALLES DE VENTA Y DEVOLVER STOCK
    OPEN cur_detalles;
    
    get_detalles: LOOP
        FETCH cur_detalles INTO v_idarticulo, v_cantidad, v_precosto, v_iddeposito_venta;
        
        IF v_finished = 1 THEN
            LEAVE get_detalles;
        END IF;
        
        -- 5.1. ACTUALIZAR STOCK (SUMA LA CANTIDAD DEVUELTA)
        UPDATE stockarticulo 
        SET stock = stock + v_cantidad
        WHERE idarticulo = v_idarticulo 
        AND iddeposito = v_iddeposito_venta
        AND idsucursal = v_idsucursal
        AND idEmpresa = v_idempresa;
        
        -- 5.2. REGISTRAR EN KARDEX (ENTRADA POR DEVOLUCIÓN)
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
            NEW.fecha,
            CONCAT('ANU-', v_nro_factura),
            v_iddeposito_venta,
            (SELECT CAST(valor AS SIGNED) FROM parametros_sistema WHERE nombre = 'KARDEX_ANULACION' AND tabla = 'motivo_ajuste' LIMIT 1),
            v_idarticulo,
            v_precosto,
            v_cantidad,
            'VENTA',
            'ENTRADA',  -- ENTRADA porque se devuelve stock
            CONCAT('DEVOLUCIÓN POR ANULACIÓN VENTA - ', v_nro_factura, ' - Cliente: ', v_cliente_nombre),
            NEW.idusuario,
            v_idempresa,
            v_idsucursal
        );
        
    END LOOP get_detalles;
    
    CLOSE cur_detalles;
    
    -- 6. REGISTRAR EN MOV_OPERACION
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
        idEmpresa,
        idapecierre
    ) VALUES (
        NEW.fecha,
        'ANULACION_VENTA',
        CASE WHEN v_tipo_venta = 'CON' THEN 'CONTADO' ELSE 'CREDITO' END,
        'EGRESOS',  -- Egreso porque se devuelve dinero
        v_idconcepto,
        CONCAT('ANU-', v_nro_factura),
        v_total_venta,
        CONCAT('ANULACIÓN VENTA #', v_nro_factura, 
               ' - Cliente: ', v_cliente_nombre,
               ' - Motivo: ', NEW.motivo),
        NEW.idusuario,
        v_idsucursal,
        v_idempresa,
        v_idapecierre
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
    IN c_reftel3 VARCHAR(45),
    in c_foto text
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
                trabajo_telefono, ref1, ref2, ref3, reftel1, reftel2, reftel3, foto
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
                NULLIF(c_reftel3, ''),
                c_foto
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
                reftel3 = NULLIF(c_reftel3, ''),
                foto = c_foto
            WHERE idcliente = n_codigo;
            
            SELECT 
                n_codigo AS id_actualizado, 
                'Cliente actualizado exitosamente' AS mensaje,
                CONCAT('ID: ', n_codigo, ' - ', TRIM(c_nombre), ' ', TRIM(c_apellido)) AS detalle;
            
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

/* Procedure structure for procedure `sp_anular_compra` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_anular_compra` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_anular_compra`(
    IN p_idcompra INT,
    IN p_motivo VARCHAR(200),
    IN p_idusuario INT
)
BEGIN

    DECLARE v_existe_compra INT DEFAULT 0;
    DECLARE v_estado_actual VARCHAR(20);
    DECLARE v_tipo_compra ENUM('CONTADO','CREDITO');
    
    -- Verificar si la compra existe y obtener su estado y tipo
    SELECT COUNT(*), estado, tipo INTO v_existe_compra, v_estado_actual, v_tipo_compra
    FROM compra 
    WHERE idcompra = p_idcompra;
    
    IF v_existe_compra = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LA COMPRA NO EXISTE';
    ELSEIF v_estado_actual = 'ANULADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'LA COMPRA YA FUE ANULADA!!';
    ELSEIF v_estado_actual = 'FACTURADO' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR UNA COMPRA YA FACTURADA';
    END IF;
    
    -- Verificar si la compra tiene pagos realizados (si es a crédito)
    IF v_tipo_compra = 'CREDITO' THEN
        -- Aquí podrías agregar validaciones si tu sistema registra pagos de compras a crédito
        -- Por ejemplo, verificar si hay pagos registrados en cuentas por pagar
        -- Por ahora, solo un mensaje informativo
         SELECT 1; -- Placeholder para futuras validaciones
    END IF;
    

     -- REGISTRA LA ANULACION DE COMPRAS. 
     INSERT INTO anulacion_compra (fecha, motivo, idcompra, idusuario)
     VALUES (NOW(), p_motivo, p_idcompra, p_idusuario);
    
    -- Actualizar estado de la compra
    UPDATE compra 
    SET estado = 'ANULADO'
    WHERE idcompra = p_idcompra;
    
    
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

/* Procedure structure for procedure `sp_anular_venta` */

/*!50003 DROP PROCEDURE IF EXISTS  `sp_anular_venta` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `sp_anular_venta`(
    IN p_idventa INT,
    IN p_motivo VARCHAR(200),
    IN p_idusuario INT
)
BEGIN
    DECLARE v_existe_venta INT DEFAULT 0;
    DECLARE v_estado_actual VARCHAR(1);
    DECLARE v_tipo_venta ENUM('CON','CRE');
    DECLARE v_tiene_cuotas_cobradas INT DEFAULT 0;
    DECLARE v_cant_cuotas_cobradas INT DEFAULT 0;
    
    -- Verificar si la venta existe y obtener su estado y tipo
    SELECT COUNT(*), estado, tipo INTO v_existe_venta, v_estado_actual, v_tipo_venta
    FROM venta 
    WHERE idVenta = p_idventa;
    
    IF v_existe_venta = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La venta no existe';
    ELSEIF v_estado_actual = 'A' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La venta ya está anulada';
    ELSEIF v_estado_actual != 'F' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Solo se pueden anular ventas facturadas';
    END IF;
    
    -- Si es venta a crédito, verificar si tiene cuotas cobradas
    IF v_tipo_venta = 'CRE' THEN
        -- Verificar si existen cuotas cobradas para esta venta
        SELECT COUNT(*) INTO v_tiene_cuotas_cobradas
        FROM cuotas c
        INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'NO'
        AND cd.estado = 'CAN'
        AND cd.saldo_cuota = 0;
        
        -- También contar pagos recibidos para esta venta
        SELECT COUNT(*) INTO v_cant_cuotas_cobradas
        FROM pagos_cuotas pc
        INNER JOIN cuotas c ON pc.idcuotas = c.idcuotas
        WHERE c.idVenta = p_idventa
        AND pc.estado = 'COB';  -- Solo pagos cobrados (no anulados)
        
        IF v_tiene_cuotas_cobradas > 0 OR v_cant_cuotas_cobradas > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR LA VENTA - TIENE CUOTAS COBRADAS';
        END IF;
        
        -- Verificar también si hay alguna cuota con saldo parcialmente pagado
        SELECT COUNT(*) INTO v_tiene_cuotas_cobradas
        FROM cuotas c
        INNER JOIN cuotas_detalle cd ON c.idcuotas = cd.idcuotas
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'NO'
        AND cd.estado = 'PEN'
        AND cd.saldo_cuota < cd.cuota
        AND cd.saldo_cuota > 0;
        
        IF v_tiene_cuotas_cobradas > 0 THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'NO SE PUEDE ANULAR LA VENTA - TIENE CUOTAS CON PAGOS PARCIALES';
        END IF;
    END IF;
    
    -- Registrar la anulación
    INSERT INTO anulacion_venta (fecha, motivo, idVenta, idusuario)
    VALUES (NOW(), p_motivo, p_idventa, p_idusuario);
    
    -- Actualizar estado de la venta
    UPDATE venta 
    SET estado = 'A'
    WHERE idVenta = p_idventa;
    
    -- Marcar cuotas como anuladas si la venta es a crédito
    IF v_tipo_venta = 'CRE' THEN
        UPDATE cuotas 
        SET anulado = 'SI'
        WHERE idVenta = p_idventa;
        
        -- También marcar todos los detalles de cuotas como cancelados
        UPDATE cuotas_detalle cd
        INNER JOIN cuotas c ON cd.idcuotas = c.idcuotas
        SET cd.estado = 'CAN'
        WHERE c.idVenta = p_idventa
        AND c.anulado = 'SI';
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
 `ubicacion_completa` varchar(93) ,
 `foto` text 
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
 `idcompra` int(11) ,
 `fecha` date ,
 `tipo_compra_descripcion` varchar(7) ,
 `tipo_compra` enum('CONTADO','CREDITO') ,
 `nombre_proveedor` char(45) ,
 `ruc_proveedor` char(20) ,
 `nro_factura` varchar(15) ,
 `idproveedor` int(11) ,
 `nombre_deposito` varchar(45) ,
 `iddeposito` int(11) ,
 `total_compra` decimal(10,0) ,
 `estado_compra` enum('PENDIENTE','FACTURADO','ANULADO') ,
 `idsucursal` int(11) ,
 `nombre_sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `nombre_empresa` varchar(45) ,
 `fecha_vencimiento` date ,
 `dias_plazo` int(10) ,
 `total_gravadas_excenta` decimal(10,0) ,
 `total_gravadas_cinco` decimal(10,0) ,
 `total_gravadas_diez` decimal(10,0) ,
 `total_liqui_iva` decimal(10,0) ,
 `idusuario` int(11) 
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

/*Table structure for table `v_detalle_compra` */

DROP TABLE IF EXISTS `v_detalle_compra`;

/*!50001 DROP VIEW IF EXISTS `v_detalle_compra` */;
/*!50001 DROP TABLE IF EXISTS `v_detalle_compra` */;

/*!50001 CREATE TABLE  `v_detalle_compra`(
 `idcompra` int(11) ,
 `fecha_compra` date ,
 `nro_factura` varchar(15) ,
 `idcompra_detalle` int(10) ,
 `idarticulo` int(11) ,
 `articulo_descripcion` varchar(100) ,
 `codbarra` varchar(45) ,
 `cantidad` int(11) ,
 `precio_costo` decimal(10,0) ,
 `subtotal` decimal(10,0) ,
 `iva` enum('0','10','5') ,
 `gravada_excenta` decimal(10,0) ,
 `gravada_cinco` decimal(10,0) ,
 `gravada_diez` decimal(10,0) ,
 `marca` char(45) ,
 `grupo_articulo` char(45) ,
 `subgrupo_articulo` varchar(45) ,
 `nombre_proveedor` char(45) ,
 `idproveedor` int(11) ,
 `proveedor` char(45) ,
 `ruc_proveedor` char(20) ,
 `telefono_proveedor` char(15) ,
 `iddeposito` int(11) ,
 `nombre_deposito` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `ciudad` varchar(45) ,
 `direccion_sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `nombre_empresa` varchar(45) ,
 `ruc_empresa` varchar(10) ,
 `estado_compra` enum('PENDIENTE','FACTURADO','ANULADO') ,
 `tipo_compra` enum('CONTADO','CREDITO') ,
 `tipo_compra_descripcion` varchar(7) ,
 `total_gravadas_excenta` decimal(10,0) ,
 `total_gravadas_cinco` decimal(10,0) ,
 `total_gravadas_diez` decimal(10,0) ,
 `total_factura` decimal(10,0) ,
 `liqui_iva_cinco` int(11) ,
 `liqui_iva_diez` decimal(10,0) ,
 `total_liqui_iva` decimal(10,0) ,
 `fecha_vencimiento` date ,
 `dias_plazo` int(10) ,
 `idusuario` int(11) ,
 `usuario_registro` varchar(48) ,
 `personal_registro` varchar(91) 
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

/*Table structure for table `v_detalle_venta` */

DROP TABLE IF EXISTS `v_detalle_venta`;

/*!50001 DROP VIEW IF EXISTS `v_detalle_venta` */;
/*!50001 DROP TABLE IF EXISTS `v_detalle_venta` */;

/*!50001 CREATE TABLE  `v_detalle_venta`(
 `idVenta` int(11) ,
 `fecha_venta` date ,
 `nro_factura` varchar(32) ,
 `idDetalle` int(11) ,
 `idarticulo` int(11) ,
 `articulo_descripcion` varchar(100) ,
 `codbarra` varchar(45) ,
 `cantidad` int(11) ,
 `precio_costo` decimal(10,2) ,
 `precio_venta` decimal(10,2) ,
 `subtotal` decimal(10,2) ,
 `marca` char(45) ,
 `grupo_articulo` char(45) ,
 `subgrupo_articulo` varchar(45) ,
 `nombre_proveedor` char(45) ,
 `tipo_cuota` enum('CUOTA','CONTADO') ,
 `plan_cuota` varchar(45) ,
 `cant_cuota` int(10) ,
 `interes_mensual` decimal(10,2) ,
 `margen_conta` decimal(10,2) ,
 `monto_cuota` decimal(10,2) ,
 `iva` enum('0','5','10') ,
 `gravada_excenta` decimal(10,2) ,
 `gravada_cinco` decimal(10,2) ,
 `gravada_diez` decimal(10,2) ,
 `idcliente` int(11) ,
 `cliente_nombre_completo` varchar(91) ,
 `cliente_ci` varchar(45) ,
 `cliente_celular` varchar(20) ,
 `cliente_telefono` varchar(20) ,
 `zona` varchar(45) ,
 `barrio` varchar(45) ,
 `idVendedor` int(11) ,
 `vendedor_nombre` varchar(91) ,
 `idcobrador` int(11) ,
 `cobrador_nombre` varchar(91) ,
 `iddeposito` int(11) ,
 `nombre_deposito` varchar(45) ,
 `idsucursal` int(11) ,
 `sucursal` varchar(45) ,
 `ciudad` varchar(45) ,
 `direccion_sucursal` varchar(45) ,
 `idEmpresa` int(11) ,
 `nombre_empresa` varchar(45) ,
 `ruc_empresa` varchar(10) ,
 `estado_venta` enum('F','A') ,
 `tipo_venta` enum('CON','CRE') ,
 `tipo_venta_descripcion` varchar(7) ,
 `total_gravada_excenta` decimal(11,0) ,
 `total_gravada_cinco` decimal(11,0) ,
 `total_gravada_diez` decimal(11,0) ,
 `total_factura` decimal(10,2) ,
 `liqui_iva_5` decimal(10,2) ,
 `liqui_iva_10` decimal(10,2) ,
 `total_liqui_iva` decimal(10,2) ,
 `fecha_vto_pagare` date 
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

/*Table structure for table `v_venta` */

DROP TABLE IF EXISTS `v_venta`;

/*!50001 DROP VIEW IF EXISTS `v_venta` */;
/*!50001 DROP TABLE IF EXISTS `v_venta` */;

/*!50001 CREATE TABLE  `v_venta`(
 `idVenta` int(11) ,
 `fecha` date ,
 `tipo_venta_descripcion` varchar(7) ,
 `tipo_venta` enum('CON','CRE') ,
 `ci` varchar(45) ,
 `apellido` varchar(45) ,
 `nombre` varchar(45) ,
 `nro_factura` varchar(32) ,
 `idcliente` int(11) ,
 `total_venta` decimal(10,2) ,
 `vendedor_nombre` varchar(91) ,
 `cobrador_nombre` varchar(91) 
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

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_clientes` AS select `c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `nombre`,`c`.`apellido` AS `apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `nombre_completo`,`c`.`ci` AS `ci`,`c`.`ruc` AS `ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`idzona` AS `idzona`,`z`.`zona` AS `zona`,`c`.`idbarrio` AS `idbarrio`,`b`.`barrio` AS `barrio`,`c`.`idprofesion` AS `idprofesion`,`p`.`profesion` AS `profesion`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`c`.`ref1` AS `ref1`,`c`.`ref2` AS `ref2`,`c`.`ref3` AS `ref3`,`c`.`reftel1` AS `reftel1`,`c`.`reftel2` AS `reftel2`,`c`.`reftel3` AS `reftel3`,concat(trim(`b`.`barrio`),' - ',trim(`z`.`zona`)) AS `ubicacion_completa`,`c`.`foto` AS `foto` from (((`cliente` `c` left join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) left join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) left join `profesion` `p` on((`c`.`idprofesion` = `p`.`idprofesion`))) */;

/*View structure for view v_cobradores */

/*!50001 DROP TABLE IF EXISTS `v_cobradores` */;
/*!50001 DROP VIEW IF EXISTS `v_cobradores` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_cobradores` AS select `cob`.`idcobrador` AS `idcobrador`,`p`.`idPersonal` AS `idPersonal`,concat(trim(`p`.`nombre`),' ',trim(`p`.`apellido`)) AS `nombre_completo`,`p`.`ci` AS `ci`,`p`.`telefono` AS `telefono`,`z`.`idzona` AS `idzona`,`z`.`zona` AS `zona`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal` from (((`cobrador` `cob` join `personal` `p` on((`cob`.`idPersonal` = `p`.`idPersonal`))) join `zona` `z` on((`cob`.`idzona` = `z`.`idzona`))) join `sucursal` `s` on((`p`.`idsucursal` = `s`.`idsucursal`))) order by `p`.`nombre`,`p`.`apellido` */;

/*View structure for view v_compra */

/*!50001 DROP TABLE IF EXISTS `v_compra` */;
/*!50001 DROP VIEW IF EXISTS `v_compra` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_compra` AS select `c`.`idcompra` AS `idcompra`,`c`.`fecha` AS `fecha`,(case when (`c`.`tipo` = 'CONTADO') then 'CONTADO' when (`c`.`tipo` = 'CREDITO') then 'CRÉDITO' else `c`.`tipo` end) AS `tipo_compra_descripcion`,`c`.`tipo` AS `tipo_compra`,`p`.`proveedor` AS `nombre_proveedor`,`p`.`ruc` AS `ruc_proveedor`,concat(`c`.`nro_est`,'-',`c`.`nro_exp`,'-',`c`.`nro_factura`) AS `nro_factura`,`p`.`idproveedor` AS `idproveedor`,`d`.`deposito` AS `nombre_deposito`,`d`.`iddeposito` AS `iddeposito`,`c`.`total` AS `total_compra`,`c`.`estado` AS `estado_compra`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `nombre_sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `nombre_empresa`,`c`.`fecha_vto` AS `fecha_vencimiento`,`c`.`plazo` AS `dias_plazo`,`c`.`total_gravadas_excenta` AS `total_gravadas_excenta`,`c`.`total_gravadas_cinco` AS `total_gravadas_cinco`,`c`.`total_gravadas_diez` AS `total_gravadas_diez`,`c`.`total_liqui_iva` AS `total_liqui_iva`,`c`.`idusuario` AS `idusuario` from ((((`compra` `c` join `proveedor` `p` on((`c`.`idproveedor` = `p`.`idproveedor`))) join `deposito` `d` on((`c`.`iddeposito` = `d`.`iddeposito`))) join `sucursal` `s` on((`c`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`c`.`idEmpresa` = `e`.`idEmpresa`))) where (`c`.`estado` <> 'ANULADO') order by `c`.`fecha` desc */;

/*View structure for view v_cuotas_ventas_clientes */

/*!50001 DROP TABLE IF EXISTS `v_cuotas_ventas_clientes` */;
/*!50001 DROP VIEW IF EXISTS `v_cuotas_ventas_clientes` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_cuotas_ventas_clientes` AS select `c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `cliente_nombre`,`c`.`apellido` AS `cliente_apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`ruc` AS `cliente_ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`z`.`zona` AS `zona`,`b`.`barrio` AS `barrio`,`prof`.`profesion` AS `profesion`,`v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,`v`.`hora` AS `hora`,`v`.`tipo` AS `tipo_venta`,(case `v`.`tipo` when 'CON' then 'CONTADO' when 'CRE' then 'CRÉDITO' end) AS `tipo_venta_descripcion`,`v`.`nrosuc` AS `nrosuc`,`v`.`nroexp` AS `nroexp`,`v`.`nrofactura` AS `nrofactura`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `factura_completa`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`total` AS `total_venta`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`cu`.`idcuotas` AS `idcuotas`,`cu`.`fecha` AS `fecha_cuota`,`cu`.`fecha_cancela` AS `fecha_cancela`,`cu`.`nrofactura` AS `factura_cuota`,`cu`.`cantidad_cuota` AS `cantidad_cuota`,`cu`.`primera_fecha_vto` AS `primera_fecha_vto`,`cu`.`total_venta` AS `total_cuota`,`cu`.`saldo_actual` AS `saldo_actual`,`cu`.`ultimo_fecha_pago` AS `ultimo_fecha_pago`,`cu`.`ultimo_importe` AS `ultimo_importe`,`cu`.`ultimo_interes_calc` AS `ultimo_interes_calc`,`cu`.`ultimo_descuento` AS `ultimo_descuento`,`cu`.`ultimo_totalac` AS `ultimo_totalac`,`cu`.`estado` AS `estado_cuota`,(case `cu`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_cuota_descripcion`,`cu`.`anulado` AS `anulado`,(select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'CAN'))) AS `cuotas_pagadas`,(select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'PEN'))) AS `cuotas_pendientes`,round((((select count(0) from `cuotas_detalle` `cd` where ((`cd`.`idcuotas` = `cu`.`idcuotas`) and (`cd`.`estado` = 'CAN'))) * 100.0) / `cu`.`cantidad_cuota`),2) AS `porcentaje_cuotas_pagadas`,`ven`.`idVendedor` AS `idVendedor`,concat(`pv`.`nombre`,' ',`pv`.`apellido`) AS `vendedor_nombre`,`cob`.`idcobrador` AS `idcobrador`,concat(`pc`.`nombre`,' ',`pc`.`apellido`) AS `cobrador_nombre`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa`,(`cu`.`total_venta` - `cu`.`saldo_actual`) AS `total_pagado`,round(((`cu`.`saldo_actual` / `cu`.`total_venta`) * 100),2) AS `porcentaje_pendiente`,(to_days(curdate()) - to_days(`cu`.`primera_fecha_vto`)) AS `dias_desde_primer_vencimiento` from (((((((((((`cliente` `c` join `venta` `v` on((`c`.`idcliente` = `v`.`idcliente`))) join `cuotas` `cu` on((`v`.`idVenta` = `cu`.`idVenta`))) join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) join `profesion` `prof` on((`c`.`idprofesion` = `prof`.`idprofesion`))) join `vendedor` `ven` on((`v`.`idVendedor` = `ven`.`idVendedor`))) join `personal` `pv` on((`ven`.`idPersonal` = `pv`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `pc` on((`cob`.`idPersonal` = `pc`.`idPersonal`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) where ((`v`.`estado` = 'F') and (`cu`.`anulado` = 'NO')) */;

/*View structure for view v_deposito */

/*!50001 DROP TABLE IF EXISTS `v_deposito` */;
/*!50001 DROP VIEW IF EXISTS `v_deposito` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_deposito` AS select `d`.`iddeposito` AS `iddeposito`,`d`.`deposito` AS `deposito`,`d`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa` from ((`deposito` `d` join `sucursal` `s` on((`d`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`s`.`idEmpresa` = `e`.`idEmpresa`))) */;

/*View structure for view v_detalle_compra */

/*!50001 DROP TABLE IF EXISTS `v_detalle_compra` */;
/*!50001 DROP VIEW IF EXISTS `v_detalle_compra` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_detalle_compra` AS select `c`.`idcompra` AS `idcompra`,`c`.`fecha` AS `fecha_compra`,concat(`c`.`nro_est`,'-',`c`.`nro_exp`,'-',`c`.`nro_factura`) AS `nro_factura`,`cd`.`idcompra_detalle` AS `idcompra_detalle`,`cd`.`idarticulo` AS `idarticulo`,`a`.`descripcion` AS `articulo_descripcion`,`a`.`codbarra` AS `codbarra`,`cd`.`cantidad` AS `cantidad`,`cd`.`precio_costo` AS `precio_costo`,`cd`.`subtotal` AS `subtotal`,`cd`.`iva` AS `iva`,`cd`.`gravada_excenta` AS `gravada_excenta`,`cd`.`gravada_cinco` AS `gravada_cinco`,`cd`.`gravada_diez` AS `gravada_diez`,`m`.`Marca` AS `marca`,`g`.`grupo` AS `grupo_articulo`,`sg`.`subgrupo` AS `subgrupo_articulo`,`p`.`proveedor` AS `nombre_proveedor`,`pr`.`idproveedor` AS `idproveedor`,`pr`.`proveedor` AS `proveedor`,`pr`.`ruc` AS `ruc_proveedor`,`pr`.`telefono` AS `telefono_proveedor`,`d`.`iddeposito` AS `iddeposito`,`d`.`deposito` AS `nombre_deposito`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`s`.`ciudad` AS `ciudad`,`s`.`direccion` AS `direccion_sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `nombre_empresa`,`e`.`ruc` AS `ruc_empresa`,`c`.`estado` AS `estado_compra`,`c`.`tipo` AS `tipo_compra`,(case when (`c`.`tipo` = 'CONTADO') then 'CONTADO' when (`c`.`tipo` = 'CREDITO') then 'CRÉDITO' else `c`.`tipo` end) AS `tipo_compra_descripcion`,`c`.`total_gravadas_excenta` AS `total_gravadas_excenta`,`c`.`total_gravadas_cinco` AS `total_gravadas_cinco`,`c`.`total_gravadas_diez` AS `total_gravadas_diez`,`c`.`total` AS `total_factura`,`c`.`liqui_iva_cinco` AS `liqui_iva_cinco`,`c`.`liqui_iva_diez` AS `liqui_iva_diez`,`c`.`total_liqui_iva` AS `total_liqui_iva`,`c`.`fecha_vto` AS `fecha_vencimiento`,`c`.`plazo` AS `dias_plazo`,`u`.`idusuario` AS `idusuario`,`u`.`nick` AS `usuario_registro`,concat(`pe`.`nombre`,' ',`pe`.`apellido`) AS `personal_registro` from ((((((((((((`compra` `c` join `compra_detalle` `cd` on((`c`.`idcompra` = `cd`.`idcompra`))) join `articulo` `a` on((`cd`.`idarticulo` = `a`.`idarticulo`))) join `marca` `m` on((`a`.`idMarca` = `m`.`idMarca`))) join `grupo` `g` on((`a`.`idgrupo` = `g`.`idgrupo`))) join `subgrupo` `sg` on((`a`.`idsubgrupo` = `sg`.`idsubgrupo`))) join `proveedor` `pr` on((`a`.`idproveedor` = `pr`.`idproveedor`))) join `proveedor` `p` on((`c`.`idproveedor` = `p`.`idproveedor`))) join `deposito` `d` on((`c`.`iddeposito` = `d`.`iddeposito`))) join `sucursal` `s` on((`c`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`c`.`idEmpresa` = `e`.`idEmpresa`))) left join `usuario` `u` on((`c`.`idusuario` = `u`.`idusuario`))) left join `personal` `pe` on((`u`.`idPersonal` = `pe`.`idPersonal`))) where (`c`.`estado` <> 'ANULADO') order by `c`.`fecha` desc,`c`.`idcompra` desc,`cd`.`idcompra_detalle` */;

/*View structure for view v_detalle_cuotas */

/*!50001 DROP TABLE IF EXISTS `v_detalle_cuotas` */;
/*!50001 DROP VIEW IF EXISTS `v_detalle_cuotas` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_detalle_cuotas` AS select `cd`.`idcuotas_detalle` AS `idcuotas_detalle`,`cd`.`orden_char` AS `orden_char`,`cd`.`orden_cuota` AS `orden_cuota`,`cd`.`fecha_vto` AS `fecha_vto`,`cd`.`cuota` AS `cuota`,`cd`.`saldo_cuota` AS `saldo_cuota`,`cd`.`ultimo_nro_recibo` AS `ultimo_nro_recibo`,`cd`.`ultimo_atraso` AS `ultimo_atraso`,`cd`.`ultimo_importe` AS `ultimo_importe`,`cd`.`ultima_Fecha_pago` AS `ultima_Fecha_pago`,`cd`.`ultimo_interes_calcu` AS `ultimo_interes_calcu`,`cd`.`ultimo_descuento` AS `ultimo_descuento`,`cd`.`ultimo_totalac` AS `ultimo_totalac`,`cd`.`estado` AS `estado_detalle`,(case `cd`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_detalle_descripcion`,(to_days(curdate()) - to_days(`cd`.`fecha_vto`)) AS `dias_atraso_actual`,(case when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 0)) then (to_days(curdate()) - to_days(`cd`.`fecha_vto`)) else 0 end) AS `dias_atraso_efectivo`,`cu`.`idcuotas` AS `idcuotas`,`cu`.`fecha` AS `fecha_cuota`,`cu`.`nrofactura` AS `factura_cuota`,`cu`.`cantidad_cuota` AS `cantidad_cuota`,`cu`.`primera_fecha_vto` AS `primera_fecha_vto`,`cu`.`total_venta` AS `total_cuota`,`cu`.`saldo_actual` AS `saldo_cuota_cabecera`,`cu`.`ultimo_fecha_pago` AS `ultimo_fecha_pago`,`cu`.`ultimo_importe` AS `ultimo_importe_cabecera`,`cu`.`ultimo_interes_calc` AS `ultimo_interes_cabecera`,`cu`.`ultimo_descuento` AS `ultimo_descuento_cabecera`,`cu`.`ultimo_totalac` AS `ultimo_totalac_cabecera`,`cu`.`estado` AS `estado_cuota`,(case `cu`.`estado` when 'PEN' then 'PENDIENTE' when 'CAN' then 'CANCELADO' end) AS `estado_cuota_descripcion`,`cu`.`anulado` AS `anulado`,`v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,`v`.`nrofactura` AS `nrofactura`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `factura_completa`,`v`.`total` AS `total_venta`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`c`.`idcliente` AS `idcliente`,`c`.`nombre` AS `cliente_nombre`,`c`.`apellido` AS `cliente_apellido`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`ruc` AS `cliente_ruc`,`c`.`celular` AS `celular`,`c`.`telefono` AS `telefono`,`c`.`referencia` AS `referencia`,`c`.`trabajo_lugar` AS `trabajo_lugar`,`c`.`trabajo_telefono` AS `trabajo_telefono`,`z`.`zona` AS `zona`,`b`.`barrio` AS `barrio`,`prof`.`profesion` AS `profesion`,`ven`.`idVendedor` AS `idVendedor`,concat(`pv`.`nombre`,' ',`pv`.`apellido`) AS `vendedor_nombre`,`cob`.`idcobrador` AS `idcobrador`,concat(`pc`.`nombre`,' ',`pc`.`apellido`) AS `cobrador_nombre`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `empresa`,(`cd`.`cuota` - `cd`.`saldo_cuota`) AS `total_pagado_detalle`,round((((`cd`.`cuota` - `cd`.`saldo_cuota`) / `cd`.`cuota`) * 100),2) AS `porcentaje_pagado_detalle`,(case when (`cd`.`estado` = 'CAN') then 'COMPLETAMENTE PAGADO' when (`cd`.`saldo_cuota` = 0) then 'COMPLETAMENTE PAGADO' when ((`cd`.`saldo_cuota` < `cd`.`cuota`) and (`cd`.`saldo_cuota` > 0)) then 'PAGO PARCIAL' when (`cd`.`saldo_cuota` = `cd`.`cuota`) then 'SIN PAGOS' else 'ESTADO INDETERMINADO' end) AS `situacion_pago`,(case when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 30)) then 'MORA GRAVE' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 15)) then 'MORA MODERADA' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) > 0)) then 'MORA LEVE' when ((`cd`.`estado` = 'PEN') and ((to_days(curdate()) - to_days(`cd`.`fecha_vto`)) <= 0)) then 'AL DÍA' else 'NO APLICA' end) AS `nivel_mora` from ((((((((((((`cuotas_detalle` `cd` join `cuotas` `cu` on((`cd`.`idcuotas` = `cu`.`idcuotas`))) join `venta` `v` on((`cu`.`idVenta` = `v`.`idVenta`))) join `cliente` `c` on((`v`.`idcliente` = `c`.`idcliente`))) join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) join `profesion` `prof` on((`c`.`idprofesion` = `prof`.`idprofesion`))) join `vendedor` `ven` on((`v`.`idVendedor` = `ven`.`idVendedor`))) join `personal` `pv` on((`ven`.`idPersonal` = `pv`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `pc` on((`cob`.`idPersonal` = `pc`.`idPersonal`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) where ((`v`.`estado` = 'F') and (`cu`.`anulado` = 'NO')) */;

/*View structure for view v_detalle_venta */

/*!50001 DROP TABLE IF EXISTS `v_detalle_venta` */;
/*!50001 DROP VIEW IF EXISTS `v_detalle_venta` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_detalle_venta` AS select `v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha_venta`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `nro_factura`,`dv`.`idDetalle` AS `idDetalle`,`dv`.`idarticulo` AS `idarticulo`,`a`.`descripcion` AS `articulo_descripcion`,`a`.`codbarra` AS `codbarra`,`dv`.`cantidad` AS `cantidad`,`dv`.`precosto` AS `precio_costo`,`dv`.`preventa` AS `precio_venta`,`dv`.`subtotal` AS `subtotal`,`m`.`Marca` AS `marca`,`g`.`grupo` AS `grupo_articulo`,`sg`.`subgrupo` AS `subgrupo_articulo`,`p`.`proveedor` AS `nombre_proveedor`,`dv`.`tipo_cuota` AS `tipo_cuota`,`dv`.`plan_cuota` AS `plan_cuota`,`dv`.`cant_cuota` AS `cant_cuota`,`dv`.`interes_mensual` AS `interes_mensual`,`dv`.`margen_conta` AS `margen_conta`,`dv`.`monto_cuota` AS `monto_cuota`,`dv`.`iva` AS `iva`,`dv`.`gravada_excenta` AS `gravada_excenta`,`dv`.`gravada_cinco` AS `gravada_cinco`,`dv`.`gravada_diez` AS `gravada_diez`,`c`.`idcliente` AS `idcliente`,concat(`c`.`nombre`,' ',`c`.`apellido`) AS `cliente_nombre_completo`,`c`.`ci` AS `cliente_ci`,`c`.`celular` AS `cliente_celular`,`c`.`telefono` AS `cliente_telefono`,`z`.`zona` AS `zona`,`b`.`barrio` AS `barrio`,`vend`.`idVendedor` AS `idVendedor`,concat(`p_vend`.`nombre`,' ',`p_vend`.`apellido`) AS `vendedor_nombre`,`cob`.`idcobrador` AS `idcobrador`,concat(`p_cob`.`nombre`,' ',`p_cob`.`apellido`) AS `cobrador_nombre`,`d`.`iddeposito` AS `iddeposito`,`d`.`deposito` AS `nombre_deposito`,`s`.`idsucursal` AS `idsucursal`,`s`.`sucursal` AS `sucursal`,`s`.`ciudad` AS `ciudad`,`s`.`direccion` AS `direccion_sucursal`,`e`.`idEmpresa` AS `idEmpresa`,`e`.`empresa` AS `nombre_empresa`,`e`.`ruc` AS `ruc_empresa`,`v`.`estado` AS `estado_venta`,`v`.`tipo` AS `tipo_venta`,(case when (`v`.`tipo` = 'CON') then 'CONTADO' when (`v`.`tipo` = 'CRE') then 'CRÉDITO' else `v`.`tipo` end) AS `tipo_venta_descripcion`,`v`.`total_gravada_excenta` AS `total_gravada_excenta`,`v`.`total_gravada_cinco` AS `total_gravada_cinco`,`v`.`total_gravada_diez` AS `total_gravada_diez`,`v`.`total` AS `total_factura`,`v`.`liqui_iva_5` AS `liqui_iva_5`,`v`.`liqui_iva_10` AS `liqui_iva_10`,`v`.`total_liqui_iva` AS `total_liqui_iva`,`v`.`fecha_vto_pagare` AS `fecha_vto_pagare` from ((((((((((((((((`venta` `v` join `detalle_venta` `dv` on((`v`.`idVenta` = `dv`.`idVenta`))) join `articulo` `a` on((`dv`.`idarticulo` = `a`.`idarticulo`))) join `marca` `m` on((`a`.`idMarca` = `m`.`idMarca`))) join `grupo` `g` on((`a`.`idgrupo` = `g`.`idgrupo`))) join `subgrupo` `sg` on((`a`.`idsubgrupo` = `sg`.`idsubgrupo`))) join `proveedor` `p` on((`a`.`idproveedor` = `p`.`idproveedor`))) join `cliente` `c` on((`v`.`idcliente` = `c`.`idcliente`))) join `zona` `z` on((`c`.`idzona` = `z`.`idzona`))) join `barrio` `b` on((`c`.`idbarrio` = `b`.`idbarrio`))) join `vendedor` `vend` on((`v`.`idVendedor` = `vend`.`idVendedor`))) join `personal` `p_vend` on((`vend`.`idPersonal` = `p_vend`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `p_cob` on((`cob`.`idPersonal` = `p_cob`.`idPersonal`))) join `deposito` `d` on((`dv`.`iddeposito` = `d`.`iddeposito`))) join `sucursal` `s` on((`v`.`idsucursal` = `s`.`idsucursal`))) join `empresa` `e` on((`v`.`idEmpresa` = `e`.`idEmpresa`))) where (`v`.`estado` = 'F') order by `v`.`fecha` desc,`v`.`idVenta` desc,`dv`.`idDetalle` */;

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

/*View structure for view v_venta */

/*!50001 DROP TABLE IF EXISTS `v_venta` */;
/*!50001 DROP VIEW IF EXISTS `v_venta` */;

/*!50001 CREATE ALGORITHM=UNDEFINED SQL SECURITY DEFINER VIEW `v_venta` AS select `v`.`idVenta` AS `idVenta`,`v`.`fecha` AS `fecha`,(case when (`v`.`tipo` = 'CON') then 'CONTADO' when (`v`.`tipo` = 'CRE') then 'CRÉDITO' else `v`.`tipo` end) AS `tipo_venta_descripcion`,`v`.`tipo` AS `tipo_venta`,`c`.`ci` AS `ci`,`c`.`apellido` AS `apellido`,`c`.`nombre` AS `nombre`,concat(`v`.`nrosuc`,'-',`v`.`nroexp`,'-',`v`.`nrofactura`) AS `nro_factura`,`c`.`idcliente` AS `idcliente`,`v`.`total` AS `total_venta`,concat(`p_vend`.`nombre`,' ',`p_vend`.`apellido`) AS `vendedor_nombre`,concat(`p_cob`.`nombre`,' ',`p_cob`.`apellido`) AS `cobrador_nombre` from (((((`venta` `v` join `cliente` `c` on((`v`.`idcliente` = `c`.`idcliente`))) join `vendedor` `vend` on((`v`.`idVendedor` = `vend`.`idVendedor`))) join `personal` `p_vend` on((`vend`.`idPersonal` = `p_vend`.`idPersonal`))) left join `cobrador` `cob` on((`v`.`idcobrador` = `cob`.`idcobrador`))) left join `personal` `p_cob` on((`cob`.`idPersonal` = `p_cob`.`idPersonal`))) where (`v`.`estado` = 'F') */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
