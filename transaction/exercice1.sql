/*****************************************************************
*******************    GÉRER LES TRANSACTIONS    *****************                 
******************************************************************/

Sous PhpMyAdmin, après avoir sélectionné votre base Papyrus codez le script suivant et exécutez-le : 

1. Première transaction : Sélectionner le numéro de fournisseur 120

START TRANSACTION;
	SELECT
    	numfou
    FROM	
    	fournis
    WHERE
    	numfou = 120;
COMMIT;

_____________________________________________________________________________________________________________________________
2. Deuxième transaction : Mettre à jour le nom du fournisseur 120

START TRANSACTION;
	UPDATE	
    	fournis
    SET
    	nomfou = 'GROBRIGAN'
    WHERE
    	numfou = 120;
COMMIT;


_____________________________________________________________________________________________________________________________

3. Troisième transaction : Vérifier le nom du fournisseur après la mise à jour

START TRANSACTION;
	SELECT
    	nomfou
    FROM
    	fournis
    WHERE
    	numfou = 120;
COMMIT;

_____________________________________________________________________________________________________________________________
###############################################################################################
########        Linstruction START TRANSACTION est suivie dune instruction UPDATE,           ##
########        mais aucune instruction COMMIT ou ROLLBACK correspondante nest présente.     ##
###############################################################################################
######################################################
#######         Que concluez-vous ?         ##########
######################################################

    Sans COMMIT ni ROLLBACK, la transaction nest pas terminée,
    linstruction UPDATE nest pas encore confirmée dans la base de données.
_____________________________________________________________________________________________________________________________
######################################################################################################################
#####                        Les données sont-elles modifiables par dautres utilisateurs                            ##
#####   (ouvrez une nouvelle fenêtre de requête pour interroger le fournisseur 120 par une instruction SELECT) ?    ##
######################################################################################################################

SELECT
	numfou
FROM
	fournis
WHERE
	numfou = 120
;

    Oui, les données sont modifiables par dautres utilisateurs.
_____________________________________________________________________________________________________________________________

###################################################
####    La transaction est-elle terminée ?      ###
###################################################

    Non, la transaction nest pas terminée.
_____________________________________________________________________________________________________________________________
###############################################################
####      Comment rendre la modification permanente ?      ####
###############################################################

    Sans COMMIT, la transaction est sans succès.

_____________________________________________________________________________________________________________________________
############################################################
#######     Comment annuler la transaction ?        ########
############################################################

    Avec ROLLBACK, la transaction est annulée.

   
_____________________________________________________________________________________________________________________________

Codez les instructions nécessaires dans chaque cas pour vérifier vos réponses. 
