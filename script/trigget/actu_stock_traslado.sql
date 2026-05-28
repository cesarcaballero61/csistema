DELIMITER $$

CREATE
    TRIGGER act_stock_traslado BEFORE INSERT
    ON detalle_traslado
    FOR EACH ROW BEGIN
	UPDATE stockarticulo SET stock=stock-new.cantidad
	WHERE idarticulo=new.idarticulo AND iddeposito=new.iddeposito;
    END$$

DELIMITER ;