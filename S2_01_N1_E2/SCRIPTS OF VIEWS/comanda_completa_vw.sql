CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `comanda_completa_vw` AS
    SELECT 
        `cmd`.`Id_Comandes` AS `Id_Comandes`,
        `cmd`.`Clients_Id_Clients` AS `Clients_Id_Clients`,
        `cmd`.`Botiga_Id_Botiga` AS `Botiga_Id_Botiga`,
        `cmd`.`DataHora_Comandes` AS `DataHora_Comandes`,
        `cmd`.`RecDom_Comandes` AS `RecDom_Comandes`,
        `cmd`.`QuantitatPizzes_Comandes` AS `QuantitatPizzes_Comandes`,
        `cmd`.`QuantitatHamburgueses_Comandes` AS `QuantitatHamburgueses_Comandes`,
        `cmd`.`QuantitatBegudes_Comandes` AS `QuantitatBegudes_Comandes`,
        `cmd`.`PreuTotal_Comandes` AS `PreuTotal_Comandes`,
        `pro_cmd`.`Id_Productes_De_Comandes` AS `Id_Productes_De_Comandes`,
        `pro_cmd`.`Productes_Id_Productes` AS `Productes_Id_Productes`,
        `pro_cmd`.`Quantitat_Productes_De_Comandes` AS `Quantitat_Productes_De_Comandes`,
        `pro`.`Id_Productes` AS `Id_Productes`,
        `pro`.`Categories_Id_Categories` AS `Categories_Id_Categories`,
        `pro`.`Nom_Productes` AS `Nom_Productes`,
        `pro`.`Descripcio_Productes` AS `Descripcio_Productes`,
        `pro`.`Imatge_Productes` AS `Imatge_Productes`,
        `pro`.`Preu_Productes` AS `Preu_Productes`,
        `cat`.`Id_Categories` AS `Id_Categories`,
        `cat`.`Nom_Categories` AS `Nom_Categories`
    FROM
        (((`comandes` `cmd`
        LEFT JOIN `productes_de_comandes` `pro_cmd` ON ((`pro_cmd`.`Id_Productes_De_Comandes` = `cmd`.`Id_Comandes`)))
        LEFT JOIN `productes` `pro` ON ((`pro`.`Id_Productes` = `pro_cmd`.`Productes_Id_Productes`)))
        LEFT JOIN `categories` `cat` ON ((`cat`.`Id_Categories` = `pro`.`Categories_Id_Categories`)))
    GROUP BY `cmd`.`Id_Comandes`