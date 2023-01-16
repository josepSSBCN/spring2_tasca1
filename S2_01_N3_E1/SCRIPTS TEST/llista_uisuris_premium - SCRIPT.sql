-- SCRIPT que llista els usuaris segons si son premium o free
use `s201n3e1_spotify`;
SELECT `Id_usuaris`, `nom_usuaris`,
CASE `premium_usuaris`
	WHEN 0 THEN 'FREE'
	WHEN 1 THEN 'PREMIUM'
END AS 'Tipus subscripció'
FROM `usuaris`
order by `premium_usuaris`;



-- WHERE `premium_usuaris` = 1;