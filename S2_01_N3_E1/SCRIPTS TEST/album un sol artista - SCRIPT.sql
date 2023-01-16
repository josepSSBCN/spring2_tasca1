-- SCRIPT que demostra que no pot haver-hi un album publicat per més d'un artista.
use `s201n3e1_spotify`;
INSERT INTO `albums`(`id_artista_albums`,`titol_albums`, `any_albums`, 
`thumbnail_albums`)
VALUES (2, 'En los años buenos', 2002, 'añosbuenos-png');
