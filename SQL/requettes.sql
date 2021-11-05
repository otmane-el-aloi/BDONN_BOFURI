
/* Message 2 */
SELECT CONCAT(nom, ' ', prenom) AS chauffeur, immatriculation AS camion FROM chauffeur;

/* Message 3*/
ALTER TABLE camion
ADD date_disponibilite VARCHAR;

UPDATE camion SET remarque = 'au garage', date_disponibilite = '2021-11-30', disponible = FALSE
WHERE LTRIM(RTRIM(immatriculation)) = 'AC-543-AG'

/* Message 4 */
SELECT immatriculation FROM camion
WHERE camion.disponible = TRUE 
EXCEPT 
SELECT immatriculation FROM chauffeur;

/* Message 5 */
SELECT commande.id_commande, commande.date_livraison, entreprise.nom as entreprise, 
CASE 
	WHEN commande_en_ordre.id_ordre ISNULL THEN 'livraison non programmée'
	ELSE CAST (commande_en_ordre.id_ordre as text)
END as id_livraison

FROM commande INNER JOIN entreprise ON (commande.id_entreprise = entreprise.id_entreprise)
LEFT JOIN commande_en_ordre ON (commande.id_commande = commande_en_ordre.id_commande)
WHERE date_part('month',commande.date_livraison) = '11' OR date_part('month', commande.date_livraison) = '12' ;

/* Message 6 */
SELECT chauffeur.nom as chauffeur, ordre_mission.id_ordre, ordre_mission.date_chargement
FROM ordre_mission INNER JOIN chauffeur ON (ordre_mission.id_chauffeur = chauffeur.id_chauffeur)
WHERE date_part('month', ordre_mission.date_chargement) = '12'
AND LTRIM(RTRIM(LOWER(chauffeur.nom))) LIKE 'henry le roc''h';

/* Message 7 */
do $$
DECLARE 
idOrdre integer;
idChauffeur integer;
idQuai integer;
BEGIN 
	SELECT MAX(id_ordre) INTO idOrdre FROM ordre_mission;
	idOrdre:= idOrdre + 1;
	SELECT id_quai INTO idQuai FROM quai_chargement WHERE  LTRIM(RTRIM(LOWER(adresse_quai))) LIKE '%nice%' ;
	SELECT id_chauffeur INTO idChauffeur FROM chauffeur WHERE LTRIM(RTRIM(LOWER(nom))) LIKE 'weber';
	INSERT INTO ordre_mission VALUES
	(idOrdre, idQuai, idChauffeur, CAST('2021-11-17 07:00:00' as timestamp));
END;$$

INSERT INTO commande_en_ordre VALUES
(3, 4, CAST('2021-11-17' as TIMESTAMP));

SELECT id_ordre, adresse_quai, CONCAT(chauffeur.nom, ' ', chauffeur.prenom) as chauffeur, ordre_mission.date_chargement
FROM ordre_mission INNER JOIN chauffeur ON (ordre_mission.id_chauffeur= chauffeur.id_chauffeur)
INNER JOIN quai_chargement ON (ordre_mission.id_quai = quai_chargement.id_quai);

/* Message 11*/
ALTER TABLE camion 
ADD "type" VARCHAR;

INSERT INTO chauffeur VALUES 
(7, 'Pierre', 'KIMOUS', NULL);

SELECT * FROM chauffeur;

/* Message 12 */
SELECT id_ordre, adresse_quai, CONCAT(chauffeur.nom, ' ', chauffeur.prenom) as chauffeur, ordre_mission.date_chargement
FROM ordre_mission INNER JOIN chauffeur ON (ordre_mission.id_chauffeur= chauffeur.id_chauffeur)
INNER JOIN quai_chargement ON (ordre_mission.id_quai = quai_chargement.id_quai)
WHERE EXTRACT(YEAR FROM ordre_mission.date_chargement) = '2021' AND LTRIM(RTRIM(LOWER(chauffeur.prenom))) = 'henry' 
AND LTRIM(RTRIM(LOWER(chauffeur.nom))) = 'le roc''h';

/* Message 13 */
ALTER TABLE chauffeur
ADD certification VARCHAR;

/* Message 14 et 15 */
UPDATE chauffeur
SET certification = 'regulier';

UPDATE chauffeur
SET certification = 'regulier, frigorifiques, double essieu'
WHERE LTRIM(RTRIM(UPPER(chauffeur.nom))) = 'CE''NEDRA' AND LTRIM(RTRIM(UPPER(chauffeur.prenom)))= 'ALEXANDRA';

UPDATE chauffeur
SET certification = 'regulier, frigorifiques'
WHERE LTRIM(RTRIM(UPPER(chauffeur.nom))) = 'EMOUCHET' AND LTRIM(RTRIM(UPPER(chauffeur.prenom))) = 'DAVID';

SELECT * FROM chauffeur;



/* Requete Bordereau de Livraison */
SELECT DISTINCT ordre_mission.id_ordre, entreprise.nom as entreprise, adresse_depot as depot, CONCAT(chauffeur.nom,' ', chauffeur.prenom) as chauffeur, commande_en_ordre.date_livraison_ordre, 
adresse_quai as quai_chargement, date_chargement, produit.nom, comporte.quantite
FROM ordre_mission INNER JOIN quai_chargement ON (ordre_mission.id_quai=quai_chargement.id_quai)
INNER JOIN commande_en_ordre ON (ordre_mission.id_ordre=commande_en_ordre.id_ordre)
INNER JOIN chauffeur ON (ordre_mission.id_chauffeur = chauffeur.id_chauffeur)
INNER JOIN commande ON (commande.id_commande = commande_en_ordre.id_commande)
INNER JOIN livree_a ON (commande.id_commande = livree_a.id_commande)
INNER JOIN depot ON (livree_a.id_depot = depot.id_depot)
INNER JOIN entreprise ON (commande.id_entreprise = entreprise.id_entreprise)
INNER JOIN comporte ON (comporte.id_commande = commande.id_commande )
INNER JOIN produit ON (comporte.id_produit = produit.id_produit)
WHERE ordre_mission.id_ordre = 3;

/* Test trigger update */
UPDATE comporte 
SET quantite = 100
WHERE  id_commande = 2 AND id_produit = 3;

SELECT * FROM commande_en_ordre as co
INNER JOIN ordre_mission as om ON (om.id_ordre = co.id_ordre);

/*
id_ordre = 2
id_commande = 4
id_quai = 1
id_produit = 5
quantite_commande_initial = 100
quantite_commande_nouvelle = 50
quantite_initial_quai  = 400
quantite_quai_prevue = 400 + 100 -50*/


/* Test trigger surpression */
SELECT * FROM ordre_mission;

SELECT * FROM quai_produit
WHERE id_quai = 2;

SELECT * FROM commande_en_ordre
WHERE id_ordre = 3;

/*
id_ordre = 3 
id_quai = 2
id_commande = 5
*/
