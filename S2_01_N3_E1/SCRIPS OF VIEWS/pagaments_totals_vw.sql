CREATE VIEW `pagaments_totals_vw` AS
SELECT 
	`usu`.`nom_usuaris` AS `Nom Usuari`,
    `usu`.`Id_usuaris` AS `Id Usuari`,
	SUM(`paga`.`valor_pagaments`) AS `Suma Total`
FROM (`pagaments` `paga`
    LEFT JOIN `usuaris` `usu` ON (`usu`.`Id_usuaris` = `paga`.`id_usuari_pagaments`))
GROUP BY `paga`.`id_usuari_pagaments`
ORDER BY `paga`.`id_usuari_pagaments`;