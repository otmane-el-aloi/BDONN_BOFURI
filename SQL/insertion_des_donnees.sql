/* Insertion des données */

INSERT INTO camion VALUES
    ('AC-543-AG', NULL, NULL, NULL, TRUE),
    ('AD-671-KA', NULL, NULL, NULL, TRUE),
    ('AH-126-GG', NULL, NULL, NULL, TRUE),
    ('AM-654-TU', NULL, NULL, NULL, TRUE),
    ('BA-865-PF', NULL, NULL, NULL, TRUE),
    ('BA-921-AA', 'au garage', NULL, NULL, FALSE),
    ('CK-221-KW', NULL, NULL, NULL, TRUE),
    ('CL-128-TR', NULL, NULL, NULL, TRUE),
    ('CN-225-AB', NULL, NULL, NULL, TRUE);

INSERT INTO chauffeur  VALUES
	(1, 'DENT','Arthur', 'AC-543-AG'),
	(2, 'LE ROC''H', 'Henry', 'BA-865-PF'),
	(3, 'DUPUIS', 'Nathalie', 'AH-126-GG'),
	(4, 'WEBER', 'Jacques', 'BA-921-AA'),
	(5, 'EMOUCHET', 'David', 'AD-671-KA'),
	(6, 'CE''NEDRA', 'Alexandra', 'CN-225-AB');


INSERT INTO entreprise VALUES
    (1, 'KAEDE', '12 Boulevard Wezemir  Paris 75012 France'),
    (2, 'KUROMU', '1 Cours Saint Pierre  Bordeaux 33000 France'),
    (3, 'KASUMI', '24 Rue du pont  Angers 49000 France');

INSERT INTO depot VALUES
    (1, 1, '5 allée des pinsons Pau France'),
    (2, 1, '25 rue des tulipes Bayonne France'),
    (3, 1, '2 rue des plantes Marseille France'),
    (4, 1, '67 rue des 5 portes Brest France'),
    (5, 2, '8 rue des marchands Tarbes France'),
    (6, 2, '1 rue de la braderie Lille France'),
    (7, 2, '32 impasse de lumières Lyon France'),
    (8, 3, '14 rue de la tour Narbonne France'),
    (9, 3, '7 allée des 3 saules Reims France');


INSERT INTO produit VALUES
    (1, 'Pommes'),
    (2, 'Pomme de terre'),
    (3, 'Poires'),
    (4, 'Kiwi'),
    (5, 'Poireau'),
    (6, 'Mandarine'),
    (7, 'Orange'),
    (8, 'Melon'),
    (9, 'Fraise');


INSERT INTO commande VALUES
    (1, '2021-11-15', 1),
    (2, '2021-11-15', 3),
    (3, '2021-11-17', 2),
    (4, '2021-11-18', 3),
    (5, '2021-11-22', 2);

INSERT INTO comporte VALUES 
    (1, 1, 500, FALSE),
    (2, 1, 800, FALSE),
    (3, 2, 200, FALSE),
    (4, 3, 100, FALSE),
    (5, 4, 200, FALSE),
    (2, 4, 600, FALSE),
    (6, 5, 200, FALSE),
    (7, 5, 400, FALSE);

INSERT INTO quai_chargement VALUES
    (1, '5 allée Beltegeuse Soumoulou France'),
    (2, '15 rue des rochers Metz France'),
    (3, '10 boulevard des marins Nice France');

INSERT INTO quai_produit VALUES
    (8, 1, 850),
    (2, 1, 12450),
    (9, 1, 75),
    (5, 1, 300),
    (7, 1, 150),
    (2, 2, 32700),
    (9, 2, 100),
    (4, 2, 400),
    (5, 2, 400),
    (8, 3, 550),
    (2, 3, 8350),
    (9, 3, 235),
    (4, 3, 650),
    (6, 3, 150),
    (5, 3, 250);

INSERT INTO livree_a VALUES
    (1, 1),
    (8, 2),
    (7, 3),
    (8, 4),
    (6, 5);




INSERT INTO ordre_mission VALUES
    (1, 1, 1, '2021-11-15 06:00:00'),
    (2, 1, 6, '2021-11-15 08:00:00'),
    (3, 2, 5, '2021-11-22 08:00:00');

INSERT INTO commande_en_ordre VALUES
    (1, 1, '2021-11-18 08:00:00'),
    (2, 1, '2021-11-15 14:00:00'),
    (4, 2, '2021-11-18 14:00:00'),
    (5, 3, '2021-11-22 16:00:00');


