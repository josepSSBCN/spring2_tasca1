CREATE VIEW `comanda_llista_productes` AS
SELECT 
`cmd`.`Id_comandes` AS `Id_comandes`,
`procom`.`quantitat_productes_comandes` AS `quantitat_productes_comandes`,
`cmd`.`data_comandes` AS `data_comandes`,
`cmd`.`quantitat_pizzes_comandes` AS `quantitat_pizzes_comandes`,
`cmd`.`quantitat_hamburgueses_comandes` AS `quantitat_hamburgueses_comandes`,
`cmd`.`quantitat_begudes_comandes` AS `quantitat_begudes_comandes`,
`cmd`.`preu_total_comandes` AS `preu_total_comandes`,
`pro`.`Id_productes` AS `Id_productes`,
`pro`.`nom_productes` AS `nom_productes`,
`pro`.`descripcio_productes` AS `descripcio_productes`,
`pro`.`imatge_productes` AS `imatge_productes`,
`pro`.`preu_productes` AS `preu_productes`,
`cat`.`Id_categories` AS `Id_categories`,
`cat`.`nom_categories` AS `nom_categories` 
FROM `s201n1e2_pizzeria`.`productes_comandes` `procom`
LEFT JOIN `comandes` `cmd` ON  `cmd`.`Id_comandes` = `procom`.`id_comandes_productes_comandes`
LEFT JOIN `productes` `pro` ON `pro`.`Id_productes` = `procom`.`id_productes_productes_comandes`
LEFT JOIN `categories` `cat` ON `cat`.`Id_categories` = `pro`.`id_categories_productes`