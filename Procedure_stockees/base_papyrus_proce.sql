/*****************************************************************
********************    PROCEDURES STOCKÉES    *******************                 
******************************************************************/

-- CRÉATION DE PROCEDURE STOCKÉES SANS PARAMÈTRE 

1. Créez la procédure stockée Lst_fournis correspondant à la requête n°2 
afficher le code des fournisseurs pour lesquels une commande a été passée.
DELIMITER $$
        CREATE PROCEDURE
            Lst_fournis()
            BEGIN
                SELECT DISTINCT
                    fournis.numfou
                FROM
                    entcom
                JOIN
                    fournis
                    ON entcom.numfou = fournis.numfou
                WHERE
                    entcom.numcom IS NOT NULL
                ;
            END $$
DELIMITER;

__________________________________________________________________________________________________________________________

2. Exécutez la pour vérifier qu’elle fonctionne conformément à votre attente. 

CALL Lst_fournis;               

__________________________________________________________________________________________________________________________

3. Exécutez la commande SQL suivante pour obtenir des informations sur cette procédure stockée :

SHOW CREATE PROCEDURE Lst_fournis;

__________________________________________________________________________________________________________________________

-- CRÉATION DE PROCEDURE STOCKÉES AVEC PARAMÈTRE EN ENTRÉE

Créer la procédure stockée Lst_Commandes, qui liste les commandes ayant un libellé particulier dans le champ obscom 
(cette requête sera construite à partir de la requête n°11). 

DELIMITER $$
    CREATE PROCEDURE    
        Lst_Commandes()
        BEGIN
            SELECT
                numcom
            FROM
                entcom
            WHERE
                obscom != ""
            ;
        END $$
DELIMITER;
            
    
__________________________________________________________________________________________________________________________

-- CRÉATION DE PROCEDURE STOCKÉES AVEC PLUSIEURS PARAMÈTRES

Créer la procédure stockée CA_ Fournisseur, qui pour un code fournisseur et une année entrée en paramètre, 
calcule et restitue le CA potentiel de ce fournisseur pour lannée souhaitée 
(cette requête sera construite à partir de la requête n°19).

DELIMITER $$ 

CREATE PROCEDURE 
    CA_Fournisseur 
    (
        IN 
        code_fournisseur INT, 
        IN annee INT
    )
BEGIN
    SELECT
        SUM
        (
            ligcom.qtecde 
            * 
            ligcom.priuni   
        ) 
        AS CA_potentiel
    FROM
        entcom
    JOIN
        ligcom 
        ON entcom.numcom = ligcom.numcom
    JOIN
        fournis 
        ON ligcom.numfou = fournis.numfou
    WHERE
        fournis.numfou = code_fournisseur
        AND 
        YEAR(entcom.datcom) = annee
    ; 
END; $$

DELIMITER; 

SHOW PROCEDURE STATUS;


On exécutera la requête que si le code fournisseur est valide, cest-à-dire dans la table FOURNIS.


Testez cette procédure avec différentes valeurs des paramètres. 

__________________________________________________________________________________________________________________________

Lister les procédures stockées :
SHOW PROCEDURE STATUS;


/*****************************************************************
**********************    REQUÊTES UTILES    *********************                 
******************************************************************/

Pour exécuter une procédure stockée, on l’appelle avec l’instruction CALL :

CALL nom_procedure;
__________________________________________________________________________________________________________________________

Lister les procédures stockées :

SHOW PROCEDURE STATUS;

__________________________________________________________________________________________________________________________

Supprimer une procédure :

DROP PROCEDURE nom_procedure;


