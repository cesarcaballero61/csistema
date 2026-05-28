SELECT
     cliente.idcliente
    , cuotas.idcuotas
    , cuotas.nrofactura AS doc
    , cliente.ci
    , cliente.nombre
    , cliente.apellido
    , SUM(CASE WHEN cuotas_detalle.fecha_vto<='2016-01-01' THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS vencidos
    , SUM(CASE WHEN MONTH(cuotas_detalle.fecha_vto)=MONTH('2016-01-01')  THEN cuotas_detalle.saldo_cuota ELSE 0 END) AS 'En Mes'
    , SUM(CASE WHEN DATEDIFF('2016-01-01',cuotas_detalle.fecha_vto)<-31  THEN cuotas_detalle.saldo_cuota ELSE 0 END) 'A vencer'
    , SUM(cuotas_detalle.saldo_cuota) totalmonto
FROM
    db.cuotas
    INNER JOIN db.cliente 
        ON (cuotas.idcliente = cliente.idcliente)
    INNER JOIN db.cuotas_detalle 
        ON (cuotas_detalle.idcuotas = cuotas.idcuotas) 
       WHERE YEAR('2016-01-01')=YEAR(NOW()) 
        GROUP BY cuotas.idcuotas ORDER BY cliente.idcliente