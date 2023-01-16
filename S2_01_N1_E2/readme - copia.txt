S'han creat 2 script per realitzar els tests demanats en l'anunciat...
	1.- begudes d'una localitat - SCRIPT.sql
		Mostra totes les begudes que s'han demanat en una localitat
	2.- comdes servides per un empleat - SCRIPT.sql
		Mostra les comandes servides per un

S'han creat 4 vistes, per poder accedir a tota la info més comodoment...
	1.- client_complet_vw
		Mostra tota la info del client, incloent localitat i provincia
	2.- botiga_complet_vw
		Mostra tota la info de la botiga,  incloent localitat i provincia
	3.- comanda_info_complet_vw
		Mostra tota la info d'una comanda, incloent el client i la seva localitat i provinca, el repartidor que 
		portarà la moto
	4.- comanda_llista_productes
		Mostra tota la info de la llista de productes que te una comanda

A nivell de taules...
	1.- Comandes
		a.- S'ha creat una taula intermitja 'productes_comandes' per poder guardar els productes que s'han comprat 
			en cada comanda
		b.- En la taula 'entregues_domicili' els registres indiquen quines comandes s'han d'enviar a domicili i quin 
			empleat les entrega.
	



