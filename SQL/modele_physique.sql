
CREATE TABLE public.camion (
                immatriculation VARCHAR NOT NULL,
                remarque VARCHAR,
                type VARCHAR,
                date_disponibilite DATE,
                disponible BOOLEAN NOT NULL,
                CONSTRAINT pk_camion PRIMARY KEY (immatriculation)
);



CREATE SEQUENCE public.chauffeur_id_chauffeur_seq;

CREATE TABLE public.chauffeur (
                id_chauffeur INTEGER NOT NULL DEFAULT nextval('public.chauffeur_id_chauffeur_seq'),
                nom VARCHAR NOT NULL,
                prenom VARCHAR NOT NULL,
                immatriculation VARCHAR,
                CONSTRAINT pk_chauffeur PRIMARY KEY (id_chauffeur)
);

ALTER TABLE public.chauffeur ADD CONSTRAINT camion_chauffeur_fk
FOREIGN KEY (immatriculation)
REFERENCES public.camion (immatriculation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;


ALTER SEQUENCE public.chauffeur_id_chauffeur_seq OWNED BY public.chauffeur.id_chauffeur;

CREATE TABLE public.utilise_camion (
                id_chauffeur INTEGER NOT NULL,
                immatriculation VARCHAR NOT NULL
);


CREATE SEQUENCE public.quai_chargement_id_quai_seq;

CREATE TABLE public.quai_chargement (
                id_quai INTEGER NOT NULL DEFAULT nextval('public.quai_chargement_id_quai_seq'),
                adresse_quai VARCHAR NOT NULL,
                CONSTRAINT pk_chargement PRIMARY KEY (id_quai)
);


ALTER SEQUENCE public.quai_chargement_id_quai_seq OWNED BY public.quai_chargement.id_quai;

CREATE SEQUENCE public.produit_id_produit_seq;

CREATE TABLE public.produit (
                id_produit INTEGER NOT NULL DEFAULT nextval('public.produit_id_produit_seq'),
                nom VARCHAR NOT NULL,
                CONSTRAINT pk_produit PRIMARY KEY (id_produit)
);


ALTER SEQUENCE public.produit_id_produit_seq OWNED BY public.produit.id_produit;

CREATE TABLE public.quai_produit (
                id_produit INTEGER NOT NULL,
                id_quai INTEGER NOT NULL,
                qte REAL NOT NULL
);


CREATE SEQUENCE public.entreprise_id_entreprise_seq;

CREATE TABLE public.entreprise (
                id_entreprise INTEGER NOT NULL DEFAULT nextval('public.entreprise_id_entreprise_seq'),
                nom VARCHAR NOT NULL,
                adresse_entreprise VARCHAR NOT NULL,
                CONSTRAINT pk_entreprise PRIMARY KEY (id_entreprise)
);


ALTER SEQUENCE public.entreprise_id_entreprise_seq OWNED BY public.entreprise.id_entreprise;

CREATE SEQUENCE public.depot_id_depot_seq;

CREATE TABLE public.depot (
                id_depot INTEGER NOT NULL DEFAULT nextval('public.depot_id_depot_seq'),
                id_entreprise INTEGER NOT NULL,
                adresse_depot VARCHAR NOT NULL,
                CONSTRAINT pk_depot PRIMARY KEY (id_depot)
);


ALTER SEQUENCE public.depot_id_depot_seq OWNED BY public.depot.id_depot;

CREATE SEQUENCE public.commande_id_commande_seq;

CREATE TABLE public.commande (
                id_commande INTEGER NOT NULL DEFAULT nextval('public.commande_id_commande_seq'),
                date_livraison DATE NOT NULL,
                id_entreprise INTEGER NOT NULL,
                CONSTRAINT pk_commande PRIMARY KEY (id_commande)
);


ALTER SEQUENCE public.commande_id_commande_seq OWNED BY public.commande.id_commande;

CREATE SEQUENCE public.ordre_mission_id_ordre_seq;

CREATE TABLE public.ordre_mission (
                id_ordre INTEGER NOT NULL DEFAULT nextval('public.ordre_mission_id_ordre_seq'),
                id_commande INTEGER NOT NULL,
                id_quai INTEGER NOT NULL,
                id_chauffeur INTEGER NOT NULL,
                date_chargement TIMESTAMP NOT NULL,
                CONSTRAINT pk_ordre_mission PRIMARY KEY (id_ordre)
);


ALTER SEQUENCE public.ordre_mission_id_ordre_seq OWNED BY public.ordre_mission.id_ordre;

CREATE TABLE public.livree_a (
                id_depot INTEGER NOT NULL,
                id_commande INTEGER NOT NULL
);


CREATE TABLE public.comporte (
                id_produit INTEGER NOT NULL,
                id_commande INTEGER NOT NULL,
                quantite REAL NOT NULL,
                livre BOOLEAN NOT NULL
);


ALTER TABLE public.utilise_camion ADD CONSTRAINT camion_utilise_camion_fk
FOREIGN KEY (immatriculation)
REFERENCES public.camion (immatriculation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.chauffeur ADD CONSTRAINT camion_chauffeur_fk
FOREIGN KEY (immatriculation)
REFERENCES public.camion (immatriculation)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordre_mission ADD CONSTRAINT chauffeur_ordre_mission_fk
FOREIGN KEY (id_chauffeur)
REFERENCES public.chauffeur (id_chauffeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.utilise_camion ADD CONSTRAINT chauffeur_utilise_camion_fk
FOREIGN KEY (id_chauffeur)
REFERENCES public.chauffeur (id_chauffeur)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordre_mission ADD CONSTRAINT qui_chargement_ordre_mission_fk
FOREIGN KEY (id_quai)
REFERENCES public.quai_chargement (id_quai)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.quai_produit ADD CONSTRAINT quai_chargement_quai_produit_fk
FOREIGN KEY (id_quai)
REFERENCES public.quai_chargement (id_quai)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comporte ADD CONSTRAINT produit_comporte_fk
FOREIGN KEY (id_produit)
REFERENCES public.produit (id_produit)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.quai_produit ADD CONSTRAINT produit_quai_produit_fk
FOREIGN KEY (id_produit)
REFERENCES public.produit (id_produit)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT entreprise_commande_fk
FOREIGN KEY (id_entreprise)
REFERENCES public.entreprise (id_entreprise)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.depot ADD CONSTRAINT entreprise_depot_fk
FOREIGN KEY (id_entreprise)
REFERENCES public.entreprise (id_entreprise)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livree_a ADD CONSTRAINT depot_livree_a_fk
FOREIGN KEY (id_depot)
REFERENCES public.depot (id_depot)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.comporte ADD CONSTRAINT commande_comporte_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.livree_a ADD CONSTRAINT commande_livree_a_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.ordre_mission ADD CONSTRAINT commande_ordre_mission_fk
FOREIGN KEY (id_commande)
REFERENCES public.commande (id_commande)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;