-- Exercice 1 : le total de clients
SELECT COUNT(*) AS nbr_client
FROM clients;
-- nombre de clients par ville 
SELECT ville, COUNT(*) AS nbr_client_par_ville
FROM clients
GROUP BY ville
ORDER BY nbr_client_par_ville DESC;

-- Exercice 2 :le prix moyen, le prix minimum et le prix maximum par catégorie.
SELECT categorie,
       ROUND(AVG(prix), 2) AS prix_moyen,
       MIN(prix) AS prix_minimum, 
       MAX(prix) AS prix_maximum
FROM produits 
GROUP BY categorie
ORDER BY prix_moyen DESC;

-- Exercice 3 :  le nombre de commandes par statut.
SELECT statut,
       COUNT(*) AS nbr_commandes
FROM commandes
GROUP BY statut
ORDER BY nbr_commandes DESC, statut;

-- Exercice 4 : le nombre de commandes par mois.
SELECT TO_CHAR( date_commande, 'YYYY-MM' ) AS mois,
       COUNT(*) AS nbr_commandes
FROM commandes
GROUP BY mois
ORDER BY mois;

-- Exercice 5 : les catégories dont le prix moyen dépasse 2000 
SELECT categorie,
       ROUND(AVG(prix), 2) AS prix_moyen  
FROM produits 
GROUP BY categorie
HAVING AVG(prix) > 2000
ORDER BY prix_moyen DESC;

-- Exercice 6 : Classe chaque produit en Bas (moins de 1000), Moyen (de 1000 à 9999) ou Haut (10000 et plus)
SELECT  nom, prix,
CASE
 WHEN prix < 1000 THEN 'Bas' 
 WHEN prix < 10000 THEN 'Moyen'
 WHEN prix >=10000 THEN 'Haut'
 ELSE 'Non renseigné'
END AS niveau_prix
FROM produits 
ORDER BY prix ;