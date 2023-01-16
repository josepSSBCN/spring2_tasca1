CREATE VIEW `video_complet_vw` AS
SELECT 
	`vds`.`Id_videos` AS `Id_videos`,
	`vds`.`titol_videos` AS `titol_videos`,
	`vds`.`descripcio_videos` AS `descripcio_videos`,
	`vds`.`mida_videos` AS `mida_videos`,
	`vds`.`nom_arxiu_videos` AS `nom_arxiu_videos`,
	`vds`.`temps_videos` AS `temps_videos`,
	`vds`.`thumbnail_videos` AS `thumbnail_videos`,
	`vds`.`reproduccions_videos` AS `reproduccions_videos`,
	`vds`.`likes_videos` AS `likes_videos`,
	`vds`.`dislikes_videos` AS `dislikes_videos`,
	`vds`.`datetime_videos` AS `datetime_videos`,
	`estvd`.`Id_estat_video` AS `Id_estat_video`,
	`estvd`.`nom_estat_video` AS `nom_estat_video`,
	`usu`.`Id_usuari` AS `Id_usuari`,
	`usu`.`nom_usuari` AS `nom_usuari`
FROM `videos` `vds`
	LEFT JOIN `estat_video` `estvd` ON `estvd`.`Id_estat_video` = `vds`.`id_estat_video_videos`
	LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuari` = `vds`.`idUsari_videos`
GROUP BY `vds`.`Id_videos`
ORDER BY `vds`.`titol_videos`