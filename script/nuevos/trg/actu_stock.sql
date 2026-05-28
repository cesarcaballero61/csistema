DELIMITER $$
DROP TRIGGER IF EXISTS actu_stock$$
CREATE
   
    TRIGGER actu_stock BEFORE INSERT ON detalle_venta
    FOR EACH ROW 
    BEGIN
	UPDATE stockarticulo SET stock=stock-new.cantidad WHERE idarticulo=new.idarticulo AND iddeposito=new.iddeposito;
    END$$

DELIMITER ;