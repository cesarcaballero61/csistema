SELECT
    venta.idVenta
    ,cuotas.idcuotas
    , venta.nrofactura
    , cliente.nombre
    , cliente.apellido
    , cliente.ci
    ,(SELECT SUM(cuotas_detalle.saldo_cuota) FROM cuotas_detalle WHERE cuotas_detalle.fecha_vto>'2016-01-31' AND cuotas_detalle.idcuotas=cuotas.idcuotas) AS a_vencer
    ,(SELECT SUM(cuotas_detalle.saldo_cuota) FROM cuotas_detalle WHERE DATEDIFF('2016-01-31',cuotas_detalle.fecha_vto)>=0 AND DATEDIFF('2016-01-31',cuotas_detalle.fecha_vto)<=30 AND cuotas_detalle.idcuotas=cuotas.idcuotas) AS cero_treinta
  
FROM
    db.venta
    INNER JOIN db.cliente 
        ON (venta.idcliente = cliente.idcliente)
    INNER JOIN db.cuotas 
        ON (cuotas.idVenta = venta.idVenta)
    INNER JOIN db.cuotas_detalle 
        ON (cuotas_detalle.idcuotas = cuotas.idcuotas)
       WHERE venta.idcliente=45
  GROUP BY venta.idVenta