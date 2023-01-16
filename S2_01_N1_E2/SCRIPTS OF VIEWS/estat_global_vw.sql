CREATE VIEW `estat_global_vw` AS
select
		(select count(*) from clients) AS 'Nº TOTAL DE CLIENTS',
        (select count(*) from ciutats) as 'Nº TOTAL DE CIUTATS',
        (select count(*) from pais) as 'Nº TOTAL DE PAISOS',
        (select count(*) from marques) as 'Nº TOTAL DE MARQUES',
        (select count(*) from ulleres) as 'NºTOTAL D\'ULLERES',
        (select count(*) from vendes) as 'Nº TOTAL DE VENDES',
        (select sum(ull.preu_ulleres) 
			from ulleres ull
			left join productes_vendes prvn on prvn.Id_productes_vendes = ull.Id_ulleres) 
            as '€ VENDES TOTALS';
		(select sum(*) from vendes)