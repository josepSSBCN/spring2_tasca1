S'han creat 3 scripts per provar el que demana l'anunciat...

	1.- client_complet.sql
	2.- marca_un_sol_proveidor.sql
	3.- ullera_proveidor.sql

També s'han creat 3 vistes per tenir tota la informació completa...

	1.- client_complet_vw.sql
		a.- S'ha creat una columna x veure els nº de compres que s'han creat
	2.- proveidor_complet_vw.sql
	3.- ullera_complet_vw.sql
		a.- S'ha creat una columna x veure el nº d'unitats venudes de cada tipus d'ullera
		b.- S'ha creat una columna x veure els € facturats per cada tipus d'ullera

A nivell de taules...
	1.- ADREÇA
		a.- S'ha creat una taula on guardar les adreces
		b.- s'han creat 2 taules auxiliars, amb els paissos i les ciutats, d'aquesta manera es facilitarà la selecció
	2.- ULLERES
		a.- S'han creat taules auxiliars per el color de la muntura, tipus de muntura, graduacions per facilitar la selecció
		b.- També s'ha creat una taula auxiliar per les màrques, que relaciona el proveidor, d'aquesta manera es pot evitar
			que una marca tingui 2 proveidors
	3.- VENDES
		a.- Per guardar les vendes, hi ha una primera taula 'vendes' on es guarda la info de la venda i una segona taula
			on es guarda els productes venuts en la venda. 
			D'aquesta manera una mateixa venda pot tenir diferents productes. 

