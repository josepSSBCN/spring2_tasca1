-- SCRIPT que llista les playlista d'un usuari, en aquest cas 1
use `s201n3e1_spotify`;
SELECT * 
FROM `playlists`
WHERE `id_usuari_playlists` = 1;
