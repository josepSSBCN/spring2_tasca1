CREATE VIEW `comanda_info_complet_vw` AS 
SELECT `cmd`.`Id_Comandes` AS `Id_Comandes`,
`cmd`.`DataHora_Comandes` AS `DataHora_Comandes`,
`cmd`.`RecDom_Comandes` AS `RecDom_Comandes`,
`cmd`.`QuantitatPizzes_Comandes` AS `QuantitatPizzes_Comandes`,
`cmd`.`QuantitatHamburgueses_Comandes` AS `QuantitatHamburgueses_Comandes`,
`cmd`.`QuantitatBegudes_Comandes` AS `QuantitatBegudes_Comandes`,
`cmd`.`PreuTotal_Comandes` AS `PreuTotal_Comandes`,
`cli`.`Id_Clients` AS `Id_Clients`,
`cli`.`Nom_Clients` AS `Nom_Clients`,
`cli`.`Cognoms_Clients` AS `Cognoms_Clients`,
`cli`.`Adreca_Clients` AS `Adreca_Clients`,
`cli`.`CodiPostal_Clients` AS `CodiPostal_Clients`,
`cli`.`NumeroTelefon_Clients` AS `NumeroTelefon_Clients`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia`,
`endo`.`Lluirament_EntreguesDomicili` AS `Lluirament_EntreguesDomicili`,
`empl`.`Id_Empleats` AS `Id_Empleats`,
`empl`.`Nom_Empleats` AS `Nom_Empleats`,
`empl`.`Cognoms_Empleats` AS `Cognoms_Empleats`,
`empl`.`NIF_Empleats` AS `NIF_Empleats`,
`empl`.`Telefon_Empleats` AS `Telefon_Empleats`
FROM `Comandes` `cmd`
LEFT JOIN `Clients` `cli` ON `cli`.`Id_Clients` = `cmd`.`idClients_Comandes`
LEFT JOIN `Localitat` `loc` ON `loc`.`Id_Localitat` = `cli`.`idLocalitat_Clients`
LEFT JOIN `Provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
LEFT JOIN `EntreguesDomicili` `endo` ON `endo`.`Comanda_Id_Comanda` = `cmd`.`Id_Comandes`
LEFT JOIN `Empleats` `empl` ON `empl`.`Id_Empleats` = `endo`.`Empleat_Id_Empleat`
GROUP BY `cmd`.`Id_Comandes`;