CREATE VIEW `pagaments_subscripcio_totals_vw` AS
SELECT 
	`usu`.`nom_usuaris` AS `Nom Usuari`,
    `usu`.`Id_usuaris` AS `Id Usuari`,
    `subs`.`Id_subscripcions` AS `Id Subscripció`,    
	SUM(`paga`.`valor_pagaments`) AS `Suma Total`
FROM (`pagaments` `paga`
    LEFT JOIN `usuaris` `usu` ON ((`usu`.`Id_usuaris` = `paga`.`id_usuari_pagaments`))
    LEFT JOIN `subscripcions` `subs` ON ((`subs`.`Id_subscripcions` = `paga`.`id_subscripcions_pagaments` )))    
GROUP BY `subs`.`Id_subscripcions`
ORDER BY `paga`.`id_usuari_pagaments`;