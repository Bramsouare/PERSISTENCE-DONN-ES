/*****************************************************************
*******************    VUES SUR BASE HOTEL    ********************                  
******************************************************************/
1. Afficher la liste des hôtels avec leur station

CREATE VIEW  
    liste_hotels_station
AS
SELECT
    hotel.hot_nom AS nom_hotels,
    station.sta_nom AS nom_stations
FROM
    hotel
JOIN
    station
    ON hotel.hot_sta_id = station.sta_id
;


   

___________________________________________________________________________________________________________________________________________________________________________________________________________________________

2. Afficher la liste des chambres et leur hôtel.

CREATE VIEW
    listes_chambres_hotels
AS
SELECT
    chambre.cha_id AS chambres, 
    chambre.cha_numero AS numero_chambres, 
    hotel.hot_nom AS nom_hotel
FROM
    hotel
JOIN 
    chambre
    ON hotel.hot_id = chambre.cha_hot_id
;

___________________________________________________________________________________________________________________________________________________________________________________________________________________________

3. Afficher la liste des réservations avec le nom des clients.

CREATE VIEW
    listes_reservation_nom_clients
AS 
SELECT
    reservation.res_cli_id AS reservation_clients,
    client.cli_id AS clients
FROM
    reservation
JOIN
    client
    ON  reservation.res_cli_id = client.cli_id 
;

___________________________________________________________________________________________________________________________________________________________________________________________________________________________

4. Afficher la liste des chambres avec le nom de l’hôtel et le nom de la station.

CREATE VIEW
    listes_chambres_nomhotel_station
AS
SELECT
    chambre.cha_id,  
    hotel.hot_nom,      
    station.sta_nom  
FROM
    chambre
JOIN
    hotel ON chambre.cha_hot_id = hotel.hot_id   
JOIN
    station ON hotel.hot_sta_id = station.sta_id 
;
___________________________________________________________________________________________________________________________________________________________________________________________________________________________

5. Afficher les réservations avec le nom du client et le nom de l’hôtel.

CREATE VIEW
    reservation_nomclient_nomhotel
AS
SELECT
    reservation.res_cli_id,
    client.cli_nom,
    hotel.hot_nom
FROM
    client
JOIN
    reservation
    ON reservation.res_cli_id = client.cli_id
JOIN
    chambre
    ON chambre.cha_id = reservation.res_cha_id
JOIN
    hotel
    ON chambre.cha_hot_id = hotel.hot_id
;
