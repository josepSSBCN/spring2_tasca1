-- script que demostra que no es pot afegir una canço en 2 albums diferents
use `s201n3e1_spotify`;
INSERT INTO `cancons`(`cancons`.`id_album_cancons`, `cancons`.`titol_cancons`, 
`cancons`.`durada_cancons`, `cancons`.`reproduccions_cancons`)
VALUES(2, 'canço 4 album 1', 110, 1234875);
