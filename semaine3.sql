-- Exercice 1 : chaque commande avec le nom du client
SELECT cmd.id_commande,
       c.nom,
       cmd.date_commande, 
       cmd.statut 
FROM commandes cmd
INNER JOIN clients c ON cmd.id_client = c.id_client
ORDER BY cmd.id_commande;

-- Exercice 2 : tous les clients, avec leurs commandes s’ils en ont
SELECT c.nom, cmd.id_commande, cmd.statut
FROM clients c
LEFT JOIN commandes cmd ON c.id_client = cmd.id_client
ORDER BY c.nom;

-- Exercice 3 : les clients sans aucune commande
SELECT c.nom, 
       c.ville
FROM clients c
LEFT JOIN commandes cmd ON c.id_client = cmd.id_client
WHERE cmd.id_commande IS NULL;

-- Exercice 4 : joindre quatre tables
SELECT c.nom AS client, 
       p.nom AS produit, 
       lc.quantite, 
       lc.quantite*p.prix AS montant
FROM lignes_commande lc
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande 
INNER JOIN clients c ON cmd.id_client =c.id_client 
INNER JOIN produits p ON lc.id_produit =p.id_produit 
ORDER BY cmd.id_commande,   p.nom ;

-- Exercice 5 : chiffre d’affaires par client
SELECT c.nom AS client,   
       SUM(lc.quantite*p.prix) AS montant
FROM lignes_commande lc
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande 
INNER JOIN clients c ON cmd.id_client =c.id_client 
INNER JOIN produits p ON lc.id_produit =p.id_produit 

ORDER BY cmd.id_commande,   p.nom ;

-- Exercice 6 : chiffre d'affaires par catégorie (commandes livrées)
SELECT p.categorie,
       SUM(lc.quantite * p.prix) AS chiffre_affaires
FROM lignes_commande lc
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande
INNER JOIN produits p    ON lc.id_produit = p.id_produit
WHERE cmd.statut = 'livrée'
GROUP BY p.categorie
ORDER BY chiffre_affaires DESC;

-- Exercice 7:
SELECT c.nom AS client,
        SUM(lc.quantite*p.prix) AS chiffre_affaire
FROM lignes_commande lc
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande
INNER JOIN clients c ON cmd.id_client =c.id_client
INNER JOIN produits p ON lc.id_produit =p.id_produit
WHERE cmd.statut ='livrée'
GROUP BY c.nom, c.id_client
HAVING SUM(lc.quantite * p.prix) >(SELECT AVG(t.chiffre_affaire)
FROM (SELECT  SUM(lc.quantite*p.prix) AS chiffre_affaire
FROM lignes_commande lc
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande
INNER JOIN clients c ON cmd.id_client =c.id_client
INNER JOIN produits p ON lc.id_produit =p.id_produit
WHERE cmd.statut ='livrée'
GROUP BY c.nom, c.id_client
   ) t ) ;

-- Exercice 7 : clients dont le chiffre d'affaires dépasse la moyenne
WITH ca_client AS (
    SELECT c.id_client,
           c.nom,
           SUM(lc.quantite * p.prix) AS chiffre_affaires
    FROM lignes_commande lc
    INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande
    INNER JOIN clients c     ON cmd.id_client = c.id_client
    INNER JOIN produits p    ON lc.id_produit = p.id_produit
    WHERE cmd.statut = 'livrée'
    GROUP BY c.id_client, c.nom
)
SELECT nom,
       chiffre_affaires
FROM ca_client
WHERE chiffre_affaires > (SELECT AVG(chiffre_affaires) FROM ca_client)
ORDER BY chiffre_affaires DESC;
