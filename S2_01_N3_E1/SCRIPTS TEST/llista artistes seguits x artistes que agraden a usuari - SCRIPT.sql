-- SCRIPT que llista els artistes que segueix un usuari
use `s201n3e1_spotify`;
SELECT `usu`.`nom_usuaris` AS 'NOM USUARI',
	`art`.`nom_artistes` AS 'NOM ARTISTA SEGUIT',
    `art2`.`nom_artistes` AS 'ARTISTA SEGUIT PEL ARTISTA' 
FROM `seguidors` `seg`
LEFT JOIN `relacio_artistes` `relart` ON `relart`.`Id_artista_principal_relacio_artistes` = `seg`.`id_artista_seguidors`
LEFT JOIN `artistes` `art` ON `art`.`Id_artistes` = `seg`.`id_artista_seguidors`
LEFT JOIN `artistes` `art2` ON `art2`.`Id_artistes` = `relart`.`Id_artista_agradat_relacio_artistes`
LEFT JOIN `usuaris` `usu` ON `usu`.`Id_usuaris` = `seg`.`id_usuari_seguidors`
WHERE `seg`.`id_usuari_seguidors` = 1;