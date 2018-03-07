SET search_path = vetDB;

DROP SCHEMA IF EXISTS VETDB CASCADE;
CREATE SCHEMA VETDB;

-- DROP TABLE IF EXISTS VETDB.Clinique;
-- DROP TABLE IF EXISTS VETDB.Employe;
-- DROP TABLE IF EXISTS VETDB.Proprietaire;
-- DROP TABLE IF EXISTS VETDB.Animal;
-- DROP TABLE IF EXISTS VETDB.Examen;
-- DROP TABLE IF EXISTS VETDB.Traitement;
-- DROP TABLE IF EXISTS VETDB.TraitementPrescrit;

CREATE DOMAIN VETDB.sexType AS CHAR
	CHECK (VALUE IN ('M', 'F'));

CREATE DOMAIN VETDB.zipcode varchar(8) 
    CONSTRAINT valid_zipcode 
    CHECK (VALUE ~ '[A-Za-z][0-9][A-Za-z]\s?[0-9][A-Za-z][0-9]');

CREATE DOMAIN VETDB.phoneNumber varchar(13) 
    CONSTRAINT valid_phoneNumber
    CHECK (VALUE ~ '(\d{3}-?){2}\d{4}');

CREATE DOMAIN VETDB.nasFormat varchar(12) 
    CONSTRAINT valid_nasForamt
    CHECK (VALUE ~ '(\d{3}\s?){2}\d{3}');

CREATE TABLE IF NOT EXISTS  VETDB.Clinique (
		numClinique		VARCHAR(50)		NOT NULL,
		rue				VARCHAR(50)		NOT NULL,
		ville			VARCHAR(50)		NOT NULL,
		province		VARCHAR(50)		NOT NULL,
		codePostal		ZIPCODE			NOT NULL,
		numTelephone	PHONENUMBER		NOT NULL UNIQUE,
		numTelecopieur	PHONENUMBER,
		gestionnaire  	VARCHAR(10),
		PRIMARY KEY (numClinique));

CREATE TABLE IF NOT EXISTS VETDB.Employe(
		numEmp 			VARCHAR(50) NOT NULL, 
		nas 			nasFormat	NOT NULL UNIQUE,
		prenom 			VARCHAR(50)	NOT NULL,
		nomFamille 		VARCHAR(50)	NOT NULL,
		rue				VARCHAR(50)	NOT NULL,
		ville			VARCHAR(50)	NOT NULL,
		province		VARCHAR(50)	NOT NULL,
		codePostal		ZIPCODE,
		numTel			PHONENUMBER	NOT NULL,
		dateNaissance 	DATE		NOT NULL,
		sexe 			SEXTYPE 	NOT NULL, 
		fonction		VARCHAR(30)	NOT NULL DEFAULT 'Employe',	
		salaireAnnuel  	NUMERIC(8,2),
		numClinique		VARCHAR(50)	NOT NULL ,
		PRIMARY KEY (numEmp),
		FOREIGN KEY(numClinique) REFERENCES VETDB.Clinique(numClinique) ON DELETE RESTRICT ON UPDATE CASCADE);
		
