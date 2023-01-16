-- SCRIPT TEST - Comades realitzades x un empleat
USE `s201n1e2_pizzeria`;
SELECT 
	`empl`.`nom_empleats` AS 'Nom Empleat',
	count(`endo`.`id_Comanda_entregues_domicili`) AS 'Comandes Servides'
FROM `comandes` `com`
LEFT JOIN `entregues_domicili` `endo` ON `endo`.`id_Comanda_entregues_domicili` = `com`.`Id_comandes`
LEFT JOIN `empleats` `empl` ON `empl`.`Id_empleats` = `endo`.`id_empleat_entregues_domicili`
WHERE `com`.`rec_dom_comandes` = 1 -- AND `empl`.`Id_empleats` = 3
GROUP BY `empl`.`nom_empleats`