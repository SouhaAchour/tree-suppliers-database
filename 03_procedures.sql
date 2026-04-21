DELIMITER $$

CREATE PROCEDURE AjouterLien(
    IN idArbre INT,
    IN idFournisseur INT,
    IN prix DECIMAL(10,2),
    IN quantite INT,
    OUT idCree INT
)
BEGIN

    INSERT INTO lienarbresfournisseurs
    (FK_Arbre, FK_Fournisseurs, PrixHtva, Nb)
    VALUES (idArbre, idFournisseur, prix, quantite);

    -- récupérer l'id créé
    SET idCree = LAST_INSERT_ID();

END $$

DELIMITER ;
