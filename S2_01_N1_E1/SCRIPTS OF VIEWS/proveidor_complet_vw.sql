-- MOSTRA TOTA LA INFO D'UN PROVEÏDOR
CREATE VIEW `proveidor_complet_vw` AS
    SELECT 
        `prov`.`Id_proveidors` AS `Id_proveidors`,
        `prov`.`nom_proveidors` AS `nom_proveidors`,
        `prov`.`telefon_proveidors` AS `telefon_proveidors`,
        `prov`.`fax_proveidors` AS `fax_proveidors`,
        `prov`.`nif_proveidors` AS `nif_proveidors`,
        `adr`.`Id_adreca` AS `Id_adreca`,
        `adr`.`carrer_adreca` AS `carrer_adreca`,
        `adr`.`numero_adreca` AS `numero_adreca`,
        `adr`.`pis_adreca` AS `pis_adreca`,
        `adr`.`porta_adreca` AS `porta_adreca`,
        `adr`.`codi_postal_adreca` AS `codi_postal_adreca`,
        `pais`.`Id_pais` AS `Id_pais`,
        `pais`.`nom_pais` AS `nom_pais`,
        `ciu`.`Id_ciutats` AS `Id_ciutats`,
        `ciu`.`nom_ciutats` AS `nom_ciutats`
    FROM
        `s0201n1e1_culampolla`.`proveidors` `prov`
        LEFT JOIN `s0201n1e1_culampolla`.`adreca` `adr` ON `adr`.`Id_adreca` = `prov`.`id_adreca_proveidors`
        LEFT JOIN `s0201n1e1_culampolla`.`pais` `pais` ON `pais`.`Id_pais` = `adr`.`id_pais_adreca`
        LEFT JOIN `s0201n1e1_culampolla`.`ciutats` `ciu` ON `ciu`.`Id_ciutats` = `adr`.`id_ciutat_adreca`
    GROUP BY `prov`.`Id_proveidors`
    ORDER BY `prov`.`nom_proveidors`