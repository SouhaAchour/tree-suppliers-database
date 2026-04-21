DELIMITER $$

CREATE FUNCTION PaysNom(code CHAR(2))
RETURNS VARCHAR(50)
READS SQL DATA
BEGIN
    DECLARE nom VARCHAR(50);

    SELECT NomPays INTO nom
    FROM pays
    WHERE PK_Pays = code;

    RETURN nom;
END $$

DELIMITER ;

-- =====================================
-- Fonction : Liste des fournisseurs par arbre
-- =====================================

DELIMITER $$

CREATE FUNCTION ListeFournisseurs(idArbre INT)
RETURNS VARCHAR(500)
READS SQL DATA
BEGIN
    DECLARE fini INT DEFAULT 0;
    DECLARE nom VARCHAR(100);
    DECLARE resultat VARCHAR(500) DEFAULT '';

    DECLARE cur CURSOR FOR
        SELECT f.Nom
        FROM lienarbresfournisseurs l
        JOIN fournisseurs f ON l.FK_Fournisseurs = f.PK_Fournisseur
        WHERE l.FK_Arbre = idArbre;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fini = 1;

    OPEN cur;

    boucle: LOOP
        FETCH cur INTO nom;

        IF fini THEN
            LEAVE boucle;
        END IF;

        SET resultat = CONCAT(resultat, nom, ' ; ');
    END LOOP;

    CLOSE cur;

    IF resultat <> '' THEN
        SET resultat = LEFT(resultat, LENGTH(resultat) - 3);
    END IF;

    RETURN resultat;
END $$

DELIMITER ;
