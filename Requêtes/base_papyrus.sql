-- Quelques conseils pour l’écriture d’une clause SELECT :
--  Déterminer les tables à mettre en jeu, les inclure dans la clause
-- FROM.
--  Décider quels sont les attributs à visualiser, les inclure dans la
-- clause SELECT.
--  Les expressions présentes dans la liste de sélection d’une re-
-- quête (clause SELECT) avec la clause GROUP BY doivent être des
-- fonctions d’agrégation ou apparaître dans la liste GROUP BY.
--  Déterminer les conditions limitant la recherche : les conditions
-- portant sur les groupes doivent figurer dans une clause HAVING,
-- celles portant sur des valeurs individuelles dans une clause
-- WHERE.
--  Pour employer une fonction sur les groupes dans une clause
-- WHERE, ou si on a besoin de la valeur d’un attribut d’une autre
-- table, il est nécessaire d’employer une requête imbriquée.
--  Préciser l’ordre d’apparition des t_uples du résultat dans une
-- clause ORDER BY.

/*****************************************************************
*****************    LES BESOINS D’AFFICHAGE    ******************                  
******************************************************************/


-- 1. Quelles sont les commandes du fournisseur 09120 ?

SELECT 
	numcom
FROM
	entcom
WHERE
	numfou = 09120
;


____________________________________________________________________________________________________________________
2. Afficher le code des fournisseurs pour lesquels des commandes ont été
passées.

SELECT 
	numfou
FROM
	entcom
WHERE
	numcom IS NOT NULL
;
____________________________________________________________________________________________________________________

3. Afficher le nombre de commandes fournisseurs passées, et le nombre
de fournisseur concernés.

SELECT 
	numfou,
	COUNT(numcom) AS nombre_commandes
FROM
	entcom
GROUP BY
	numfou
;

____________________________________________________________________________________________________________________

4. Editer les produits ayant un stock inférieur ou égal au stock dalerte et
dont la quantité annuelle est inférieur est inférieure à 1000

SELECT 
	libart,
	stkale,
	qteann
FROM
	produit
WHERE
	stkale <= qteann 
	AND 
	stkale <= 1000
;

4.1 informations à fournir : n° produit, libellé produit, stock, stock actuel
dalerte, quantité annuelle.

SELECT 
	libart,
	stkale,
	qteann
FROM
	produit
WHERE
	stkale <= qteann 
	AND 
	stkale <= 1000
;
____________________________________________________________________________________________________________________

5. Quels sont les fournisseurs situés dans les départements 75 78 92 77 ?
L’affichage (département, nom fournisseur) sera effectué par
département décroissant, puis par ordre alphabétique.

SELECT 
	posfou,
    nomfou
FROM
	fournis
WHERE
	posfou LIKE '75%' 
	OR 
	posfou LIKE '78%' 
	OR 
	posfou LIKE '92%' 
	OR 
	posfou LIKE '77%'
ORDER BY
	posfou DESC,
	nomfou ASC
;	
____________________________________________________________________________________________________________________

6. Quelles sont les commandes passées au mois de mars et avril ?

SELECT
	numcom,
	datcom
FROM
	entcom
WHERE
	MONTH(datcom) = 3 
	OR 
	MONTH(datcom) = 4
;

____________________________________________________________________________________________________________________

7. Quelles sont les commandes du jour qui ont des observations
particulières ?
(Affichage numéro de commande, date de commande).

SELECT
	numcom,
	datcom
FROM
	entcom
WHERE
	datcom = CURDATE()
	AND
	obscom IS NOT NULL
;

____________________________________________________________________________________________________________________

8. Lister le total de chaque commande par total décroissant
(Affichage numéro de commande et total).

SELECT
	numcom,
	SUM(qtecde * priuni) AS total
FROM
	ligcom
GROUP BY
	numcom
ORDER BY
	total DESC
;

____________________________________________________________________________________________________________________

9. Lister les commandes dont le total est supérieur à 10 000€ ; on exclura
dans le calcul du total les articles commandés en quantité supérieure
ou égale à 1000.

SELECT
	numcom,
	SUM(qtecde * priuni) AS total
FROM
	ligcom
GROUP BY
	numcom
HAVING
	total > 10000
	AND
	qtecde <= 1000
ORDER BY
	total DESC
;

9.1. Afficher le total par commande

SELECT
	numcom,
	SUM(qtecde * priuni) AS total
FROM
	ligcom
GROUP BY
	numcom
ORDER BY
	total DESC
;
	
____________________________________________________________________________________________________________________

10. Lister les commandes par nom fournisseur
(Afficher le nom du fournisseur, le numéro de commande et la date).

SELECT
	nomfou,
	numcom,
	datcom
FROM
	entcom
JOIN
	fournis
ON
	entcom.numfou = fournis.numfou
