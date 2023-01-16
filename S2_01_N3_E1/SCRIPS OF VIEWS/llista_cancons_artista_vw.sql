CREATE VIEW `llista_cancons_artista_vw` AS
SELECT 
	`art`.`nom_artistes` AS `nom_artistes`,
	`alb`.`titol_albums` AS `titol_albums`,
	`alb`.`any_albums` AS `any_albums`,
	`canc`.`titol_cancons` AS `titol_cancons`,
	`canc`.`durada_cancons` AS `durada_cancons`,
	`canc`.`reproduccions_cancons` AS `reproduccions_cancons`,
	`art`.`Id_artistes` AS `Id_artistes`,
	`alb`.`Id_albums` AS `Id_albums`,
	`alb`.`id_artista_albums` AS `id_artista_albums`,
	`canc`.`Id_cancons` AS `Id_cancons`,
	`canc`.`id_album_cancons` AS `id_album_cancons`
FROM `artistes` `art`
	LEFT JOIN `albums` `alb` ON `alb`.`id_artista_albums` = `art`.`Id_artistes`
	LEFT JOIN `cancons` `canc` ON `canc`.`id_album_cancons` = `alb`.`Id_albums`
GROUP BY `canc`.`Id_cancons`