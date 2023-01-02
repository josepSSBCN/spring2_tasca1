CREATE VIEW `lientcomplet_vw` 
AS 
SELECT * FROM clients
LEFT JOIN localitat loc ON loc.Id_Localitat = Localitat_IdLocalitat
LEFT JOIN provincia pro ON pro.Id_Provincia = loc.Provincia_Id_Provincia
group by Id_Clients;