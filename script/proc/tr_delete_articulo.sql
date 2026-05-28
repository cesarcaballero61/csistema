DELIMITER $$

USE `db`$$

DROP TRIGGER /*!50032 IF EXISTS */ `trg_delete_articulo`$$

CREATE
    /*!50017 DEFINER = 'root'@'localhost' */
    TRIGGER `trg_delete_articulo` BEFORE DELETE ON `articulo` 
    FOR EACH ROW BEGIN
	DELETE FROM stockarticulo WHERE stockarticulo.idarticulo = old.idarticulo;
END;
$$

DELIMITER ;