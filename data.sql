SET search_path = vetDB;

--Creation des Cliniques
INSERT INTO VETDB.Clinique (numClinique,rue, ville, province, codePostal,numTelephone, numTelecopieur) 
VALUES ('C111', '19 rue des hetres', 'Gatineau', 'Quebec', 'J8R 2Y8', '819-663-8266', '819-333-5444');
INSERT INTO VETDB.Clinique (numClinique,rue, ville, province, codePostal,numTelephone) 
VALUES ('C112', '80 rue Private Univeristy', 'Ottawa', 'Ontario', 'K1N 2Y9', '613-772-6789');
INSERT INTO VETDB.Clinique (numClinique,rue, ville, province, codePostal,numTelephone) 
VALUES ('C113', '60 Patterson Blvd SW', 'Calgary', 'Alberta', 'T3H 2E1', '403-297-2706');

--Creation des employees
INSERT INTO VETDB.Employe VALUES ('E1', '230 456 666','Shanel', 'Gauthier', '4 rue Kennedy', 'Val-des-Monts', 'Quebec','J8R 1K9', '819-671-6833', '1995-08-04', 'F','Gestionnaire','50000.00', 'C111');    
INSERT INTO VETDB.Employe VALUES ('E2', '540 404 222','James', 'Mandala', '34 rue des Riches', ' Ottawa', 'Ontario','Y8T 4R5', '403-444-8790', '1961-12-03', 'F','Gestionnaire','57000.44', 'C112'); 
INSERT INTO VETDB.Employe VALUES ('E3', '156 456 606','Madeleine', 'Bertrier', '13 rue Paul', 'Calgary', 'Alberta','Y9I 1K7', '819-671-6833', '1989-01-29', 'F','Gestionnaire','60000.00', 'C113');    
INSERT INTO VETDB.Employe VALUES ('E4', '344 999 797','Jean', 'Tremblay', ' 1111 boulevard des Tartes', ' Gatineau', 'Quebec','T5F 1H6', '403-444-8790', '1978-09-19', 'F','Veterinaire','110055.55', 'C111'); 
INSERT INTO VETDB.Employe VALUES ('E5', '966 456 666','Ginette', 'Paul','1234 boulevard Maloney','Gatineau', 'Quebec','K9J 8I9', '819-671-6833', '1999-08-05', 'M','Secretaire','23000.66','C111');    
INSERT INTO VETDB.Employe VALUES ('E6', '344 555 777','Jasmin', 'Green', '34 rue des Riches', 'Cantley', 'Quebec','G6U 7Y8', '403-444-8790', '1967-04-17', 'M','Infirmiere','54300.99', 'C111'); 
INSERT INTO VETDB.Employe VALUES ('E7', '000 000 001','Georges', 'Laraque', '69 rue des Pauvres', 'Westmount', 'Quebec','E2Z F2U', '819-666-8790', '1976-12-07', 'M','Veterinaire','100000.69', 'C111'); 


--Assignation des gestionnaires
UPDATE VETDB.Clinique SET gestionnaire='E1' WHERE numClinique='C111';
UPDATE VETDB.Clinique SET gestionnaire='E2' WHERE numClinique='C112';
UPDATE VETDB.Clinique SET gestionnaire='E3'WHERE numClinique='C113';

--Creation des Proprietaire d'animal
INSERT INTO VETDB.Proprietaire VALUES ('C111', 'P1', 'Isabelle', 'Tremblay', '542 rue Montee-Paiment', 'Gatineau', 'Quebec', 'J8R 0G8', '819-234-0999') ;
INSERT INTO VETDB.Proprietaire VALUES ('C111', 'P2', 'Sylvain', 'Gauthier', '27 rue Lippizans', 'Gatineau', 'Quebec', 'J8U 0B4', '613-345-9995'); 
INSERT INTO VETDB.Proprietaire VALUES ('C111', 'P3', 'Penelope', 'BlayChou', '96 rue Levens', 'Cantley', 'Quebec', 'J8R 1G7', '514-234-0009');
INSERT INTO VETDB.Proprietaire VALUES ('C112', 'P4', 'Jacob', 'Hebert', '24 rue Levens', 'Cantley', 'Quebec', 'J8R 1G7', '514-234-0008');

--Creation des traitements
INSERT INTO VETDB.Traitement VALUES ('T100', 'Examen', 20.00); 
INSERT INTO VETDB.Traitement VALUES ('T110', 'Traitement contre vomissement', 50.00); 
INSERT INTO VETDB.Traitement VALUES ('T112', 'Traitement anti douleur', 70.00); 
INSERT INTO VETDB.Traitement VALUES ('T113', 'Traitement anti verre blanc', 200.00);
INSERT INTO VETDB.Traitement VALUES ('T114', 'Vaccin contre la grippe pour chien', 400.00);

--Creations des animaux
INSERT INTO VETDB.Animal VALUES ('C111', 'A1', 'Paddy', 'Chat', 'chat batard de couleur gris et blanc', '2015-09-18', '2017-12-01', FALSE, 'P1') ;
INSERT INTO VETDB.Animal VALUES ('C111', 'A2', 'Pruno', 'Chien', 'chien eau portuguais noir', '2017-01-21', now(), TRUE, 'P1'); 
INSERT INTO VETDB.Animal VALUES ('C111', 'A3', 'Linux', 'Chat', 'chat batard noir et blanc', '2011-04-09', now(), TRUE,'P2' ); 
INSERT INTO VETDB.Animal VALUES ('C112', 'A4', 'Noireau', 'Chat', 'chat batard noir', '2017-04-09', now(),TRUE, 'P1');
INSERT INTO VETDB.Animal VALUES ('C111', 'A5', 'Wankanda', 'Tortue', 'tortue verte', '2000-05-13', now(),TRUE, 'P4'); 


--Creation des examensphysiques
INSERT INTO VETDB.Examen VALUES ('EX1', '2018-03-10', '04:00:00','chat ne cesse de vomir', 'C111', 'A1', 'E4'); 
INSERT INTO VETDB.Examen VALUES ('EX2', '2018-03-11', '16:00:00','chien blessure a la pate gauche', 'C111', 'A2', 'E4' ); 
INSERT INTO VETDB.Examen VALUES ('EX3', '2018-04-10', '08:30:00','verre blanc dans les excrements du chat', 'C111', 'A3', 'E4'); 
INSERT INTO VETDB.Examen VALUES ('EX4', '2018-04-12', '10:30:00','vaccin pour chien contre la grippe', 'C111', 'A2', 'E4');

--Creation des traitements personalises
INSERT INTO VETDB.TraitementPersonalise VALUES ('T110','EX1', '2018-03-10', '2018-03-17', 2, 'C111', 'A1');
INSERT INTO VETDB.TraitementPersonalise VALUES ('T112','EX2', '2018-03-11', '2018-03-25', 2, 'C111', 'A2');       
INSERT INTO VETDB.TraitementPersonalise VALUES ('T113','EX3', '2018-04-13', '2018-04-17', 2, 'C111', 'A3');
INSERT INTO VETDB.TraitementPersonalise VALUES ('T114','EX4', '2018-04-13', '2018-04-17', 1, 'C111', 'A2');

















