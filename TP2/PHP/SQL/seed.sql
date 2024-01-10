-- Création de la table utilisateur
CREATE TABLE utilisateur (
    id INT PRIMARY KEY,
    nom VARCHAR(50),
    email VARCHAR(50)
);

-- Insertion de données de test
INSERT INTO utilisateur (id, nom, email) VALUES
(1, 'Fallon', 'vflorentin.fallon@ynov.com');

