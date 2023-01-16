create VIEW `usuaris_pagaments_vw` AS
    SELECT 
        `usr`.`Id_usuaris` AS `Id_usuaris`,
        `usr`.`nom_usuaris` AS `nom_usuaris`,
        `subc`.`Id_subscripcions` AS `Id_subscripcions`,
        `subc`.`data_inici_subscripcions` AS `data_inici_subscripcions`,
        `subc`.`data_renovacio_subscripcions` AS `data_renovacio_subscripcions`,
        `pgm`.`Id_pagaments` AS `Id_pagaments`,
        `pgm`.`data_pagaments` AS `data_pagaments`,
        `pgm`.`num_orde_pagaments` AS `num_orde_pagaments`,
        `pgm`.`valor_pagaments` AS `valor_pagaments`
    FROM
        ((`usuaris` `usr`
        LEFT JOIN `subscripcions` `subc` ON ((`subc`.`id_usuari_subscripcions` = `usr`.`Id_usuaris`)))
        LEFT JOIN `pagaments` `pgm` ON ((`pgm`.`id_subscripcions_pagaments` = `subc`.`Id_subscripcions`)))
    ORDER BY `usr`.`Id_usuaris`