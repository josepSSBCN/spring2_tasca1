-- SCRIPT TEST - Llistat de les begudes venudes en una localitat
USE `s201n1e2_pizzeria`;
SELECT 
    `loc`.`nom_localitat` AS 'Nom localitat',
    SUM(`com`.`quantitat_begudes_comandes`) AS 'Begudes venudes' 
FROM `productes_comandes` `proco`
LEFT JOIN `comandes` `com` ON `com`.`Id_comandes` = `proco`.`id_comandes_productes_comandes`
LEFT JOIN `clients` `cli` ON `cli`.`Id_clients` = `com`.`id_clients_comandes`
LEFT JOIN `localitat` `loc` ON `loc`.`Id_localitat` = `cli`.`id_localitat_clients`
LEFT JOIN `productes` `pro` ON  `pro`.`Id_productes` = `proco`.`id_productes_productes_comandes`
WHERE `pro`.`id_categories_productes` = 6
GROUP BY `loc`.`nom_localitat`
ORDER BY `loc`.`nom_localitat`;

-- LOCALITATS: Sabadell, 