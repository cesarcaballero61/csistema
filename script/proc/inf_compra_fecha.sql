DROP PROCEDURE IF EXISTS inf_compra_fecha;
DELIMITER $
CREATE PROCEDURE inf_compra_fecha(cod_suc INT, cod_prov INT,cod_tipo INT, desde DATE, hasta DATE)
BEGIN
IF cod_suc=0 THEN -- todas las sucursales
	IF cod_prov=0 THEN -- todos los proveedores
		IF cod_tipo=1 THEN -- ambos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F";

		ELSEIF cod_tipo=2 THEN -- contados
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=1;		
		ELSEIF cod_tipo=3 THEN -- creditos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=2;		
		END IF;
	ELSE -- por proveedor
		IF cod_tipo=1 THEN -- ambos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.idproveedor=cod_prov;

		ELSEIF cod_tipo=2 THEN -- contados
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=1  AND compra.idproveedor=cod_prov;		
		ELSEIF cod_tipo=3 THEN -- creditos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=2  AND compra.idproveedor=cod_prov;		
		END IF;	

	END IF;
ELSE -- por sucursal
	IF cod_prov=0 THEN -- todos los proveedores
		IF cod_tipo=1 THEN -- ambos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.idsucursal=cod_suc;

		ELSEIF cod_tipo=2 THEN -- contados
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=1 AND compra.idsucursal=cod_suc;		
		ELSEIF cod_tipo=3 THEN -- creditos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=2 AND compra.idsucursal=cod_suc;	
		END IF;
	ELSE -- por proveedor
		IF cod_tipo=1 THEN -- ambos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.idproveedor=cod_prov AND compra.idsucursal=cod_suc;

		ELSEIF cod_tipo=2 THEN -- contados
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=1  AND compra.idproveedor=cod_prov AND compra.idsucursal=cod_suc;	
		ELSEIF cod_tipo=3 THEN -- creditos
			SELECT
			    compra.idcompra
			    , compra.nro_factura
				, compra.fecha
			    , compra.tipo
			    , proveedor.proveedor
			    , compra.total_gravadas_excenta
			    , compra.total_gravadas_cinco
			    , compra.total_gravadas_diez
			    , sucursal.sucursal
			FROM
			    compra
			    INNER JOIN proveedor 
				ON (compra.idproveedor = proveedor.idproveedor)
			    INNER JOIN sucursal 
				ON (compra.idsucursal = sucursal.idsucursal) 
				WHERE compra.fecha>=desde AND compra.fecha<=hasta AND compra.estado="F" AND compra.estado=2  AND compra.idproveedor=cod_prov AND compra.idsucursal=cod_suc;	
		END IF;	

	END IF;

END IF;

END