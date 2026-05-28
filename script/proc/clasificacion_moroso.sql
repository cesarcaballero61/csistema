drop function if exists clasificacion_moroso;
DELIMITER $$

CREATE

    FUNCTION clasificacion_moroso(atraso int,cod_sucursal int)
    RETURNS CHAR(10)
	
    BEGIN
	DECLARE tipo_morosidad CHAR(10);
	DECLARE moroso_reg_desde,moroso_reg_hasta INT;
	DECLARE moroso_grav_desde,moroso_grav_hasta INT;
	DECLARE inforc INT;

	select mor_desde from parametro_sistema  where idsucursal=cod_sucursal into moroso_reg_desde;
	select mor_hasta from parametro_sistema  where idsucursal=cod_sucursal into moroso_reg_hasta;

	select morg_desde from parametro_sistema  where idsucursal=cod_sucursal into moroso_grav_desde;
	select morg_hasta from parametro_sistema  where idsucursal=cod_sucursal into moroso_grav_hasta;
	
	IF atraso>=moroso_reg_desde AND atraso<=moroso_reg_hasta THEN
		SET tipo_morosidad="MR";
	END IF;
	
	IF atraso>=moroso_grav_desde AND atraso<=moroso_grav_hasta THEN
		SET tipo_morosidad="MG";
	END IF;
	
	IF atraso>=inforc AND atraso<=119 THEN 
		SET tipo_morosidad="INF";
	END IF;
	
	IF atraso>=120 THEN 
		SET tipo_morosidad="INC";
	END IF;
	
	RETURN tipo_morosidad;
    END$$

DELIMITER ;