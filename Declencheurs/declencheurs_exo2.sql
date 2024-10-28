###################################################################
###############            EXERCICES            ###################
###################################################################

1. Nous pouvons mettre en place un déclencheur sur la table lignedecommande,
qui va se charger de recalculer le total puis mettre à jour la table commande.

DELIMITER $$

CREATE TRIGGER
    maj_total AFTER
    INSERT ON
        lignedecommande
    FOR EACH 
        ROW
    BEGIN
    DECLARE 
        id_cmd INT;
    DECLARE
        tot DOUBLE;
    SET
        id_cmd = NEW.id_commande;
    SET
        tot = 
        (
            SELECT
                SUM(prix * quantite) 
            FROM 
                lignedecommande 
            WHERE 
                id_commande = id_cmd
        )
    ;
UPDATE
    commande
SET
    total = tot
WHERE
    id_commande = id_cmd;
END$$
DELIMITER ;

____________________________________________________________________________________________________________________________________________________________________

2. Mettez en place ce trigger, puis ajoutez un produit dans une commande, vérifiez que le champ total est bien mis à jour.

DELIMITER $$
    CREATE TRIGGER
        maj_total2 AFTER
        INSERT ON
            lignedecommande
        FOR EACH 
            ROW
        BEGIN
        DECLARE 
            id_cmd INT;
        DECLARE
            tot DOUBLE;
        SET
            id_cmd = NEW.id_commande;
        SET
            tot = 
            (
                SELECT
                    SUM(prix * quantite) 
                FROM 
                    lignedecommande 
                WHERE 
                    id_commande = id_cmd
            )
        ;
    UPDATE
        commande
    SET
        total = tot
    WHERE
        id_commande = id_cmd;
    END$$
DELIMITER ;

DROP TRIGGER maj_total2;

INSERT INTO `commande` (`id`, `id_client`, `date_commande`, `remise`, `total`) 
VALUES (4, 5, '2018-09-01 00:00:00', 0, NULL);

DELETE FROM `commande` WHERE id = 4;
____________________________________________________________________________________________________________________________________________________________________

3. Ce trigger ne fonctionne que lorsque lon ajoute des produits dans la commande, 
les modifications ou suppressions ne permettent pas de recalculer le total. 
Modifiez le code ci-dessus pour faire en sorte que la modification ou la suppression de produit recalcule le total de la commande.

DELIMITER $$
    CREATE TRIGGER
        maj_total3 AFTER
        INSERT ON
            lignedecommande
        FOR EACH 
            ROW
        BEGIN
        DECLARE 
            id_cmd INT;
        DECLARE
            tot DOUBLE;
        SET
            id_cmd = NEW.id_commande;
        SET
            tot = 
            (
                SELECT
                    SUM(prix * quantite) 
                FROM 
                    lignedecommande 
                WHERE 
                    id_commande = id_cmd
            )
        ;
    UPDATE
        commande
    SET
        total = tot
    WHERE
        id_commande = id_cmd;
    END$$
DELIMITER ;

____________________________________________________________________________________________________________________________________________________________________

4. Un champ remise était prévu dans la table commande, 
il contient le coefficient de remise à appliquer à la commande. Prenez en compte ce champ dans le code de votre trigger.

DELIMITER $$
    CREATE TRIGGER
        maj_total4 AFTER
        INSERT ON
            lignedecommande
        FOR EACH 
            ROW
        BEGIN
        DECLARE 
            id_cmd INT;
        DECLARE
            tot DOUBLE;
        SET
            id_cmd = NEW.id_commande;
        SET
            tot = 
            (
                SELECT
                    SUM(prix * quantite) 
                FROM 
                    lignedecommande 
                WHERE 
                    id_commande = id_cmd
            )
        ;
    UPDATE
        commande
    SET
        total = tot
    WHERE
        id_commande = id_cmd;
    END$$
DELIMITER ;

