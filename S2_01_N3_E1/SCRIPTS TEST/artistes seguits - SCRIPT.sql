-- scripty que llista els artistes que segueix un cert usuari
use `s201n3e1_spotify`;
SELECT `usu`.`nom_usuaris` AS 'NOM USUARI',
	`art`.`nom_artistes` as 'NOM ARTISTA SEGUIT'
FROM `seguidors` `seg`
LEFT JOIN `artistes` `art` ON `art`.`Id_artistes` = `seg`.`id_artista_seguidors`
LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuaris` = `seg`.`id_usuari_seguidors`
WHERE `seg`.`id_usuari_seguidors` = 1;