DELIMITER $$

USE `db`$$

DROP TRIGGER /*!50032 IF EXISTS */ `actu_stock`$$

CREATE
    /*!50017 DEFINER = 'root'@'localhost' */
    TRIGGER `actu_stock` BEFORE INSERT ON `detalle_venta` 
    FOR EACH ROW BEGIN
	UPDATE stockarticulo SET stock=stock-(new.cantidad * new.cant_unidad) WHERE idarticulo=new.idarticulo AND iddeposito=new.iddeposito;
    END;
$$

DELIMITER ;