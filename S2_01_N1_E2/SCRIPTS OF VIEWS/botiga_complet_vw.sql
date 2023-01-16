CREATE VIEW `botiga_complet_vw` AS
SELECT  
`bot`.`Id_botigues` AS `Id_Botigues`,
`bot`.`codi_postal_botigues` AS `codi_postal_botigues`,
`bot`.`adreça_botigues` AS `adreça_botigues`,
`loc`.`Id_localitat` AS `Id_localitat`,
`loc`.`nom_localitat` AS `nom_localitat`,
`pro`.`Id_provincia` AS `Id_provincia`,
`pro`.`nom_provincia` AS `nom_provincia`
FROM `botigues` AS `bot`
RIGHT JOIN `s201n1e2_pizzeria`.`localitat` `loc` ON `loc`.`Id_localitat` = `bot`.`id_localitat_botigues`
RIGHT JOIN `s201n1e2_pizzeria`.`provincia` `pro` ON `pro`.`Id_provincia` = `loc`.`id_provincia_localitat`
GROUP BY `s201n1e2_pizzeria`.`bot`.`Id_botigues`;