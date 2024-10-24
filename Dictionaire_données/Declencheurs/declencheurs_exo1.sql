###################################################################
###############            EXERCICES            ###################
###################################################################
1. modif_reservation : interdire la modification des réservations (on autorise lajout et la suppression).

DELIMITER $$
        CREATE TRIGGER
            modif_reservation
        BEFORE
            UPDATE ON
            reservation
        FOR EACH ROW
        BEGIN
            SIGNAL SQLSTATE "45000"
            SET
                MESSAGE_TEXT = "Modification interdite";
        END;$$
DELIMITER ; 
________________________________________________________________________________________________________________________

2. insert_reservation : interdire lajout de réservation pour les hôtels possédant déjà 10 réservations.
DELIMITER $$
    CREATE TRIGGER 
        insert_reservation
    BEFORE 
        UPDATE ON
        reservation 
    FOR EACH
        ROW
    BEGIN
        


________________________________________________________________________________________________________________________

3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations.

________________________________________________________________________________________________________________________

4. insert_chambre : lors dune insertion, on calcule le total des capacités des chambres pour lhôtel, 
et si ce total est supérieur à 50, on interdit linsertion de la chambre.
