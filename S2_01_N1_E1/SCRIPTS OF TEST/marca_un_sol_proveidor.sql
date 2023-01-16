-- ES DEMOSTRA QUE NO ES POT POSAR UNA MARCA AMB UN ALTRE PROVEIDOR
-- L'ERROR => "Duplicate entry 'marca 1' for key 'marques.Nom_Marques_UNIQUE'"
USE s0201n1e1_culampolla;
INSERT INTO marques(id_proveidor_marques, nom_marques)
VALUES ('2', 'marca 1')