ORDER BY
	nomfou ASC
;

____________________________________________________________________________________________________________________

11. Sortir les produits des commandes ayant le mot urgent en
observation?
(Afficher le numéro de commande, le nom du fournisseur, le libellé du
produit et le sous total = quantité commandée * Prix unitaire).

SELECT
	ligcom.numcom,
	entcom.numfou,
	produit.libart,
	qtecde * priuni AS sous_total
FROM	
	ligcom
JOIN
	entcom
ON
	ligcom.numcom = entcom.numcom
JOIN
	produit
ON
	ligcom.codart = produit.codart
JOIN
	fournis
ON
	entcom.numfou = fournis.numfou
WHERE
	obscom LIKE '%urgent%'	
;

____________________________________________________________________________________________________________________


12. Coder de 2 manières différentes la requête suivante :
Lister le nom des fournisseurs susceptibles de livrer au moins un article.

a. Première manières

SELECT DISTINCT
	nomfou
FROM
	entcom
JOIN
	fournis
ON
	entcom.numfou = fournis.numfou
WHERE
	obscom IS NOT NULL
;	

b. Deuxième manieres

SELECT
    fournis.nomfou, 
    SUM(produit.stkphy) AS total_stkphy  
FROM
    ligcom
JOIN
    entcom
    ON ligcom.numcom = entcom.numcom  
JOIN
    produit 
    ON ligcom.codart = produit.codart 
JOIN
    fournis
    ON entcom.numfou = fournis.numfou  
WHERE
    produit.stkphy > 1 
GROUP BY
    fournis.nomfou
; 
____________________________________________________________________________________________________________________

13. Coder de 2 manières différentes la requête suivante
Lister les commandes (Numéro et date) dont le fournisseur est celui de
la commande 70210.

a. Première manieres

SELECT 
    numcom,
    datcom
FROM 
    entcom
WHERE 
    numfou = 
    (
        SELECT 
        	numfou 
        FROM 
        	entcom 
        WHERE 
        	numcom = 70210
    )
;

b. Deuxième manieres

SELECT	
    entcom.numcom,
    entcom.datcom
FROM
    entcom
JOIN
    ligcom 
    ON 
    entcom.numcom = ligcom.numcom
WHERE
    entcom.numfou = 
    (
        SELECT
        	numfou
        FROM
        	entcom 
        WHERE 
        	numcom = 70210
    )
;

____________________________________________________________________________________________________________________

14. Dans les articles susceptibles d’être vendus, lister les articles moins
chers (basés sur Prix1) que le moins cher des rubans (article dont le
premier caractère commence par R). On affichera le libellé de l’article
et prix1.

SELECT
	produit.libart,
	produit.priuni
FROM
	produit
WHERE
	produit.priuni < 
	(
		SELECT
			MIN(produit.priuni)
		FROM
			produit
		WHERE
			produit.libart LIKE 'r%'
	)
;

____________________________________________________________________________________________________________________

15. Editer la liste des fournisseurs susceptibles de livrer les produits
dont le stock est inférieur ou égal à 150 % du stock dalerte. La liste est
triée par produit puis fournisseur.

____________________________________________________________________________________________________________________

16. Éditer la liste des fournisseurs susceptibles de livrer les produit dont
le stock est inférieur ou égal à 150 % du stock dalerte et un délai de
livraison dau plus 30 jours. La liste est triée par fournisseur puis
produit.

____________________________________________________________________________________________________________________

17. Avec le même type de sélection que ci-dessus, sortir un total des
stocks par fournisseur trié par total décroissant.

____________________________________________________________________________________________________________________

18. En fin dannée, sortir la liste des produits dont la quantité réellement
commandée dépasse 90% de la quantité annuelle prévue.

____________________________________________________________________________________________________________________

19. Calculer le chiffre daffaire par fournisseur pour lannée 93 sachant
que les prix indiqués sont hors taxes et que le taux de TVA est 20%.

____________________________________________________________________________________________________________________

20. Existe-t-il des lignes de commande non cohérentes avec les produits
vendus par les fournisseurs. ?


/*****************************************************************
*****************   LES BESOINS DE MISE A JOUR    ****************                 
******************************************************************/

1. Application dune augmentation de tarif de 4% pour le prix 1 et de 2%
pour le prix2 pour le fournisseur 9180.

____________________________________________________________________________________________________________________

2. Dans la table vente, mettre à jour le prix2 des articles dont le prix2 est
null, en affectant a prix2 la valeur de prix1.

____________________________________________________________________________________________________________________

3. Mettre à jour le champ obscom en positionnant (*****) pour toutes les
commandes dont le fournisseur a un indice de satisfaction <5.

____________________________________________________________________________________________________________________

4. Suppression du produit I110.

____________________________________________________________________________________________________________________

5. Suppression des entête de commande qui nont aucune ligne.