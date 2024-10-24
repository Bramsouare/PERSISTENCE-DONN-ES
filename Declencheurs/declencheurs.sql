############################################################
##########           les déclencheurs          #############
############################################################

# Le moteur de stockage par défaut lorsqu'une table est créée est MyIsam,
# généralement qui ne supporte pas les transactions.  
# L'autre moteur de stockage le plus utilisé et qui supporte les transactions est le moteur InnoDB.
# il faut donc utiliser (InnoDB)

1. Pour changer le moteur de stockage dune table, exécuter la requête suivante :

ALTER TABLE 
    nom_table
ENGINE 
    = InnoDB
;

____________________________________________________________________________________________________________________________

2. Création dun déclancheur :

DELIMITER 
    $$
        CREATE TRIGGER
            nom_table 
            [INSERT ou UPDATE ou DELETE]
        ON 
            [table]
        FOR EACH 
                ROW 
            BEGIN
                -- [requête]
            END
        ;
    $$
DELIMITER;
____________________________________________________________________________________________________________________________

3. Autres instructions

Exécution dun trigger, les mots-clés,

## La syntaxe ##
OLD.nom_colonne (manipuler létat des données avant)

## La syntaxe ##
NEW.nom_colonne (manipuler létat des données apres)

## OLD et NEW représentent donc la table sur laquelle le déclencheur s'applique. ##

DECLARE : déclare une variable

SET : affecte une valeur à une variable

IF…THEN : écriture de conditions

____________________________________________________________________________________________________________________________

4. Suppression dun déclencheur :

DROP TRIGGER 
    nom_table
;
____________________________________________________________________________________________________________________________

5. Lister les déclencheurs existants :  

SHOW TRIGGERS;
____________________________________________________________________________________________________________________________

6. Supprimer tous les déclencheurs :

DROP TRIGGER 
    *
;

____________________________________________________________________________________________________________________________

7. Donc nous allons trouver un moyen dinterdire ce genre de requête:

insert into 
    station 
    (
        sta_nom,
        sta_altitude
    ) 
    values 
        (
            'station du bas',
            666
        )
;

7.1 Nous pouvons mettre en place un trigger en insertion sur la table station.

DELIMITER
    $$
        CREATE TRIGGER 
            insert_stration  -- Nom du trigger   
        AFTER   
            INSERT ON -- Après insertion
            station
            FOR EACH -- Pour chaque nouvelle ligne
                ROW
        BEGIN  
            DECLARE  
                altitude INT; -- Variable de stockage pour la nouvelle ligne inserée
            SET
                altitude = NEW.sta_altitude; -- Assigne la nouvelle valeur dans la variable
            IF altitude < 1000 -- Vérification de l'altitude
                THEN
                    SIGNAL -- Déclenche une erreur
                        SQLSTATE
                            '40000'
                SET
                    MESSAGE_TEXT
                        = 'Un problème est survenu. Règle de gestion altitude !';
            END IF;
        END;
    $$
DELIMITER;

________________________________________________________________________________________________________________________

