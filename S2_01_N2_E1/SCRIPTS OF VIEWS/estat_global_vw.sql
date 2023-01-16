CREATE VIEW `estat_global_vw` AS
SELECT
(select count(*) from usuarus) as 'Nº TOTAL USUARIS',
(select count(*) from usuaris where Id_sexe = 1) as 'Nº TOTAL HOMES',
(select count(*) from usuaris where Id_sexe = 2) as 'Nº TOTAL DONES',
(select  count(*) from subscripcions) as 'Nº TOTAL SUBSCRIPCIONS',
(select count(*) from canals) as 'Nº TOTAL CANALS',
(select count(*) from videos) as 'Nº TOTAL DE VIDEOS',
(select count(*) from likeS_videos) as 'Nº TOTAL DE LIKES A videos',
(select count(*) from etiquetes) as 'Nº TOTAL D\'ETIQUETES',
(select count(*) from comentaris) as ' Nº TOTAL DE COMENTARIS',
(select count(*) from like_comentaris) as 'Nº TOTAL DE LIKES A COMENTARIS',
(select count(*) from playlist) as 'Nº TOTAL DE PLAYLISTS',
(select count(*) fromlike_comentaris as 'Nº TOTAL DE COMENTARIS',