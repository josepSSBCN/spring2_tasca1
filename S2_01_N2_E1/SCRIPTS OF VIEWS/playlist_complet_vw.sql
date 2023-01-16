CREATE VIEW `playlist_complet_vw` AS
SELECT 
	`ply`.`Id_playlist` AS `Id_playlist`,
	`ply`.`nom_playlist` AS `nom_playlist`,
	`ply`.`data_playlist` AS `data_playlist`,
	`estply`.`Id_estat_playlist` AS `Id_estat_playlist`,
	`estply`.`nom_estat_playlist` AS `nom_estat_playlist`,
	`usu`.`Id_usuari` AS `Id_usuari`,
	`usu`.`nom_usuari` AS `nom_usuari`
FROM `playlist` `ply`
	LEFT JOIN `estat_playlist` `estply` ON `estply`.`Id_estat_playlist` = `ply`.`id_estat_playlist_playlist`
	LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuari` = `ply`.`idUsuari_playlist`
GROUP BY `ply`.`Id_playlist`
ORDER BY `ply`.`nom_playlist`