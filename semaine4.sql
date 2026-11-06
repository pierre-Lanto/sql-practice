-- Exercice 1 : classer les clients par chiffre d’affaires
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
       chiffre_affaires,
       RANK() OVER (ORDER BY chiffre_affaires DESC) AS rang
FROM ca_client
ORDER BY rang;

-- Exercice 2 : numéroter les commandes de chaque client
SELECT c.nom,
       cmd.id_commande,
       cmd.date_commande,
       ROW_NUMBER() OVER (
           PARTITION BY c.id_client
           ORDER BY cmd.date_commande, cmd.id_commande
       ) AS numero_commande
FROM commandes cmd
INNER JOIN clients c ON cmd.id_client = c.id_client
ORDER BY c.nom, numero_commande;

-- Exercice 3 : chiffre d’affaires cumulé par mois
WITH ca_mensuel AS 
(SELECT TO_CHAR(cmd.date_commande, 'YYYY-MM') AS mois,
        SUM(p.prix*lc.quantite ) AS chiffre_affaires_mois
FROM produits p
INNER JOIN lignes_commande lc ON p.id_produit = lc.id_produit
INNER JOIN commandes cmd ON lc.id_commande = cmd.id_commande 
WHERE cmd.statut = 'livrée'
GROUP BY mois)
 SELECT mois,
        chiffre_affaires_mois,
        SUM(chiffre_affaires_mois) OVER (ORDER BY mois) AS cumul
FROM ca_mensuel
ORDER BY mois;

-- Exercice 4 : le délai depuis la commande précédente
SELECT c.nom,
       cmd.id_commande  AS  commande,
     cmd.date_commande - LAG(cmd.date_commande) OVER (PARTITION BY c.id_client ORDER BY cmd.date_commande) AS delai
FROM clients c
INNER JOIN commandes cmd ON c.id_client =cmd.id_client
ORDER BY c.nom, cmd.date_commande; 
        
