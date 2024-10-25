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
    INSERT ON 
        reservation
    FOR EACH ROW
    BEGIN
        DECLARE 
            reservationshot INT; 
        SELECT 
            COUNT(*) 
        INTO 
            reservationshot
        FROM 
            hotel
        JOIN 
            chambre 
            ON chambre.hot_id = hotel.hot_id
        JOIN 
            reservation 
            ON chambre.cha_id = reservation.res_cha_id
        WHERE 
            hotel.hot_id = 
            (
                SELECT 
                    hot_id 
                FROM 
                    chambre 
                WHERE 
                    cha_id = NEW.res_cha_id
            );
        IF 
            reservationshot >= 10 THEN
            SIGNAL 
                SQLSTATE '45000'
            SET 
                MESSAGE_TEXT = 'Interdiction d\'ajout de réservation : l\'hôtel a déjà 10 réservations';
        END IF;
    END$$
DELIMITER ;



________________________________________________________________________________________________________________________

3. insert_reservation2 : interdire les réservations si le client possède déjà 3 réservations.

DELIMITER $$

    CREATE TRIGGER 
        insert_reservation2
    BEFORE 
    INSERT ON 
        reservation
    FOR EACH ROW
    BEGIN
        DECLARE 
            reservationshot INT; 
        SELECT 
            COUNT(*) 
        INTO 
            reservationshot
        FROM 
            hotel
        JOIN 
            chambre 
            ON chambre.hot_id = hotel.hot_id
        JOIN 
            reservation 
            ON chambre.cha_id = reservation.res_cha_id
        JOIN 
            client 
            ON reservation.res_cli_id = client.cli_id
        WHERE 
            client.cli_id = 
            (
                SELECT 
                    cli_id 
                FROM 
                    reservation 
                WHERE 
                    res_id = NEW.res_id
            );
        IF 
            reservationshot >= 3 THEN
            SIGNAL 
                SQLSTATE '45000'
            SET 
                MESSAGE_TEXT = 'Interdiction le client a déjà 3 reservations';
        END IF;
    END$$
DELIMITER ;

________________________________________________________________________________________________________________________

4. insert_chambre : lors dune insertion, on calcule le total des capacités des chambres pour lhôtel, 
et si ce total est supérieur à 50, on interdit linsertion de la chambre.

DELIMMITER $$

    CREATE TRIGGER 
        insert_chambre
    BEFORE 
    INSERT ON 
        chambre
    FOR EACH ROW
    BEGIN
        DECLARE 
            totalchambres INT; 
        SELECT 
            SUM(cha_capacite) 
        INTO 
            totalchambres
        FROM 
            chambre
        WHERE 
            cha_hot_id = NEW.cha_hot_id;
        IF 
            totalchambres > 50 THEN
            SIGNAL 
                SQLSTATE '45000'
            SET 
                MESSAGE_TEXT = 'Interdiction la capacité maximal est de 50 chambres';
        END IF; 
    END$$
DELIMITER ;