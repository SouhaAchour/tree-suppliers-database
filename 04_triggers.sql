-- =====================================
-- Table d'historique des suppressions
-- =====================================

CREATE TABLE historique_suppression (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom_fournisseur VARCHAR(100),
    nom_arbre VARCHAR(100),
    prix DECIMAL(10,2),
    quantite INT,
    date_suppression DATETIME,
    utilisateur VARCHAR(100)
);

-- =====================================
-- Trigger : sauvegarde avant suppression
-- =====================================

DELIMITER $$

CREATE TRIGGER avant_suppression
BEFORE DELETE ON lienarbresfournisseurs
FOR EACH ROW
BEGIN
    INSERT INTO historique_suppression
    (nom_fournisseur, nom_arbre, prix, quantite, date_suppression, utilisateur)
    SELECT 
        f.Nom,
        a.NomArbre,
        OLD.PrixHtva,
        OLD.Nb,
        NOW(),
        USER()
    FROM fournisseurs f
    JOIN arbres a ON a.PK_Arbre = OLD.FK_Arbre
    WHERE f.PK_Fournisseur = OLD.FK_Fournisseurs;
END $$

DELIMITER ;

-- =====================================
-- Tests
-- =====================================

-- SET SQL_SAFE_UPDATES = 0;
-- DELETE FROM lienarbresfournisseurs
-- WHERE PK_LienArbreFournisseurs = 1;

-- SELECT * FROM historique_suppression;