CREATE VIEW `botiga_complet_vw` AS
SELECT  
`bot`.`Id_Botigues` AS `Id_Botigues`,
`bot`.`CodiPostal_Botigues` AS `CodiPostal_Botigues`,
`bot`.`Adreça_Botigues` AS `Adreça_Botigues`,
`loc`.`Id_Localitat` AS `Id_Localitat`,
`loc`.`Nom_Localitat` AS `Nom_Localitat`,
`pro`.`Id_Provincia` AS `Id_Provincia`,
`pro`.`Nom_Provincia` AS `Nom_Provincia`
FROM `botigues` AS `bot`
RIGHT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_Localitat` = `bot`.`idLocalitat_Botigues`
RIGHT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_Provincia` = `loc`.`idProvincia_Localitat`
GROUP BY `s201n1e2_pizzeria`.`bot`.`Id_Botigues`;