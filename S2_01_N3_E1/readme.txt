TAULA PAÏSOS:
	1.- Al mon hi ha 194 països, fins a 255 del Id tipus TINYINT encara es poden crear molts països nous
TAULA USUARIS:
	1.- Es creen dos index, pel nom d'usuari i el e-mail.
TAULA PAGAMENTS:
	1.- He fet una petita modificació de l'anunicat, en la taula pagaments, es guarden els pagaments que a anat fent 
		l'usuari amb el id de la subscripció a que pertanyen.
		He creat una vista que sumarà tots els pagaments de cada subscripció que ha fet l'usuari.
	2.- He creat un index de la data, pk el més segur que els de contabilitat vuiguin saber quan s'ha pagat per dia
	3.- Per saber el total pagat per cada subscripció, s'ha creat una VIEW
	4.- Per saber el total pagat d'un usuari, s'ha creat la VIEW pagaments_totals_vw
TUAL 'formas_pagaments'
	1.- Ho he posat per subscripció, pk un suauri pot arribar a tenir difrents subscripcions i cadescuna d'aquestes
		fer el pagament d'una forma diferent.
VIEW 'pagaments_subscripcio_totals_vw'
	1.- Es el resultat de suma els pagaments d'una mateixa subscripció
	2.- La info que mostra és el el nom i el id del usuari, el id de la subscripció i el total de la subscripció
VIEW 'pagaments_totals_vw':
	1.- És el resultant de suma tots els pagaments d'un usuari
	2.- La info que mostra és el el nom i el id del usuari i el total
TAULA PLAYLISTS
	1.- Es crea un index per les cerques del títol
	2.- La part de la eliminació de les playlists, ho he fet amb un altre taula, les playlists que s'eliminen
		s'afegeix el id usuari, id playlist i la data d'eliminació en aquesta nova taual
	3.-

TAULA 'ARTISTES'
	1.- Es crea un index pel nom, per fer les cerques més ràpides.
TAULA 'ALBUMS'
	1.- Es crea un index pel titol i un altre per l'any, per fer les cerques més ràpides.
TAULA 'CANCONS'
	1.- Es crea un index pel titol, per fer cerques més ràpides




    




