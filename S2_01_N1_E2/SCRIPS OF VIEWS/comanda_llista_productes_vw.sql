CREATE VIEW `comanda_llista_productes` AS
SELECT 
`cmd`.`Id_Comandes` AS `Id_Comandes`,
`procom`.`Quantitat_Productes_De_Comandes` AS `Quantitat_Productes_De_Comandes`,
`cmd`.`DataHora_Comandes` AS `DataHora_Comandes`,
`cmd`.`QuantitatPizzes_Comandes` AS `QuantitatPizzes_Comandes`,
`cmd`.`QuantitatHamburgueses_Comandes` AS `QuantitatHamburgueses_Comandes`,
`cmd`.`QuantitatBegudes_Comandes` AS `QuantitatBegudes_Comandes`,
`cmd`.`PreuTotal_Comandes` AS `PreuTotal_Comandes`,
`pro`.`Id_Productes` AS `Id_Productes`,
`pro`.`Nom_Productes` AS `Nom_Productes`,
`pro`.`Descripcio_Productes` AS `Descripcio_Productes`,
`pro`.`Imatge_Productes` AS `Imatge_Productes`,
`pro`.`Preu_Productes` AS `Preu_Productes`,
`cat`.`Id_Categories` AS `Id_Categories`,
`cat`.`Nom_Categories` AS `Nom_Categories` 
FROM `s201n1e2_pizzeria`.`productes_de_comandes` `procom`
LEFT JOIN `comandes` `cmd` ON  `cmd`.`Id_Comandes` = `procom`.`idComandes_Productes_De_Comandes`
LEFT JOIN `productes` `pro` ON `pro`.`Id_Productes` = `procom`.`idProductes_Productes_De_Comandes`
LEFT JOIN `categories` `cat` ON `cat`.`Id_Categories` = `pro`.`idCategories_Productes`