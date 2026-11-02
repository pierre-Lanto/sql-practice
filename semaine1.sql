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