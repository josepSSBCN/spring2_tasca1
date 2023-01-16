CREATE VIEW `client_complet_vw` AS
SELECT `cli`.`Id_clients` AS `Id_clients`,
`cli`.`nom_clients` AS `nom_clients`,
`cli`.`cognoms_clients` AS `cognoms_clients`,
`cli`.`adreca_clients` AS `sareca_clients`,
`cli`.`codi_postal_clients` AS `codi_postal_clients`,
`cli`.`telefon_clients` AS `telefon_clients`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia` 
FROM `s201n1e2_pizzeria`.`clients` `cli`
LEFT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_localitat` = `cli`.`id_localitat_clients`
LEFT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
GROUP BY `cli`.`Id_clients`;