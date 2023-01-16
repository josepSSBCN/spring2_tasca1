CREATE VIEW `client_complet_vw` AS
SELECT 
	`cli`.`Id_clients` AS `Id_clients`,
	`cli`.`id_client_recomanador_clients` AS `id_client_recomanador_clients`,
	`cli`.`nom_clients` AS `nom_clients`,
	`cli`.`telefon_clients` AS `telefon_clients`,
	`cli`.`email_clients` AS `email_clients`,
	`cli`.`data_registre_clients` AS `data_registre_clients`,
	`adr`.`Id_adreca` AS `Id_adreca`,
	`adr`.`carrer_adreca` AS `carrer_adreca`,
	`adr`.`numero_adreca` AS `numero_adreca`,
	`adr`.`pis_adreca` AS `pis_adreca`,
	`adr`.`porta_adreca` AS `porta_adreca`,
	`adr`.`codi_postal_adreca` AS `codi_postal_adreca`,
	`ps`.`Id_pais` AS `Id_pais`,
	`ps`.`nom_pais` AS `nom_pais`,
	`ciu`.`nom_ciutats` AS `nom_ciutats`,        
	COUNT(`vnds`.`Id_vendes`) AS `VENDES REALITZADES AL CLIENT`,
	`ciu`.`Id_ciutats` AS `Id_ciutats`
FROM `s0201n1e1_culampolla`.`clients` `cli`
	LEFT JOIN `s0201n1e1_culampolla`.`adreca` `adr` ON `adr`.`Id_adreca` = `cli`.`id_adreca_clients`
	LEFT JOIN `s0201n1e1_culampolla`.`pais` `ps` ON `ps`.`Id_pais` = `adr`.`id_pais_adreca`
	LEFT JOIN `s0201n1e1_culampolla`.`ciutats` `ciu` ON `ciu`.`Id_ciutats` = `adr`.`id_ciutat_adreca`
	LEFT JOIN `s0201n1e1_culampolla`.`vendes` `vnds` ON `vnds`.`id_clients_vendes` = `cli`.`Id_clients`
	LEFT JOIN `s0201n1e1_culampolla`.`productes_vendes` `proven` ON `proven`.`Id_productes_vendes` = `vnds`.`Id_vendes`
GROUP BY `cli`.`Id_clients`
ORDER BY `cli`.`nom_clients`