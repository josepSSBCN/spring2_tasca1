CREATE VIEW `usuari_complet_vw` AS
    SELECT 
        `usu`.`Id_usuari` AS `Id_usuari`,
        `usu`.`email_usuari` AS `email_usuari`,
        `usu`.`nom_usuari` AS `nom_usuari`,
        `usu`.`password_usuari` AS `password_usuari`,
        `usu`.`DateNeixament_usuari` AS `DateNeixament_usuari`,
        `usu`.`cp_usuari` AS `cp_usuari`,
        `sx`.`Id_sexe` AS `Id_sexe`,
        `sx`.`Nom_sexe` AS `Nom_sexe`,
        `ps`.`Id_pais` AS `Id_pais`,
        `ps`.`nom_pais` AS `nom_pais`
    FROM `usuaris` `usu`
        LEFT JOIN `sexe` `sx` ON `sx`.`Id_sexe` = `usu`.`idsexe_usuari`
        LEFT JOIN `pais` `ps` ON `ps`.`Id_pais` = `usu`.`id_pais_usuaris`
    GROUP BY `usu`.`Id_usuari`
    ORDER BY `usu`.`nom_usuari`