-- =====================================
-- BASE
-- =====================================
USE test;

-- =====================================
-- QUESTION 1
-- Fournisseurs de pins triés par code postal
-- =====================================
SELECT fournisseurs.Nom, codepostal.CodePostal
FROM lienarbresfournisseurs
INNER JOIN arbres ON lienarbresfournisseurs.FK_ARBRE = arbres.PK_ARBRE
INNER JOIN fournisseurs ON lienarbresfournisseurs.FK_Fournisseurs = fournisseurs.PK_Fournisseur
INNER JOIN codepostal ON fournisseurs.FK_CodePostal = codepostal.PK_CodePostal
WHERE NomArbre = 'Pins'
ORDER BY codepostal.CodePostal;

-- =====================================
-- QUESTION 2
-- Prix max, min, moyenne et nb fournisseurs
-- =====================================
SELECT arbres.NomArbre,
       MAX(lienarbresfournisseurs.PrixHtva) AS maximum,
       MIN(lienarbresfournisseurs.PrixHtva) AS minimum,
       AVG(lienarbresfournisseurs.PrixHtva) AS moyen,
       COUNT(lienarbresfournisseurs.FK_Fournisseurs) AS nb_fournisseurs
FROM lienarbresfournisseurs
INNER JOIN arbres ON lienarbresfournisseurs.FK_ARBRE = arbres.PK_ARBRE
GROUP BY arbres.NomArbre;

-- =====================================
-- QUESTION 3
-- Total stock par fournisseur (TVAC)
-- =====================================
SELECT fournisseurs.Nom,
       SUM(lienarbresfournisseurs.PrixHtva * 1.21 * lienarbresfournisseurs.Nb) AS Total
FROM lienarbresfournisseurs
INNER JOIN fournisseurs ON lienarbresfournisseurs.FK_Fournisseurs = fournisseurs.PK_Fournisseur
GROUP BY fournisseurs.PK_Fournisseur, fournisseurs.Nom;

-- =====================================
-- QUESTION 4
-- Vue ensemble
-- =====================================
CREATE VIEW Ensemble AS
SELECT *
FROM lienarbresfournisseurs
INNER JOIN arbres ON lienarbresfournisseurs.FK_ARBRE = arbres.PK_ARBRE
INNER JOIN fournisseurs ON lienarbresfournisseurs.FK_Fournisseurs = fournisseurs.PK_Fournisseur
INNER JOIN codepostal ON fournisseurs.FK_CodePostal = codepostal.PK_CodePostal;

-- =====================================
-- QUESTION 5
-- Augmenter prix des pins de 10%
-- =====================================
SET SQL_SAFE_UPDATES = 0;

UPDATE lienarbresfournisseurs
INNER JOIN arbres 
ON lienarbresfournisseurs.FK_ARBRE = arbres.PK_ARBRE
SET PrixHtva = PrixHtva + PrixHtva * 0.1
WHERE arbres.NomArbre = 'Pins';

-- =====================================
-- QUESTION 6
-- HTVA / TVAC pour les chênes
-- =====================================
SELECT fournisseurs.Nom,
       SUM(lienarbresfournisseurs.PrixHtva * lienarbresfournisseurs.Nb) AS HTVAC,
       SUM(lienarbresfournisseurs.PrixHtva * 1.21 * lienarbresfournisseurs.Nb) AS TVAC
FROM lienarbresfournisseurs
INNER JOIN fournisseurs ON lienarbresfournisseurs.FK_Fournisseurs = fournisseurs.PK_Fournisseur
INNER JOIN arbres ON lienarbresfournisseurs.FK_ARBRE = arbres.PK_ARBRE
WHERE arbres.NomArbre = 'Chênes'
GROUP BY fournisseurs.PK_Fournisseur, fournisseurs.Nom;


-- =====================================
-- REQUETE AVANCEE
-- Nb fournisseurs + stock total + stock BE / FR
-- =====================================

SELECT 
    a.NomArbre,
    COUNT(DISTINCT f.PK_Fournisseur) AS nb_fournisseurs,
    SUM(l.Nb) AS stock_total,

    SUM(CASE 
        WHEN p.PK_Pays = 'BE' THEN l.Nb 
        ELSE 0 
    END) AS stock_BE,

    SUM(CASE 
        WHEN p.PK_Pays = 'FR' THEN l.Nb 
        ELSE 0 
    END) AS stock_FR

FROM lienarbresfournisseurs l

JOIN arbres a 
    ON l.FK_Arbre = a.PK_Arbre

JOIN fournisseurs f 
    ON l.FK_Fournisseurs = f.PK_Fournisseur

JOIN pays p 
    ON f.Cpays = p.PK_Pays

WHERE l.PrixHtva > 10

GROUP BY a.NomArbre

HAVING COUNT(DISTINCT f.PK_Fournisseur) > 2;
