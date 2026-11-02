-- Semaine 1 : bases du SQL (base "boutique")

-- Exercice 1 : afficher tous les produits
SELECT *
FROM produits;

-- Exercice 2 : produits dont le prix est supérieur à 5000
SELECT *
FROM produits
WHERE prix > 5000;

-- Exercice 3 : villes distinctes des clients
SELECT DISTINCT ville
FROM clients
ORDER BY ville;

-- Exercice 4 : clients dont le nom commence par A
SELECT nom
FROM clients
WHERE nom LIKE 'A%';
--Exercice 5 : Les commandes livrées en juillet 2025
SELECT *
FROM commandes
WHERE statut = 'livrée'
  AND EXTRACT(MONTH FROM date_commande) = 7
  AND EXTRACT(YEAR FROM date_commande) = 2025;
--Exercice 6 : les 3 produits les plus chers
SELECT *
FROM produits
ORDER BY prix DESC
LIMIT 3;
--SELECT nom, prix FROM produits ORDER BY prix DESC LIMIT 2 OFFSET 1;
--OFFSET 1 saute la première ligne. C’est utile pour obtenir « le deuxième plus cher

--Exercice 7 : Les produits de la catégorie Papeterie ou Audio
SELECT *
FROM produits
WHERE categorie  IN ('Papeterie','Audio' );
