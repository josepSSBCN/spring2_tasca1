CREATE VIEW `client_complet_vw` AS
SELECT `cli`.`Id_Clients` AS `Id_Clients`,
`cli`.`Nom_Clients` AS `Nom_Clients`,
`cli`.`Cognoms_Clients` AS `Cognoms_Clients`,
`cli`.`Adreca_Clients` AS `Adreca_Clients`,
`cli`.`CodiPostal_Clients` AS `CodiPostal_Clients`,
`cli`.`NumeroTelefon_Clients` AS `NumeroTelefon_Clients`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia` 
FROM `s201n1e2_pizzeria`.`Clients` `cli`
LEFT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_Localitat` = `cli`.`idLocalitat_Clients`
LEFT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
GROUP BY `cli`.`Id_Clients`;