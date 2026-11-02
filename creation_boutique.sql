-- Création de la base (à exécuter une seule fois, connecté à "postgres") :
-- CREATE DATABASE boutique;

--SELECT current_database();
CREATE TABLE clients (id_client INTEGER PRIMARY KEY, nom TEXT, ville TEXT, date_inscription DATE);
CREATE TABLE produits (id_produit INTEGER PRIMARY KEY, nom TEXT, categorie TEXT, prix NUMERIC(10,2));
CREATE TABLE commandes (id_commande INTEGER PRIMARY KEY, id_client INTEGER, date_commande DATE, statut TEXT);
CREATE TABLE lignes_commande (id_ligne INTEGER PRIMARY KEY, id_commande INTEGER, id_produit INTEGER, quantite INTEGER);

INSERT INTO clients VALUES
(1,'Kofi','Lomé','2025-01-10'),(2,'Ama','Kara','2025-02-05'),(3,'Yao','Lomé','2025-03-12'),
(4,'Akosua','Sokodé','2025-03-20'),(5,'Edem','Lomé','2025-04-02'),(6,'Mawuli','Kpalimé','2025-05-15');

INSERT INTO produits VALUES
(1,'Clavier','Informatique',8000),(2,'Souris','Informatique',3500),(3,'Cahier','Papeterie',500),
(4,'Stylo','Papeterie',200),(5,'Casque','Audio',12000);

INSERT INTO commandes VALUES
(1,1,'2025-06-01','livrée'),(2,1,'2025-06-15','livrée'),(3,2,'2025-06-20','annulée'),
(4,3,'2025-07-02','livrée'),(5,3,'2025-07-10','livrée'),(6,5,'2025-07-18','en cours'),
(7,1,'2025-08-01','livrée'),(8,2,'2025-08-05','livrée');

INSERT INTO lignes_commande VALUES
(1,1,1,1),(2,1,3,10),(3,2,5,1),(4,3,2,2),(5,4,1,1),(6,4,2,1),
(7,5,4,20),(8,6,5,2),(9,7,3,5),(10,7,4,10),(11,8,1,2);
