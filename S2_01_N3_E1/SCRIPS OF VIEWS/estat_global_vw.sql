CREATE VIEW `estat_global_vw` AS
 SELECT 
        (SELECT COUNT(*) FROM `usuaris`) AS 'Nº USUARIS',
        (SELECT COUNT(*) FROM `subscripcions`) AS 'SUBSCRIPCIONS TOTALS',
        (SELECT SUM(`valor_pagaments`) FROM `pagaments`) AS 'INGRESSOS TOTALS (€)',
        (SELECT COUNT(*) FROM `playlists`) AS 'Nº PLAYLISTS',
        (SELECT COUNT(*) FROM playlist_eliminades) AS ' PLAYLIST ELIMINDADES',
        (SELECT COUNT(*) FROM `artistes`) AS 'Nº ARTISTES',
        (select count(*) from `cancons`) as 'Nº CANÇONS',
        (select count(*) from `albums`) as 'Nº ALBUMS';