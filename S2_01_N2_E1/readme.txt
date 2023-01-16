S'han creat X script per realitzar els tests demanats en l'anunciat...
	1.- usuaris.sql
		Mostra tota la infomració dels usuaris completament, incloent el país i el sexe
	2.- videos.sql
		Mostra tota la informació d'un video, incloent-hi l'usuari que l'ha creat i l'estat del vídeo

VISTES
S'han creat X vistes, per poder accedir a tota la info d'una manera més cómoda...
	1.- playlist_complet_vw.sql
		Mostra tota la info de la playlist, l'estat de la playlist i quin usuari l'ha creat
	2.- usuari_complet_vw.sql
		Mostra tota la info de l'usuari, incloent el país i el sexe
	3.- video_complet_vw.sql
		Mostra tota la informació d'un video, incloent-hi l'usuari que l'ha creat i l'estat del vídeo

TAULES...
	1.- TAULA VÍDEOS
		a.- L'estat dels vídeos aquest cop l'he fet amb un ENUM 'estat_videos' x veure com funciona.
		b.- He creat 2 index, pel 'idusuar' i 'titol', x agilitzar les cerques per títol i els vídeos que ha penjat un usuari
	2.- PLAYLIST
		a.- L'estat de les playlist, també l'he fet amb un ENUM 'estat_playlist' on hi ha les opcions 'privada' o 'publica'







