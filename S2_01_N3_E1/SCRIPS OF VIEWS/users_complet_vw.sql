CREATE VIEW `users_complete_vw` AS
SELECT 
        `usr`.`Id_usuaris` AS `Id_usuaris`,
        `usr`.`email_usuaris` AS `email_usuaris`,
        `usr`.`nom_usuaris` AS `nom_usuaris`,
        `usr`.`date_neixament_usuaris` AS `date_neixament_usuaris`,
        `usr`.`cod_postal_usuaris` AS `cod_postal_usuaris`,
        `usr`.`premium_usuaris` AS `premium_usuaris`,
        `usr`.`id_sexe_usuaris` AS `id_sexe_usuaris`,
        `sx`.`nom_sexes` AS `nom_sexes`,
        `usr`.`id_pais_usuaris` AS `id_pais_usuaris`,
        `pss`.`nom_paisos` AS `nom_paisos`,
        `pyp`.`nom_usuari_paypals` AS `nom_usuari_paypals`,
        `trcr`.`numero_targetes_credit` AS `numero_targetes_credit`,
        `trcr`.`mes_targetes_credit` AS `mes_targetes_credit`,
        `trcr`.`any_targetes_credit` AS `any_targetes_credit`,
        `trcr`.`cvc_targetes_credit` AS `cvc_targetes_credit`,
        (select sum(`pagaments`.`valor_pagaments`) from `pagaments` 
			where `pagaments`.`id_usuari_pagaments` = `usr`.`Id_usuaris`) AS '€ RECAUDATS X USUARI'
    FROM
        usuaris usr
        LEFT JOIN `sexes` `sx` ON `sx`.`Id_sexes` = `usr`.`id_sexe_usuaris`
        LEFT JOIN `paisos` `pss` ON `pss`.`Id_paisos` = `usr`.`id_pais_usuaris`
        LEFT JOIN `paypals` `pyp` ON `pyp`.`id_usuari_paypals` = `usr`.`Id_usuaris`
        LEFT JOIN `targetes_credit` `trcr` ON `trcr`.`id_usuari_targetes_credit` = `usr`.`Id_usuaris`
    GROUP BY `usr`.`Id_usuaris`
    ORDER BY `usr`.`nom_usuaris`