drop procedure if exists cur_recibo_extracto;
delimiter $
create procedure cur_recibo_extracto(cod_cuota int)

begin
SELECT
    pagos_cuotas.idpago
    , pagos_cuotas.nro_recibo
	, detalle_pagos_cuotas.orden_char as orden
    , pagos_cuotas.fecha
    , detalle_pagos_cuotas.atraso
    , detalle_pagos_cuotas.interes
    , detalle_pagos_cuotas.descuento
    , detalle_pagos_cuotas.importe
FROM
    detalle_pagos_cuotas
    INNER JOIN pagos_cuotas 
        ON (detalle_pagos_cuotas.idpago = pagos_cuotas.idpago) 
		where pagos_cuotas.idcuotas=cod_cuota AND pagos_cuotas.estado="COB";

end 