ALTER TABLE VETDB.Clinique
ADD FOREIGN KEY(gestionnaire) REFERENCES VETDB.Employe(numEmp) ON DELETE RESTRICT ON UPDATE CASCADE;
			
 
CREATE TABLE IF NOT EXISTS VETDB.Proprietaire(
		numClinique 	VARCHAR(10)		NOT NULL,
		numProprietaire	VARCHAR(10)		NOT NULL,
		prenom 			VARCHAR(60)		NOT NULL,
		nomFamille 		VARCHAR(60)		NOT NULL,
		rue				VARCHAR(50)		NOT NULL,
		ville			VARCHAR(50)		NOT NULL,
		province		VARCHAR(50)		NOT NULL,
		codePostal		ZIPCODE,
		numTel			PHONENUMBER		NOT NULL, 
		PRIMARY KEY (numClinique, numProprietaire),
		FOREIGN KEY(numClinique) REFERENCES VETDB.Clinique(numClinique) ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS VETDB.Animal(
		numClinique 	VARCHAR(10)			NOT NULL,
		numProprietaire	VARCHAR(10)			NOT NULL,
		numAnimal	 	VARCHAR(10)			NOT NULL,
		nom 			VARCHAR(30)			NOT NULL,
		type			VARCHAR(30)			NOT NULL,
		description		VARCHAR(60),
		dateNaissance	DATE,
		dateInscription	DATE				NOT NULL,
		estVivant		BOOLEAN				NOT NULL DEFAULT TRUE,
		PRIMARY KEY (numClinique, numAnimal),
		FOREIGN KEY (numClinique, numProprietaire) REFERENCES VETDB.Proprietaire(numClinique, numProprietaire) 
		ON DELETE RESTRICT ON UPDATE CASCADE);

CREATE TABLE IF NOT EXISTS VETDB.Traitement(
		numTraitement 		VARCHAR(10)			NOT NULL,
		description			VARCHAR(60)			NOT NULL,
		cout	 			NUMERIC(8,2)		NOT NULL,
		PRIMARY KEY  (numTraitement));


CREATE TABLE IF NOT EXISTS VETDB.ExamenPhysique(
		numExamen 			VARCHAR(10)			NOT NULL,
		dateExamen			DATE				NOT NULL,
		heure	 			TIME				NOT NULL,
		description 		VARCHAR(60)			NOT NULL,
		prenomVeterinaire	VARCHAR(50)			NOT NULL,
		nomVeterinaire		VARCHAR(50)			NOT NULL,
		numClinique 		VARCHAR(10)			NOT NULL,
		numAnimal			VARCHAR(10)			NOT NULL,
		numTraitement 		VARCHAR(10)			NOT NULL,
		PRIMARY KEY  (numTraitement, numExamen),
		FOREIGN KEY (numClinique, numAnimal) REFERENCES VETDB.Animal(numClinique, numAnimal) 
		ON DELETE RESTRICT ON UPDATE CASCADE);


CREATE TABLE IF NOT EXISTS VETDB.TraitementPersonalise(
		numTraitement 		VARCHAR(10)			NOT NULL,
		numExamen 			VARCHAR(10)			NOT NULL,
		dateExamen			DATE				NOT NULL,
		dateDebut			DATE				NOT NULL,
		dateFin	 			DATE				NOT NULL,
		quantite			INTEGER				NOT NULL,
		numClinique 		VARCHAR(10)			NOT NULL,
		numAnimal	 		VARCHAR(10)			NOT NULL,
		PRIMARY KEY  (numTraitement, numExamen),
		FOREIGN KEY (numTraitement) REFERENCES VETDB.Traitement(numTraitement) ON DELETE RESTRICT ON UPDATE CASCADE,
		FOREIGN KEY (numClinique, numAnimal) REFERENCES VETDB.Animal(numClinique,numAnimal) 
		ON DELETE RESTRICT ON UPDATE CASCADE);
		


---- Fonction checkClinique() qui implante le comportement désiré
---- On veut que le gestionnaire soit un employe avec la fonction gestionnaire
CREATE OR REPLACE FUNCTION checkClinique() RETURNS TRIGGER AS $checkCliniqueTrigger$
DECLARE
	position VARCHAR;
BEGIN
		IF (TG_OP = 'UPDATE' OR TG_OP = 'INSERT') THEN
			Select fonction into position FROM VETDB.Employe WHERE numEmp=new.gestionnaire;
    		IF(position!='Gestionnaire') THEN
    			raise exception 'ERREUR: Le gestionnaire doit etre un employe avec la fonction de gestionnaire';
    		END IF;
        END IF;
        RETURN NEW;
END;
$checkCliniqueTrigger$ LANGUAGE plpgsql;

--- Trigger qui se déclenche avant d'insérer des données
DROP TRIGGER IF EXISTS checkCliniqueTrigger on VETDB.Clinique;

CREATE TRIGGER checkCliniqueTrigger
BEFORE INSERT OR UPDATE ON VETDB.Clinique
FOR EACH ROW EXECUTE PROCEDURE checkClinique();

