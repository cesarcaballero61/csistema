drop procedure if exists cur_kardex;
delimiter $
create procedure cur_kardex(desde date,hasta date ,cod_suc int,cod_deposito int,cod_motivo int,cod_articulo int)

begin
if cod_suc=0 then  -- Todas las sucursales.
	if cod_motivo=0 then -- Todas los motivos.
		if cod_deposito=0 then -- Todas los depositos.
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal) 
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo;
			end if;
		else -- por deposito
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.iddeposito=cod_deposito;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.iddeposito=cod_deposito;
			end if;
		end if;
	else -- por motivo.
		if cod_deposito=0 then -- Todas los depositos.
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idmotivo=cod_motivo;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)				
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.idmotivo=cod_motivo;
			end if;
		else -- por deposito
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.iddeposito=cod_deposito and kardex.idmotivo=cod_motivo;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)				
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.iddeposito=cod_deposito and kardex.idmotivo=cod_motivo;
			end if;
		end if;
	end if;

else -- por sucursal
	if cod_motivo=0 then -- Todas los motivos.
		if cod_deposito=0 then -- Todas los depositos.
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo;
			end if;
		else -- por deposito
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.iddeposito=cod_deposito;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.iddeposito=cod_deposito;
			end if;
		end if;
	else -- por motivo.
		if cod_deposito=0 then -- Todas los depositos.
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idmotivo=cod_motivo;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
				where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.idmotivo=cod_motivo;
			end if;
		else -- por deposito
			if cod_articulo=0 then -- Todas los articulos.
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo) 
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.iddeposito=cod_deposito and kardex.idmotivo=cod_motivo;
			else
				SELECT
					kardex.operacion
					, articulo.codbarra
					, articulo.descripcion
					, kardex.fecha
					, kardex.tipo
					, kardex.cantidad
					, motivo_ajuste.motivo
					, kardex.Nro_comprobante
					, sucursal.sucursal
					, kardex.iddeposito
					, deposito.deposito
				FROM
					db.kardex
					INNER JOIN db.articulo 
						ON (kardex.idarticulo = articulo.idarticulo)
					INNER JOIN db.motivo_ajuste 
						ON (kardex.idmotivo = motivo_ajuste.idmotivo)
					INNER JOIN db.sucursal 
						ON (kardex.idsucursal = sucursal.idsucursal)
					INNER JOIN db.deposito
						ON(Kardex.iddeposito=deposito.iddeposito)
					where kardex.fecha>=desde and kardex.fecha<=hasta and kardex.idarticulo=cod_articulo and kardex.iddeposito=cod_deposito and kardex.idmotivo=cod_motivo;
			end if;
		end if;
	end if;
end if;
END 