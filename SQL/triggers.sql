/* TRIGGER pour la mise à jour de la quantité d'un produit */
CREATE OR REPLACE FUNCTION gere_quantite_produit_update() RETURNS TRIGGER language ’plpgsql’ AS
$BODY$
DECLARE
quai_id INTEGER;
BEGIN
    IF OLD.quantite != NEW.quantite THEN 
        IF OLD.id_commande IN (SELECt id_commande FROM commande_en_ordre) THEN 
            SELECT id_quai INTO quai_id 
            FROM ordre_mission INNR JOIN commande_en_ordre 
            ON (ordre_mission.id_ordre = commande_en_ordre.id_ordre);

            UPDATE quai_produit 
            SET qte = qte + OLD.quantite - NEW.quantite
            WHERE quai_produit.id_quai = quai_id AND OLD.id_produit = quai_produit.id_produit;
        END IF;
    END IF;
    RETURN NEW ;
END ;
$BODY$ ;

CREATE TRIGGER gere_quantite_produit_update
AFTER UPDATE
ON comporte
FOR EACH ROW EXECUTE PROCEDURE gere_quantite_produit_update() ;



/* TRIGGER pour l'insertion d'une ligne de livraison */
DECLARE
    produit_qte CURSOR FOR SELECT commande_en_ordre.id_commande, comporte.id_produit, comporte.quantite
    FROM ordre_mission INNER JOIN commande_en_ordre ON (ordre_mission.id_ordre=commande_en_ordre.id_ordre)
    INNER JOIN commande ON (commande_en_ordre.id_commande=commande.id_commande)
    INNER JOIN comporte ON (commande.id_commande = comporte.id_produit)
    INNER JOIN produit ON (comporte.id_produit=produit.id_produit)
    WHERE ordre_mission.id_ordre = NEW.id_ordre;

    quai_id INTEGER;
    ordre_id INTEGER;
    commande_id INTEGER;
    produit_id INTEGER;
    quantite_commande FLOAT;
    qte_quai FLOAT;

BEGIN
    quai_id := NEW.id_quai;
    ordre_id := NEW.id_ordre;
    OPEN produit_qte;
    LOOP 
        FETCH produit_qte INTO commande_id, produit_id, quantite_commande;
		EXIT WHEN NOT FOUND;
        UPDATE quai_produit 
        SET qte = qte - quantite_commande
        WHERE quai_produit.id_produit = produit_id AND quai_produit.id_quai = quai_id;
	END LOOP;
	CLOSE produit_qte;
    RETURN NEW ;
END ;

CREATE TRIGGER gestion_quantite_insertion
        AFTER INSERT
        ON commande_en_ordre
        FOR EACH ROW 
        EXECUTE PROCEDURE gere_quantite_produit_insertion();



/* TRIGGER pour gerer les quantités des produits appartenant aux livraisons supperimée */
CREATE OR REPLACE FUNCTION gere_quantite_produit_surpression() RETURNS TRIGGER language 'plpgsql' AS
$BODY$
DECLARE
    produit_qte CURSOR FOR SELECT commande_en_ordre.id_commande, comporte.id_produit, comporte.quantite
    FROM ordre_mission INNER JOIN commande_en_ordre ON (ordre_mission.id_ordre=commande_en_ordre.id_ordre)
    INNER JOIN commande ON (commande_en_ordre.id_commande=commande.id_commande)
    INNER JOIN comporte ON (commande.id_commande = comporte.id_produit)
    INNER JOIN produit ON (comporte.id_produit=produit.id_produit)
    WHERE ordre_mission.id_ordre = OLD.id_ordre;

    quai_id INTEGER;
    ordre_id INTEGER;
    commande_id INTEGER;
    produit_id INTEGER;
    quantite_commande FLOAT;
    qte_quai FLOAT;

BEGIN
    quai_id := OLD.id_quai;
    ordre_id := OLD.id_ordre;
    OPEN produit_qte;
    LOOP 
        FETCH produit_qte INTO commande_id, produit_id, quantite_commande;
		EXIT WHEN NOT FOUND;
        UPDATE quai_produit 
        SET qte = qte + quantite_commande
        WHERE quai_produit.id_produit = produit_id AND quai_produit.id_quai = quai_id;
	END LOOP;
	CLOSE produit_qte;
    RETURN NEW ;
END ;
$BODY$;

CREATE TRIGGER gestion_quantite_surpression
        AFTER DELETE
        ON commande_en_ordre
        FOR EACH ROW 
        EXECUTE PROCEDURE gere_quantite_produit_surpression();


