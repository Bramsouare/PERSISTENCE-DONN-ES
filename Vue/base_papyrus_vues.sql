/*****************************************************************
*******************    VUES SUR BASE PAPYRUS    ******************                 
******************************************************************/


1. v_GlobalCde correspondant à la requête : 
A partir de la table Ligcom,
afficher par code produit, la somme des quantités commandées et le prix total correspondant : 
on nommera la colonne correspondant à la somme des quantités commandées, QteTot et le prix total, PrixTot.

CREATE VIEW
    v_GlobalCde
AS
SELECT
    ligcom.codart,
    SUM(ligcom.qtecde) AS total_quantite, -- l'ensemble des quantités commandées
    SUM(ligcom.qtecde * ligcom.priuni) AS total_prix -- quantités * le prix = total
FROM
    ligcom
JOIN
    produit
    ON produit.codart = ligcom.codart
GROUP BY
    produit.codart
;

___________________________________________________________________________________________________________________________________________________________________________________________________________________________

2. v_VentesI100 correspondant à la requête : 
Afficher les ventes dont le code produit est le I100 (affichage de toutes les colonnes de la table Vente). 

CREATE VIEW
    v_VentesI100
AS
SELECT
    *
FROM   
    vente
WHERE   
    codart = 'I100'
;

___________________________________________________________________________________________________________________________________________________________________________________________________________________________

3. A partir de la vue précédente, 
créez v_VentesI100Grobrigan remontant toutes les ventes concernant le produit I100 et le fournisseur 00120.

CREATE VIEW
    v_VentesI100Grobrigan
AS
SELECT
    v_VentesI100.*,         
    fournis.numfou AS fournis_numfou 
FROM
    v_VentesI100
JOIN
    fournis ON v_VentesI100.numfou = fournis.numfou 
WHERE
    fournis.numfou = '00120';

 
___________________________________________________________________________________________________________________________________________________________________________________________________________________________


/*****************************************************************
**********************    REQUÊTES UTILES    *********************                 
******************************************************************/

1. Afficher la définition dune vue

SHOW CREATE VIEW v_nomvue
___________________________________________________________________________________________________________________________________________________________________________________________________________________________

2. Modifier une vue

a. Solution 1 :

ALTER VIEW v_nomvue 
AS 
[NOUVELLE REQUETE]

b. Solution 2 :

CREATE OR REPLACE VIEW v_nomvue
AS
[NOUVELLE REQUETE] 
___________________________________________________________________________________________________________________________________________________________________________________________________________________________

3. Supprimer une vue

DROP VIEW v_nomvue 

3.1 on peut spécifier loption IF EXISTS :

DROP VIEW IF EXISTS v_nomvue 
___________________________________________________________________________________________________________________________________________________________________________________________________________________________

4. Définir des privilèges sur une vue

GRANT 
CREATE VIEW, 
SHOW VIEW 
ON `nom_base`.* TO 'utilisateur'@'adresse_ip'
___________________________________________________________________________________________________________________________________________________________________________________________________________________________

5. Lister les vues existantes

SELECT * FROM information_schema.views 

