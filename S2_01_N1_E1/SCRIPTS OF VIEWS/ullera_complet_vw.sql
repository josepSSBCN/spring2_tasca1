-- MOSTRA TOTA LA INFO D'UNA ULLERA: el proveidor, el color, muntura, etc...
CREATE VIEW `ullera_complet_vw` AS
    SELECT 
        `ull`.`Id_ulleres` AS `Id_ulleres`,
        `ull`.`id_color_muntura_ulleres` AS `id_color_muntura_ulleres`,        
        `ull`.`preu_ulleres` AS `preu_ulleres`,
        `mun`.`Id_muntures` AS `Id_muntures`,
        `mun`.`tipus_muntures` AS `tipus_muntures`,
        `marq`.`Id_marques` AS `Id_marques`,
        `marq`.`id_proveidor_marques` AS `id_proveidor_marques`,
        `marq`.`nom_marques` AS `nom_marques`,
		`prvd`.`Id_proveidors` AS `Id_proveidors`,
        `prvd`.`nom_proveidors` AS `nom_proveidors`,        
        COUNT(`proven`.`Id_productes_vendes`) AS `UNITATS VENUDES`,
        (COUNT(`proven`.`Id_productes_vendes`) * `ull`.`preu_ulleres`) AS `VENDES TOTALS EN €`,
        `ull`.`id_graduacions_ulleres` AS `id_graduacions_ulleres`
    FROM
        `s0201n1e1_culampolla`.`ulleres` `ull`
        LEFT JOIN `s0201n1e1_culampolla`.`muntures` `mun` ON `mun`.`Id_muntures` = `ull`.`id_muntures_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`marques` `marq` ON `marq`.`Id_marques` = `ull`.`Id_marques_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`color_muntura` `col` ON `col`.`Id_color_muntura` = `ull`.`id_color_muntura_ulleres`
        LEFT JOIN `s0201n1e1_culampolla`.`productes_vendes` `proven` ON `proven`.`id_ullera_vendes` = `ull`.`Id_ulleres`
		LEFT JOIN `s0201n1e1_culampolla`.`proveidors` `prvd` ON `prvd`.`Id_proveidors` = `marq`.`id_proveidor_marques`
    GROUP BY `ull`.`Id_ulleres`