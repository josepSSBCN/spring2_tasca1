CREATE VIEW `comanda_info_complet_vw` AS 
SELECT `cmd`.`Id_comandes` AS `Id_comandes`,
`cmd`.`data_comandes` AS `data_comandes`,
`cmd`.`rec_dom_comandes` AS `rec_dom_comandes`,
`cmd`.`quantitat_pizzes_comandes` AS `quantitat_pizzes_comandes`,
`cmd`.`quantitat_hamburgueses_comandes` AS `quantitat_hamburgueses_comandes`,
`cmd`.`quantitat_begudes_comandes` AS `quantitat_begudes_comandes`,
`cmd`.`preu_total_comandes` AS `preu_total_comandes`,
`cli`.`Id_clients` AS `Id_clients`,
`cli`.`nom_clients` AS `nom_clients`,
`cli`.`cognoms_clients` AS `cognoms_clients`,
`cli`.`adreca_clients` AS `adreca_clients`,
`cli`.`codi_postal_clients` AS `codi_postal_clients`,
`cli`.`telefon_clients` AS `telefon_clients`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia`,
`endo`.`lluirament_entregues_domicili` AS `lluirament_entregues_domicili`,
`empl`.`Id_empleats` AS `Id_empleats`,
`empl`.`nom_empleats` AS `nom_empleats`,
`empl`.`cognoms_empleats` AS `cognoms_empleats`,
`empl`.`nif_empleats` AS `nif_empleats`,
`empl`.`telefon_empleats` AS `telefon_empleats`
FROM `comandes` `cmd`
LEFT JOIN `clients` `cli` ON `cli`.`Id_clients` = `cmd`.`id_clients_comandes`
LEFT JOIN `localitat` `loc` ON `loc`.`Id_localitat` = `cli`.`id_localitat_clients`
LEFT JOIN `provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
LEFT JOIN `entregues_domicili` `endo` ON `endo`.`id_Comanda_entregues_domicili` = `cmd`.`Id_comandes`
LEFT JOIN `empleats` `empl` ON `empl`.`Id_empleats` = `endo`.`id_empleat_entregues_domicili`
GROUP BY `cmd`.`Id_comandes`;